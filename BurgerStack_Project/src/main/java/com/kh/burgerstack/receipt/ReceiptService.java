package com.kh.burgerstack.receipt;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.burgerstack.common.pagination.PageInfo;
import com.kh.burgerstack.common.pagination.PagingRequest;
import com.kh.burgerstack.inventory.command.ChangeInventoryCommand;
import com.kh.burgerstack.inventory.domain.InventoryTransaction;
import com.kh.burgerstack.inventory.service.InventoryService;
import com.kh.burgerstack.user.LoginUser;

@Service
public class ReceiptService {

    private final InventoryService inventoryService;

    @Autowired
    private ReceiptDao receiptDao;

    @Autowired
    private SqlSessionTemplate sqlSession;

    ReceiptService(InventoryService inventoryService) {
        this.inventoryService = inventoryService;
    }

    public PageInfo getHistoryPageInfo(PagingRequest pagingRequest,
            String receiptType,
            String startDate,
            String endDate,
            String keyword) {
        return pagingRequest.toPageInfo(
                receiptDao.getHistoryTotalCount(
                        sqlSession,
                        receiptType,
                        startDate,
                        endDate,
                        keyword));
    }

    public PageInfo getPlanPageInfo(PagingRequest pagingRequest,
            String status,
            String startDate,
            String endDate,
            String keyword,
            Long storeId) {

        return pagingRequest.toPageInfo(
                receiptDao.getPlanTotalCount(
                        status,
                        startDate,
                        endDate,
                        keyword,
                        storeId));
    }

    public List<ReceiptPlanDto> selectReceiptPlanList(PagingRequest pagingRequest,
            String status,
            String startDate,
            String endDate,
            String keyword,
            Long storeId) {

        return receiptDao.selectReceiptPlanList(
                pagingRequest,
                status,
                startDate,
                endDate,
                keyword,
                storeId);
    }

    public List<Receipt> selectReceiptList(PagingRequest pagingRequest,
            String receiptType,
            String startDate,
            String endDate,
            String keyword) {
        return receiptDao.selectReceiptList(
                sqlSession,
                pagingRequest,
                receiptType,
                startDate,
                endDate,
                keyword);
    }

    public Long selectStoreIdByOwnerUserNo(Long ownerUserNo) {
        return receiptDao.selectStoreIdByOwnerUserNo(ownerUserNo);
    }

    @Transactional
    public void processReceipt(Long purchaseOrderId,
            ReceiptForm form,
            LoginUser loginUser) {
        // RECEIPTS 테이블 저장
        Receipt receipt = new Receipt();

        receipt.setPurchaseOrderId(purchaseOrderId);

        // 사용자가 모달에서 입력한 비고 저장
        String receiptMemo = form.getReceiptMemo();

        if (receiptMemo == null || receiptMemo.trim().isEmpty()) {
            receiptMemo = "입고 처리";
        }

        receipt.setReceiptMemo(receiptMemo);

        receiptDao.insertReceipt(receipt);

        // 생성된 입고번호
        Long receiptId = receipt.getReceiptId();

        // 입고 상품 반복 처리
        for (ReceiptItem item : form.getItems()) {

            // 현재 입고번호 설정
            item.setReceiptId(receiptId);

            // null 방지 - 실입고 수량
            Long receivedQuantity = item.getReceivedQuantity();

            if (receivedQuantity == null) {
                receivedQuantity = 0L;
                item.setReceivedQuantity(receivedQuantity);
            }

            // null 방지 - 차이 수량
            Long diffQuantity = item.getDefectQuantity();

            if (diffQuantity == null) {
                diffQuantity = 0L;
                item.setDefectQuantity(diffQuantity);
            }

            // 차이 수량이 있는데 사유가 없으면 서버에서도 차단
            if (diffQuantity != 0) {
                String reason = item.getReceiptItemMemo();

                if (reason == null || reason.trim().isEmpty()) {
                    throw new IllegalArgumentException("차이 수량이 있는 품목은 사유를 선택해야 합니다.");
                }
            }

            // 차이 수량이 없으면 사유 제거
            if (diffQuantity == 0) {
                item.setReceiptItemMemo(null);
            }

            // RECEIPT_ITEMS 저장
            receiptDao.insertReceiptItem(item);
        }

        List<ChangeInventoryCommand.DeltaQuantityChange> inventoryChangeItems = form.getItems()
                .stream()
                .filter(item -> item.getReceivedQuantity() != 0)
                .map(item -> {
                    int deltaQuantity = item.getReceivedQuantity().intValue();
                    int inventoryId = receiptDao
                            .selectStoreInventoryId(loginUser.getStoreId(), item.getPurchaseOrderItemId()).intValue();
                    return new ChangeInventoryCommand.DeltaQuantityChange(inventoryId, deltaQuantity);
                }).toList();

        ChangeInventoryCommand inventoryReceiptChangeCommand = new ChangeInventoryCommand(
                loginUser,
                InventoryTransaction.forReceiving(
                        loginUser,
                        receiptMemo,
                        receiptId.intValue()),
                inventoryChangeItems);

        inventoryService.change(inventoryReceiptChangeCommand);

        // 발주 상태 변경
        // APPROVED -> RECEIVED
        receiptDao.updatePurchaseOrderStatus(
                purchaseOrderId);
    }

    public Receipt selectReceiptDetail(Long receiptId) {
        return receiptDao.selectReceiptDetail(receiptId);
    }

    public List<ReceiptItemDetail> selectReceiptItemDetailList(Long receiptId) {
        return receiptDao.selectReceiptItemDetailList(receiptId);
    }

    public List<ReceiptCheckItemDto> selectReceiptCheckItemList(Long purchaseId) {
        return receiptDao.selectReceiptCheckItemList(purchaseId);
    }

    public String selectPurchaseStatus(Long purchaseId) {
        return receiptDao.selectPurchaseStatus(purchaseId);
    }

}
