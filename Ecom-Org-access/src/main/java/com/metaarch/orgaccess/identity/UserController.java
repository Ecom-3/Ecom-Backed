package com.metaarch.orgaccess.identity;

import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/users")
public class UserController {
  private final IdentityService identities;
  public UserController(IdentityService identities) { this.identities = identities; }

  @PostMapping
  @ResponseStatus(HttpStatus.CREATED)
  // The Super Admin role is the explicit authority for staff provisioning in the admin UI.
  // Keep the role guard here so stale/mismatched supplemental permission grants cannot block
  // the configured Super Admin account, and cannot authorize a non-admin with USER_WRITE alone.
  @PreAuthorize("hasRole('SUPER_ADMIN')")
  public UserSummary create(@Valid @RequestBody UserCreateRequest request, Authentication authentication) {
    UserAccount user = identities.create(request, authentication.getName());
    return new UserSummary(user.getId(), user.getUsername(), user.getEmail());
  }

  @GetMapping
  @PreAuthorize("hasRole('SUPER_ADMIN')")
  public java.util.List<IdentityService.StaffSummary> list(Authentication authentication) {
    return identities.listStaff(authentication.getName());
  }

  @PutMapping("/{id}")
  @PreAuthorize("hasRole('SUPER_ADMIN')")
  public UserSummary update(@PathVariable Long id, @Valid @RequestBody UserUpdateRequest request,
      Authentication authentication) {
    UserAccount user = identities.updateStaff(id, request, authentication.getName());
    return new UserSummary(user.getId(), user.getUsername(), user.getEmail());
  }

  @PutMapping("/me/password")
  @ResponseStatus(HttpStatus.NO_CONTENT)
  public void changeMyPassword(@Valid @RequestBody PasswordChangeRequest request, Authentication authentication) {
    identities.changePassword(authentication.getName(), request.currentPassword(), request.newPassword());
  }

  public record UserSummary(Long id, String username, String email) {}
}
