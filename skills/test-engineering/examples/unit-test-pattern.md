# Unit Test Patterns (TypeScript & Python)

Clean examples showcasing the **Arrange-Act-Assert (AAA)** pattern with clear failure cases.

---

## TypeScript (Vitest / Jest)

```typescript
import { describe, it, expect, vi, beforeEach } from 'vitest';
import { PricingService } from './pricing.service';
import type { DiscountRepository } from './discount.repository';

describe('PricingService', () => {
  let pricingService: PricingService;
  let mockDiscountRepo: DiscountRepository;

  beforeEach(() => {
    // Arrange: Create test doubles
    mockDiscountRepo = {
      findByCode: vi.fn(),
    };
    pricingService = new PricingService(mockDiscountRepo);
  });

  it('should apply 20% discount when a valid seasonal coupon is provided', async () => {
    // Arrange
    vi.mocked(mockDiscountRepo.findByCode).mockResolvedValue({
      code: 'SUMMER20',
      percentage: 20,
      active: true,
    });

    // Act
    const result = await pricingService.calculateTotal({
      basePrice: 100,
      discountCode: 'SUMMER20',
    });

    // Assert
    expect(result.finalPrice).toBe(80);
    expect(result.discountApplied).toBe(20);
    expect(mockDiscountRepo.findByCode).toHaveBeenCalledWith('SUMMER20');
  });

  it('should throw an error when discount code is expired', async () => {
    // Arrange
    vi.mocked(mockDiscountRepo.findByCode).mockResolvedValue({
      code: 'EXPIRED10',
      percentage: 10,
      active: false,
    });

    // Act & Assert
    await expect(
      pricingService.calculateTotal({ basePrice: 100, discountCode: 'EXPIRED10' })
    ).rejects.toThrowError(/coupon has expired/i);
  });
});
```

---

## Python (pytest)

```python
import pytest
from unittest.mock import create_autospec
from app.services.pricing import PricingService
from app.repositories.discount import DiscountRepository
from app.exceptions import InvalidCouponError

@pytest.fixture
def mock_discount_repo():
    return create_autospec(DiscountRepository, instance=True)

@pytest.fixture
def pricing_service(mock_discount_repo):
    return PricingService(discount_repo=mock_discount_repo)

def test_calculate_total_applies_valid_discount(pricing_service, mock_discount_repo):
    # Arrange
    mock_discount_repo.find_by_code.return_value = {
        "code": "FALL15",
        "percentage": 15,
        "active": True
    }

    # Act
    result = pricing_service.calculate_total(base_price=200, discount_code="FALL15")

    # Assert
    assert result.final_price == 170
    assert result.discount_applied == 30
    mock_discount_repo.find_by_code.assert_called_once_with("FALL15")

def test_calculate_total_raises_for_inactive_coupon(pricing_service, mock_discount_repo):
    # Arrange
    mock_discount_repo.find_by_code.return_value = {
        "code": "OLDCODE",
        "percentage": 10,
        "active": False
    }

    # Act & Assert
    with pytest.raises(InvalidCouponError, match="coupon has expired"):
        pricing_service.calculate_total(base_price=100, discount_code="OLDCODE")
```
