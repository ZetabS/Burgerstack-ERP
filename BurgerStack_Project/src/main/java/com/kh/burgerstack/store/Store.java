package com.kh.burgerstack.store;

import lombok.Data;

@Data
public class Store {

	private int storeId;
	private String storeCode;
	private String storeName;
	private String storePhone;
	private String storeAddress;
	private int ownerUserId;
	private String storeStatus;
	private int createUser;
	private String createDate;
	private int updateUser;
	private String updateDate;
	
	}






