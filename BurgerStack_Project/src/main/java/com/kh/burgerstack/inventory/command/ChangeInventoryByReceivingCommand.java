package com.kh.burgerstack.inventory.command;

import java.util.List;

import com.kh.burgerstack.inventory.domain.InventoryTransaction;
import com.kh.burgerstack.user.LoginUser;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.ToString;

@RequiredArgsConstructor
@ToString
public class ChangeInventoryByReceivingCommand implements ChangeInventoryCommand {
    @Getter
    private final LoginUser loginUser; // 로그인 사용자

    private final String transactionMemo; // 변동 메모
    private final Integer receiptId; // 입고 ID

    @Getter
    private final List<ChangeInventoryCommand.DeltaItem> items; // 변경된 재고 정보

    @Override
    public InventoryTransaction createInventoryTransaction(int storeId) {
        return new InventoryTransaction(
                null,
                InventoryTransaction.Type.RECEIPT,
                "발주 입고 반영",
                transactionMemo,
                null,
                loginUser.getUserNo().intValue(),
                storeId,
                receiptId,
                null);
    }
}
