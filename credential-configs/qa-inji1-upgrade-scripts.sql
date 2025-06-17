ALTER TABLE certify.credential_config
    ADD COLUMN IF NOT EXISTS vct VARCHAR;

ALTER TABLE certify.credential_config ALTER COLUMN vc_template DROP NOT NULL;
ALTER TABLE certify.credential_config ALTER COLUMN did_url DROP NOT NULL;
ALTER TABLE certify.credential_config ALTER COLUMN key_manager_app_id DROP NOT NULL;

CREATE UNIQUE INDEX idx_credential_config_vct_unique
ON credential_config(vct)
WHERE vct IS NOT NULL;

CREATE UNIQUE INDEX idx_credential_config_doctype_unique
ON credential_config(doctype)
WHERE doctype IS NOT NULL;