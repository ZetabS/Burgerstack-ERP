package com.kh.burgerstack.inventory.command;

import java.util.List;

import com.kh.burgerstack.inventory.domain.InventoryTransaction;
import com.kh.burgerstack.user.LoginUser;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.ToString;

public interface ChangeInventoryCommand {
    LoginUser getLoginUser();

    List<? extends ChangeInventoryCommand.QuantityChange> getItems();

    InventoryTransaction createInventoryTransaction(int storeId);

    interface QuantityChange {
        int getInventoryId();
    }

    @RequiredArgsConstructor
    @Getter
    @ToString
    public static class DeltaQuantityChange implements ChangeInventoryCommand.QuantityChange {
        private final int inventoryId;
        private final int deltaQuantity;
    }

    @RequiredArgsConstructor
    @Getter
    @ToString
    public static class FixedQuantityChange implements ChangeInventoryCommand.QuantityChange {
        private final int inventoryId;
        private final int actualQuantity;
    }
}
