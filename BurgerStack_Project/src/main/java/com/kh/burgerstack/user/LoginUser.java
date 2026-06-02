package com.kh.burgerstack.user;

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
public class LoginUser {

	private Long userId;
	private String loginId;
	private String password;
	private String role;
	
}
