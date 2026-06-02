package com.kh.burgerstack.user.model.vo;

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
public class User {
	
			private Long userId;				//	USER_ID    NUMBER NOT NULL 
			private String loginId;				//	LOGIN_ID   VARCHAR2(50) NOT NULL 
			private String password;			//	PASSWORD   VARCHAR2(255) NOT NULL 
			private String userName;			//	USER_NAME  VARCHAR2(50) NOT NULL 
			private String phone;				//	PHONE      VARCHAR2(30) 
			private String email;				//	EMAIL      VARCHAR2(100) 
			private String role;				//	ROLE       VARCHAR2(20) DEFAULT 'OWNER' NOT NULL 
			private String status; 				//	STATUS     VARCHAR2(20) DEFAULT 'ACTIVE' NOT NULL 
			private Long createdBy;				//	CREATED_BY NUMBER 
			private LocalDateTime createdAt;	//	CREATED_AT DATE DEFAULT SYSDATE NOT NULL 
			private Long updatedBy;				//	UPDATED_BY NUMBER 
			private LocalDateTime updatedAt;	//	UPDATED_AT DATE 

			
}

	
