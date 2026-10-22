package com.metaarch.orgaccess.identity;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

/** Editable staff profile fields. Credentials, username and organization membership are immutable here. */
public record UserUpdateRequest(
    @NotBlank @Size(max = 180) String name,
    @NotBlank @Email @Size(max = 255) String email,
    @Size(max = 30) String mobile,
    @NotBlank String role,
    @NotBlank String status,
    String location) {}
