package com.metaarch.orgaccess.audit;

import jakarta.persistence.criteria.Predicate;
import java.time.Instant;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

@RestController
@RequestMapping("/api/audit-logs")
@PreAuthorize("hasAnyRole('GLOBAL_ADMIN','SUPER_ADMIN')")
public class AdminAuditLogController {
  private static final Set<String> SORT_FIELDS = Set.of("id", "actor", "action", "createdAt");
  private final AuditLogRepository logs;

  public AdminAuditLogController(AuditLogRepository logs) { this.logs = logs; }

  @GetMapping
  public AuditPage list(@RequestParam(defaultValue = "0") int page,
      @RequestParam(defaultValue = "25") int size,
      @RequestParam(required = false) String actor,
      @RequestParam(required = false) String action,
      @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) Instant from,
      @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) Instant to,
      @RequestParam(defaultValue = "createdAt") String sortBy,
      @RequestParam(defaultValue = "desc") String direction) {
    if (page < 0 || size < 1 || size > 100)
      throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Page must be non-negative and size must be between 1 and 100.");
    if (!SORT_FIELDS.contains(sortBy) || !("asc".equalsIgnoreCase(direction) || "desc".equalsIgnoreCase(direction)))
      throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Unsupported audit sort field or direction.");
    if (from != null && to != null && from.isAfter(to))
      throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "The from timestamp must not be after the to timestamp.");
    var sort = Sort.by("asc".equalsIgnoreCase(direction) ? Sort.Direction.ASC : Sort.Direction.DESC, sortBy);
    var result = logs.findAll((root, query, cb) -> {
      List<Predicate> predicates = new ArrayList<>();
      if (actor != null && !actor.isBlank()) predicates.add(cb.like(cb.lower(root.get("actor")), "%" + actor.trim().toLowerCase() + "%"));
      if (action != null && !action.isBlank()) predicates.add(cb.like(cb.lower(root.get("action")), "%" + action.trim().toLowerCase() + "%"));
      if (from != null) predicates.add(cb.greaterThanOrEqualTo(root.get("createdAt"), from));
      if (to != null) predicates.add(cb.lessThanOrEqualTo(root.get("createdAt"), to));
      return cb.and(predicates.toArray(Predicate[]::new));
    }, PageRequest.of(page, size, sort));
    return new AuditPage(result.getContent().stream().map(AuditRow::from).toList(), result.getNumber(),
        result.getSize(), result.getTotalElements(), result.getTotalPages());
  }

  public record AuditRow(Long id, String actor, String action, String target, Instant createdAt) {
    static AuditRow from(AuditLog row) { return new AuditRow(row.getId(), row.getActor(), row.getAction(), row.getTarget(), row.getCreatedAt()); }
  }
  public record AuditPage(List<AuditRow> content, int page, int size, long totalElements, int totalPages) {}
}
