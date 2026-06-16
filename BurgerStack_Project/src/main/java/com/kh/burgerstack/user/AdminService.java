package com.kh.burgerstack.user;

import java.util.List;

import org.springframework.stereotype.Service;

import com.kh.burgerstack.common.pagination.PagingRequest;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AdminService {

	private final AdminDao adminDao;
	
	// 관리자 마이페이지 정보 수정
	public int update(User u) {
		return adminDao.update(u);
	}

	// 관리자 비밀번호 변경
	public int updatePassword(User u) {
		return adminDao.updatePassword(u);
	}

	// 점주 계정 등록
	public int NewOwner(User u) {
		return adminDao.NewOwner(u);
	}

	// 점주 목록 조회
	public List<User> OwnerList(String status,
            String keyword, PagingRequest pi) {

		/*
		 * Controller에서 받은 검색 조건을 DAO로 그대로 넘깁니다.
		 *
		 * status 값:
		 * ""          전체
		 * "ACTIVE"    영업중
		 * "INACTIVE"  폐점
		 *
		 * keyword 값:
		 * 아이디 또는 점주명 검색어
		 */
	    return adminDao.OwnerList(status, keyword, pi);
	}

	// 점주 상세 조회
	public User OwnerListDetail(String userId) {
		return adminDao.OwnerListDetail(userId);
	}

	// 점주 상태 변경
	public int OwnerStatus(User u) {
		return adminDao.OwnerStatus(u);
	}

	// 점주 정보 수정
	public int OwnerUpdate(User user) {
		return adminDao.OwnerUpdate(user);
	}

	public int getOwnerCount(String status, String keyword) {
		return adminDao.getOwnerCount(status, keyword);
	}
}
