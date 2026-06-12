package com.kh.burgerstack.inventory.dto;

import java.util.List;

import com.kh.burgerstack.inventory.enums.TransactionType;
import com.kh.burgerstack.inventory.interfaces.InventoryChangeCommand;
import com.kh.burgerstack.user.LoginUser;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.ToString;

@RequiredArgsConstructor
@Getter
@ToString
public class InventoryStoreClosingChangeCommand implements InventoryChangeCommand {
    private final LoginUser loginUser; // 로그인 사용자
    private final List<InventoryChangeItem> items; // 변경된 재고 정보
    private final String transactionMemo; // 변동 메모
    private final Integer storeClosingId; // 마감 ID
    private final int storeId; // 점포 ID

    private final Integer receiptId = null;
    private final TransactionType transactionType = TransactionType.STORE_CLOSING;

    @Override
    public String getReason() {
        return transactionType.getLabel();
    }
}
