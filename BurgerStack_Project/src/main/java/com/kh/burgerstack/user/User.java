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
public class User {
	private Long userNo;
	private String userId;
	private String password;
	private String userName;
	private String phone;
	private String email;
	private String role;
	private String status;
	private LocalDateTime createdAt;
}
