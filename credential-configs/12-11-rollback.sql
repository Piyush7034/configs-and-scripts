-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.
-- -------------------------------------------------------------------------------------------------
-- Database Name: inji_certify
-- Table Name : credential_config, credential_template
-- Purpose    : To remove Certify v0.12.0 changes and make DB ready for Certify v0.11.0
--
-- Create By   	: Piyush Shukla
-- Created Date	: March 2025
--
-- Modified Date        Modified By         Comments / Remarks
-- ------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------

-- Step 1: Drop the new primary key constraint
DO $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM information_schema.table_constraints
        WHERE table_name = 'credential_config'
          AND constraint_name = 'pk_config_id'
    ) THEN
        ALTER TABLE certify.credential_config DROP CONSTRAINT pk_config_id;
    END IF;
END $$;

-- Step 2: Drop the partial unique index
DO $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM pg_indexes
        WHERE tablename = 'credential_config'
          AND indexname = 'idx_credential_config_vct_unique'
    ) THEN
        DROP INDEX idx_credential_config_vct_unique;
    END IF;
END $$;

-- Step 3: Drop all the newly added columns
DO $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM information_schema.columns
        WHERE table_name = 'credential_config'
          AND column_name = 'credential_config_key_id'
    ) THEN
        ALTER TABLE certify.credential_config DROP COLUMN credential_config_key_id;
    END IF;

    IF EXISTS (
        SELECT 1
        FROM information_schema.columns
        WHERE table_name = 'credential_config'
          AND column_name = 'config_id'
    ) THEN
        ALTER TABLE certify.credential_config DROP COLUMN config_id;
    END IF;

    IF EXISTS (
        SELECT 1
        FROM information_schema.columns
        WHERE table_name = 'credential_config'
          AND column_name = 'status'
    ) THEN
        ALTER TABLE certify.credential_config DROP COLUMN status;
    END IF;

    IF EXISTS (
        SELECT 1
        FROM information_schema.columns
        WHERE table_name = 'credential_config'
          AND column_name = 'doctype'
    ) THEN
        ALTER TABLE certify.credential_config DROP COLUMN doctype;
    END IF;

    IF EXISTS (
        SELECT 1
        FROM information_schema.columns
        WHERE table_name = 'credential_config'
          AND column_name = 'vct'
    ) THEN
        ALTER TABLE certify.credential_config DROP COLUMN vct;
    END IF;

    -- Repeat similar checks for all other columns added in the upgrade script
    IF EXISTS (
        SELECT 1
        FROM information_schema.columns
        WHERE table_name = 'credential_config'
          AND column_name = 'credential_format'
    ) THEN
        ALTER TABLE certify.credential_config DROP COLUMN credential_format;
    END IF;

    IF EXISTS (
        SELECT 1
        FROM information_schema.columns
        WHERE table_name = 'credential_config'
          AND column_name = 'did_url'
    ) THEN
        ALTER TABLE certify.credential_config DROP COLUMN did_url;
    END IF;

    IF EXISTS (
        SELECT 1
        FROM information_schema.columns
        WHERE table_name = 'credential_config'
          AND column_name = 'key_manager_app_id'
    ) THEN
        ALTER TABLE certify.credential_config DROP COLUMN key_manager_app_id;
    END IF;

    IF EXISTS (
        SELECT 1
        FROM information_schema.columns
        WHERE table_name = 'credential_config'
          AND column_name = 'key_manager_ref_id'
    ) THEN
        ALTER TABLE certify.credential_config DROP COLUMN key_manager_ref_id;
    END IF;

    IF EXISTS (
        SELECT 1
        FROM information_schema.columns
        WHERE table_name = 'credential_config'
          AND column_name = 'signature_algo'
    ) THEN
        ALTER TABLE certify.credential_config DROP COLUMN signature_algo;
    END IF;

    IF EXISTS (
        SELECT 1
        FROM information_schema.columns
        WHERE table_name = 'credential_config'
          AND column_name = 'sd_claim'
    ) THEN
        ALTER TABLE certify.credential_config DROP COLUMN sd_claim;
    END IF;

    IF EXISTS (
        SELECT 1
        FROM information_schema.columns
        WHERE table_name = 'credential_config'
          AND column_name = 'display'
    ) THEN
        ALTER TABLE certify.credential_config DROP COLUMN display;
    END IF;

    IF EXISTS (
        SELECT 1
        FROM information_schema.columns
        WHERE table_name = 'credential_config'
          AND column_name = 'display_order'
    ) THEN
        ALTER TABLE certify.credential_config DROP COLUMN display_order;
    END IF;

    IF EXISTS (
        SELECT 1
        FROM information_schema.columns
        WHERE table_name = 'credential_config'
          AND column_name = 'scope'
    ) THEN
        ALTER TABLE certify.credential_config DROP COLUMN scope;
    END IF;

    IF EXISTS (
        SELECT 1
        FROM information_schema.columns
        WHERE table_name = 'credential_config'
          AND column_name = 'cryptographic_binding_methods_supported'
    ) THEN
        ALTER TABLE certify.credential_config DROP COLUMN cryptographic_binding_methods_supported;
    END IF;

    IF EXISTS (
        SELECT 1
        FROM information_schema.columns
        WHERE table_name = 'credential_config'
          AND column_name = 'credential_signing_alg_values_supported'
    ) THEN
        ALTER TABLE certify.credential_config DROP COLUMN credential_signing_alg_values_supported;
    END IF;

    IF EXISTS (
        SELECT 1
        FROM information_schema.columns
        WHERE table_name = 'credential_config'
          AND column_name = 'proof_types_supported'
    ) THEN
        ALTER TABLE certify.credential_config DROP COLUMN proof_types_supported;
    END IF;

    IF EXISTS (
        SELECT 1
        FROM information_schema.columns
        WHERE table_name = 'credential_config'
          AND column_name = 'credential_subject'
    ) THEN
        ALTER TABLE certify.credential_config DROP COLUMN credential_subject;
    END IF;

    IF EXISTS (
        SELECT 1
        FROM information_schema.columns
        WHERE table_name = 'credential_config'
          AND column_name = 'claims'
    ) THEN
        ALTER TABLE certify.credential_config DROP COLUMN claims;
    END IF;

    IF EXISTS (
        SELECT 1
        FROM information_schema.columns
        WHERE table_name = 'credential_config'
          AND column_name = 'plugin_configurations'
    ) THEN
        ALTER TABLE certify.credential_config DROP COLUMN plugin_configurations;
    END IF;
