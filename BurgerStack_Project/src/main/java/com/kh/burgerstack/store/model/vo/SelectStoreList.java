package com.kh.burgerstack.store.model.vo;


public class SelectStoreList {
		
		private int storeCode;
	    private String storeName;
	    private String storeAddress;
	    private String storePhone;
	    private String storeStatus;
	    private String openDate;
		public int getStoreCode() {
			return storeCode;
		}
		public void setStoreCode(int storeCode) {
			this.storeCode = storeCode;
		}
		public String getStoreName() {
			return storeName;
		}
		public void setStoreName(String storeName) {
			this.storeName = storeName;
		}
		public String getStoreAddress() {
			return storeAddress;
		}
		public void setStoreAddress(String storeAddress) {
			this.storeAddress = storeAddress;
		}
		public String getStorePhone() {
			return storePhone;
		}
		public void setStorePhone(String storePhone) {
			this.storePhone = storePhone;
		}
		public String getStoreStatus() {
			return storeStatus;
		}
		public void setStoreStatus(String storeStatus) {
			this.storeStatus = storeStatus;
		}
		public String getOpenDate() {
			return openDate;
		}
		public void setOpenDate(String openDate) {
			this.openDate = openDate;
		}
		@Override
		public String toString() {
			return "SelectStoreList [storeCode=" + storeCode + ", storeName=" + storeName + ", storeAddress="
					+ storeAddress + ", storePhone=" + storePhone + ", storeStatus=" + storeStatus + ", openDate="
					+ openDate + "]";
		}
	    
		public int getStorecode() {
		    return storeCode;
		}
	    
	    
	    
	}

