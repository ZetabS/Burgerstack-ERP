package com.kh.burgerstack.inventory.domain;

import java.time.LocalDateTime;

import com.kh.burgerstack.exception.BadRequestException;
import com.kh.burgerstack.exception.BusinessException;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class StoreInventory {
    private Integer storeInventoryId;
    private Integer currentQuantity;
    private Integer safetyQuantity;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private Integer storeId;
    private Integer materialId;

    public InventoryTransactionItem change(int actualQuantity) {
        if (actualQuantity < 0) {
            throw new BadRequestException("수량은 0 이상이어야 합니다.");
        }

        int beforeQuantity = this.currentQuantity;

        this.currentQuantity = actualQuantity;

        return new InventoryTransactionItem(
                beforeQuantity,
                actualQuantity,
                this.getStoreInventoryId());
    }

    public void changeSafetyQuantityTo(int safetyQuantity) {
        if (this.safetyQuantity == safetyQuantity) {
            throw new BusinessException("변경 전과 후의 수량이 동일합니다.");
        }

        if (safetyQuantity < 0) {
            throw new BadRequestException("수량은 0 이상이어야 합니다.");
        }

        this.safetyQuantity = safetyQuantity;
    }
}
