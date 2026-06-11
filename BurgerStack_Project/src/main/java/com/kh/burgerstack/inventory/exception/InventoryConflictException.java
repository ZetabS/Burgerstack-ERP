package com.kh.burgerstack.inventory.exception;

import com.kh.burgerstack.exception.AppException;

public class InventoryConflictException extends AppException {
    public InventoryConflictException() {
        super("재고 정보가 변경되었습니다. 다시 조회한 뒤 처리해주세요.");
    }
}