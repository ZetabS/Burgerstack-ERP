package com.kh.burgerstack.store.model.vo;


public class SelectStoreList {
		
	private int storeId;
	private String storeCode;
	private String storeName;
	private String storePhone;
	private String storeAddress;
	private String storeStatus;
	private String createDate;
	public int getStoreId() {
		return storeId;
	}
	public void setStoreId(int storeId) {
		this.storeId = storeId;
	}
	public String getStoreCode() {
		return storeCode;
	}
	public void setStoreCode(String storeCode) {
		this.storeCode = storeCode;
	}
	public String getStoreName() {
		return storeName;
	}
	public void setStoreName(String storeName) {
		this.storeName = storeName;
	}
	public String getStorePhone() {
		return storePhone;
	}
	public void setStorePhone(String storePhone) {
		this.storePhone = storePhone;
	}
	public String getStoreAddress() {
		return storeAddress;
	}
	public void setStoreAddress(String storeAddress) {
		this.storeAddress = storeAddress;
	}
	public String getStoreStatus() {
		return storeStatus;
	}
	public void setStoreStatus(String storeStatus) {
		this.storeStatus = storeStatus;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	@Override
	public String toString() {
		return "SelectStoreList [storeId=" + storeId + ", storeCode=" + storeCode + ", storeName=" + storeName
				+ ", storePhone=" + storePhone + ", storeAddress=" + storeAddress + ", storeStatus=" + storeStatus
				+ ", createDate=" + createDate + "]";
	}
	    
	    
	
	
	
	
	}