END $$;

-- Step 4: Rename vc_template back to template
DO $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM information_schema.columns
        WHERE table_name = 'credential_config'
          AND column_name = 'vc_template'
    ) THEN
        ALTER TABLE certify.credential_config RENAME COLUMN vc_template TO template;

        -- Update existing rows to ensure no NULL values
        UPDATE certify.credential_config SET template = 'default_value' WHERE template IS NULL;

        -- Make the column NOT NULL
        ALTER TABLE certify.credential_config ALTER COLUMN template SET NOT NULL;
    END IF;
END $$;

-- Step 5: Restore the column types to original specifications
DO $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM information_schema.columns
        WHERE table_name = 'credential_config'
          AND column_name = 'template'
    ) THEN
        ALTER TABLE certify.credential_config
            ALTER COLUMN template TYPE VARCHAR;
    END IF;

    IF EXISTS (
        SELECT 1
        FROM information_schema.columns
        WHERE table_name = 'credential_config'
          AND column_name = 'context'
    ) THEN
        ALTER TABLE certify.credential_config
            ALTER COLUMN context TYPE character varying(1024);
    END IF;

     IF EXISTS (
         SELECT 1
         FROM information_schema.columns
         WHERE table_name = 'credential_config'
           AND column_name = 'credential_type'
     ) THEN
         ALTER TABLE certify.credential_config
            ALTER COLUMN credential_type TYPE character varying(1024);
     END IF;
END $$;

-- Step 6: Add back the original primary key constraint
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM information_schema.table_constraints
        WHERE table_name = 'credential_config'
          AND constraint_name = 'pk_template'
    ) THEN
        ALTER TABLE certify.credential_config ADD CONSTRAINT pk_template PRIMARY KEY (template);
    END IF;
END $$;

-- Step 7: Rename the table back to its original name
ALTER TABLE IF EXISTS certify.credential_config RENAME TO credential_template;

COMMENT ON TABLE credential_template IS 'Template Data: Contains velocity template for VC';

COMMENT ON COLUMN credential_template.context IS 'VC Context: Context URL list items separated by comma(,)';
COMMENT ON COLUMN credential_template.credential_type IS 'Credential Type: Credential type list items separated by comma(,)';
COMMENT ON COLUMN credential_template.template IS 'Template Content: Velocity Template to generate the VC';
COMMENT ON COLUMN credential_template.cr_dtimes IS 'Date when the template was inserted in table.';
COMMENT ON COLUMN credential_template.upd_dtimes IS 'Date when the template was last updated in table.';