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
  @org.springframework.beans.factory.annotation.Autowired private org.springframework.jdbc.core.JdbcTemplate customerDb;

  public IdentityService(UserAccountRepository users, MembershipRepository memberships,
      RoleRepository roles, PasswordEncoder passwordEncoder, AuditLogRepository auditLogs) {
    this.users = users; this.memberships = memberships; this.roles = roles;
    this.passwordEncoder = passwordEncoder; this.auditLogs = auditLogs;
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
  public UserAccount updateStaff(Long id, UserUpdateRequest request, String actor) {
    UserAccount user = users.findWithRolesById(id)
        .orElseThrow(() -> new UsernameNotFoundException("User not found"));
    List<Membership> staffMemberships = memberships.findByUserId(id).stream()
        .filter(m -> m.getRole().getName().equals("GLOBAL_ADMIN") || m.getRole().getName().equals("LOCATION_ADMIN"))
        .toList();
    if (staffMemberships.isEmpty())
      throw new org.springframework.security.access.AccessDeniedException("This account cannot be edited through staff management");
    boolean orgMatches = staffMemberships.stream()
        .allMatch(m -> "metaarch-commerce".equalsIgnoreCase(m.getOrganizationId()));
    if (!orgMatches) throw new org.springframework.security.access.AccessDeniedException("Staff account is outside the authorized organization");
    Set<String> currentRoleNames = staffMemberships.stream()
        .map(m -> m.getRole().getName()).collect(java.util.stream.Collectors.toSet());
    if (currentRoleNames.size() != 1)
      throw new org.springframework.security.access.AccessDeniedException("Staff account has inconsistent staff assignments");
    String currentRoleName = currentRoleNames.iterator().next();
    String requestedRole = normalizeRole(request.role());
    if (!requestedRole.equals("GLOBAL_ADMIN") && !requestedRole.equals("LOCATION_ADMIN"))
      throw new org.springframework.security.access.AccessDeniedException("Only Global Admin and Location Admin roles can be assigned here");
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
    user.setEnabled(nextStatus.equalsIgnoreCase("Active"));
    user.setLocked(nextStatus.equalsIgnoreCase("Blocked"));
    user.getRoles().removeIf(role -> role.getName().equals(currentRoleName));
    user.getRoles().add(nextRole);
    users.save(user);
    for (Membership membership : staffMemberships) {
      membership.setRole(nextRole);
      if (requestedRole.equals("LOCATION_ADMIN")) membership.setLocationId(request.location().trim().toLowerCase(Locale.ROOT));
      else membership.setLocationId(null);
      memberships.save(membership);
    }
    auditLogs.save(new AuditLog(actor, "UPDATE_USER", user.getUsername()));
    return user;
  }

  @Transactional(readOnly = true)
  public List<StaffSummary> listStaff(String actor) {
    return memberships.findByOrganizationIdIgnoreCase("metaarch-commerce").stream()
        .filter(membership -> membership.getRole().getName().equals("GLOBAL_ADMIN") || membership.getRole().getName().equals("LOCATION_ADMIN"))
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
    auditLogs.save(new AuditLog(username, "CHANGE_PASSWORD", username));
  }

  private void saveMembership(UserAccount user, Role role, UserCreateRequest request, String actor) {
    String organizationId = blank(request.organizationId());
    String locationId = blank(request.location());
    String storeId = blank(request.storeId());
    String storeName = blank(request.store());
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
