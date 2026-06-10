package com.kh.burgerstack.dashboard.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.ToString;

@AllArgsConstructor
@Getter
@ToString
public class StoreStatistics {
    private int openStoreCount;
    private int pausedStoreCount;
    private int closedStoreCount;
}