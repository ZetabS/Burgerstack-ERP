package com.kh.burgerstack.inventory.command;

import java.util.List;

import com.kh.burgerstack.inventory.domain.InventoryTransactionType;
import com.kh.burgerstack.user.LoginUser;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.ToString;

@RequiredArgsConstructor
@Getter
@ToString
public class ChangeInventoryByReceivingCommand implements ChangeInventoryCommand {
    private final LoginUser loginUser; // 로그인 사용자
    private final List<ChangeInventoryCommand.Item> items; // 변경된 재고 정보
    private final String transactionMemo; // 변동 메모
    private final Integer receiptId; // 입고 ID
    private final int storeId; // 점포 ID

    private final Integer storeClosingId = null;
    private final InventoryTransactionType transactionType = InventoryTransactionType.RECEIPT;
    private final String reason = "발주 입고 반영";
}
