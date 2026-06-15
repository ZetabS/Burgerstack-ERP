package com.kh.burgerstack.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class AdminDao {

	private final UserMapper userMapper;
	
	// 관리자 마이페이지 정보 수정
	public int update(User u) {
		return userMapper.update(u);
	}

	// 관리자 비밀번호 변경
	public int updatePassword(User u) {
		return userMapper.updatePassword(u);
	}

	// 점주 계정 등록
	public int NewOwner(User u) {
		return userMapper.NewOwner(u);
	}

	// 점주 목록 조회
	public List<User> OwnerList(String status,
	                            String keyword) {

		/*
		 * MyBatis Mapper로 넘길 검색 조건 Map입니다.
		 *
		 * status:
		 * ""          전체
		 * "ACTIVE"    영업중
		 * "INACTIVE"  폐점
		 *
		 * keyword:
		 * 아이디 또는 점주명 검색어
		 */
		Map<String, String> param = new HashMap<>();

		/*
		 * null이 들어오면 MyBatis if문에서 처리하기 불편할 수 있으므로
		 * 빈 문자열로 바꿔서 넘깁니다.
		 */
		param.put("status", status == null ? "" : status);
		param.put("keyword", keyword == null ? "" : keyword);

		return userMapper.OwnerList(param);
	}

	// 점주 상세 조회
	public User OwnerListDetail(String userId) {
		return userMapper.OwnerListDetail(userId);
	}

	// 점주 상태 변경
	public int OwnerStatus(User u) {
		return userMapper.OwnerStatus(u);
	}

	// 점주 정보 수정
	public int OwnerUpdate(User user) {
		return userMapper.OwnerUpdate(user);
	}

}