package com.ja.shape.member.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ja.shape.commons.MessageDigestUtil;
import com.ja.shape.member.mapper.MemberRESTSQLMapper;
import com.ja.shape.vo.FriendsVo;
import com.ja.shape.vo.MemberVo;
import com.ja.shape.vo.SmallCategoryVo;

@Service
public class MemberRESTServiceImpl {

	@Autowired
	MemberRESTSQLMapper memberRESTSQLMapper;
	
	public ArrayList<SmallCategoryVo> getAllSmallCategoryList(){
		
		return memberRESTSQLMapper.selectAllSmallCategory();
		
	}
	
	// big_category_no로 small_category 불러오기.
	public ArrayList<SmallCategoryVo> getSmallCategoryList(int big_category_no){
		
		return memberRESTSQLMapper.selectSmallCatrgoryByBigNo(big_category_no);
		
	}
	
	
	
	// 로그인 페이지 관련..
	// 로그인 회원 확인하기.
	public MemberVo checkMember(MemberVo vo) {
		
		//암호화 - SHA-1
		String hashValue = MessageDigestUtil.getPasswordHashCode(vo.getPw());
		vo.setPw(hashValue);
		
		return memberRESTSQLMapper.selectMemberByIdAndPw(vo);

	}
	
	
	
	// 회원가입 페이지 관련...
	// id 중복 확인하기.
	public MemberVo checkId(String id) {
		
		return memberRESTSQLMapper.selectMemberById(id);
		
	}
	
	
	
	
	// 친구 추가 관련..
	// 친구 추가하기.
	public void createFriends(int memberNo, FriendsVo friendsVo) {
		
		int friendsGroupNo = memberRESTSQLMapper.selectMyFriendsGroupNoByMemberNo(memberNo);
		
		friendsVo.setContent("기본친구");
		friendsVo.setFriends_group_no(friendsGroupNo);
		
		memberRESTSQLMapper.insertFriendsByVo(friendsVo);
		
	}
	// 친구 확인하기.
	public int[] selectMyFriendList(int memberNo) {
		
		return memberRESTSQLMapper.selectMyFriendsMemberNo(memberNo);
		
	}
	
	
	
}
