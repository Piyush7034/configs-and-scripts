INSERT INTO certify.credential_template (context, credential_type, template, cr_dtimes, upd_dtimes) VALUES ('https://www.w3.org/2018/credentials/v1', 'CompassCredential,VerifiableCredential', '{
    "@context": [
        "https://www.w3.org/2018/credentials/v1",
        "https://mosip.github.io/inji-config/contexts/compass-context.json",
        "https://w3id.org/security/suites/ed25519-2020/v1"
    ],
    "issuer": "${issuer}",
    "type": [
        "VerifiableCredential",
        "CompassCredential"
    ],
    "issuanceDate": "${validFrom}",
    "expirationDate": "${validUntil}",
    "credentialSubject": {
		"id": "${_holderId}",
        "firstName": "${first_name_primary}",
        "lastName": "${last_name_secondary}",
        "nationalIDNumber": "${national_uid}", 
        "dateOfBirth": "${date_of_birth}",
        "nationality": "${nationality}",
        "gender": "${gender}",
        "cardAccessNumber": "${card_access_number}", 
        "birthCountry": "${birth_country}",
        "face": "${face_image_color}", 
        "compassId": "${compass_id}",
		"compassIssuanceDate": "${validFrom}",
		"compassExpirationDate": "${validUntil}"
    }
}', Now(), NULL);