package com.metaarch.orgaccess.identity;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.ArgumentCaptor.forClass;

import com.metaarch.orgaccess.audit.AuditLogRepository;
import java.util.List;
import java.util.Optional;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.util.ReflectionTestUtils;

class IdentityServiceTest {
  private final UserAccountRepository users = mock(UserAccountRepository.class);
  private final MembershipRepository memberships = mock(MembershipRepository.class);
  private final RoleRepository roles = mock(RoleRepository.class);
  private final PasswordEncoder passwordEncoder = mock(PasswordEncoder.class);
  private final AuditLogRepository auditLogs = mock(AuditLogRepository.class);
  private final JdbcTemplate customerDb = mock(JdbcTemplate.class);
  private IdentityService service;

  @BeforeEach
  void setUp() {
    service = new IdentityService(users, memberships, roles, passwordEncoder, auditLogs);
    ReflectionTestUtils.setField(service, "customerDb", customerDb);
  }

  @Test
  void requiresAnEnabledUnlockedUser() {
    UserAccount user = user("alice");
    when(users.findByUsernameIgnoreCase("alice")).thenReturn(Optional.of(user));

    assertThat(service.requireUser("alice")).isSameAs(user);
  }

  @Test
  void resetsOnlyAssignedStoreManagerPasswordAndRevokesExistingSessions() {
    UserAccount target = user("manager");
    target.getRoles().add(role("STORE_MANAGER", "ORDER_READ"));
    Membership membership = new Membership();
    membership.setUser(target);
    membership.setRole(role("STORE_MANAGER", "ORDER_READ"));
    membership.setOrganizationId("metaarch-commerce");
    membership.setLocationId("hyderabad");
    membership.setStoreId("store-sr-nagar-store");
    when(users.findWithRolesById(235L)).thenReturn(Optional.of(target));
    when(memberships.findByUserId(235L)).thenReturn(List.of(membership));
    when(passwordEncoder.encode("NewTestPassword123")).thenReturn("encoded-value");

    service.resetStoreManagerPassword(235L, "NewTestPassword123", "root-admin");

    assertThat(target.getPasswordHash()).isEqualTo("encoded-value");
    assertThat(target.getTokenVersion()).isEqualTo(1);
    org.mockito.ArgumentCaptor<com.metaarch.orgaccess.audit.AuditLog> audit =
        org.mockito.ArgumentCaptor.forClass(com.metaarch.orgaccess.audit.AuditLog.class);
    verify(auditLogs).save(audit.capture());
    assertThat(audit.getValue().getAction()).isEqualTo("RESET_STORE_MANAGER_PASSWORD");
  }

  @Test
  void refusesPasswordResetForMisassignedOrNonStoreManagerAccount() {
    UserAccount target = user("admin-target");
    target.getRoles().add(role("GLOBAL_ADMIN", "USER_READ"));
    Membership membership = new Membership();
    membership.setUser(target);
    membership.setRole(role("GLOBAL_ADMIN", "USER_READ"));
    membership.setOrganizationId("metaarch-commerce");
    when(users.findWithRolesById(7L)).thenReturn(Optional.of(target));
    when(memberships.findByUserId(7L)).thenReturn(List.of(membership));

    assertThatThrownBy(() -> service.resetStoreManagerPassword(7L, "NewTestPassword123", "root-admin"))
        .isInstanceOf(org.springframework.security.access.AccessDeniedException.class);
    assertThat(target.getPasswordHash()).isNull();
    assertThat(target.getTokenVersion()).isZero();
    org.mockito.Mockito.verifyNoInteractions(auditLogs);
  }

  @Test
  void rejectsMissingDisabledAndLockedUsers() {
    when(users.findByUsernameIgnoreCase("missing")).thenReturn(Optional.empty());
    assertThatThrownBy(() -> service.requireUser("missing"))
        .isInstanceOf(org.springframework.security.core.userdetails.UsernameNotFoundException.class);

    UserAccount disabled = user("disabled");
    disabled.setEnabled(false);
    when(users.findByUsernameIgnoreCase("disabled")).thenReturn(Optional.of(disabled));
    assertThatThrownBy(() -> service.requireUser("disabled"))
        .isInstanceOf(org.springframework.security.core.userdetails.UsernameNotFoundException.class);

    UserAccount locked = user("locked");
    locked.setLocked(true);
    when(users.findByUsernameIgnoreCase("locked")).thenReturn(Optional.of(locked));
    assertThatThrownBy(() -> service.requireUser("locked"))
        .isInstanceOf(org.springframework.security.core.userdetails.UsernameNotFoundException.class);
  }

