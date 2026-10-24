package com.metaarch.customerprofile.profile;

import org.springframework.http.HttpStatus;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

@RestController
@RequestMapping("/api/v1/admin/customers")
public class AdminCustomerController {
  private final CustomerProfileRepository profiles;

  public AdminCustomerController(CustomerProfileRepository profiles) { this.profiles = profiles; }

  @GetMapping
  public CustomerPage list(@RequestParam(defaultValue = "0") int page,
      @RequestParam(defaultValue = "25") int size) {
    if (page < 0 || size < 1 || size > 100)
      throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Page must be non-negative and size must be between 1 and 100.");
    var result = profiles.findAll(PageRequest.of(page, size, Sort.by(Sort.Direction.ASC, "id")));
    return new CustomerPage(result.getContent().stream().map(CustomerSummary::from).toList(),
        result.getNumber(), result.getSize(), result.getTotalElements(), result.getTotalPages());
  }

  public record CustomerSummary(String id, String name, String username, String phone, String email, java.time.Instant createdAt) {
    static CustomerSummary from(CustomerProfile profile) {
      return new CustomerSummary(profile.getId().toString(), profile.getName(), profile.getUsername(),
          profile.getPhone(), profile.getEmail(), profile.getCreatedAt());
    }
  }

  public record CustomerPage(java.util.List<CustomerSummary> content, int page, int size,
      long totalElements, int totalPages) {}
}
