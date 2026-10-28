package com.metaarch.orgaccess.identity;

import com.metaarch.orgaccess.audit.AuditLog;
import com.metaarch.orgaccess.audit.AuditLogRepository;
import java.util.HashSet;
import java.util.List;
import java.util.Locale;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Set;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class IdentityService {
  private final UserAccountRepository users;
  private final MembershipRepository memberships;
  private final RoleRepository roles;
  private final PasswordEncoder passwordEncoder;
  private final AuditLogRepository auditLogs;
  private final CatalogStoreScopeClient catalogStoreScope;
  @org.springframework.beans.factory.annotation.Autowired private org.springframework.jdbc.core.JdbcTemplate customerDb;

  @org.springframework.beans.factory.annotation.Autowired
  public IdentityService(UserAccountRepository users, MembershipRepository memberships,
      RoleRepository roles, PasswordEncoder passwordEncoder, AuditLogRepository auditLogs,
      CatalogStoreScopeClient catalogStoreScope) {
    this.users = users; this.memberships = memberships; this.roles = roles;
    this.passwordEncoder = passwordEncoder; this.auditLogs = auditLogs;
    this.catalogStoreScope = catalogStoreScope;
  }

  public IdentityService(UserAccountRepository users, MembershipRepository memberships,
      RoleRepository roles, PasswordEncoder passwordEncoder, AuditLogRepository auditLogs) {
    this(users, memberships, roles, passwordEncoder, auditLogs, null);
  }

  @Transactional(readOnly = true)
  public UserAccount requireUser(String username) {
    UserAccount user = users.findByUsernameIgnoreCase(username)
        .orElseThrow(() -> new UsernameNotFoundException("User not found: " + username));
    if (!user.isEnabled() || user.isLocked()) {
      throw new UsernameNotFoundException("User is disabled or locked: " + username);
    }
    return user;
  }

  @Transactional(readOnly = true)
  public List<GrantedAuthority> authorities(UserAccount user) {
    Set<GrantedAuthority> result = new HashSet<>();
    user.getRoles().forEach(role -> addRole(result, role));
    memberships.findByUserUsernameIgnoreCase(user.getUsername()).forEach(membership -> {
      addRole(result, membership.getRole());
      addScope(result, "ORGANIZATION", membership.getOrganizationId());
      addScope(result, "LOCATION", membership.getLocationId());
      addScope(result, "STORE", membership.getStoreId());
    });
    return result.stream().toList();
  }

  @Transactional
  public UserAccount provisionOAuthUser(String subject, String email, String name) {
    UserAccount user = users.findByOauthSubject(subject).orElseGet(() -> {
      UserAccount created = new UserAccount();
      created.setOauthSubject(subject);
      created.setEmail(email == null || email.isBlank() ? subject + "@oauth.local" : email);
      created.setUsername(name == null || name.isBlank() ? created.getEmail() : name);
      return created;
    });
    user.setOauthSubject(subject);
    if (email != null && !email.isBlank()) user.setEmail(email);
    users.save(user);
    auditLogs.save(new AuditLog(user.getUsername(), "OAUTH2_LOGIN", user.getUsername()));
    return user;
  }

  @Transactional
  public UserAccount create(UserCreateRequest request, String actor) {
    String username = clean(request.username());
    String email = clean(request.email());
    String roleName = normalizeRole(request.role());
    Map<String, String> conflicts = new LinkedHashMap<>();
    if (users.existsByUsernameIgnoreCase(username)) conflicts.put("username", "This username is already registered. Choose another username.");
    String normalizedEmail = email.toLowerCase(Locale.ROOT);
    if (users.existsByEmailIgnoreCase(email) || contactClaimExists("email:" + normalizedEmail))
      conflicts.put("email", "This email address is already registered. Use another email address.");
    String mobile = blank(request.mobile());
    String normalizedMobile = mobile == null ? null : com.metaarch.orgaccess.customer.CustomerAuthService.mobile(mobile);
    if (normalizedMobile != null && contactClaimExists("mobile:" + normalizedMobile.substring(1)))
      conflicts.put("mobile", "This mobile number is already registered. Use another mobile number.");
    if (!conflicts.isEmpty()) throw new DuplicateUserContactException(conflicts);
    Role role = roles.findByName(roleName).orElseThrow(() -> new IllegalArgumentException("Unknown role"));
    if (!Set.of("GLOBAL_ADMIN", "LOCATION_ADMIN", "STORE_MANAGER").contains(roleName))
      throw new org.springframework.security.access.AccessDeniedException("This role cannot be provisioned through staff management");
    validateStaffAssignment(roleName, request);
    UserAccount user = new UserAccount();
    user.setUsername(username); user.setEmail(email);
    user.setPasswordHash(passwordEncoder.encode(request.password()));
    user.setDisplayName(blank(request.name()));
    user.setMobile(mobile);
    user.setStatus(status(request.status()));
    user.setEnabled(!"Blocked".equalsIgnoreCase(user.getStatus()));
    user.setLocked("Blocked".equalsIgnoreCase(user.getStatus()));
    user.getRoles().add(role);
    UserAccount saved = users.save(user);
    users.flush();
    customerDb.update("INSERT INTO customer_contact_claims(contact,user_id) VALUES(?,?)","email:"+normalizedEmail,saved.getId());
    if (normalizedMobile!=null) customerDb.update("INSERT INTO customer_contact_claims(contact,user_id) VALUES(?,?)","mobile:"+normalizedMobile.substring(1),saved.getId());
    if (roleName.equals("CUSTOMER")) {
      users.flush();
      customerDb.update("INSERT INTO customers(id,user_id,full_name) VALUES(UNHEX(REPLACE(UUID(),'-','')),?,?)",saved.getId(),request.name()==null?username:request.name());
    }
    saveMembership(saved, role, request, actor);
    auditLogs.save(new AuditLog(actor, "CREATE_USER", saved.getUsername()));
    return saved;
  }

  @Transactional
  public UserAccount createManagedStoreManager(UserCreateRequest request, String actor) {
    String location = locationForAdmin(actor);
    if (!"STORE_MANAGER".equals(normalizeRole(request.role()))) {
      throw new org.springframework.security.access.AccessDeniedException("Location Admins may provision Store Managers only");
    }
    if (request.location() == null || !location.equalsIgnoreCase(request.location().trim())) {
      throw new org.springframework.security.access.AccessDeniedException("Store Manager must belong to your assigned location");
    }
    boolean allowedStore = catalogStoreScope != null
        ? catalogStoreScope.storeBelongsToLocation(request.storeId(), location)
        : memberships.findByLocationIdIgnoreCaseAndRole_Name(location, "STORE_MANAGER").stream()
            .anyMatch(m -> "metaarch-commerce".equalsIgnoreCase(m.getOrganizationId())
                && m.getStoreId() != null && m.getStoreId().equalsIgnoreCase(String.valueOf(request.storeId()))
                && m.getStoreName() != null && m.getStoreName().equalsIgnoreCase(String.valueOf(request.store())));
    if (!allowedStore) {
      throw new org.springframework.security.access.AccessDeniedException("Choose a store within your assigned location");
    }
    UserCreateRequest scoped = new UserCreateRequest(request.username(), request.email(), request.password(),
        "STORE_MANAGER", request.name(), request.mobile(), request.status(), "metaarch-commerce", location,
        request.storeId(), request.store(), location, request.storeAddress(), request.latitude(), request.longitude(),
        request.provider(), request.providerPlaceId(), request.providerOsmType(), request.providerOsmId(),
        request.locationAccuracyMeters(), null);
    return create(scoped, actor);
  }

  @Transactional
  public UserAccount updateStaff(Long id, UserUpdateRequest request, String actor) {
    UserAccount user = users.findWithRolesById(id)
        .orElseThrow(() -> new UsernameNotFoundException("User not found"));
    List<Membership> accountMemberships = memberships.findByUserId(id);
    List<Membership> staffMemberships = accountMemberships.stream()
        .filter(m -> Set.of("GLOBAL_ADMIN", "LOCATION_ADMIN", "STORE_MANAGER").contains(m.getRole().getName()))
        .toList();
    if (staffMemberships.size() != 1 || accountMemberships.size() != 1)
      throw new org.springframework.security.access.AccessDeniedException("This account cannot be edited through staff management");
    boolean orgMatches = staffMemberships.stream()
        .allMatch(m -> "metaarch-commerce".equalsIgnoreCase(m.getOrganizationId()));
    if (!orgMatches) throw new org.springframework.security.access.AccessDeniedException("Staff account is outside the authorized organization");
    Set<String> currentRoleNames = staffMemberships.stream()
        .map(m -> m.getRole().getName()).collect(java.util.stream.Collectors.toSet());
    if (currentRoleNames.size() != 1)
      throw new org.springframework.security.access.AccessDeniedException("Staff account has inconsistent staff assignments");
    String currentRoleName = currentRoleNames.iterator().next();
    Set<String> accountRoleNames = user.getRoles().stream().map(Role::getName).collect(java.util.stream.Collectors.toSet());
    if (!accountRoleNames.equals(currentRoleNames))
      throw new org.springframework.security.access.AccessDeniedException("Staff account has additional or inconsistent roles");
    String requestedRole = normalizeRole(request.role());
    if (!Set.of("GLOBAL_ADMIN", "LOCATION_ADMIN", "STORE_MANAGER").contains(requestedRole))
      throw new org.springframework.security.access.AccessDeniedException("This role cannot be assigned through staff management");
    if (currentRoleName.equals("STORE_MANAGER") != requestedRole.equals("STORE_MANAGER"))
      throw new org.springframework.security.access.AccessDeniedException("Store Manager assignments cannot be changed to an administrator role");
    if (requestedRole.equals("LOCATION_ADMIN") && (request.location() == null || request.location().isBlank()))
      throw new IllegalArgumentException("Location is required for a Location Admin");
    if (requestedRole.equals("GLOBAL_ADMIN") && request.location() != null && !request.location().isBlank())
      throw new IllegalArgumentException("Global Admin cannot be assigned to a location");
    Role nextRole = roles.findByName(requestedRole)
        .orElseThrow(() -> new IllegalArgumentException("Unknown role"));
    user.setDisplayName(request.name().trim());
    user.setEmail(request.email().trim());
    user.setMobile(blank(request.mobile()));
    String nextStatus = status(request.status());
    if (!nextStatus.equalsIgnoreCase("Active") && !nextStatus.equalsIgnoreCase("Blocked"))
      throw new IllegalArgumentException("Status must be Active or Blocked");
    user.setStatus(nextStatus);
    boolean nextEnabled = nextStatus.equalsIgnoreCase("Active");
    boolean nextLocked = nextStatus.equalsIgnoreCase("Blocked");
    if (user.isEnabled() != nextEnabled || user.isLocked() != nextLocked) user.incrementTokenVersion();
    user.setEnabled(nextEnabled);
    user.setLocked(nextLocked);
    user.getRoles().removeIf(role -> role.getName().equals(currentRoleName));
    user.getRoles().add(nextRole);
    users.save(user);
    for (Membership membership : staffMemberships) {
      membership.setRole(nextRole);
      if (requestedRole.equals("LOCATION_ADMIN")) membership.setLocationId(request.location().trim().toLowerCase(Locale.ROOT));
      else if (!requestedRole.equals("STORE_MANAGER")) membership.setLocationId(null);
      memberships.save(membership);
    }
    auditLogs.save(new AuditLog(actor, "UPDATE_USER", user.getUsername()));
    return user;
  }

  @Transactional
  public UserAccount updateManagedStoreManager(Long id, UserUpdateRequest request, String actor) {
    String location = locationForAdmin(actor);
    Membership target = memberships.findByUserId(id).stream()
        .filter(m -> "STORE_MANAGER".equals(m.getRole().getName())
            && "metaarch-commerce".equalsIgnoreCase(m.getOrganizationId())
            && location.equalsIgnoreCase(String.valueOf(m.getLocationId())))
        .findFirst().orElseThrow(() -> new org.springframework.security.access.AccessDeniedException(
            "Store Manager is outside your assigned location"));
    UserAccount account = target.getUser();
    if (!"STORE_MANAGER".equals(normalizeRole(request.role()))
        || !account.getEmail().equalsIgnoreCase(request.email())
        || !java.util.Objects.equals(blank(account.getMobile()), blank(request.mobile()))
        || (request.location() != null && !location.equalsIgnoreCase(request.location().trim()))) {
      throw new org.springframework.security.access.AccessDeniedException(
          "Location Admins may edit a Store Manager's name and status only");
    }
    return updateStaff(id, request, actor);
  }

  private String locationForAdmin(String actor) {
    return memberships.findByUserUsernameIgnoreCase(actor).stream()
        .filter(m -> "LOCATION_ADMIN".equals(m.getRole().getName())
            && "metaarch-commerce".equalsIgnoreCase(m.getOrganizationId())
            && m.getLocationId() != null && !m.getLocationId().isBlank())
        .map(m -> m.getLocationId().trim())
        .findFirst().orElseThrow(() -> new org.springframework.security.access.AccessDeniedException(
            "A valid Location Admin assignment is required"));
  }

  @Transactional
  public void deleteStaff(Long id, String actor) {
    if (id == null || id <= 0) throw new IllegalArgumentException("A valid staff account ID is required");
    UserAccount user = users.findWithRolesById(id)
        .orElseThrow(() -> new UsernameNotFoundException("User not found"));
    if (user.getUsername().equalsIgnoreCase(actor))
      throw new org.springframework.security.access.AccessDeniedException("You cannot delete your own account");

    List<Membership> accountMemberships = memberships.findByUserId(id);
    if (accountMemberships.isEmpty())
      throw new org.springframework.security.access.AccessDeniedException("Only assigned staff accounts can be deleted here");
    Set<String> staffRoles = Set.of("GLOBAL_ADMIN", "LOCATION_ADMIN", "STORE_MANAGER");
    boolean validStaffMemberships = accountMemberships.stream().allMatch(membership ->
        "metaarch-commerce".equalsIgnoreCase(membership.getOrganizationId())
            && staffRoles.contains(membership.getRole().getName()));
    if (!validStaffMemberships)
      throw new org.springframework.security.access.AccessDeniedException("Account has assignments outside the managed staff organization");

    Set<String> assignedRoles = accountMemberships.stream().map(membership -> membership.getRole().getName())
        .collect(java.util.stream.Collectors.toSet());
    Set<String> accountRoles = user.getRoles().stream().map(Role::getName).collect(java.util.stream.Collectors.toSet());
    if (assignedRoles.size() != 1 || !assignedRoles.equals(accountRoles))
      throw new org.springframework.security.access.AccessDeniedException("Account has additional or inconsistent roles and cannot be deleted as staff");

    Integer customerRecords = customerDb.queryForObject("SELECT COUNT(*) FROM customers WHERE user_id = ?", Integer.class, id);
    if (customerRecords != null && customerRecords > 0)
      throw new org.springframework.security.access.AccessDeniedException("This account has customer records and cannot be deleted as staff");

    auditLogs.save(new AuditLog(actor, "DELETE_USER", user.getUsername()));
    customerDb.update("DELETE FROM customer_otp WHERE user_id = ?", id);
    customerDb.update("DELETE FROM customer_contact_claims WHERE user_id = ?", id);
    memberships.deleteAll(accountMemberships);
    user.getRoles().clear();
    users.delete(user);
    users.flush();
  }

  @Transactional(readOnly = true)
  public List<StaffSummary> listStaff(String actor) {
    UserAccount actorAccount = users.findByUsernameIgnoreCase(actor)
        .orElseThrow(() -> new UsernameNotFoundException("Staff account not found"));
    List<Membership> actorMemberships = memberships.findByUserUsernameIgnoreCase(actor);
    boolean superAdmin = actorAccount.getRoles().stream().anyMatch(role -> "SUPER_ADMIN".equals(role.getName()));
    String location = actorMemberships.stream()
        .filter(m -> "LOCATION_ADMIN".equals(m.getRole().getName())
            && "metaarch-commerce".equalsIgnoreCase(m.getOrganizationId()))
        .map(Membership::getLocationId).filter(value -> value != null && !value.isBlank()).findFirst().orElse(null);
    if (!superAdmin && location == null) {
      throw new org.springframework.security.access.AccessDeniedException("Staff list is not available for this role");
    }
    return memberships.findByOrganizationIdIgnoreCase("metaarch-commerce").stream()
        .filter(membership -> Set.of("GLOBAL_ADMIN", "LOCATION_ADMIN", "STORE_MANAGER").contains(membership.getRole().getName()))
        .filter(membership -> superAdmin || ("STORE_MANAGER".equals(membership.getRole().getName())
            && location.equalsIgnoreCase(String.valueOf(membership.getLocationId()))))
        .map(membership -> new StaffSummary(membership.getUser().getId(), membership.getUser().getUsername(),
            membership.getUser().getEmail(), membership.getUser().getDisplayName(), membership.getUser().getMobile(),
            membership.getRole().getName(), membership.getUser().getStatus(), membership.getOrganizationId(),
            membership.getLocationId(), membership.getStoreId(), membership.getStoreName()))
        .collect(java.util.stream.Collectors.collectingAndThen(java.util.stream.Collectors.toMap(StaffSummary::id,
            summary -> summary, (first, ignored) -> first, java.util.LinkedHashMap::new), map -> List.copyOf(map.values())));
  }

  public record StaffSummary(Long id, String username, String email, String name, String mobile, String role,
      String status, String organizationId, String location, String storeId, String store) {}

  private boolean contactClaimExists(String contact) {
    Integer count = customerDb.queryForObject(
        "SELECT COUNT(*) FROM customer_contact_claims WHERE contact = ?", Integer.class, contact);
    return count != null && count > 0;
  }

  @Transactional
  public void changePassword(String username, String currentPassword, String newPassword) {
    UserAccount user = requireUser(username);
    if (user.getPasswordHash() == null || !passwordEncoder.matches(currentPassword, user.getPasswordHash())) {
      throw new IllegalArgumentException("Current password is incorrect");
    }
    user.setPasswordHash(passwordEncoder.encode(newPassword));
    user.incrementTokenVersion();
    auditLogs.save(new AuditLog(username, "CHANGE_PASSWORD", username));
  }

  @Transactional
  public void resetStoreManagerPassword(Long id, String newPassword, String actor) {
    UserAccount user = users.findWithRolesById(id)
        .orElseThrow(() -> new UsernameNotFoundException("User not found"));
    List<Membership> accountMemberships = memberships.findByUserId(id);
    Set<String> membershipRoles = accountMemberships.stream().map(m -> m.getRole().getName())
        .collect(java.util.stream.Collectors.toSet());
    Set<String> accountRoles = user.getRoles().stream().map(Role::getName)
        .collect(java.util.stream.Collectors.toSet());
    boolean scopedStoreManager = accountMemberships.size() == 1 && membershipRoles.equals(Set.of("STORE_MANAGER"))
        && accountRoles.equals(Set.of("STORE_MANAGER"))
        && "metaarch-commerce".equalsIgnoreCase(accountMemberships.get(0).getOrganizationId())
        && accountMemberships.get(0).getLocationId() != null
        && accountMemberships.get(0).getStoreId() != null;
    if (!scopedStoreManager) {
      throw new org.springframework.security.access.AccessDeniedException(
          "Only a correctly assigned Store Manager account can be reset here");
    }
    user.setPasswordHash(passwordEncoder.encode(newPassword));
    user.incrementTokenVersion();
    auditLogs.save(new AuditLog(actor, "RESET_STORE_MANAGER_PASSWORD", user.getUsername()));
  }

  @Transactional
  public void resetLocationManagedStaffPassword(Long id, String newPassword, String actor) {
    String location = locationForAdmin(actor);
    UserAccount user = users.findWithRolesById(id)
        .orElseThrow(() -> new UsernameNotFoundException("User not found"));
    List<Membership> accountMemberships = memberships.findByUserId(id);
    Set<String> membershipRoles = accountMemberships.stream().map(m -> m.getRole().getName())
        .collect(java.util.stream.Collectors.toSet());
    Set<String> accountRoles = user.getRoles().stream().map(Role::getName)
        .collect(java.util.stream.Collectors.toSet());
    boolean scopedManagedStaff = accountMemberships.size() == 1
        && membershipRoles.size() == 1
        && Set.of("STORE_MANAGER", "DELIVERY_PARTNER").contains(membershipRoles.iterator().next())
        && accountRoles.equals(membershipRoles)
        && "metaarch-commerce".equalsIgnoreCase(accountMemberships.get(0).getOrganizationId())
        && location.equalsIgnoreCase(String.valueOf(accountMemberships.get(0).getLocationId()))
        && accountMemberships.get(0).getStoreId() != null
        && !accountMemberships.get(0).getStoreId().isBlank();
    if (!scopedManagedStaff) {
      throw new org.springframework.security.access.AccessDeniedException(
          "Only a Store Manager or Delivery Partner assigned within your location can be reset here");
    }
    user.setPasswordHash(passwordEncoder.encode(newPassword));
    user.incrementTokenVersion();
    auditLogs.save(new AuditLog(actor, "RESET_LOCATION_STAFF_PASSWORD", user.getUsername()));
  }

  private void saveMembership(UserAccount user, Role role, UserCreateRequest request, String actor) {
    String roleName = role.getName();
    boolean administrativeAccount = roleName.equals("GLOBAL_ADMIN") || roleName.equals("LOCATION_ADMIN");
    String organizationId = administrativeAccount ? "metaarch-commerce" : blank(request.organizationId());
    String locationId = request.location() == null ? null : request.location().trim().toLowerCase(Locale.ROOT);
    String storeId = administrativeAccount ? null : blank(request.storeId());
    String storeName = administrativeAccount ? null : blank(request.store());
    if (organizationId == null && locationId == null && storeId == null && storeName == null) return;
    Membership membership = new Membership();
    membership.setUser(user);
    membership.setRole(role);
    membership.setOrganizationId(organizationId == null ? "metaarch-commerce" : organizationId);
    membership.setLocationId(locationId);
    membership.setStoreId(storeId);
    membership.setStoreName(storeName);
    membership.setStoreLocation(blank(request.storeLocation()));
    membership.setStoreAddress(blank(request.storeAddress()));
    membership.setLatitude(request.latitude());
    membership.setLongitude(request.longitude());
    membership.setProvider(blank(request.provider()));
    membership.setProviderPlaceId(blank(request.providerPlaceId()));
    membership.setProviderOsmType(blank(request.providerOsmType()));
    membership.setProviderOsmId(blank(request.providerOsmId()));
    membership.setLocationAccuracyMeters(request.locationAccuracyMeters());
    // Attribution is security-sensitive; never trust a caller-provided assignedBy value.
    membership.setAssignedBy(actor);
    memberships.save(membership);
  }

  private void validateStaffAssignment(String roleName, UserCreateRequest request) {
    boolean hasStoreAssignment = request.storeId() != null && !request.storeId().isBlank()
        || request.store() != null && !request.store().isBlank()
        || request.storeLocation() != null && !request.storeLocation().isBlank()
        || request.storeAddress() != null && !request.storeAddress().isBlank();
    if (Set.of("GLOBAL_ADMIN", "LOCATION_ADMIN").contains(roleName) && hasStoreAssignment)
      throw new IllegalArgumentException("Administrator accounts cannot have a store assignment");
    if (roleName.equals("LOCATION_ADMIN") && (request.location() == null || request.location().isBlank()))
      throw new IllegalArgumentException("Location is required for a Location Admin");
    if (roleName.equals("GLOBAL_ADMIN") && request.location() != null && !request.location().isBlank())
      throw new IllegalArgumentException("Global Admin cannot be assigned to a location");
    if (roleName.equals("STORE_MANAGER")) {
      if (request.storeId() == null || request.storeId().isBlank())
        throw new IllegalArgumentException("Select an existing store before creating a Store Manager account");
      if (request.store() == null || request.store().isBlank())
        throw new IllegalArgumentException("Store name is required for a Store Manager account");
      if (request.storeLocation() == null || request.storeLocation().isBlank())
        throw new IllegalArgumentException("Store location is required for a Store Manager account");
    }
    String requestedOrganization = blank(request.organizationId());
    if (requestedOrganization != null && !requestedOrganization.equalsIgnoreCase("metaarch-commerce"))
      throw new org.springframework.security.access.AccessDeniedException("Administrator account is outside the managed organization");
  }

  private String normalizeRole(String value) {
    return clean(value).replace('-', '_').replace("ROLE_", "").toUpperCase(Locale.ROOT);
  }

  private String status(String value) {
    String status = blank(value);
    return status == null ? "Active" : status;
  }

  private String clean(String value) {
    if (value == null) throw new IllegalArgumentException("Required value is missing");
    return value.trim();
  }

  private String blank(String value) {
    return value == null || value.isBlank() ? null : value.trim();
  }

  private void addRole(Set<GrantedAuthority> result, Role role) {
    result.add(new SimpleGrantedAuthority("ROLE_" + role.getName()));
    role.getPermissions().forEach(permission -> result.add(new SimpleGrantedAuthority("PERM_" + permission.getCode())));
  }

  private void addScope(Set<GrantedAuthority> result, String type, String value) {
    if (value != null && !value.isBlank()) result.add(new SimpleGrantedAuthority("SCOPE_" + type + ":" + value));
  }
}
