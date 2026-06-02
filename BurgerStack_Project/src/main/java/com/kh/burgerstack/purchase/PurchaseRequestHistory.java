package com.kh.burgerstack.purchase;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class PurchaseRequestHistory {

    private Long purchaseRequestHistoryId;
    private Long purchaseRequestId;
    private String fromStatus;
    private String toStatus;
    private String reason;
    private Long createdBy;
    private LocalDateTime createdAt;
}
