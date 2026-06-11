package com.kh.burgerstack.inventory.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.burgerstack.common.pagination.PagingRequest;
import com.kh.burgerstack.exception.BadRequestException;
import com.kh.burgerstack.exception.BusinessException;
import com.kh.burgerstack.exception.NotFoundException;
import com.kh.burgerstack.inventory.dao.InventoryDao;
import com.kh.burgerstack.inventory.dto.InventoryAdjustmentCommand;
import com.kh.burgerstack.inventory.dto.InventoryDetail;
import com.kh.burgerstack.inventory.dto.InventoryListItem;
import com.kh.burgerstack.inventory.dto.InventoryListView;
import com.kh.burgerstack.inventory.dto.InventorySearchCondition;
import com.kh.burgerstack.inventory.dto.InventoryTransactionCreateCommand;
import com.kh.burgerstack.inventory.vo.InventoryTransactionItem;
import com.kh.burgerstack.inventory.vo.StoreInventory;
import com.kh.burgerstack.store.StoreDao;
import com.kh.burgerstack.store.dto.StoreOption;
import com.kh.burgerstack.user.LoginUser;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class InventoryService {
    private final InventoryTransactionService inventoryTransactionService;
    private final InventoryDao inventoryDao;
    private final StoreDao storeDao;

    public InventoryListView getInventoryListView(
            InventorySearchCondition condition,
            PagingRequest pagingRequest,
            LoginUser loginUser) {
        if (!loginUser.isAdmin() && condition.getStoreId() != null
                && condition.getStoreId() != loginUser.getStoreId().intValue()) {
            throw new BusinessException("재고를 찾을 수 없습니다.");
        }

        List<InventoryListItem> list = inventoryDao.findInventoryListItems(condition, pagingRequest);
        int totalCount = inventoryDao.count(condition);
        List<StoreOption> storeOptions = storeDao.getStoreOptions();

        return new InventoryListView(
                list,
                storeOptions,
                condition,
                pagingRequest.toPageInfo(totalCount));
    }

    public InventoryDetail getInventoryDetail(int inventoryId, LoginUser loginUser) {
        InventoryDetail detail = inventoryDao.getInventoryDetailById(inventoryId);
        if (!loginUser.isAdmin() && detail.getStoreId() != loginUser.getStoreId().intValue()) {
            throw new BusinessException("재고를 찾을 수 없습니다.");
        }

        return detail;
    }

    @Transactional
    public void adjustQuantity(InventoryAdjustmentCommand command) {
        StoreInventory current = find(command.getInventoryId());
        validateAccess(current, command.getLoginUser());
        validateQuantity(current.getCurrentQuantity(), command.getAfterQuantity());
        updateQuantity(current, command);

        List<InventoryTransactionItem> list = new ArrayList<>();
        InventoryTransactionItem inventoryTransactionItem = new InventoryTransactionItem(
                current.getCurrentQuantity(),
                command.getAfterQuantity(),
                command.getInventoryId());
        list.add(inventoryTransactionItem);
        inventoryTransactionService.createTransaction(new InventoryTransactionCreateCommand(
                "ADJUSTMENT",
                command.getReason(),
                command.getTransactionMemo(),
                command.getLoginUser().getUserNo().intValue(),
                current.getStoreId(),
                null,
                null,
                list));
    }

    @Transactional
    public void changeSafetyQuantity(
            int inventoryId,
            int safetyQuantity,
            LoginUser loginUser) {
        StoreInventory current = find(inventoryId);

        validateAccess(current, loginUser);
        validateSafetyQuantity(current, safetyQuantity);

        inventoryDao.updateSafetyQuantity(inventoryId, safetyQuantity, current.getSafetyQuantity());
    }

    private StoreInventory find(int inventoryId) {
        StoreInventory current = inventoryDao.findById(inventoryId);

        if (current == null) {
            throw new NotFoundException("재고를 찾을 수 없습니다.");
        }

        return current;
    }

    private void validateAccess(StoreInventory current, LoginUser loginUser) {
        boolean isAdmin = loginUser.isAdmin();
        boolean isOwnStore = current.getStoreId() != loginUser.getStoreId().intValue();

        if (!isAdmin && !isOwnStore) {
            throw new BusinessException("재고에 접근할 권한이 없습니다.");
        }
    }

    private void validateQuantity(int beforeQuantity, int afterQuantity) {
        if (afterQuantity < 0) {
            throw new BadRequestException("재고 수량은 0 이상이어야 합니다.");
        }

        if (beforeQuantity == afterQuantity) {
            throw new BusinessException("변경 전과 후의 재고 수량이 동일합니다.");
        }
    }

    private void updateQuantity(StoreInventory current, InventoryAdjustmentCommand command) {
        inventoryDao.updateQuantity(
                command.getInventoryId(),
                current.getCurrentQuantity(),
                command.getAfterQuantity());
    }

    private void validateSafetyQuantity(StoreInventory current, int safetyQuantity) {
        if (safetyQuantity < 0) {
            throw new BadRequestException("안전재고 수량은 0 이상이어야 합니다.");
        }

        if (current.getSafetyQuantity() == safetyQuantity) {
            throw new BusinessException("변경 전과 후의 안전재고 수량이 동일합니다.");
        }
    }
}
