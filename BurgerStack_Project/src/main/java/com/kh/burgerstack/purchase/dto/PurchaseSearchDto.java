package com.kh.burgerstack.purchase.dto;

import java.time.LocalDate;

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
public class PurchaseSearchDto {
    
    private String status;
    private Long storeId;
    private String keyword;

    private LocalDate startDate;
    private LocalDate endDate;

    private boolean isAdmin;

}
