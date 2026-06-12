package com.kh.burgerstack.inventory.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.burgerstack.common.pagination.PagingRequest;
import com.kh.burgerstack.exception.BadRequestException;
import com.kh.burgerstack.exception.BusinessException;
import com.kh.burgerstack.exception.NotFoundException;
import com.kh.burgerstack.inventory.dao.InventoryDao;
import com.kh.burgerstack.inventory.dto.InventoryAdjustmentChangeCommand;
import com.kh.burgerstack.inventory.dto.InventoryAdjustmentCommand;
import com.kh.burgerstack.inventory.dto.InventoryChangeItem;
import com.kh.burgerstack.inventory.dto.InventoryChangeParam;
import com.kh.burgerstack.inventory.dto.InventoryDetail;
import com.kh.burgerstack.inventory.dto.InventoryListItem;
import com.kh.burgerstack.inventory.dto.InventoryListView;
import com.kh.burgerstack.inventory.dto.InventorySearchCondition;
import com.kh.burgerstack.inventory.dto.InventoryTransactionCreateCommand;
import com.kh.burgerstack.inventory.interfaces.InventoryChangeCommand;
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
        validateAccess(loginUser, condition.getStoreId());

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
        validateAccess(loginUser, detail.getStoreId());
        return detail;
    }

    @Transactional
    public void change(InventoryChangeCommand command) {
        // InventoryChangeItem 리스트를 InventoryChangeParam 리스트로 변환
        List<InventoryChangeParam> inventoryChangeParams = command.getItems()
                .stream()
                .map((InventoryChangeItem item) -> {
                    StoreInventory current = find(item.getInventoryId());
                    validateAccess(command.getLoginUser(), current.getStoreId());

                    int beforeQuantity = current.getCurrentQuantity();
                    int afterQuantity = beforeQuantity + item.getDeltaQuantity();

                    validateQuantity(beforeQuantity, afterQuantity);

                    return new InventoryChangeParam(
                            item.getInventoryId(),
                            beforeQuantity,
                            afterQuantity);
                }).toList();

        for (InventoryChangeParam param : inventoryChangeParams) {
            inventoryDao.updateQuantity(param);
        }

        inventoryTransactionService.createTransaction(new InventoryTransactionCreateCommand(
                command.getTransactionType(),
                command.getReason(),
                command.getTransactionMemo(),
                command.getLoginUser().getUserNo().intValue(),
                command.getStoreId(),
                command.getReceiptId(),
                command.getStoreClosingId(),
                inventoryChangeParams));
    }

    @Transactional
    public void adjustQuantity(InventoryAdjustmentCommand command) {
        StoreInventory current = find(command.getInventoryId());

        // 검증은 change에서 수행하므로 다루지 않음
        int deltaQuantity = command.getAfterQuantity() - current.getCurrentQuantity();
        List<InventoryChangeItem> items = List.of(new InventoryChangeItem(command.getInventoryId(), deltaQuantity));

        change(new InventoryAdjustmentChangeCommand(
                command.getLoginUser(),
                items,
                command.getTransactionMemo(),
                command.getReason(),
                current.getStoreId()));
    }

    @Transactional
    public void changeSafetyQuantity(
            int inventoryId,
            int safetyQuantity,
            LoginUser loginUser) {
        StoreInventory current = find(inventoryId);

        validateAccess(loginUser, current.getStoreId());
        validateQuantity(current.getSafetyQuantity(), safetyQuantity);

        inventoryDao.updateSafetyQuantity(
                inventoryId,
                safetyQuantity,
                current.getSafetyQuantity());
    }

    private StoreInventory find(int inventoryId) {
        StoreInventory current = inventoryDao.findById(inventoryId);

        if (current == null) {
            throw new NotFoundException("재고를 찾을 수 없습니다.");
        }

        return current;
    }

    private void validateAccess(LoginUser loginUser, Integer storeId) {
        // 관리자는 접근 가능
        if (loginUser.isAdmin()) {
            return;
        }

        boolean isOwnStore = loginUser.getStoreId() == null ? false
                : loginUser.getStoreId().intValue() == storeId;

        // 점주는 자신의 점포에 접근 가능
        if (loginUser.isOwner() && isOwnStore) {
            return;
        }

        // 해당하지 않으면 거절
        throw new BusinessException("재고에 접근할 권한이 없습니다.");
    }

    private void validateQuantity(int beforeQuantity, int afterQuantity) {
        if (afterQuantity < 0) {
            throw new BadRequestException("수량은 0 이상이어야 합니다.");
        }

        if (beforeQuantity == afterQuantity) {
            throw new BusinessException("변경 전과 후의 수량이 동일합니다.");
        }
    }
}
