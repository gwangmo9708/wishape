package com.ja.shape.member.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.commons.text.StringEscapeUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.ja.shape.commons.MessageDigestUtil;
import com.ja.shape.member.mapper.MemberSQLMapper;
import com.ja.shape.vo.BigCategoryVo;
import com.ja.shape.vo.FriendsGroupVo;
import com.ja.shape.vo.FriendsVo;
import com.ja.shape.vo.MemberCategoryVo;
import com.ja.shape.vo.MemberVo;
import com.ja.shape.vo.MessageVo;
import com.ja.shape.vo.SmallCategoryVo;

@Service
public class MemberServiceImpl {
	
	@Autowired
	private MemberSQLMapper memberSQLMapper;
	
	
	// 로그인.
	public MemberVo login(MemberVo vo) {
		
		//암호화 - SHA-1
		String hashValue = MessageDigestUtil.getPasswordHashCode(vo.getPw());
		vo.setPw(hashValue);
		
		return memberSQLMapper.selectMemberByVo(vo);
		
	}
	
	// 회원가입.
	public void joinMember(MemberVo memberVo, MemberCategoryVo memberCategoryVo) {
		
		
		int member_no = memberSQLMapper.createMemberPK();
		
		//암호화 - SHA-1
		String hashValue = MessageDigestUtil.getPasswordHashCode(memberVo.getPw());
		memberVo.setPw(hashValue);
		

		// member 생성.
		memberVo.setNo(member_no);
		memberSQLMapper.insertMemberByVo(memberVo);

		// 기본 그룹 생성하기.
		memberSQLMapper.insertFriendsGroupByNo(member_no);
		
		// memeber_category 생성.
		memberCategoryVo.setMember_no(member_no);
		memberSQLMapper.insertMemberCategoryByVo(memberCategoryVo);
		
	}
	
	// 대분류 불러오기.
	public ArrayList<BigCategoryVo> getBigCategoryVoList() {
		return memberSQLMapper.selectBigCategory();
	}
	
	// 소분류 불러오기.
	public ArrayList<SmallCategoryVo> getSmallCategoryVoList() {
		return memberSQLMapper.selectSmallCategory();
	}
	
	
	
	
	// 친구, 메시지 관련...
	//friends_group 추가하기
	public void insertFriendsGroup(FriendsGroupVo vo) {
		memberSQLMapper.insertFriendsGroupByVo(vo);
	}
	//friends_group 이름 수정하기
	public void updateFriendsGroup(FriendsGroupVo vo) {
		memberSQLMapper.updateFriendsGroupByVo(vo);
	}
	//friends 이동하기
	public void updateFriendsMove(FriendsVo vo) {
		memberSQLMapper.updateFriendsMoveByVo(vo);
	}
	//friends 그룹 이동 byNo
	public void updateFriendsToDefault(int no,int friends_group_no) {
		
		memberSQLMapper.updateFriendsMoveByFriendsGroupVo(no,friends_group_no);
	}
	
	//friends 추가하기
	public void insertFriends(FriendsVo vo) {
		
		memberSQLMapper.insertFriendsByVo(vo);
	}
			
//	//follow 유무 조회(친구가아니면 0,팔로우면 1)
//	public int getFriends(FriendsVo vo) {
//		return memberSQLMapper.selectFriendsByNoMemberNo(vo);
//	}
	//멤버 리스트에서 친구 선택
	public ArrayList<HashMap<String, Object>> getFriendsByMember(int member_no,String searchWord){
		
		ArrayList<HashMap<String, Object>> memberNcategoryList = new ArrayList<HashMap<String,Object>>(); 
		
		ArrayList<MemberVo> memberList = memberSQLMapper.selectMember(member_no,searchWord);
				
		for(MemberVo memberVo : memberList) {
			HashMap<String, Object> hashMap = new HashMap<String, Object>();
			
			int memberNo = memberVo.getNo();
			
			SmallCategoryVo smallCategory= memberSQLMapper.selectSmallCategoryByMemberNo(memberNo);
			
			if(smallCategory != null) {
				int bigNo = smallCategory.getBig_category_no();
				BigCategoryVo bigCategory = memberSQLMapper.selectBigCategoryByNo(bigNo);
				hashMap.put("bigCategory",bigCategory);
			}			
			
			hashMap.put("memberVo", memberVo);
			hashMap.put("smallCategory", smallCategory);
			
		
			memberNcategoryList.add(hashMap);
		}
		return memberNcategoryList;
	}
		
	
	//친구 그룹	 셀렉트
	public ArrayList<FriendsGroupVo> getFriendsGroupByNo(int member_no){
		
		return memberSQLMapper.selectFriendsGroupByNo(member_no);
	}
	
