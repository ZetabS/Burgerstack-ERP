package com.kh.burgerstack.inventory.domain;

import java.time.LocalDateTime;

import com.kh.burgerstack.user.LoginUser;

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
public class InventoryTransaction {
    private Integer inventoryTransactionId;
    private InventoryTransaction.Type transactionType;
    private String reason;
    private String transactionMemo;
    private LocalDateTime createdAt;
    private Integer createdBy;
    private Integer storeId;
    private Integer receiptId;
    private Integer storeClosingId;

    @AllArgsConstructor
    @Getter
    public enum Type {
        RECEIPT("입고"),
        STORE_CLOSING("마감"),
        ADJUSTMENT("조정");

        private String label;
    }

    public static InventoryTransaction forAdjustment(
            LoginUser loginUser,
            String transactionMemo,
            String reason) {
        return new InventoryTransaction(
                null,
                InventoryTransaction.Type.ADJUSTMENT,
                reason,
                transactionMemo,
                null,
                loginUser.getUserNo().intValue(),
                null,
                null,
                null);
    }

    public static InventoryTransaction forReceiving(
            LoginUser loginUser,
            String transactionMemo,
            int receiptId) {
        return new InventoryTransaction(
                null,
                InventoryTransaction.Type.RECEIPT,
                "발주 입고 반영",
                transactionMemo,
                null,
                loginUser.getUserNo().intValue(),
                null,
                receiptId,
                null);
    }

    public static InventoryTransaction forClosing(
            LoginUser loginUser,
            String transactionMemo,
            int storeClosingId) {
        return new InventoryTransaction(
                null,
                InventoryTransaction.Type.STORE_CLOSING,
                "일일 마감 반영",
                transactionMemo,
                null,
                loginUser.getUserNo().intValue(),
                null,
                null,
                storeClosingId);
    }
}