  @Test
  void combinesRolePermissionAndMembershipScopeAuthorities() {
    UserAccount user = user("manager");
    Role role = role("STORE_MANAGER", "ORDER_READ");
    user.getRoles().add(role);
    Membership membership = new Membership();
    membership.setRole(role("DELIVERY_PARTNER", "DELIVERY_READ"));
    membership.setOrganizationId("org-1");
    membership.setLocationId("loc-1");
    membership.setStoreId("store-1");
    when(memberships.findByUserUsernameIgnoreCase("manager")).thenReturn(List.of(membership));

    assertThat(service.authorities(user)).containsExactlyInAnyOrder(
        new SimpleGrantedAuthority("ROLE_STORE_MANAGER"),
        new SimpleGrantedAuthority("PERM_ORDER_READ"),
        new SimpleGrantedAuthority("ROLE_DELIVERY_PARTNER"),
        new SimpleGrantedAuthority("PERM_DELIVERY_READ"),
        new SimpleGrantedAuthority("SCOPE_ORGANIZATION:org-1"),
        new SimpleGrantedAuthority("SCOPE_LOCATION:loc-1"),
        new SimpleGrantedAuthority("SCOPE_STORE:store-1"));
  }

  @Test
  void superAdminListsStaffFromAccountRoleWithoutRequiringAnAdminMembership() {
    UserAccount actor = user("root-admin");
    actor.getRoles().add(role("SUPER_ADMIN", "USER_READ"));
    when(users.findByUsernameIgnoreCase("root-admin")).thenReturn(Optional.of(actor));
    when(memberships.findByUserUsernameIgnoreCase("root-admin")).thenReturn(List.of());

    UserAccount manager = user("manager");
    Membership assignment = new Membership();
    assignment.setUser(manager);
    assignment.setRole(role("STORE_MANAGER", "ORDER_READ"));
    assignment.setOrganizationId("metaarch-commerce");
    assignment.setLocationId("hyderabad");
    when(memberships.findByOrganizationIdIgnoreCase("metaarch-commerce")).thenReturn(List.of(assignment));

    assertThat(service.listStaff("root-admin"))
        .extracting(IdentityService.StaffSummary::username)
        .containsExactly("manager");
  }

  @Test
  void provisionsOAuthUserWithStableDefaults() {
    when(users.findByOauthSubject("subject-1")).thenReturn(Optional.empty());
    when(users.save(any(UserAccount.class))).thenAnswer(invocation -> invocation.getArgument(0));

    UserAccount result = service.provisionOAuthUser("subject-1", null, null);

    assertThat(result.getOauthSubject()).isEqualTo("subject-1");
    assertThat(result.getEmail()).isEqualTo("subject-1@oauth.local");
    assertThat(result.getUsername()).isEqualTo("subject-1@oauth.local");
    verify(auditLogs).save(any());
  }

  @Test
  void changesPasswordOnlyAfterVerifyingCurrentPassword() {
    UserAccount user = user("alice");
    user.setPasswordHash("old-hash");
    when(users.findByUsernameIgnoreCase("alice")).thenReturn(Optional.of(user));
    when(passwordEncoder.matches("old", "old-hash")).thenReturn(true);
    when(passwordEncoder.encode("new")).thenReturn("new-hash");

    service.changePassword("alice", "old", "new");

    assertThat(user.getPasswordHash()).isEqualTo("new-hash");
    verify(auditLogs).save(any());
  }

  @Test
  void doesNotChangePasswordWhenCurrentPasswordIsWrong() {
    UserAccount user = user("alice");
    user.setPasswordHash("old-hash");
    when(users.findByUsernameIgnoreCase("alice")).thenReturn(Optional.of(user));
    when(passwordEncoder.matches("wrong", "old-hash")).thenReturn(false);

    assertThatThrownBy(() -> service.changePassword("alice", "wrong", "new"))
        .isInstanceOf(IllegalArgumentException.class);
    assertThat(user.getPasswordHash()).isEqualTo("old-hash");
  }

