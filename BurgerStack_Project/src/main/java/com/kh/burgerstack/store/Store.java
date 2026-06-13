package com.kh.burgerstack.store;

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
public class Store {
    private Long storeId;
    private String storeCode;
    private String storeName;
    private String phone;
    private String address;
    private String status;
    private LocalDateTime createdAt;
    private Long ownerUserNo;
    private String ownerName;
}
