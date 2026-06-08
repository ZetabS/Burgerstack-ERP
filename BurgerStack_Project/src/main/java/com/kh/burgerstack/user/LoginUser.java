package com.kh.burgerstack.user;

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
public class LoginUser {

	private Long userNo;
	private String userId;
	private String password;
	private String userName;
	private String phone;
	private String email;
	private String role;
	
}
