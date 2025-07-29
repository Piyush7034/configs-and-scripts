-- Step 1: Alter columns to set default values to empty lists and objects
ALTER TABLE certify.credential_config
    ALTER COLUMN cryptographic_binding_methods_supported SET DEFAULT ARRAY[]::TEXT[],
    ALTER COLUMN credential_signing_alg_values_supported SET DEFAULT ARRAY[]::TEXT[],
    ALTER COLUMN proof_types_supported SET DEFAULT '{}'::jsonb;

-- Step 2: Update the columns with the given values
UPDATE certify.credential_config
SET cryptographic_binding_methods_supported = ARRAY['did:jwk', 'did:key']
WHERE cryptographic_binding_methods_supported = ARRAY[]::TEXT[];

UPDATE certify.credential_config
SET credential_signing_alg_values_supported = ARRAY['Ed25519Signature2020']
WHERE credential_signing_alg_values_supported = ARRAY[]::TEXT[];

UPDATE certify.credential_config
SET proof_types_supported = '{"jwt": {"proof_signing_alg_values_supported": ["RS256", "ES256", "PS256", "Ed25519"]}}'::jsonb
WHERE proof_types_supported = '{}'::jsonb;