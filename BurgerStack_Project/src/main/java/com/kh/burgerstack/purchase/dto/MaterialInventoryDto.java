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

    private Long materialId;

    private String materialName;

    private BigDecimal costPrice;

    private Long currentQuantity;

    private String status;

    // 화면에서 총 금액 보여주고 싶으면
    private BigDecimal buyPrice;

}