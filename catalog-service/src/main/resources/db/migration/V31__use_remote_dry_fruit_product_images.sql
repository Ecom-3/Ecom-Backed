-- Product detail/card images are stored in the catalog database and served
-- from a remote image CDN so the frontend does not depend on local assets.
UPDATE product_images i
JOIN products p ON p.id = i.product_id
SET i.url = 'https://images.unsplash.com/photo-1642337841034-249c5a21623c?auto=format&fit=crop&w=900&q=85',
    i.alt_text = CONCAT(p.name, ' product image'),
    i.updated_at = NOW(6)
WHERE p.sku IN (
  'DRY-CAL-ALMOND', 'DRY-PREM-CASHEW', 'DRY-AFG-RAISIN', 'DRY-IRN-PISTA', 'DRY-PREM-WALNUT'
)
  AND i.primary_image = TRUE;
