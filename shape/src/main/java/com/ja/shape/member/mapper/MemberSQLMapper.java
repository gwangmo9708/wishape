package com.ja.shape.member.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.ja.shape.vo.BigCategoryVo;
import com.ja.shape.vo.FriendsGroupVo;
import com.ja.shape.vo.FriendsVo;
import com.ja.shape.vo.MemberCategoryVo;
import com.ja.shape.vo.MemberVo;
import com.ja.shape.vo.MessageVo;
import com.ja.shape.vo.SmallCategoryVo;

public interface MemberSQLMapper {
	
	// Member 추가하기.
	public void insertMemberByVo(MemberVo vo);
	
	// 로그인하기.
	public MemberVo selectMemberByVo(MemberVo vo);	
	
	// big_category 불러오기.
	public ArrayList<BigCategoryVo> selectBigCategory();
	
	// small_category 불러오기.
	public ArrayList<SmallCategoryVo> selectSmallCategory();
	
	//멤버 번호로 호출(질답 게시판 메인 보드 만들기 위함)
	public MemberVo getMemberByNo(int no);	
	
	// member no seq 생성하기
	public int createMemberPK();	
	
	// member_category 추가하기.
	public void insertMemberCategoryByVo(MemberCategoryVo vo);	
	
	
	
	
	//friends_group 회원가입때 추가하기
	public void insertFriendsGroupByNo(int member_no);
	
	//friends_group 생성후 추가할때
	public void insertFriendsGroupByVo(FriendsGroupVo vo);
	
	//friends_group 수정할때
	public void updateFriendsGroupByVo(FriendsGroupVo vo);
	
	//friends 친구 그룹 이동 할때
	public void updateFriendsMoveByVo(FriendsVo vo);
	
	//friends 삭제후 기본으로 이동할때
	public void updateFriendsMoveByFriendsGroupVo(@Param("no") int no,
												  @Param("friends_group_no") int friends_group_no);
	
	//friends 테이블 추가하기
	public void insertFriendsByVo(FriendsVo vo);
			
//	//follow 유무 조회(친구면 1,친구가아니면 0)
//	public int selectFriendsByNoMemberNo(FriendsVo vo);
	
	//멤버에서 친구추가할 리스트 뽑기
	public ArrayList<MemberVo> selectMember(@Param("member_no") int member_no,
											@Param("searchWord") String searchWord);
	
	//친구그룹 조회
	public ArrayList<FriendsGroupVo> selectFriendsGroupByNo(int member_no);
	
	//친구 그룹이동 update 뒤에 no 받는것
	public int selectFriendsMoveByMemberNo(int member_no);
	
	//그룹내의 친구 조회
	public ArrayList<FriendsVo> selectFriendsByFriendsGroupNo(int member_no);
	
	//친구 no로 조회하기
	public FriendsVo selectFriendsByNo(int no);
	
	//친구 삭제
	public void deleteFriendsByNo(int member_no); 
	
	//친구 그룹 삭제
	public void deleteFriendsGroupByno(int no);
	
	//멤버 카테고리 셀렉트
	public SmallCategoryVo selectSmallCategoryByMemberNo(int member_no);
	
	public BigCategoryVo selectBigCategoryByNo(int no);
	
	
	
	//message 추가하기
	public void insertMessageByVo(MessageVo vo);
	
	//message 보낼 대상(멤버)들 리스트 
	public ArrayList<MemberVo> selectMemberOrderByNo(@Param("searchWord") String searchWord,
													 @Param("pageNum") int PageNum);
	
	public int selectMemberTotalCount(@Param ("searchWord") String searchWord); 
		
	
	//Message ToNo로 데이터 출력
	public ArrayList<MessageVo> getMessageByToNo(int to_member_no);
	
	//Message FromNo로 데이터 출력
	public ArrayList<MessageVo> getMessageByFromNo(int from_member_no);
	
	public void updateReadCheckMessage(int to_member_no);
	
	public void updateDeleteCheckMessage(int no);
	
	public MessageVo selectMessageOrderBycheck();
	
	public int getMessageReadCheckByToNo(int to_member_no);
	
	public ArrayList<MemberVo> getIdByMemberVo(String id);
	
	
	
	
	
}
