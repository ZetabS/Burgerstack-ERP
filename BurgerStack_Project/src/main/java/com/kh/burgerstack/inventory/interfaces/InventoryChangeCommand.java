package com.kh.burgerstack.inventory.interfaces;

import java.util.List;

import com.kh.burgerstack.inventory.dto.InventoryChangeItem;
import com.kh.burgerstack.inventory.enums.TransactionType;
import com.kh.burgerstack.user.LoginUser;

public interface InventoryChangeCommand {
    TransactionType getTransactionType();

    LoginUser getLoginUser();

    int getStoreId();

    List<InventoryChangeItem> getItems();

    String getReason();

    String getTransactionMemo();

    Integer getStoreClosingId();

    Integer getReceiptId();
}
