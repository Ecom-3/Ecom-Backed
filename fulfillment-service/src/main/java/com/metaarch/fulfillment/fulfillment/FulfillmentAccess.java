package com.metaarch.fulfillment.fulfillment;

import com.metaarch.sync.PublicApiSecurity;
import com.metaarch.fulfillment.shipment.ShipmentRepository;
import java.util.UUID;
import org.springframework.context.annotation.Import;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

@Component("fulfillmentAccess")
@Import({PublicApiSecurity.class, com.metaarch.sync.CatalogLocationClient.class})
@Transactional(readOnly=true)
public class FulfillmentAccess {
  private final FulfillmentRepository fulfillments;
  private final ShipmentRepository shipments;
  private final com.metaarch.fulfillment.event.FulfillmentOrderSnapshotRepository snapshots;
  private final com.metaarch.sync.CatalogLocationClient catalog;
  public FulfillmentAccess(FulfillmentRepository fulfillments, ShipmentRepository shipments, com.metaarch.fulfillment.event.FulfillmentOrderSnapshotRepository snapshots, com.metaarch.sync.CatalogLocationClient catalog) { this.fulfillments=fulfillments;this.shipments=shipments;this.snapshots=snapshots;this.catalog=catalog; }
  public boolean admin() {return PublicApiSecurity.administrator();}
  public String partnerId() {
    var auth=org.springframework.security.core.context.SecurityContextHolder.getContext().getAuthentication();
    if (!(auth instanceof org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationToken token)
        || "customer".equals(token.getToken().getClaimAsString("accountType"))
        || token.getAuthorities().stream().noneMatch(a -> a.getAuthority().equals("ROLE_DELIVERY_PARTNER"))) return null;
    String id=token.getToken().getClaimAsString("deliveryPartnerId");
    return id!=null && !id.isBlank()?id:null;
  }
  public boolean assignedOrder(UUID id) {
    String partner=partnerId();
    return partner!=null && shipments.findByOrderId(id).map(s -> partner.equals(s.getDeliveryPartnerId())).orElse(false);
  }
  public boolean assignedShipment(UUID id) {
    String partner=partnerId();
    return (partner!=null && shipments.findById(id).map(s -> partner.equals(s.getDeliveryPartnerId())).orElse(false))
        || trustedDeliveryAction(id);
  }
  public boolean owner(UUID id) {return admin() || fulfillments.findById(id).map(f -> PublicApiSecurity.owns(f.getCustomerId()) || manages(f.getStoreId())).orElse(false);}
  public boolean order(UUID id) {return admin() || assignedOrder(id) || fulfillments.findByOrderId(id).map(f -> PublicApiSecurity.owns(f.getCustomerId()) || manages(f.getStoreId())).orElseGet(() -> snapshots.findById(id).map(f -> PublicApiSecurity.owns(f.getCustomerId()) || manages(f.getStoreId())).orElse(false));}
  public boolean shipment(UUID id) {return admin() || assignedShipment(id) || shipments.findById(id).map(s -> PublicApiSecurity.owns(s.getFulfillment().getCustomerId()) || manages(s.getFulfillment().getStoreId())).orElse(false);}
  public boolean manage(UUID id) {return admin() || fulfillments.findById(id).map(f -> manages(f.getStoreId())).orElse(false);}
  public boolean manageShipment(UUID id) {return admin() || shipments.findById(id).map(s -> manages(s.getFulfillment().getStoreId())).orElse(false);}
  public boolean updateAssignedShipment(UUID id) {return trustedDeliveryAction(id) || manageShipment(id);}

  private boolean trustedDeliveryAction(UUID shipmentId) {
    var auth=org.springframework.security.core.context.SecurityContextHolder.getContext().getAuthentication();
    if (!(auth instanceof org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationToken token)
        || token.getAuthorities().stream().noneMatch(a -> a.getAuthority().equals("ROLE_DELIVERY_PARTNER"))
        || !Boolean.TRUE.equals(token.getToken().getClaimAsBoolean("deliveryActionProxy"))) return false;
    String partnerId=token.getToken().getClaimAsString("deliveryPartnerId");
    String orderId=token.getToken().getClaimAsString("deliveryActionOrderId");
    return partnerId!=null && orderId!=null && shipments.findById(shipmentId)
        .map(shipment -> partnerId.equals(shipment.getDeliveryPartnerId())
            && orderId.equals(shipment.getOrderId().toString())).orElse(false);
  }
  public boolean create(CreateFulfillmentRequest request) {
    return admin() || snapshots.findById(request.orderId()).map(s -> !s.isCancelled()
        && manages(s.getStoreId()) && s.getStoreId().equals(request.storeId())
        && s.getCustomerId().equals(request.customerId())
        && java.util.Objects.equals(s.getShippingAddressId(), request.shippingAddressId())
        && s.getFulfillmentType() == request.fulfillmentType()).orElse(false);
  }

  private boolean manages(String storeId) {
    if (PublicApiSecurity.managesStore(storeId)) return true;
    var auth=org.springframework.security.core.context.SecurityContextHolder.getContext().getAuthentication();
    if (!(auth instanceof org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationToken token)
        || token.getAuthorities().stream().noneMatch(a -> a.getAuthority().equals("ROLE_LOCATION_ADMIN"))) return false;
    String location=token.getAuthorities().stream().map(a->a.getAuthority()).filter(a->a.startsWith("SCOPE_LOCATION:"))
        .map(a->a.substring("SCOPE_LOCATION:".length())).findFirst().orElse(null);
    return location!=null && catalog.locationOf(storeId).map(location::equalsIgnoreCase).orElse(false);
  }
}
