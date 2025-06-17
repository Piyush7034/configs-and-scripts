Here is a detailed spike document based on the provided points and the code context:

---

### **Spike Document: Validation and Changes for CredentialConfiguration and SD-JWT Stories**

#### **1. CredentialConfig Entity Changes**
- **Current State**:
  - The primary key for `CredentialConfig` includes `context`, `credentialType`, and `format`.
  - These fields are mandatory for all credential formats.

- **Proposed Changes**:
  1. **Remove `context` and `credentialType` from the primary key**:
     - For `mso_mdoc` and `vc+sd-jwt`, `context` and `credentialType` are not required.
     - This change will simplify the primary key structure for these formats.
  2. **Add a condition in the service layer for `ldp_vc`**:
     - Ensure that `context` and `credentialType` are validated only for `ldp_vc`.
  3. **Optional**: Replace the current composite primary key with a single field `credentialConfigKeyId`:
     - This will act as the primary key for all credential formats, making the entity more flexible.

- **Impact**:
  - Database schema changes will be required to update the primary key structure.
  - Service layer logic will need to handle format-specific validations.

---

#### **2. CredentialFormat Validation**
- **Current State**:
  - No specific validation rules are enforced for different credential formats.

- **Proposed Changes**:
  - Add format-specific validation rules:
    1. **`ldp_vc`**:
       - `credentialSubject` is mandatory.
    2. **`mso_mdoc`**:
       - `claims` and `doctype` are mandatory.
    3. **`vc+sd-jwt`**:
       - `claims` is mandatory.
       - Add a new field `vct` in `CredentialConfig` to support this format.

- **Impact**:
  - Validation logic will need to be updated in the service layer.
  - The `CredentialConfig` entity will require a new field `vct`.

---

#### **3. Changes in `CertifyIssuanceServiceImpl` for SD-JWT**
- **Current State**:
  - The `getCredential` method validates `credentialDefinition` for all formats.
  - The `validateLdpVcFormatRequest` method enforces `credentialType` and `context` for all formats.
  - The `getScopeCredentialMapping` method includes a condition for `vc+sd-jwt`.

- **Proposed Changes**:
  1. **Remove `credentialDefinition` dependency for `vc+sd-jwt`**:
     - `vc+sd-jwt` does not require `credentialDefinition`.
     - Skip the `validateLdpVcFormatRequest` method for this format.
  2. **Remove `credentialType` and `context` dependency for `vc+sd-jwt`**:
     - These fields are not required for this format.
  3. **Update `getScopeCredentialMapping`**:
     - Remove the condition for `vc+sd-jwt` as it does not rely on `credentialType` or `context`.

- **Impact**:
  - The `getCredential` method will need format-specific logic.
  - The `validateLdpVcFormatRequest` method will be removed for `vc+sd-jwt`.
  - The `getScopeCredentialMapping` method will be simplified.

---

#### **4. Credential Subject Keys and Order**
- **Current State**:
  - No enforcement of key order or structure in `credentialSubject`.

- **Proposed Changes**:
  - Ensure that the keys and their order in `credentialSubject` are consistent across all formats.
  - Add a utility method to validate and reorder keys if necessary.

- **Impact**:
  - A new utility method will be required to enforce key order.
  - Validation logic will need to be updated in the service layer.

---

#### **Implementation Plan**
1. **Database Changes**:
   - Update the `CredentialConfig` table to:
     - Remove `context` and `credentialType` from the primary key.
     - Add a new field `vct` for `vc+sd-jwt`.
     - Optionally, introduce `credentialConfigKeyId` as the primary key.

2. **Entity Updates**:
   - Modify the `CredentialConfig` entity to reflect the database changes.

3. **Service Layer Updates**:
   - Add format-specific validation logic in `CredentialConfigurationServiceImpl`.
   - Update `CertifyIssuanceServiceImpl` to:
     - Skip `validateLdpVcFormatRequest` for `vc+sd-jwt`.
     - Remove `credentialType` and `context` dependency for `vc+sd-jwt`.
     - Simplify `getScopeCredentialMapping`.

4. **Utility Method**:
   - Create a utility method to validate and reorder `credentialSubject` keys.

5. **Testing**:
   - Add unit tests for the new validation rules.
   - Test the changes for all credential formats (`ldp_vc`, `mso_mdoc`, `vc+sd-jwt`).

