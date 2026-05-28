package com.kh.burgerstack.store.model.vo;

import lombok.Data;

@Data
public class Store {

    private int storeNo;
    private String storeName;
    private String ownerId;
    private String storePhone;
    private String storeAddress;
}