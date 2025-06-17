INSERT INTO certify.credential_template (context, credential_type, template, cr_dtimes, upd_dtimes)
VALUES (
    'https://www.w3.org/2018/credentials/v1',
    'RegistrationReceiptCredential,VerifiableCredential',
    '{
         "@context": [
                 "https://www.w3.org/2018/credentials/v1",
                 "https://mosip.github.io/inji-config/contexts/landregistry-registration-receipt-context.json",
                 "https://w3id.org/security/suites/ed25519-2020/v1"
         ],
         "issuer": "${_issuer}",
         "type": [
             "VerifiableCredential",
             "RegistrationReceiptCredential"
         ],
         "issuanceDate": "${validFrom}",
         "expirationDate": "${validUntil}",
         "credentialSubject": {
            "NumberOfCAR": "${car_registration_number}",
            "RegistrationDate": "${registration_date}",
            "RuralPropertyName": "${rural_property_name}",
            "Municipality": "${municipality}",
            "Latitude": "${latitude}",
            "Longitude": "${longitude}",
            "TotalArea": ${total_area},
            "FiscalModules": ${fiscal_modules},
            "ProtocolCode": "${protocol_code}",
            "CPF": "${cpf}",
            "HolderName": "${holder_name}",
            "TotalDeclaredArea": ${total_area_declared},
            "AdministrativeEasementArea": ${administrative_easement_area},
            "NetArea": ${net_area},
            "ConsolidatedArea": ${consolidated_area},
            "NativeVegetationRemnant": ${native_vegetation_remnant},
            "LegalReserveArea": ${legal_reserve_area},
            "PermanentPreservationArea": ${permanent_preservation_area},
            "RestrictedUseArea": ${restricted_use_area}
         }
     }
', '2024-10-24 12:32:38.065994', NULL);

INSERT INTO certify.credential_template (context, credential_type, template, cr_dtimes, upd_dtimes)
VALUES (
    'https://www.w3.org/2018/credentials/v1',
    'LandStatementCredential,VerifiableCredential',
    '{
         "@context": [
                 "https://www.w3.org/2018/credentials/v1",
                 "https://mosip.github.io/inji-config/contexts/landregistry-statement-context.json",
                 "https://w3id.org/security/suites/ed25519-2020/v1"
         ],
         "issuer": "${_issuer}",
         "type": [
             "VerifiableCredential",
             "LandStatementCredential"
         ],
         "issuanceDate": "${validFrom}",
         "expirationDate": "${validUntil}",
         "credentialSubject": {
            "NumberOfCAR": "${car_registration_number}",
            "RegistrationDate": "${registration_date}",
            "LastModificationDate": "${date_of_last_amendment}",
            "RuralPropertyArea": ${rural_property_area},
            "Latitude": "${latitude}",
            "Longitude": "${longitude}",
            "Municipality": "${municipality}",
            "ExternalCondition": "${external_condition}",
            "RegistrationStatus": "${registration_status}",
            "PRACondition": "${pra_condition}",
            "GroundCoverage": "${land_cover}",
            "NativeVegetationRemnantArea": ${native_vegetation_remnant_area},
            "ConsolidatedRuralArea": ${consolidated_rural_area},
            "AdministrativeEasementArea": ${administrative_easement_area},
            "LegalReserveLocation": "${location_of_legal_reserve}",
            "RegisteredLegalReserveArea": ${registered_legal_reserve_area},
            "GeoreferencedLegalReserveArea": ${georeferenced_legal_reserve_area},
            "ApprovedUnregisteredLegalReserveArea": ${approved_legal_reserve_area_not_registered},
            "ProposedLegalReserveArea": ${proposed_legal_reserve_area},
            "TotalDeclaredLegalReserve": ${total_legal_reserve_declared},
            "PermanentPreservationAreas": ${permanent_preservation_areas_app},
            "APPInConsolidatedRuralArea": ${app_in_consolidated_rural_area},
            "APPInNativeVegetationRemnantArea": ${app_in_native_vegetation_remnant_area},
            "RestrictedUseAreas": ${restricted_use_areas},
            "LegalReserveDeficitOrExcess": ${legal_reserve_deficit_excess},
            "LegalReserveAreaToBeRestored": ${legal_reserve_area_to_recompose},
            "PermanentPreservationAreasToBeRestored": ${permanent_preservation_areas_to_recompose},
            "RestrictedUseAreaToBeRestored": ${restricted_use_area_to_recompose},
            "EmbarggedAreaDescription": "${embargoed_area_description}",
            "EmbarggedAreaProcessingDate": "${embargoed_area_processing_date}",
            "EmbarggedAreaOverlap": ${embargoed_area_overlap},
            "EmbarggedAreaOverlapPercentage": ${embargoed_area_overlap_percentage},
            "ConservationUnitDescription": "${conservation_unit_description}",
            "ConservationUnitProcessingDate": "${conservation_unit_processing_date}",
            "ConservationUnitOverlapArea": ${conservation_unit_overlap_area},
            "ConservationUnitOverlapPercentage": ${conservation_unit_overlap_percentage}
         }
     }
', '2024-10-24 12:32:38.065994', NULL);




