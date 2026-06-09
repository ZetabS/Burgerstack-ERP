package com.kh.burgerstack.store.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@Getter
@Setter
@ToString
public class StoreOption {
    private Integer storeId;
    private String storeName;
}
