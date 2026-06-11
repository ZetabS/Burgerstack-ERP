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

    public PageInfo getHistoryPageInfo(PagingRequest pagingRequest, String receiptType) {
        return pagingRequest.toPageInfo(
                receiptDao.getHistoryTotalCount(sqlSession, receiptType)
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
    
    public List<Receipt> selectReceiptList(String receiptType) {
        return receiptDao.selectReceiptList(receiptType);
    }
    
    @Transactional // 하나라도 실패하면 전체 롤백
    public void processReceipt(Long purchaseOrderId,
                               ReceiptForm form,
                               Long createdBy) {

        // 발주 번호로 점포 번호 조회
        Long storeId =
                receiptDao.selectStoreIdByPurchaseOrderId(purchaseOrderId);

        
        // RECEIPTS 테이블 저장
        Receipt receipt = new Receipt();

        receipt.setPurchaseOrderId(purchaseOrderId);

        // 불량수량이 1개 이상 있는지 확인
        boolean hasDefect = false;

        for (ReceiptItem item : form.getItems()) {
            if (item.getDefectQuantity() != null && item.getDefectQuantity() > 0) {
                hasDefect = true;
                break;
            }
        }

        // 입고 메모 자동 설정
        if (hasDefect) {
            receipt.setReceiptMemo("불량 포함 입고");
        } else {
            receipt.setReceiptMemo("정상 입고");
        }

        receiptDao.insertReceipt(receipt);

        // 생성된 입고번호
        Long receiptId = receipt.getReceiptId();

        
        // INVENTORY_TRANSACTIONS 생성
        // 재고 변동 이력 헤더 생성
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

            
            // RECEIPT_ITEMS 저장
            receiptDao.insertReceiptItem(item);

            
            // 현재 재고 조회
            Long beforeQuantity =
                    receiptDao.selectCurrentQuantity(
                            storeId,
                            item.getPurchaseOrderItemId()
                    );

            // null 방지
            Long receivedQuantity = item.getReceivedQuantity();

            if (receivedQuantity == null) {
                receivedQuantity = 0L;
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

            System.out.println("storeId = " + storeId);
            System.out.println("purchaseOrderItemId = " + item.getPurchaseOrderItemId());
            System.out.println("storeInventoryId = " + storeInventoryId);


            // INVENTORY_TRANSACTION_ITEMS 저장
            // 재고 변동 상세 이력 생성
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







