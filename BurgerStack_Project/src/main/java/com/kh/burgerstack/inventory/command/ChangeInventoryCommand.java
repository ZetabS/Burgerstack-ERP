package com.kh.burgerstack.inventory.command;

import java.util.List;

import com.kh.burgerstack.inventory.domain.InventoryTransaction;
import com.kh.burgerstack.user.LoginUser;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.ToString;

@RequiredArgsConstructor
@Getter
public class ChangeInventoryCommand {
    private final LoginUser loginUser; // 로그인 사용자
    private final InventoryTransaction inventoryTransaction;
    private final List<? extends ChangeInventoryCommand.QuantityChange> items; // 변경된 재고 정보

    public static interface QuantityChange {
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
