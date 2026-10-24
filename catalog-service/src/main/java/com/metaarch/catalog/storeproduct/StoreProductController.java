package com.metaarch.catalog.storeproduct;
import java.net.URI; import java.util.*; import jakarta.validation.Valid; import org.springframework.http.*; import org.springframework.security.access.AccessDeniedException; import org.springframework.security.core.Authentication; import org.springframework.web.bind.annotation.*;
@RestController @RequestMapping("/api/v1/store-products") public class StoreProductController {
 private final StoreProductService service; public StoreProductController(StoreProductService s){service=s;}
 @PostMapping ResponseEntity<StoreProductResponse> create(@Valid @RequestBody StoreProductRequest r,Authentication auth){authorizeStore(auth,r.storeId());StoreProductResponse v=service.create(r);return ResponseEntity.created(URI.create("/api/v1/store-products/"+v.id())).body(v);}
 @GetMapping List<StoreProductResponse> list(@RequestParam(required=false) String storeId,@RequestParam(required=false) UUID productId){return service.list(storeId,productId);} @GetMapping("/{id}") StoreProductResponse get(@PathVariable UUID id){return service.get(id);}
 @PutMapping("/{id}") StoreProductResponse update(@PathVariable UUID id,@Valid @RequestBody StoreProductRequest r,Authentication auth){authorizeStore(auth,service.get(id).storeId());authorizeStore(auth,r.storeId());return service.update(id,r);}
 @DeleteMapping("/{id}") @ResponseStatus(HttpStatus.NO_CONTENT) void delete(@PathVariable UUID id,Authentication auth){authorizeStore(auth,service.get(id).storeId());service.delete(id);}
 private void authorizeStore(Authentication auth,String storeId){
  if(auth==null)throw new AccessDeniedException("Authentication is required.");
  boolean admin=auth.getAuthorities().stream().anyMatch(a->Set.of("ROLE_GLOBAL_ADMIN","ROLE_SUPER_ADMIN").contains(a.getAuthority()));
  boolean manager=auth.getAuthorities().stream().anyMatch(a->"ROLE_STORE_MANAGER".equals(a.getAuthority()));
  if(admin)return;
  boolean assignedStore=auth.getAuthorities().stream().anyMatch(a->("SCOPE_STORE:"+storeId).equals(a.getAuthority()));
  if(!manager||!assignedStore)throw new AccessDeniedException("Store managers may manage mappings only for their assigned store.");
 }
}