---

#### **Risks and Mitigation**
- **Risk**: Breaking existing functionality for `ldp_vc`.
  - **Mitigation**: Add comprehensive tests for `ldp_vc` to ensure backward compatibility.
- **Risk**: Database migration issues.
  - **Mitigation**: Use a migration script to update the schema and data.




---------------------------------------CredentialConfigurationDTO Validation-----------------------------------------


Here are additional changes and suggestions for improving the `CredentialConfigurationDTO` validation and related areas:

---

### **1. Add Validation Annotations in `CredentialConfigurationDTO`**
- Ensure that all required fields in `CredentialConfigurationDTO` are validated using annotations like `@NotNull`, `@NotBlank`, or custom validators.
- Example:
  ```java
  @NotBlank(message = "Format is mandatory")
  private String format;

  @NotNull(message = "Claims cannot be null for vc+sd-jwt")
  private Map<String, Object> claims;

  @NotBlank(message = "Doctype is mandatory for mso_mdoc")
  private String doctype;
  ```

---

### **2. Add Format-Specific Validation Logic**
- Implement a method in the service layer to validate `CredentialConfigurationDTO` based on the `format` field.
- Example:
  ```java
  public void validateCredentialConfiguration(CredentialConfigurationDTO dto) {
      switch (dto.getFormat()) {
          case "ldp_vc":
              if (dto.getCredentialSubject() == null) {
                  throw new InvalidRequestException("CredentialSubject is mandatory for ldp_vc");
              }
              break;
          case "mso_mdoc":
              if (dto.getClaims() == null || dto.getDoctype() == null) {
                  throw new InvalidRequestException("Claims and Doctype are mandatory for mso_mdoc");
              }
              break;
          case "vc+sd-jwt":
              if (dto.getClaims() == null) {
                  throw new InvalidRequestException("Claims are mandatory for vc+sd-jwt");
              }
              if (dto.getVct() == null) {
                  throw new InvalidRequestException("VCT is mandatory for vc+sd-jwt");
              }
              break;
          default:
              throw new InvalidRequestException("Unsupported format: " + dto.getFormat());
      }
  }
  ```

---

### **3. Add Custom Validator for `CredentialSubject` Key Order**
- Create a custom validator to ensure that the keys in `credentialSubject` are in the correct order.
- Example:
  ```java
  @Constraint(validatedBy = CredentialSubjectOrderValidator.class)
  @Target({ ElementType.FIELD })
  @Retention(RetentionPolicy.RUNTIME)
  public @interface ValidCredentialSubjectOrder {
      String message() default "Invalid key order in credentialSubject";
      Class<?>[] groups() default {};
      Class<? extends Payload>[] payload() default {};
  }
  ```

---

### **4. Update `CredentialConfig` Entity**
- Add constraints to ensure data integrity at the database level:
  - Use `@Column(nullable = false)` for mandatory fields.
  - Add unique constraints for fields like `credentialConfigKeyId` if it becomes the primary key.

---

### **5. Enhance Error Handling**
- Add detailed error messages for validation failures in `CredentialConfigurationServiceImpl`.
- Use a centralized exception handler to return meaningful error responses.

---

### **6. Add Unit Tests for Validation**
- Write unit tests to cover all validation scenarios for `CredentialConfigurationDTO`.
- Example:
  ```java
  @Test
  public void testValidateCredentialConfiguration_WithInvalidFormat_ShouldThrowException() {
      CredentialConfigurationDTO dto = new CredentialConfigurationDTO();
      dto.setFormat("invalid_format");
      assertThrows(InvalidRequestException.class, () -> service.validateCredentialConfiguration(dto));
  }
  ```

---

### **7. Add Default Values for Optional Fields**
- Use `@Value` or default initialization for optional fields in `CredentialConfigurationDTO` to avoid null checks.

---

These changes will improve the robustness and maintainability of the validation logic for `CredentialConfigurationDTO`.


------------------------------------------------------------------------------------------------------------------------


---

#### **Conclusion**
The proposed changes will make the system more flexible and aligned with the requirements for `vc+sd-jwt` and `mso_mdoc`. The implementation will require updates to the database schema, entity classes, service layer, and utility methods. Comprehensive testing will ensure that the changes do not break existing functionality.