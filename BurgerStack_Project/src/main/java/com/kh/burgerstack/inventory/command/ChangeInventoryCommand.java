package com.kh.burgerstack.inventory.command;

import java.util.List;

import com.kh.burgerstack.exception.BusinessException;
import com.kh.burgerstack.inventory.domain.InventoryTransaction;
import com.kh.burgerstack.user.LoginUser;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.ToString;

public interface ChangeInventoryCommand {
    LoginUser getLoginUser();

    int getStoreId();

    InventoryTransaction getInventoryTransaction();

    List<? extends ChangeInventoryCommand.Item> getItems();

    interface Item {
        int getInventoryId();

        int resolveAfterQuantity(int currentQuantity);
    }

    @RequiredArgsConstructor
    @ToString
    public static class DeltaItem implements ChangeInventoryCommand.Item {
        @Getter
        private final int inventoryId;
        private final int deltaQuantity;

        @Override
        public int resolveAfterQuantity(int currentQuantity) {
            if (deltaQuantity == 0) {
                throw new BusinessException("변경 전과 후의 수량이 동일합니다.");
            }
            return currentQuantity + deltaQuantity;
        }
    }

    @RequiredArgsConstructor
    @ToString
    public static class ActualItem implements ChangeInventoryCommand.Item {
        @Getter
        private final int inventoryId;
        private final int actualQuantity;

        @Override
        public int resolveAfterQuantity(int currentQuantity) {
            int deltaQuantity = actualQuantity - currentQuantity;
            if (deltaQuantity == 0) {
                throw new BusinessException("변경 전과 후의 수량이 동일합니다.");
            }
            return actualQuantity;
        }
    }
}
