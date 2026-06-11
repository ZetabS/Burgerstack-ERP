package com.kh.burgerstack.purchase.dto;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PurchaseApprovalRequestDto {

    private List<PurchaseApprovalItemDto> items;
}
