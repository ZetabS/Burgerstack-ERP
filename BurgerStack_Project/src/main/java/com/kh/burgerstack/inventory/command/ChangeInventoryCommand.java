package com.kh.burgerstack.inventory.command;

import java.util.List;

import com.kh.burgerstack.inventory.domain.InventoryTransactionType;
import com.kh.burgerstack.user.LoginUser;

import lombok.Getter;
import lombok.ToString;

public interface ChangeInventoryCommand {
    InventoryTransactionType getTransactionType();

    LoginUser getLoginUser();

    int getStoreId();

    List<ChangeInventoryCommand.Item> getItems();

    String getReason();

    String getTransactionMemo();

    Integer getStoreClosingId();

    Integer getReceiptId();

    @Getter
    @ToString
    class Item {
        private int inventoryId; // 재고 ID
        private int deltaQuantity; // 변경 수량

        public Item(int inventoryId, int deltaQuantity) {
            this.inventoryId = inventoryId;
            this.deltaQuantity = deltaQuantity;
        }
    }

}
