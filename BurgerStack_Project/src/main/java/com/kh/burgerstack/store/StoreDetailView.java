package com.kh.burgerstack.store;

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
public class StoreDetailView {

    private Long storeId;
    private String storeCode;
    private String storeName;
    private String phone;
    private String address;
    private Long ownerUserId;
    private String status;
    private String ownerLoginId;
    private String ownerUserName;
    private String ownerPhone;
    private String ownerEmail;
}
