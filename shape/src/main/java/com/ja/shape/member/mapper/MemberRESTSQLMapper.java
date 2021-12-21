package com.ja.shape.member.mapper;

import java.util.ArrayList;

import com.ja.shape.vo.FriendsVo;
import com.ja.shape.vo.MemberVo;
import com.ja.shape.vo.SmallCategoryVo;

public interface MemberRESTSQLMapper {

	// 모든 small_category 불러오기.
	public ArrayList<SmallCategoryVo> selectAllSmallCategory();
	
	// big_category_no로 small_category 불러오기.
	public ArrayList<SmallCategoryVo> selectSmallCatrgoryByBigNo(int big_category_no);
	
	// no로 member 불러오기.
	public MemberVo selectMemberByNo(int member_no);
	
	
	
	// id pw로 로그인 확인하기.
	public MemberVo selectMemberByIdAndPw(MemberVo vo);
	// id 중복확인하기.
	public MemberVo selectMemberById(String id);
	
	
	
	
	// 친구추가하기. 
	// 내 기본그룹 확인하기.
	public int selectMyFriendsGroupNoByMemberNo(int member_no);
	// 친구 추가하기.
	public void insertFriendsByVo(FriendsVo vo);
	// 내 친구 확인하기.
	public int[] selectMyFriendsMemberNo(int member_no);
	
}
