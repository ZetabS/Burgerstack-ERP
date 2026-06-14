package com.kh.burgerstack.receipt;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.burgerstack.common.pagination.PageInfo;
import com.kh.burgerstack.common.pagination.PagingRequest;
import com.kh.burgerstack.purchase.PurchaseOrder;

import org.springframework.transaction.annotation.Transactional;
@Service
public class ReceiptService {

    @Autowired
    private ReceiptDao receiptDao;

    @Autowired
	private SqlSessionTemplate sqlSession;

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
						keyword
					)
			);
	}

    public PageInfo getPlanPageInfo(PagingRequest pagingRequest, String status) {
        return pagingRequest.toPageInfo(
                receiptDao.getPlanTotalCount(sqlSession, status)
        );
    }

    public List<PurchaseOrder> selectReceiptPlanList(PagingRequest pagingRequest, String status) {
        return receiptDao.selectReceiptPlanList(sqlSession, pagingRequest, status);
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
					keyword
				);
	}
    
    @Transactional
    public void processReceipt(Long purchaseOrderId,
                               ReceiptForm form,
                               Long createdBy) {

        // 발주 번호로 점포 번호 조회
        Long storeId =
                receiptDao.selectStoreIdByPurchaseOrderId(purchaseOrderId);

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

        // INVENTORY_TRANSACTIONS 생성
        ReceiptTransactionParam transactionParam =
                new ReceiptTransactionParam(
                        storeId,
                        receiptId,
                        createdBy
                );

        receiptDao.insertInventoryTransaction(transactionParam);

        Long inventoryTransactionId =
                transactionParam.getInventoryTransactionId();

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

            // 현재 재고 조회
            Long beforeQuantity =
                    receiptDao.selectCurrentQuantity(
                            storeId,
                            item.getPurchaseOrderItemId()
                    );

            if (beforeQuantity == null) {
                beforeQuantity = 0L;
            }

            // 입고 후 재고 계산
            Long afterQuantity =
                    beforeQuantity + receivedQuantity;

            // STORE_INVENTORIES 증가
            ReceiptInventoryParam inventoryParam =
                    new ReceiptInventoryParam(
                            storeId,
                            item.getPurchaseOrderItemId(),
                            receivedQuantity
                    );

            receiptDao.increaseStoreInventory(inventoryParam);

            // 증가된 재고 행 조회
            Long storeInventoryId =
                    receiptDao.selectStoreInventoryId(
                            storeId,
                            item.getPurchaseOrderItemId()
                    );

            // INVENTORY_TRANSACTION_ITEMS 저장
            ReceiptTransactionItemParam itemParam =
                    new ReceiptTransactionItemParam(
                            inventoryTransactionId,
                            storeInventoryId,
                            beforeQuantity,
                            afterQuantity
                    );

            receiptDao.insertInventoryTransactionItem(itemParam);
        }

        // 발주 상태 변경
        // APPROVED -> RECEIVED
        receiptDao.updatePurchaseOrderStatus(
                purchaseOrderId
        );
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







