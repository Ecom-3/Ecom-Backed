package com.metaarch.orgaccess.identity;

import jakarta.validation.Valid;
import jakarta.validation.constraints.*;
import java.util.List;
import java.util.Map;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.http.HttpStatus;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;
import com.metaarch.orgaccess.customer.CustomerAuthService;

@RestController
@RequestMapping("/api/delivery-partners")
@PreAuthorize("hasAnyRole('STORE_MANAGER','LOCATION_ADMIN','SUPER_ADMIN')")
public class DeliveryPartnerController {
  private final JdbcTemplate jdbc;
  private final UserAccountRepository users;
  private final MembershipRepository memberships;
  private final RoleRepository roles;
  private final PasswordEncoder passwords;
  public DeliveryPartnerController(JdbcTemplate jdbc, UserAccountRepository users, MembershipRepository memberships,
      RoleRepository roles, PasswordEncoder passwords) {
    this.jdbc=jdbc; this.users=users; this.memberships=memberships; this.roles=roles; this.passwords=passwords;
  }
  private List<Membership> scope(Authentication auth) {
    return memberships.findByUserUsernameIgnoreCase(auth.getName());
  }
  private boolean superAdmin(Authentication auth) {
    return auth.getAuthorities().stream().anyMatch(a -> a.getAuthority().equals("ROLE_SUPER_ADMIN"));
  }
  private boolean allowed(Authentication auth, String store, String location) {
    if (superAdmin(auth)) return true;
    return scope(auth).stream().anyMatch(m ->
      ("STORE_MANAGER".equals(m.getRole().getName()) && store != null && !store.isBlank() && store.equals(m.getStoreId())) ||
      ("LOCATION_ADMIN".equals(m.getRole().getName()) && location != null && !location.isBlank() && location.equals(m.getLocationId())));
  }
  @GetMapping
  @Transactional(readOnly=true)
  public List<Map<String,Object>> list(Authentication auth) {
    return jdbc.queryForList("""
      SELECT DISTINCT CAST(u.id AS CHAR) AS id, u.username, u.email, u.display_name AS name,
        u.mobile, u.mobile AS phone, u.status, (u.enabled AND NOT u.locked AND u.status = 'Active') AS active,
        u.vehicle_type AS vehicleType, u.vehicle_number AS vehicleNumber, u.licence_number AS licenceNumber,
        u.address, u.emergency_contact AS emergencyContact,
        u.delivery_latitude AS deliveryLatitude, u.delivery_longitude AS deliveryLongitude,
        ROUND(UNIX_TIMESTAMP(u.delivery_location_updated_at) * 1000) AS deliveryLocationUpdatedAt,
        u.created_at AS accountCreatedAt, u.updated_at AS accountUpdatedAt,
        m.store_id AS storeId, m.store_name AS store, m.store_location AS storeLocation,
        m.store_address AS storeAddress, m.location_id AS location
      FROM users u JOIN memberships m ON m.user_id=u.id JOIN roles r ON r.id=m.role_id
      WHERE r.name='DELIVERY_PARTNER' ORDER BY u.display_name
      """).stream().filter(row -> allowed(auth, (String)row.get("storeId"), (String)row.get("location"))).toList();
  }
  public record CreateRequest(
      @NotBlank @Size(max=180) String name, @NotBlank @Pattern(regexp="[+0-9 ()-]{7,30}") String mobile,
      @NotBlank @Size(max=190) String username, @NotBlank @Email @Size(max=255) String email,
      @NotBlank @Size(min=8,max=100) String password,
      @NotBlank @Size(max=40) String vehicleType, @NotBlank @Size(max=40) String vehicleNumber,
      @NotBlank @Size(max=60) String licenceNumber, @Size(max=700) String address,
      @NotNull Boolean active, @Size(max=100) String storeId, @Size(max=100) String location) {}
  @PostMapping
  @ResponseStatus(HttpStatus.CREATED)
  @PreAuthorize("hasAnyRole('STORE_MANAGER','LOCATION_ADMIN')")
  @Transactional
  public Map<String,Object> create(@Valid @RequestBody CreateRequest request, Authentication auth) {
    boolean locationAdmin = auth.getAuthorities().stream().anyMatch(a -> a.getAuthority().equals("ROLE_LOCATION_ADMIN"));
    Membership assignment;
    if (locationAdmin) {
      Membership locationScope = scope(auth).stream().filter(m -> "LOCATION_ADMIN".equals(m.getRole().getName())
          && "metaarch-commerce".equalsIgnoreCase(m.getOrganizationId()) && m.getLocationId() != null
          && m.getLocationId().equalsIgnoreCase(String.valueOf(request.location())))
          .findFirst().orElseThrow(() -> new ResponseStatusException(HttpStatus.FORBIDDEN,
              "Delivery Partner must belong to your assigned location."));
      assignment = memberships.findByLocationIdIgnoreCaseAndRole_Name(locationScope.getLocationId(), "STORE_MANAGER").stream()
          .filter(m -> "metaarch-commerce".equalsIgnoreCase(m.getOrganizationId()) && m.getStoreId() != null
              && m.getStoreId().equalsIgnoreCase(String.valueOf(request.storeId())))
          .findFirst().orElseThrow(() -> new ResponseStatusException(HttpStatus.FORBIDDEN,
              "Choose a store assigned within your location."));
    } else {
      assignment = scope(auth).stream().filter(m -> "STORE_MANAGER".equals(m.getRole().getName())
          && m.getStoreId()!=null && !m.getStoreId().isBlank())
          .findFirst().orElseThrow(() -> new ResponseStatusException(HttpStatus.CONFLICT,"No store is assigned to this manager."));
    }
    Map<String,String> conflicts = new java.util.LinkedHashMap<>();
    String email = request.email().trim().toLowerCase(java.util.Locale.ROOT);
    String mobile = CustomerAuthService.mobile(request.mobile());
    if(users.existsByUsernameIgnoreCase(request.username().trim()))
      conflicts.put("username", "This username is already registered. Use another username.");
    if(users.existsByEmailIgnoreCase(email) || jdbc.queryForObject(
        "SELECT COUNT(*) FROM customer_contact_claims WHERE contact = ?", Integer.class, "email:" + email) > 0)
      conflicts.put("email", "This email is already registered. Use another email address.");
    String mobileDigits = mobile.replaceAll("\\D", "");
    String localDigits = mobileDigits.startsWith("91") ? mobileDigits.substring(2) : mobileDigits;
    if(jdbc.queryForObject("SELECT COUNT(*) FROM customer_contact_claims WHERE contact IN (?, ?)",
        Integer.class, "mobile:" + mobileDigits, "mobile:" + localDigits) > 0)
      conflicts.put("mobile", "This mobile number is already registered. Use another mobile number.");
    if(!conflicts.isEmpty()) throw new DuplicateUserContactException(conflicts);
    Role role=roles.findByName("DELIVERY_PARTNER").orElseThrow();
    UserAccount user=new UserAccount();
    user.setUsername(request.username().trim()); user.setEmail(email);
    user.setDisplayName(request.name().trim()); user.setMobile(mobile);
    user.setPasswordHash(passwords.encode(request.password()));
    user.setVehicleType(request.vehicleType().trim()); user.setVehicleNumber(request.vehicleNumber().trim());
    user.setLicenceNumber(request.licenceNumber().trim()); user.setAddress(request.address());
    user.setEnabled(request.active()); user.setStatus(request.active()?"Active":"Inactive");
    user.getRoles().add(role); users.saveAndFlush(user);
    jdbc.update("INSERT INTO customer_contact_claims (contact, user_id) VALUES (?, ?)",
        "email:" + email, user.getId());
    jdbc.update("INSERT INTO customer_contact_claims (contact, user_id) VALUES (?, ?)",
        "mobile:" + mobileDigits, user.getId());
    Membership membership=new Membership(); membership.setUser(user); membership.setRole(role);
    membership.setOrganizationId(assignment.getOrganizationId()); membership.setLocationId(assignment.getLocationId());
    membership.setStoreId(assignment.getStoreId()); membership.setStoreName(assignment.getStoreName());
    membership.setStoreLocation(assignment.getStoreLocation()); membership.setStoreAddress(assignment.getStoreAddress());
    membership.setAssignedBy(auth.getName()); memberships.saveAndFlush(membership);
    return list(auth).stream().filter(row -> user.getId().toString().equals(row.get("id"))).findFirst().orElseThrow();
  }
  public record StatusRequest(@NotNull Boolean active) {}
  @PutMapping("/{id}/status")
  @Transactional
  public Map<String,Object> status(@PathVariable Long id, @Valid @RequestBody StatusRequest request, Authentication auth) {
    if(list(auth).stream().noneMatch(row -> id.toString().equals(row.get("id"))))
      throw new ResponseStatusException(HttpStatus.NOT_FOUND,"Delivery partner not found in your assigned scope.");
    UserAccount user=users.findById(id).orElseThrow();
    boolean nextEnabled = request.active();
    if (user.isEnabled() != nextEnabled) user.incrementTokenVersion();
    user.setEnabled(nextEnabled); user.setStatus(nextEnabled?"Active":"Inactive");
    users.saveAndFlush(user);
    return list(auth).stream().filter(row -> id.toString().equals(row.get("id"))).findFirst().orElseThrow();
  }
}
