package com.kh.burgerstack.user;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface UserMapper {

	// 로그인
	// XML에서 #{userId}로 사용하므로 @Param("userId")를 붙여줍니다.
	public LoginUser login(@Param("userId") String userId);
	
	// 관리자 마이페이지 정보 수정
	public int update(User u);

	// 관리자 비밀번호 변경
	public int updatePassword(User u);

	// 점주 계정 등록
	public int NewOwner(User u);

	// 점주 상세 조회
	// XML에서 #{userId}로 사용하므로 @Param("userId")를 붙여줍니다.
	public User OwnerListDetail(@Param("userId") String userId);

	// 점주 상태 변경
	public int OwnerStatus(User u);

	// 점주 정보 수정
	public int OwnerUpdate(User user);

	// 점주 목록 조회
	// status, keyword를 Map으로 넘기기 때문에 XML에서 #{status}, #{keyword}로 사용 가능
	public List<User> OwnerList(Map<String, Object> param);

	public int getOwnerCount(Map<String, String> param);
}