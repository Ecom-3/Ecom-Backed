package com.metaarch.catalog.coupon;

import java.util.List;
import java.util.Optional;
import java.util.UUID;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CouponRepository extends JpaRepository<Coupon, UUID> {
  List<Coupon> findAllByOrderByCreatedAtDesc();
  Optional<Coupon> findByCodeIgnoreCase(String code);
  boolean existsByCodeIgnoreCase(String code);
  boolean existsByCodeIgnoreCaseAndIdNot(String code, UUID id);
  java.util.Optional<Coupon> findFirstByCodeIgnoreCase(String code);
}
