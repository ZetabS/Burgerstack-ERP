package com.kh.burgerstack.inventory.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.burgerstack.exception.CustomException;
import com.kh.burgerstack.inventory.dao.InventoryTransactionDao;
import com.kh.burgerstack.inventory.dto.InventoryTransactionCreateCommand;
import com.kh.burgerstack.inventory.vo.InventoryTransaction;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class InventoryTransactionService {
    private final InventoryTransactionDao inventoryTransactionDao;
    private static final List<String> TRANSACTION_TYPE = List.of("RECEIPT", "STORE_CLOSING", "ADJUSTMENT");

    @Transactional
    public InventoryTransaction createTransaction(InventoryTransactionCreateCommand command) {
        if (!TRANSACTION_TYPE.contains(command.getTransactionType())) {
            throw new CustomException("재고 변동 이력 유형이 올바르지 않습니다.");
        }

        InventoryTransaction inventoryTransaction = command.getInventoryTransaction();
        inventoryTransactionDao.insert(inventoryTransaction);

        inventoryTransactionDao.insertItems(
                inventoryTransaction.getInventoryTransactionId(),
                command.getInventoryTransactionItems());

        return inventoryTransaction;
    }
}