INSERT INTO certify.credential_template (context, credential_type, template, cr_dtimes, upd_dtimes)
VALUES (
    'https://www.w3.org/ns/credentials/v2',
    'RegistrationReceiptCredential,VerifiableCredential',
    '{
         "@context": [
                 "https://www.w3.org/ns/credentials/v2",
                 "https://mosip.github.io/inji-config/contexts/landregistry-registration-receipt-context.json",
                 "https://w3id.org/security/suites/ed25519-2020/v1"
         ],
         "issuer": "${_issuer}",
         "type": [
             "VerifiableCredential",
             "RegistrationReceiptCredential"
         ],
         "validFrom": "${validFrom}",
         "validUntil": "${validUntil}",
         "credentialSubject": {
            "NumberOfCAR": "${car_registration_number}",
            "RegistrationDate": "${registration_date}",
            "RuralPropertyName": "${rural_property_name}",
            "Municipality": "${municipality}",
            "Latitude": "${latitude}",
            "Longitude": "${longitude}",
            "TotalArea": ${total_area},
            "FiscalModules": ${fiscal_modules},
            "ProtocolCode": "${protocol_code}",
            "CPF": "${cpf}",
            "HolderName": "${holder_name}",
            "TotalDeclaredArea": ${total_area_declared},
            "AdministrativeEasementArea": ${administrative_easement_area},
            "NetArea": ${net_area},
            "ConsolidatedArea": ${consolidated_area},
            "NativeVegetationRemnant": ${native_vegetation_remnant},
            "LegalReserveArea": ${legal_reserve_area},
            "PermanentPreservationArea": ${permanent_preservation_area},
            "RestrictedUseArea": ${restricted_use_area}
         }
     }
', '2024-10-24 12:32:38.065994', NULL);

INSERT INTO certify.credential_template (context, credential_type, template, cr_dtimes, upd_dtimes)
VALUES (
    'https://www.w3.org/ns/credentials/v2',
    'LandStatementCredential,VerifiableCredential',
    '{
         "@context": [
                 "https://www.w3.org/ns/credentials/v2",
                 "https://mosip.github.io/inji-config/contexts/landregistry-statement-context.json",
                 "https://w3id.org/security/suites/ed25519-2020/v1"
         ],
         "issuer": "${_issuer}",
         "type": [
             "VerifiableCredential",
             "LandStatementCredential"
         ],
         "validFrom": "${validFrom}",
         "validUntil": "${validUntil}",
         "credentialSubject": {
            "NumberOfCAR": "${car_registration_number}",
            "RegistrationDate": "${registration_date}",
            "LastModificationDate": "${date_of_last_amendment}",
            "RuralPropertyArea": ${rural_property_area},
            "Latitude": "${latitude}",
            "Longitude": "${longitude}",
            "Municipality": "${municipality}",
            "ExternalCondition": "${external_condition}",
            "RegistrationStatus": "${registration_status}",
            "PRACondition": "${pra_condition}",
            "GroundCoverage": "${land_cover}",
            "NativeVegetationRemnantArea": ${native_vegetation_remnant_area},
            "ConsolidatedRuralArea": ${consolidated_rural_area},
            "AdministrativeEasementArea": ${administrative_easement_area},
            "LegalReserveLocation": "${location_of_legal_reserve}",
            "RegisteredLegalReserveArea": ${registered_legal_reserve_area},
            "GeoreferencedLegalReserveArea": ${georeferenced_legal_reserve_area},
            "ApprovedUnregisteredLegalReserveArea": ${approved_legal_reserve_area_not_registered},
            "ProposedLegalReserveArea": ${proposed_legal_reserve_area},
            "TotalDeclaredLegalReserve": ${total_legal_reserve_declared},
            "PermanentPreservationAreas": ${permanent_preservation_areas_app},
            "APPInConsolidatedRuralArea": ${app_in_consolidated_rural_area},
            "APPInNativeVegetationRemnantArea": ${app_in_native_vegetation_remnant_area},
            "RestrictedUseAreas": ${restricted_use_areas},
            "LegalReserveDeficitOrExcess": ${legal_reserve_deficit_excess},
            "LegalReserveAreaToBeRestored": ${legal_reserve_area_to_recompose},
            "PermanentPreservationAreasToBeRestored": ${permanent_preservation_areas_to_recompose},
            "RestrictedUseAreaToBeRestored": ${restricted_use_area_to_recompose},
            "EmbarggedAreaDescription": "${embargoed_area_description}",
            "EmbarggedAreaProcessingDate": "${embargoed_area_processing_date}",
            "EmbarggedAreaOverlap": ${embargoed_area_overlap},
            "EmbarggedAreaOverlapPercentage": ${embargoed_area_overlap_percentage},
            "ConservationUnitDescription": "${conservation_unit_description}",
            "ConservationUnitProcessingDate": "${conservation_unit_processing_date}",
            "ConservationUnitOverlapArea": ${conservation_unit_overlap_area},
            "ConservationUnitOverlapPercentage": ${conservation_unit_overlap_percentage}
         }
     }
', '2024-10-24 12:32:38.065994', NULL);