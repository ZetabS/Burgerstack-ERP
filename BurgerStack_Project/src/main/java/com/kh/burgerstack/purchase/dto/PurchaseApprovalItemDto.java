package com.kh.burgerstack.purchase.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class PurchaseApprovalItemDto {

    private int materialId;
    private int requestQuantity;
    private int approvedQuantity;
    private String status;
    private String rejectReason;
    
}
