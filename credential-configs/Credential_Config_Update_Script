-- 1. Rename column `vct` → `sd_jwt_vct`
ALTER TABLE credential_config RENAME COLUMN vct TO sd_jwt_vct;

-- 2. Drop old primary key constraint
ALTER TABLE credential_config DROP CONSTRAINT pk_config_id;

-- 3. Drop NOT NULL constraints from columns no longer required to be NOT NULL
ALTER TABLE credential_config
    ALTER COLUMN context DROP NOT NULL,
    ALTER COLUMN credential_type DROP NOT NULL,
    ALTER COLUMN did_url DROP NOT NULL,
    ALTER COLUMN key_manager_app_id DROP NOT NULL;

-- 4. Set `config_id` to NOT NULL
ALTER TABLE credential_config
    ALTER COLUMN config_id SET NOT NULL;



-- 5. Create new primary key on `config_id`
ALTER TABLE credential_config ADD CONSTRAINT pk_config_id PRIMARY KEY (config_id);

-- 6. Drop old unique index on `vct`
DROP INDEX IF EXISTS idx_credential_config_vct_unique;

-- 7. Create new indexes
CREATE UNIQUE INDEX idx_credential_config_type_context_unique
ON credential_config(credential_type, context, credential_format)
WHERE credential_type IS NOT NULL AND credential_type <> ''
  AND context IS NOT NULL AND context <> '';

CREATE UNIQUE INDEX idx_credential_config_sd_jwt_vct_unique
ON credential_config(sd_jwt_vct, credential_format)
WHERE sd_jwt_vct IS NOT NULL AND sd_jwt_vct <> '';

CREATE UNIQUE INDEX idx_credential_config_doctype_unique
ON credential_config(doctype, credential_format)
WHERE doctype IS NOT NULL AND doctype <> '';

