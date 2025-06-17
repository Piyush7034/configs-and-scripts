ALTER TABLE certify.user_info
ADD COLUMN first_name_primary_latin VARCHAR(100) NOT NULL DEFAULT '',
ADD COLUMN last_name_secondary_latin VARCHAR(100) NOT NULL DEFAULT '';


UPDATE certify.user_info
SET first_name_primary_latin = first_name_primary,
    last_name_secondary_latin = last_name_secondary;






TRUNCATE TABLE certify.credential_template;

INSERT INTO certify.credential_template (context, credential_type, template, cr_dtimes, upd_dtimes) 
VALUES (
  'https://www.w3.org/2018/credentials/v1', 
  'CompassCredential,VerifiableCredential', 
  '## Adjusting the date pattern to match the input format with space and truncate microseconds to milliseconds
	#set( $defaultLocale = $_dateTool.getLocale() )
	#set( $calenderNow = $_dateTool.getCalendar() )
	## Original cr_dtimes has format "yyyy-MM-dd HH:mm:ss.SSSSSS" (six fractional seconds)
	## Truncate to 23 characters to keep three fractional digits (milliseconds)
	#set( $cr_dtimes_trimmed = $cr_dtimes.toString().substring(0,23) )
	## Use pattern matching "yyyy-MM-dd HH:mm:ss.SSS"
	#set( $inputDateTimePattern = "yyyy-MM-dd HH:mm:ss.SSS" )
	#set( $compassIssuedOn = $_dateTool.toDate($inputDateTimePattern, $cr_dtimes_trimmed) )
	## Create a new calendar for the expiration date (5 years from issuance)
	#set( $expirationCalendar = $_dateTool.toCalendar($compassIssuedOn) )
	#set( $void = $expirationCalendar.add(1, 5) ) ## 1 = Calendar.YEAR, add 5 years
	#set( $compassExpiresOn = $expirationCalendar.getTime() )
	## Parse and reformat date_of_birth from yyyy-MM-dd to dd-MM-yyyy
	#set( $dobDate = $_dateTool.toDate(''yyyy-MM-dd'', $date_of_birth) )
	#set( $formattedDOB = $_dateTool.format(''dd-MM-yyyy'', $dobDate) )
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
			"firstNameLatin": "${first_name_primary_latin}",
			"lastNameLatin": "${last_name_secondary_latin}",
	        "nationalIDNumber": "${national_uid}", 
	        "dateOfBirth": "${formattedDOB}",
	        "nationality": "${nationality}",
	        "gender": "${gender}",
	        "cardAccessNumber": "${card_access_number}", 
	        "birthCountry": "${birth_country}",
	        "face": "${face_image_color}", 
	        "compassId": "${compass_id}",
	        "compassIssuanceDate": "${_dateTool.format(''dd-MM-yyyy'', $compassIssuedOn)}",
	        "compassExpirationDate": "${_dateTool.format(''dd-MM-yyyy'', $compassExpiresOn)}"
	    }
	}', 
  Now(), 
  NULL
);