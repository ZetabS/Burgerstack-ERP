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

	// 사용자 번호 PK
	private Long userNo;

	// 사용자 아이디
	private String userId;

	// 비밀번호
	private String password;

	// 사용자 이름
	private String userName;

	// 연락처
	private String phone;

	// 이메일
	private String email;

	// 권한
	// 예: ADMIN, OWNER
	private String role;

	// 계정 상태
	// 예: ACTIVE, INACTIVE
	private String status;

	// 등록일
	private LocalDateTime createdAt;

	// 화면 표시용 번호
	// 예: U20260001
	private String displayNo;
}