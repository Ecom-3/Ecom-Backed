package com.metaarch.orgaccess.identity;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;
import org.mockito.ArgumentCaptor;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import org.junit.jupiter.api.Test;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.server.ResponseStatusException;

class DeliveryPartnerControllerTest {
  @Test void managerCannotListOrUpdateAnotherStoresPartners() {
    JdbcTemplate jdbc=mock(JdbcTemplate.class);
    UserAccountRepository users=mock(UserAccountRepository.class);
    MembershipRepository memberships=mock(MembershipRepository.class);
    Role role=new Role(); role.setName("STORE_MANAGER");
    Membership scope=new Membership(); scope.setRole(role); scope.setStoreId("store-a");
    when(memberships.findByUserUsernameIgnoreCase("manager")).thenReturn(List.of(scope));
    when(jdbc.queryForList(anyString())).thenReturn(List.of(
      Map.of("id","1","storeId","store-a","location","city"),
      Map.of("id","2","storeId","store-b","location","city")));
    var controller=new DeliveryPartnerController(jdbc,users,memberships,mock(RoleRepository.class),mock(PasswordEncoder.class));
    var auth=new UsernamePasswordAuthenticationToken("manager","",List.of(new SimpleGrantedAuthority("ROLE_STORE_MANAGER")));
    assertEquals(List.of("1"),controller.list(auth).stream().map(row -> row.get("id")).toList());
    ArgumentCaptor<String> query=ArgumentCaptor.forClass(String.class);
    verify(jdbc).queryForList(query.capture());
    assertTrue(query.getValue().contains("u.delivery_latitude AS deliveryLatitude"));
    assertTrue(query.getValue().contains("u.delivery_longitude AS deliveryLongitude"));
    assertTrue(query.getValue().contains("ROUND(UNIX_TIMESTAMP(u.delivery_location_updated_at) * 1000) AS deliveryLocationUpdatedAt"));
    var request = new DeliveryPartnerController.StatusRequest(false);
    assertThrows(ResponseStatusException.class,() -> controller.status(2L,request,auth));
    verifyNoInteractions(users);
  }
  @Test void managerWithoutStoreCannotCreatePartner() {
    var memberships=mock(MembershipRepository.class);
    when(memberships.findByUserUsernameIgnoreCase("manager")).thenReturn(List.of());
    var users=mock(UserAccountRepository.class);
    var controller=new DeliveryPartnerController(mock(JdbcTemplate.class),users,memberships,mock(RoleRepository.class),mock(PasswordEncoder.class));
    var auth=new UsernamePasswordAuthenticationToken("manager","",List.of(new SimpleGrantedAuthority("ROLE_STORE_MANAGER")));
    assertThrows(ResponseStatusException.class,() -> controller.create(null,auth));
    verifyNoInteractions(users);
  }

  @Test void locationAdminCannotCreatePartnerWithForeignLocationOrStoreOverrides() {
    JdbcTemplate jdbc=mock(JdbcTemplate.class);
    UserAccountRepository users=mock(UserAccountRepository.class);
    MembershipRepository memberships=mock(MembershipRepository.class);
    Role locationRole=new Role(); locationRole.setName("LOCATION_ADMIN");
    Membership scope=new Membership(); scope.setRole(locationRole); scope.setOrganizationId("metaarch-commerce"); scope.setLocationId("location-a");
    when(memberships.findByUserUsernameIgnoreCase("location-admin")).thenReturn(List.of(scope));
    when(memberships.findByLocationIdIgnoreCaseAndRole_Name("location-a","STORE_MANAGER")).thenReturn(List.of());
    var controller=new DeliveryPartnerController(jdbc,users,memberships,mock(RoleRepository.class),mock(PasswordEncoder.class));
    var auth=new UsernamePasswordAuthenticationToken("location-admin","",List.of(new SimpleGrantedAuthority("ROLE_LOCATION_ADMIN")));
    var foreignLocation=new DeliveryPartnerController.CreateRequest("Partner","9876543210","partner-a","partner-a@example.test","ValidPass123","Bike","E2E-1","LIC-1",null,true,"store-a","location-b");
    var foreignStore=new DeliveryPartnerController.CreateRequest("Partner","9876543210","partner-b","partner-b@example.test","ValidPass123","Bike","E2E-2","LIC-2",null,true,"store-b","location-a");

    assertThrows(ResponseStatusException.class,() -> controller.create(foreignLocation,auth));
    assertThrows(ResponseStatusException.class,() -> controller.create(foreignStore,auth));
    verifyNoInteractions(users,jdbc);
  }

  @Test void locationAdminOnlyReceivesPartnerLocationsWithinAssignedLocation() {
    JdbcTemplate jdbc=mock(JdbcTemplate.class);
    MembershipRepository memberships=mock(MembershipRepository.class);
    Role role=new Role(); role.setName("LOCATION_ADMIN");
    Membership scope=new Membership(); scope.setRole(role); scope.setLocationId("location-a");
    when(memberships.findByUserUsernameIgnoreCase("location-admin")).thenReturn(List.of(scope));
    when(jdbc.queryForList(anyString())).thenReturn(List.of(
      Map.of("id","1","storeId","store-a","location","location-a","deliveryLatitude",17.4,"deliveryLongitude",78.4),
      Map.of("id","2","storeId","store-b","location","location-b","deliveryLatitude",12.9,"deliveryLongitude",80.2)));
    var controller=new DeliveryPartnerController(jdbc,mock(UserAccountRepository.class),memberships,mock(RoleRepository.class),mock(PasswordEncoder.class));
    var auth=new UsernamePasswordAuthenticationToken("location-admin","",List.of(new SimpleGrantedAuthority("ROLE_LOCATION_ADMIN")));

    var partners=controller.list(auth);
    assertEquals(List.of("1"),partners.stream().map(row -> row.get("id")).toList());
    assertEquals(17.4,partners.getFirst().get("deliveryLatitude"));
    assertEquals(78.4,partners.getFirst().get("deliveryLongitude"));
  }

  @Test void locationAdminStatusChangesDisablePartnersAndRevokeOldSessions() {
    JdbcTemplate jdbc=mock(JdbcTemplate.class);
    UserAccountRepository users=mock(UserAccountRepository.class);
    MembershipRepository memberships=mock(MembershipRepository.class);
    Role role=new Role(); role.setName("LOCATION_ADMIN");
    Membership scope=new Membership(); scope.setRole(role); scope.setLocationId("location-a");
    when(memberships.findByUserUsernameIgnoreCase("location-admin")).thenReturn(List.of(scope));
    when(jdbc.queryForList(anyString())).thenReturn(List.of(Map.of("id","77","storeId","store-a","location","location-a")));
    UserAccount partner=new UserAccount(); partner.setUsername("partner");
    when(users.findById(77L)).thenReturn(Optional.of(partner));
    var controller=new DeliveryPartnerController(jdbc,users,memberships,mock(RoleRepository.class),mock(PasswordEncoder.class));
    var auth=new UsernamePasswordAuthenticationToken("location-admin","",List.of(new SimpleGrantedAuthority("ROLE_LOCATION_ADMIN")));

    controller.status(77L,new DeliveryPartnerController.StatusRequest(false),auth);
    assertFalse(partner.isEnabled());
    assertEquals("Inactive",partner.getStatus());
    assertEquals(1,partner.getTokenVersion());

    controller.status(77L,new DeliveryPartnerController.StatusRequest(true),auth);
    assertTrue(partner.isEnabled());
    assertEquals("Active",partner.getStatus());
    assertEquals(2,partner.getTokenVersion());
  }
}