  @Test
  void rejectsDuplicateUsersBeforePersistingAnything() {
    when(users.existsByUsernameIgnoreCase("alice")).thenReturn(true);
    UserCreateRequest request = new UserCreateRequest(" alice ", "alice@example.com", "password", "CUSTOMER",
        null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

    assertThatThrownBy(() -> service.create(request, "admin"))
        .isInstanceOf(DuplicateUserContactException.class)
        .satisfies(error -> assertThat(((DuplicateUserContactException) error).fields())
            .containsEntry("username", "This username is already registered. Choose another username."));
  }

  @Test
  void rejectsEmailAlreadyClaimedByAnotherAccountWithEmailFieldError() {
    when(users.existsByUsernameIgnoreCase("alice")).thenReturn(false);
    when(users.existsByEmailIgnoreCase("alice@example.com")).thenReturn(false);
    when(customerDb.queryForObject(anyString(), eq(Integer.class), eq("email:alice@example.com"))).thenReturn(1);
    UserCreateRequest request = new UserCreateRequest("alice", "alice@example.com", "password", "CUSTOMER",
        null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

    assertThatThrownBy(() -> service.create(request, "admin"))
        .isInstanceOf(DuplicateUserContactException.class)
        .satisfies(error -> assertThat(((DuplicateUserContactException) error).fields())
            .containsKey("email").doesNotContainKey("mobile"));
    verify(users, org.mockito.Mockito.never()).save(any(UserAccount.class));
  }

  @Test
  void rejectsMobileAlreadyClaimedByAnotherAccountWithMobileFieldError() {
    when(users.existsByUsernameIgnoreCase("alice")).thenReturn(false);
    when(users.existsByEmailIgnoreCase("alice@example.com")).thenReturn(false);
    when(customerDb.queryForObject(anyString(), eq(Integer.class), eq("email:alice@example.com"))).thenReturn(0);
    when(customerDb.queryForObject(anyString(), eq(Integer.class), eq("mobile:918639616977"))).thenReturn(1);
    UserCreateRequest request = new UserCreateRequest("alice", "alice@example.com", "password", "CUSTOMER",
        null, "+918639616977", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

    assertThatThrownBy(() -> service.create(request, "admin"))
        .isInstanceOf(DuplicateUserContactException.class)
        .satisfies(error -> assertThat(((DuplicateUserContactException) error).fields())
            .containsKey("mobile").doesNotContainKey("email"));
    verify(users, org.mockito.Mockito.never()).save(any(UserAccount.class));
  }

  @Test
  void rejectsUnknownRolesBeforeWritingCustomerData() {
    when(users.existsByUsernameIgnoreCase("alice")).thenReturn(false);
    when(users.existsByEmailIgnoreCase("alice@example.com")).thenReturn(false);
    when(roles.findByName("CUSTOMER")).thenReturn(Optional.empty());
    UserCreateRequest request = new UserCreateRequest("alice", "alice@example.com", "password", "ROLE_CUSTOMER",
        null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

    assertThatThrownBy(() -> service.create(request, "admin"))
        .isInstanceOf(IllegalArgumentException.class)
        .hasMessage("Unknown role");
  }

  @Test
  void persistsLocationAdminAndUsesAuthenticatedActorForMembershipAttribution() {
    Role locationAdminRole = role("LOCATION_ADMIN", "USER_READ");
    when(users.existsByUsernameIgnoreCase("new-location-admin")).thenReturn(false);
    when(users.existsByEmailIgnoreCase("new-location-admin@example.com")).thenReturn(false);
    when(roles.findByName("LOCATION_ADMIN")).thenReturn(Optional.of(locationAdminRole));
    when(passwordEncoder.encode("ValidPass123")).thenReturn("encoded-password");
    when(users.save(any(UserAccount.class))).thenAnswer(invocation -> invocation.getArgument(0));
    UserCreateRequest request = new UserCreateRequest("new-location-admin", "new-location-admin@example.com",
        "ValidPass123", "LOCATION_ADMIN", "Location Admin", "+918639616977", "Active", "metaarch-commerce",
        "hyderabad", null, null, null, null, null, null, null, null, null, null, null,
        "spoofed-client-identity");

    UserAccount created = service.create(request, "authenticated-super-admin");

    assertThat(created.getUsername()).isEqualTo("new-location-admin");
    assertThat(created.getEmail()).isEqualTo("new-location-admin@example.com");
    assertThat(created.getPasswordHash()).isEqualTo("encoded-password");
    assertThat(created.getRoles()).contains(locationAdminRole);
    var membership = forClass(Membership.class);
    verify(memberships).save(membership.capture());
    assertThat(membership.getValue().getUser()).isSameAs(created);
    assertThat(membership.getValue().getRole()).isSameAs(locationAdminRole);
    assertThat(membership.getValue().getOrganizationId()).isEqualTo("metaarch-commerce");
    assertThat(membership.getValue().getLocationId()).isEqualTo("hyderabad");
    assertThat(membership.getValue().getStoreId()).isNull();
    assertThat(membership.getValue().getStoreName()).isNull();
    assertThat(membership.getValue().getAssignedBy()).isEqualTo("authenticated-super-admin");
    verify(auditLogs).save(any());
    verify(customerDb).update(anyString(), eq("email:new-location-admin@example.com"), eq((Object) null));
  }

  @Test
  void locationAdminCreatesStoreManagerOnlyAtAnAlreadyManagedStoreInTheirLocation() {
    Role adminRole = role("LOCATION_ADMIN", "USER_READ");
    Membership admin = new Membership();
    admin.setRole(adminRole);
    admin.setOrganizationId("metaarch-commerce");
    admin.setLocationId("hyderabad");
    when(memberships.findByUserUsernameIgnoreCase("location-admin")).thenReturn(List.of(admin));

    Role managerRole = role("STORE_MANAGER", "ORDER_READ");
    Membership assignedStore = new Membership();
    assignedStore.setRole(managerRole);
    assignedStore.setOrganizationId("metaarch-commerce");
    assignedStore.setLocationId("hyderabad");
    assignedStore.setStoreId("store-sr-nagar");
    assignedStore.setStoreName("SR Nagar Store");
    when(memberships.findByLocationIdIgnoreCaseAndRole_Name("hyderabad", "STORE_MANAGER"))
        .thenReturn(List.of(assignedStore));

    UserCreateRequest request = new UserCreateRequest("new-manager", "new-manager@example.test", "ValidPass123",
        "STORE_MANAGER", "New Manager", null, "Active", "metaarch-commerce", "hyderabad", "store-sr-nagar",
        "SR Nagar Store", "Hyderabad", "Address", null, null, null, null, null, null, null, null);
    when(users.existsByUsernameIgnoreCase("new-manager")).thenReturn(false);
    when(users.existsByEmailIgnoreCase("new-manager@example.test")).thenReturn(false);
    when(customerDb.queryForObject(anyString(), eq(Integer.class), eq("email:new-manager@example.test"))).thenReturn(0);
    when(roles.findByName("STORE_MANAGER")).thenReturn(Optional.of(managerRole));
    when(passwordEncoder.encode("ValidPass123")).thenReturn("encoded");
    when(users.save(any(UserAccount.class))).thenAnswer(invocation -> invocation.getArgument(0));

    service.createManagedStoreManager(request, "location-admin");

    var membership = forClass(Membership.class);
    verify(memberships).save(membership.capture());
    assertThat(membership.getValue().getLocationId()).isEqualTo("hyderabad");
    assertThat(membership.getValue().getStoreId()).isEqualTo("store-sr-nagar");
    assertThat(membership.getValue().getStoreName()).isEqualTo("SR Nagar Store");
  }

  @Test
  void locationAdminCannotCreateStoreManagerOutsideTheirLocationOrStoreAssignments() {
    Role adminRole = role("LOCATION_ADMIN", "USER_READ");
    Membership admin = new Membership();
    admin.setRole(adminRole);
    admin.setOrganizationId("metaarch-commerce");
    admin.setLocationId("hyderabad");
    when(memberships.findByUserUsernameIgnoreCase("location-admin")).thenReturn(List.of(admin));
    UserCreateRequest foreignLocation = new UserCreateRequest("new-manager", "new-manager@example.test",
        "ValidPass123", "STORE_MANAGER", "New Manager", null, "Active", "metaarch-commerce", "other-city",
        "foreign-store", "Foreign Store", "other-city", "Address", null, null, null, null, null, null, null, null);

    assertThatThrownBy(() -> service.createManagedStoreManager(foreignLocation, "location-admin"))
        .isInstanceOf(org.springframework.security.access.AccessDeniedException.class)
        .hasMessageContaining("assigned location");
    org.mockito.Mockito.verify(users, org.mockito.Mockito.never()).save(any(UserAccount.class));

    UserCreateRequest unassignedStore = new UserCreateRequest("new-manager", "new-manager@example.test",
        "ValidPass123", "STORE_MANAGER", "New Manager", null, "Active", "metaarch-commerce", "hyderabad",
        "foreign-store", "Foreign Store", "hyderabad", "Address", null, null, null, null, null, null, null, null);
    when(memberships.findByLocationIdIgnoreCaseAndRole_Name("hyderabad", "STORE_MANAGER")).thenReturn(List.of());
    assertThatThrownBy(() -> service.createManagedStoreManager(unassignedStore, "location-admin"))
        .isInstanceOf(org.springframework.security.access.AccessDeniedException.class)
        .hasMessageContaining("already assigned within your location");
    org.mockito.Mockito.verify(users, org.mockito.Mockito.never()).save(any(UserAccount.class));
  }

  @Test
  void locationAdminCannotEditStoreManagerOutsideTheirLocation() {
    Role managerRole = role("STORE_MANAGER", "ORDER_READ");
    UserAccount manager = user("manager");
    manager.setEmail("manager@example.test");
    manager.setMobile("9876500000");
    manager.getRoles().add(managerRole);
    Membership membership = new Membership();
    membership.setUser(manager);
    membership.setRole(managerRole);
    membership.setOrganizationId("metaarch-commerce");
    membership.setLocationId("other-city");
    when(memberships.findByUserUsernameIgnoreCase("location-admin")).thenReturn(List.of(locationAdminMembership("hyderabad")));
    when(memberships.findByUserId(99L)).thenReturn(List.of(membership));

    UserUpdateRequest request = new UserUpdateRequest("Changed", "manager@example.test", "9876500000",
        "STORE_MANAGER", "Active", "other-city");
    assertThatThrownBy(() -> service.updateManagedStoreManager(99L, request, "location-admin"))
        .isInstanceOf(org.springframework.security.access.AccessDeniedException.class)
        .hasMessageContaining("outside your assigned location");
    org.mockito.Mockito.verify(users, org.mockito.Mockito.never()).save(any(UserAccount.class));
  }

  private Membership locationAdminMembership(String location) {
    Membership membership = new Membership();
    membership.setRole(role("LOCATION_ADMIN", "USER_READ"));
    membership.setOrganizationId("metaarch-commerce");
    membership.setLocationId(location);
    return membership;
  }
  @Test
  void createsGlobalAdminWithoutLocationOrGlobalAdminParent() {
    Role globalAdminRole = role("GLOBAL_ADMIN", "CATALOG_WRITE");
    when(users.existsByUsernameIgnoreCase("new-global-admin")).thenReturn(false);
    when(users.existsByEmailIgnoreCase("new-global-admin@example.com")).thenReturn(false);
    when(roles.findByName("GLOBAL_ADMIN")).thenReturn(Optional.of(globalAdminRole));
    when(passwordEncoder.encode("ValidPass123")).thenReturn("encoded-password");
    when(users.save(any(UserAccount.class))).thenAnswer(invocation -> invocation.getArgument(0));
    UserCreateRequest request = new UserCreateRequest("new-global-admin", "new-global-admin@example.com",
        "ValidPass123", "GLOBAL_ADMIN", "Global Admin", null, "Active", null, null,
        null, null, null, null, null, null, null, null, null, null, null, null);

    UserAccount created = service.create(request, "authenticated-super-admin");

    assertThat(created.getRoles()).contains(globalAdminRole);
    var membership = forClass(Membership.class);
    verify(memberships).save(membership.capture());
    assertThat(membership.getValue().getOrganizationId()).isEqualTo("metaarch-commerce");
    assertThat(membership.getValue().getLocationId()).isNull();
    assertThat(membership.getValue().getAssignedBy()).isEqualTo("authenticated-super-admin");
  }

  @Test
  void rejectsInvalidLocationAdminAssignmentBeforeCreatingAccount() {
    when(users.existsByUsernameIgnoreCase("unassigned-location-admin")).thenReturn(false);
    when(users.existsByEmailIgnoreCase("unassigned@example.com")).thenReturn(false);
    when(roles.findByName("LOCATION_ADMIN")).thenReturn(Optional.of(role("LOCATION_ADMIN", "USER_READ")));
    UserCreateRequest request = new UserCreateRequest("unassigned-location-admin", "unassigned@example.com",
        "ValidPass123", "LOCATION_ADMIN", "Location Admin", null, "Active", null, null,
        null, null, null, null, null, null, null, null, null, null, null, null);

    assertThatThrownBy(() -> service.create(request, "authenticated-super-admin"))
        .isInstanceOf(IllegalArgumentException.class)
        .hasMessage("Location is required for a Location Admin");
    org.mockito.Mockito.verify(users, org.mockito.Mockito.never()).save(any(UserAccount.class));
    org.mockito.Mockito.verify(memberships, org.mockito.Mockito.never()).save(any(Membership.class));
  }

  @Test
  void rejectsClientSuppliedOrganizationOutsideManagedAdminOrganization() {
    when(users.existsByUsernameIgnoreCase("foreign-org-admin")).thenReturn(false);
    when(users.existsByEmailIgnoreCase("foreign-org@example.com")).thenReturn(false);
    when(roles.findByName("GLOBAL_ADMIN")).thenReturn(Optional.of(role("GLOBAL_ADMIN", "USER_READ")));
    UserCreateRequest request = new UserCreateRequest("foreign-org-admin", "foreign-org@example.com",
        "ValidPass123", "GLOBAL_ADMIN", "Global Admin", null, "Active", "untrusted-org", null,
        null, null, null, null, null, null, null, null, null, null, null, null);

    assertThatThrownBy(() -> service.create(request, "authenticated-super-admin"))
        .isInstanceOf(org.springframework.security.access.AccessDeniedException.class)
        .hasMessage("Administrator account is outside the managed organization");
    org.mockito.Mockito.verify(users, org.mockito.Mockito.never()).save(any(UserAccount.class));
  }

  @Test
  void updatesLocationAdminWithinOrganizationAndPreservesCredentials() {
    UserAccount target = user("location-admin");
    target.setPasswordHash("unchanged-hash");
    Role oldRole = role("LOCATION_ADMIN", "USER_READ");
    Role nextRole = role("LOCATION_ADMIN", "USER_READ");
    target.getRoles().add(oldRole);
    Membership membership = new Membership();
    membership.setUser(target); membership.setRole(oldRole); membership.setOrganizationId("metaarch-commerce");
    membership.setLocationId("hyderabad");
    when(users.findWithRolesById(7L)).thenReturn(Optional.of(target));
    when(memberships.findByUserId(7L)).thenReturn(List.of(membership));
    when(roles.findByName("LOCATION_ADMIN")).thenReturn(Optional.of(nextRole));

    UserAccount saved = service.updateStaff(7L,
        new UserUpdateRequest("Updated Name", "location-admin@example.com", "9876543210", "LOCATION_ADMIN", "Active", "secunderabad"),
        "root-admin");

    assertThat(saved.getDisplayName()).isEqualTo("Updated Name");
    assertThat(saved.getPasswordHash()).isEqualTo("unchanged-hash");
    assertThat(membership.getOrganizationId()).isEqualTo("metaarch-commerce");
    assertThat(membership.getLocationId()).isEqualTo("secunderabad");
    assertThat(membership.getRole()).isSameAs(nextRole);
    verify(users).save(target);
    verify(auditLogs).save(any());
  }

  @Test
  void staffStatusChangesInvalidateExistingSessionsOnlyWhenStateChanges() {
    UserAccount target=user("global-admin");
    Role adminRole=role("GLOBAL_ADMIN","USER_READ");
    target.getRoles().add(adminRole);
    Membership membership=new Membership(); membership.setUser(target); membership.setRole(adminRole);
    membership.setOrganizationId("metaarch-commerce");
    when(users.findWithRolesById(7L)).thenReturn(Optional.of(target));
    when(memberships.findByUserId(7L)).thenReturn(List.of(membership));
    when(roles.findByName("GLOBAL_ADMIN")).thenReturn(Optional.of(adminRole));

    UserUpdateRequest blocked=new UserUpdateRequest("Global Admin","global-admin@example.test",null,"GLOBAL_ADMIN","Blocked",null);
    service.updateStaff(7L,blocked,"root-admin");
    assertThat(target.isEnabled()).isFalse();
    assertThat(target.isLocked()).isTrue();
    assertThat(target.getTokenVersion()).isEqualTo(1);

    service.updateStaff(7L,blocked,"root-admin");
    assertThat(target.getTokenVersion()).isEqualTo(1);
  }

  @Test
  void rejectsOrganizationChangeAndPrivilegeEscalationDuringStaffUpdate() {
    UserAccount target = user("global-admin");
    target.getRoles().add(role("GLOBAL_ADMIN", "USER_READ"));
    Membership membership = new Membership(); membership.setUser(target); membership.setRole(role("GLOBAL_ADMIN", "USER_READ")); membership.setOrganizationId("other-org");
    when(users.findWithRolesById(8L)).thenReturn(Optional.of(target));
    when(memberships.findByUserId(8L)).thenReturn(List.of(membership));
    assertThatThrownBy(() -> service.updateStaff(8L,
        new UserUpdateRequest("Root", "root@example.com", null, "SUPER_ADMIN", "Active", null), "root-admin"))
        .isInstanceOf(org.springframework.security.access.AccessDeniedException.class);
    verify(users, org.mockito.Mockito.never()).save(any());

    membership.setOrganizationId("metaarch-commerce");
    assertThatThrownBy(() -> service.updateStaff(8L,
        new UserUpdateRequest("Root", "root@example.com", null, "SUPER_ADMIN", "Active", null), "root-admin"))
        .isInstanceOf(org.springframework.security.access.AccessDeniedException.class);
    verify(users, org.mockito.Mockito.never()).save(any());
  }

  @Test
  void deletesOnlyAssignedStaffAndRemovesItsMembershipAndContactClaims() {
    UserAccount target = user("location-admin");
    Role staffRole = role("LOCATION_ADMIN", "USER_READ");
    target.getRoles().add(staffRole);
    Membership membership = new Membership(); membership.setUser(target); membership.setRole(staffRole);
    membership.setOrganizationId("metaarch-commerce");
    when(users.findWithRolesById(7L)).thenReturn(Optional.of(target));
    when(memberships.findByUserId(7L)).thenReturn(List.of(membership));
    when(customerDb.queryForObject(anyString(), eq(Integer.class), eq(7L))).thenReturn(0);

    service.deleteStaff(7L, "root-admin");

    verify(customerDb).update("DELETE FROM customer_otp WHERE user_id = ?", 7L);
    verify(customerDb).update("DELETE FROM customer_contact_claims WHERE user_id = ?", 7L);
    verify(memberships).deleteAll(List.of(membership));
    assertThat(target.getRoles()).isEmpty();
    verify(users).delete(target);
    verify(users).flush();
    verify(auditLogs).save(any());
  }

  @Test
  void preventsSelfDeletionAndAccountsWithCustomerRecordsOrAdditionalRoles() {
    UserAccount target = user("location-admin");
    Role staffRole = role("LOCATION_ADMIN", "USER_READ");
    target.getRoles().add(staffRole);
    Membership membership = new Membership(); membership.setUser(target); membership.setRole(staffRole);
    membership.setOrganizationId("metaarch-commerce");
    when(users.findWithRolesById(7L)).thenReturn(Optional.of(target));
    when(memberships.findByUserId(7L)).thenReturn(List.of(membership));

    assertThatThrownBy(() -> service.deleteStaff(7L, "location-admin"))
        .isInstanceOf(org.springframework.security.access.AccessDeniedException.class);
    verify(users, org.mockito.Mockito.never()).delete(any());

    when(customerDb.queryForObject(anyString(), eq(Integer.class), eq(7L))).thenReturn(1);
    assertThatThrownBy(() -> service.deleteStaff(7L, "root-admin"))
        .isInstanceOf(org.springframework.security.access.AccessDeniedException.class);
    verify(users, org.mockito.Mockito.never()).delete(any());

    target.getRoles().add(role("CUSTOMER", "CUSTOMER_READ"));
    when(customerDb.queryForObject(anyString(), eq(Integer.class), eq(7L))).thenReturn(0);
    assertThatThrownBy(() -> service.deleteStaff(7L, "root-admin"))
        .isInstanceOf(org.springframework.security.access.AccessDeniedException.class);
    verify(users, org.mockito.Mockito.never()).delete(any());
  }

  private static UserAccount user(String username) {
    UserAccount user = new UserAccount();
    user.setUsername(username);
    user.setEmail(username + "@example.com");
    return user;
  }

  private static Role role(String name, String permissionCode) {
    Role role = new Role();
    role.setName(name);
    Permission permission = new Permission();
    permission.setCode(permissionCode);
    role.getPermissions().add(permission);
    return role;
  }
}
