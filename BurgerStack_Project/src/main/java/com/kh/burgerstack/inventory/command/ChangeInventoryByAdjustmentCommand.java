package com.kh.burgerstack.inventory.command;

import java.util.List;

import com.kh.burgerstack.inventory.domain.InventoryTransaction;
import com.kh.burgerstack.inventory.domain.InventoryTransactionType;
import com.kh.burgerstack.user.LoginUser;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.ToString;

@RequiredArgsConstructor
@ToString
public class ChangeInventoryByAdjustmentCommand implements ChangeInventoryCommand {
    @Getter
    private final LoginUser loginUser; // 로그인 사용자
    @Getter
    private final int storeId; // 점포 ID

    private final String reason;
    private final String transactionMemo;

    @Getter
    private final List<ChangeInventoryCommand.ActualItem> items; // 변경된 재고 정보

    @Override
    public InventoryTransaction getInventoryTransaction() {
        return new InventoryTransaction(
                null,
                InventoryTransactionType.ADJUSTMENT,
                reason,
                transactionMemo,
                null,
                loginUser.getUserNo().intValue(),
                storeId,
                null,
                null);
    }
}