	//친구 no로 셀렉트
	public HashMap<String, Object> getFriends(int no,int memberNo) {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		FriendsVo friendsVo = memberSQLMapper.selectFriendsByNo(no);
		int member_no = friendsVo.getMember_no();
		
		MemberVo memberVo = memberSQLMapper.getMemberByNo(member_no);
			
		ArrayList<FriendsGroupVo> friendsGroupVo = memberSQLMapper.selectFriendsGroupByNo(memberNo);
				
		map.put("friendsVo", friendsVo);
		map.put("memberVo", memberVo);
		map.put("friendsGroupVo", friendsGroupVo);
				
		return map;
	}
	
	
	//친구 리스트
	public ArrayList<HashMap<String, Object>> getFriendsByNo(int member_no){
		
		ArrayList<HashMap<String, Object>> getFriendsGroupList = new ArrayList<HashMap<String,Object>>();
				
		ArrayList<FriendsGroupVo> friendsGroupList = memberSQLMapper.selectFriendsGroupByNo(member_no);
				
		for(FriendsGroupVo friendsGroupVo:friendsGroupList) {
			
			int GroupNo = friendsGroupVo.getNo();
			
			ArrayList<FriendsVo> friendsList = memberSQLMapper.selectFriendsByFriendsGroupNo(GroupNo);
			
			HashMap<String, Object> GroupVoNArrayMap = new HashMap<String, Object>();
			GroupVoNArrayMap.put("friendsGroupVo", friendsGroupVo);
			
			ArrayList<HashMap<String, Object>> getFriendsAndMembers = new ArrayList<HashMap<String,Object>>();
						
			for(FriendsVo friendsVo:friendsList) {
				HashMap<String, Object> FriendsVoNMemberVoMap = new HashMap<String, Object>();
				FriendsVoNMemberVoMap.put("friendsVo", friendsVo);
				int F_memberNo = friendsVo.getMember_no();
				
				MemberVo memberVo = memberSQLMapper.getMemberByNo(F_memberNo);
				FriendsVoNMemberVoMap.put("memberVo", memberVo);
				
				getFriendsAndMembers.add(FriendsVoNMemberVoMap);
			}
			GroupVoNArrayMap.put("getFriendsAndMembers", getFriendsAndMembers);
			
			
			getFriendsGroupList.add(GroupVoNArrayMap);
		}
		
		
		return getFriendsGroupList;
	}
	//친구 삭제
	public void deleteFriendsList(int member_no) {
		memberSQLMapper.deleteFriendsByNo(member_no);
	}
	//친구 그룹 삭제
	public void deleteFriendsGroup(int no) {
		
		memberSQLMapper.deleteFriendsGroupByno(no);
	}
	//친구 이동할때 기본그룹으로 이동하려면 필요한 select 
	public int selectFriendsGroupByMemberNo(int member_no) {
		
		return memberSQLMapper.selectFriendsMoveByMemberNo(member_no);
	}
	
	
	
	
	//메세지
	//메시지 추가하기
	//message 추가하기
	public void insertMessage(MessageVo vo) {
		
		memberSQLMapper.insertMessageByVo(vo);
		}
	
	//멤버 전체 출력
	public ArrayList<MemberVo> getMembersAll(String searchWord,int pageNum) {
		
		return memberSQLMapper.selectMemberOrderByNo(searchWord,pageNum);
	}
	//멤버 페이징
	public int selectMemberTotalCount(String searchWord) {
		
		return memberSQLMapper.selectMemberTotalCount(searchWord);
	}
	
	//멤버 no 에서 메시지 보낼사람 찾기
	public HashMap<String, Object> getToMember(int no) {
		
		HashMap<String, Object> messageMap = new HashMap<String, Object>();
		
		MemberVo memberVo = memberSQLMapper.getMemberByNo(no);
		
		messageMap.put("memberVo", memberVo);
		
		return messageMap;
	}
	
	public ArrayList<HashMap<String, Object>> getMessageToNo(int to_member_no,boolean escape){
		
		ArrayList<HashMap<String, Object>> memberNmessage = new ArrayList<HashMap<String,Object>>();
		
		ArrayList<MessageVo> messageList = memberSQLMapper.getMessageByToNo(to_member_no);
		
		for(MessageVo messageVo : messageList) {
			int fromMemberNo = messageVo.getFrom_member_no();
			MemberVo memberVo = memberSQLMapper.getMemberByNo(fromMemberNo);
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("messageVo", messageVo);
			map.put("memberVo", memberVo);
			
			memberNmessage.add(map);
			
			if(escape) {
				String str = StringEscapeUtils.escapeHtml4(messageVo.getContent());
				str = str.replaceAll("\n", "<br>");
				messageVo.setContent(str);
			}
		}
				 
		 return memberNmessage;
	}
	public void updateReadCheck(int to_member_no) {
		
		memberSQLMapper.updateReadCheckMessage(to_member_no);
	}
	public void updateDeleteCheckMessage(int no) {
		
		memberSQLMapper.updateDeleteCheckMessage(no);
	}
	public MessageVo MessageOrderBycheck() {
		
		return memberSQLMapper.selectMessageOrderBycheck();
	}
	public boolean isExistCheck(int to_member_no) {
		int count = memberSQLMapper.getMessageReadCheckByToNo(to_member_no);
			
		if(count > 0) {
			return true;
		}else {
			return false;
		}
			
	}	
	
	
	
	
	
}


