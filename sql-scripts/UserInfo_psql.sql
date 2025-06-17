CREATE TABLE user_info (
    user_info_id UUID PRIMARY KEY NOT NULL,
    compass_id VARCHAR(20),
    birth_country VARCHAR(255) NOT NULL,
    card_access_number BIGINT  CHECK (card_access_number BETWEEN 1000000000 AND 9999999999),
    date_of_birth DATE NOT NULL,
    email VARCHAR(255),
    face_image_color TEXT NOT NULL,
    face_image_grey TEXT NOT NULL,
    first_name_primary VARCHAR(100) NOT NULL,
    gender VARCHAR(50) NOT NULL,
    last_name_secondary VARCHAR(100) NOT NULL,
    first_name_primary_latin VARCHAR(100) NOT NULL,
    last_name_secondary_latin VARCHAR(100) NOT NULL,
    national_uid VARCHAR(255) NOT NULL,
    nationality VARCHAR(255) NOT NULL,
	cr_dtimes TIMESTAMP NOT NULL,
    upd_dtimes TIMESTAMP,
    CONSTRAINT uk_user_info_national_uid UNIQUE (national_uid)
);



-- Insert credential templates
INSERT INTO certify.credential_template (context, credential_type, template, cr_dtimes, upd_dtimes) 
VALUES (
  'https://www.w3.org/2018/credentials/v1', 
  'CompassCredential,VerifiableCredential', 
  '##Here we are injecting DateTool instance from java velocity library to set the expiry date
	#set( $defaultLocale = $_dateTool.getLocale() )
	#set( $calenderNow = $_dateTool.getCalendar() )
	#set( $ISO8601DateTimeWithMillisUTC = "yyyy-MM-dd''T''HH:mm:ss.SSS''Z''" )
	#set( $compassIssuedOn = $_dateTool.toDate($ISO8601DateTimeWithMillisUTC, ${validFrom}))
	## Create a new calendar for the expiration date (5 years from issuance)
	#set( $expirationCalendar = $_dateTool.toCalendar($compassIssuedOn) )
	#set( $void = $expirationCalendar.add(1, 5) )
	#set( $compassExpiresOn = $expirationCalendar.getTime() )
	{
		"@context": [
			"https://www.w3.org/2018/credentials/v1",
			"https://mosip.github.io/inji-config/contexts/compass-context.json",
			"https://w3id.org/security/suites/ed25519-2020/v1"
		],
		"issuer": "${_issuer}",
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
			"compassIssuanceDate": "${_dateTool.format(''yyyy-dd-MM'', $compassIssuedOn)}",
			"compassExpirationDate": "${_dateTool.format(''yyyy-dd-MM'', $compassExpiresOn)}"
		}
	}', 
  Now(), 
  NULL
);