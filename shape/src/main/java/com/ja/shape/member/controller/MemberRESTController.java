package com.ja.shape.member.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ja.shape.member.service.MemberRESTServiceImpl;
import com.ja.shape.member.service.MemberServiceImpl;
import com.ja.shape.vo.FriendsVo;
import com.ja.shape.vo.MemberVo;
import com.ja.shape.vo.SmallCategoryVo;

@Controller
@RequestMapping("/member/")
@ResponseBody
public class MemberRESTController {

	@Autowired
	MemberRESTServiceImpl memberRESTService;
	@Autowired
	private MemberServiceImpl memberService;
	
	
	@RequestMapping("allSmallCategory.do")
	public HashMap<String, Object> allSmallCategory(){
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		ArrayList<SmallCategoryVo> allSmallCategoryList = memberRESTService.getAllSmallCategoryList();
		
		data.put("allSmallCategoryList", allSmallCategoryList);
		
		return data;
		
	}
	
	@RequestMapping("sortSmallCategory.do")
	public HashMap<String, Object> sortSmallCategory(int big_category_no){
		
		HashMap<String, Object> data = new HashMap<>();
		
		ArrayList<SmallCategoryVo> smallCategoryList = memberRESTService.getSmallCategoryList(big_category_no);
		data.put("smallCategoryList", smallCategoryList);
		
		return data;
	
	}
	
	
	
	// 로그인 페이지 관련..
	// id, pw로 memberVo 확인하기.
	@RequestMapping("checkMember.do")
	public HashMap<String, Object> checkMember(MemberVo param){
		
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		MemberVo memberVo = memberRESTService.checkMember(param);
		data.put("memberVo", memberVo);
		
		return data;
		
	}
	
	
	
	
	// 회원가입 관련 페이지..
	// id로 memberVo 확인하기.
	@RequestMapping("checkId.do")
	public HashMap<String, Object> checkId(String id) {
		
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		MemberVo memberVo = memberRESTService.checkId(id);
		data.put("memberVo", memberVo);
		
		return data;
		
	}
	
	
	
	
	// 친구 추가하기.
	@RequestMapping("createFriend.do")
	public void createFriend(FriendsVo friendsVo, HttpSession session) {
		
		MemberVo memberVo = (MemberVo)session.getAttribute("user");
		int myMemberNo = memberVo.getNo();
		
		memberRESTService.createFriends(myMemberNo, friendsVo);
		
	}
	// 친구 확인하기.
	@RequestMapping("getMyFriendsList.do")
	public HashMap<String, Object> getMyFriendsList(HttpSession session) {
		
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		MemberVo memberVo = (MemberVo) session.getAttribute("user");
		int memberNo = memberVo.getNo();
		
		int[] myFriendsList = memberRESTService.selectMyFriendList(memberNo);
		data.put("myFriendsList", myFriendsList);
	
		return data;
		
	}
	
	
	
	
	@RequestMapping("alarm.do")
	public HashMap<String, Object> AlarmMessage(int to_member_no) {
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		boolean isExist =memberService.isExistCheck(to_member_no);
		
		data.put("isExist", isExist);
		
		return data;
	}
	
	
	
}
