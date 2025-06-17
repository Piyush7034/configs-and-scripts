-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.
-- -------------------------------------------------------------------------------------------------
-- Database Name: inji_certify
-- Table Name : rendering_template, credential_template, ca_cert_store
-- Purpose    : To upgrade Certify v0.11.0 changes and make it compatible with v0.12.0
--
-- Create By   	: Piyush Shukla
-- Created Date	: January-2025
--
-- Modified Date        Modified By         Comments / Remarks
-- ------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------

-- Step 1: Rename the table if it exists
DO $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM information_schema.tables
        WHERE table_name = 'credential_template'
          AND table_schema = 'certify'
    ) THEN
        ALTER TABLE certify.credential_template RENAME TO credential_config;
    END IF;
END $$;

-- Step 2: Add new columns if they do not already exist
ALTER TABLE certify.credential_config
    ADD COLUMN IF NOT EXISTS credential_config_key_id VARCHAR(255) NOT NULL UNIQUE DEFAULT gen_random_uuid(),
    ADD COLUMN IF NOT EXISTS config_id VARCHAR(255) DEFAULT gen_random_uuid(),
    ADD COLUMN IF NOT EXISTS status VARCHAR(255) DEFAULT 'active',
    ADD COLUMN IF NOT EXISTS doctype VARCHAR,
    ADD COLUMN IF NOT EXISTS vct VARCHAR,
    ADD COLUMN IF NOT EXISTS credential_format VARCHAR(255) NOT NULL DEFAULT 'default_format', -- Adding a default value for NOT NULL constraint
    ADD COLUMN IF NOT EXISTS did_url VARCHAR DEFAULT 'did:web:mosip.github.io:inji-config:default', -- Adding a default value for NOT NULL constraint
    ADD COLUMN IF NOT EXISTS key_manager_app_id VARCHAR(36) DEFAULT '', -- Adding a default value for NOT NULL constraint
    ADD COLUMN IF NOT EXISTS key_manager_ref_id VARCHAR(128),
    ADD COLUMN IF NOT EXISTS signature_algo VARCHAR(36),
    ADD COLUMN IF NOT EXISTS sd_claim VARCHAR,
    ADD COLUMN IF NOT EXISTS display JSONB NOT NULL DEFAULT '[]'::jsonb, -- Adding a default value for NOT NULL constraint
    ADD COLUMN IF NOT EXISTS display_order TEXT[] DEFAULT ARRAY[]::TEXT[], -- Adding a default value for NOT NULL constraint
    ADD COLUMN IF NOT EXISTS scope VARCHAR(255) NOT NULL DEFAULT '', -- Adding a default value for NOT NULL constraint
    ADD COLUMN IF NOT EXISTS cryptographic_binding_methods_supported TEXT[] NOT NULL DEFAULT ARRAY[]::TEXT[], -- Adding a default value for NOT NULL constraint
    ADD COLUMN IF NOT EXISTS credential_signing_alg_values_supported TEXT[] NOT NULL DEFAULT ARRAY[]::TEXT[], -- Adding a default value for NOT NULL constraint
    ADD COLUMN IF NOT EXISTS proof_types_supported JSONB NOT NULL DEFAULT '{}'::jsonb, -- Adding a default value for NOT NULL constraint
    ADD COLUMN IF NOT EXISTS credential_subject JSONB DEFAULT '{}'::jsonb,
    ADD COLUMN IF NOT EXISTS claims JSONB,
    ADD COLUMN IF NOT EXISTS plugin_configurations JSONB;

-- Step 3: Rename the column if it exists
DO $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM information_schema.columns
        WHERE table_name = 'credential_config'
          AND column_name = 'template'
    ) THEN
        ALTER TABLE certify.credential_config RENAME COLUMN template TO vc_template;
    END IF;
END $$;

-- Step 4: Alter column sizes if the columns exist
DO $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM information_schema.columns
        WHERE table_name = 'credential_config'
          AND column_name = 'context'
    ) THEN
        ALTER TABLE certify.credential_config
            ALTER COLUMN context TYPE VARCHAR;
    END IF;

    IF EXISTS (
        SELECT 1
        FROM information_schema.columns
        WHERE table_name = 'credential_config'
          AND column_name = 'credential_type'
    ) THEN
        ALTER TABLE certify.credential_config
            ALTER COLUMN credential_type TYPE VARCHAR;
    END IF;
