package com.kh.burgerstack.closing;

import java.time.LocalDate;
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
public class StoreClosing {

    private Long storeClosingId;
    private Long storeId;
    private LocalDate businessDate;
    private String closingMemo;
    private Long closedBy;
    private LocalDateTime closedAt;
}
