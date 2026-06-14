package com.kh.burgerstack.purchase.dto;

import java.math.BigDecimal;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class MaterialInventoryDto {

    private Long materialId; // 자재 아이디
    private String materialType; // 자재 종류 (예: 상온, 냉동, etc.)
    private String materialName; // 자재명
    private BigDecimal supplyPrice; // 공급가
    private Long currentQuantity; // 현재 재고 수량
    private Long safetyQuantity; // 안전 재고 수량

    private String status; // 판매 상태 (예: 정상, 품절, 판매중지)

    // 화면에서 총 금액 보여주고 싶으면
    private BigDecimal buyPrice;

}