END $$;

-- Step 5: Update the primary key constraint if it exists
DO $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM information_schema.table_constraints
        WHERE table_name = 'credential_config'
          AND constraint_name = 'pk_template'
    ) THEN
        ALTER TABLE certify.credential_config DROP CONSTRAINT pk_template;
    END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM information_schema.table_constraints
        WHERE table_name = 'credential_config'
          AND constraint_name = 'pk_config_id'
    ) THEN
        ALTER TABLE certify.credential_config ADD CONSTRAINT pk_config_id PRIMARY KEY (context, credential_type, credential_format);
    END IF;

    ALTER TABLE certify.credential_config
            ALTER COLUMN vc_template DROP NOT NULL;
END $$;

-- Step 6: Create the unique index on vct if it does not already exist
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM pg_indexes
        WHERE tablename = 'credential_config'
          AND indexname = 'idx_credential_config_vct_unique'
    ) THEN
        CREATE UNIQUE INDEX idx_credential_config_vct_unique
        ON credential_config(vct)
        WHERE vct IS NOT NULL;
    END IF;
END $$;

-- Step 7: Add comments to the table and columns
COMMENT ON TABLE credential_config IS 'Credential Config: Contains details of credential configuration.';

COMMENT ON COLUMN credential_config.config_id IS 'Credential Config ID: Unique id assigned to save and identify configuration.';
COMMENT ON COLUMN credential_config.status IS 'Credential Config Status: Status of the credential configuration.';
COMMENT ON COLUMN credential_config.vc_template IS 'VC Template: Template used for the verifiable credential.';
COMMENT ON COLUMN credential_config.doctype IS 'Doc Type: Doc Type specifically for Mdoc VC.';
COMMENT ON COLUMN credential_config.vct IS 'VCT field: VC Type specifically for SD-JWT VC.';
COMMENT ON COLUMN credential_config.context IS 'Context: Array of context URIs for the credential.';
COMMENT ON COLUMN credential_config.credential_type IS 'Credential Type: Array of credential types supported.';
COMMENT ON COLUMN credential_config.credential_format IS 'Credential Format: Format of the credential (e.g., JWT, JSON-LD).';
COMMENT ON COLUMN credential_config.did_url IS 'DID URL: Decentralized Identifier URL for the issuer.';
COMMENT ON COLUMN credential_config.key_manager_app_id IS 'Key Manager App Id: AppId of the keymanager';
COMMENT ON COLUMN credential_config.key_manager_ref_id IS 'Key Manager Reference Id: RefId of the keymanager';
COMMENT ON COLUMN credential_config.signature_algo IS 'Signature Algorithm: This is for VC signature or proof algorithm';
COMMENT ON COLUMN credential_config.sd_claim IS 'SD Claim: This is a comma separated list for selective disclosure';
COMMENT ON COLUMN credential_config.display IS 'Display: Credential Display object';
COMMENT ON COLUMN credential_config.display_order IS 'Display Order: Array defining the order of display elements.';
COMMENT ON COLUMN credential_config.scope IS 'Scope: Authorization scope for the credential.';
COMMENT ON COLUMN credential_config.cryptographic_binding_methods_supported IS 'Cryptographic Binding Methods: Array of supported binding methods.';
COMMENT ON COLUMN credential_config.credential_signing_alg_values_supported IS 'Credential Signing Algorithms: Array of supported signing algorithms.';
COMMENT ON COLUMN credential_config.proof_types_supported IS 'Proof Types: JSON object containing supported proof types and their configurations.';
COMMENT ON COLUMN credential_config.credential_subject IS 'Credential Subject: JSON object containing subject attributes schema.';
COMMENT ON COLUMN credential_config.claims IS 'Claims: JSON object containing subject attributes schema specifically for Mdoc VC.';
COMMENT ON COLUMN credential_config.plugin_configurations IS 'Plugin Configurations: Array of JSON objects for plugin configurations.';
COMMENT ON COLUMN credential_config.cr_dtimes IS 'Created DateTime: Date and time when the config was inserted in table.';
COMMENT ON COLUMN credential_config.upd_dtimes IS 'Updated DateTime: Date and time when the config was last updated in table.';