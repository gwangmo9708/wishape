package com.ja.shape.wish.mapper;

import java.util.ArrayList;
import java.util.Date;

import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.PatchMapping;

import com.ja.shape.vo.BigCategoryVo;
import com.ja.shape.vo.SmallCategoryVo;
import com.ja.shape.vo.TodoRunVo;
import com.ja.shape.vo.TodoVo;
import com.ja.shape.vo.WishLikeVo;
import com.ja.shape.vo.WishReliabilityVo;
import com.ja.shape.vo.WishReplyVo;
import com.ja.shape.vo.WishReplyWarnigVo;
import com.ja.shape.vo.WishRunReplyVo;
import com.ja.shape.vo.WishRunVo;
import com.ja.shape.vo.WishVo;

public interface WishSQLMapper {

	public void makeAWish(WishVo param);//새 Wish를 wish 테이블에 인서트...
	
	public ArrayList<WishVo> getWishList(int member_no);
	
	public ArrayList<TodoVo> getToDoList(int wish_no);
	
	public WishVo getWishByWishNo(int wish_no);
	
	public void insertToDo(TodoVo todoVo);//todo 만들기	
	
	public void updatePlanCheck(int wishNo);	
	
	public void deleteWish(int no);
	
	public void updateWish(WishVo wishvo);
	
	public void updateToDo(TodoVo todoVo);
	
	public void addReadCount(int wish_no);
	
	public void insertReply(int wish_no, int member_no, String content);
	
	public ArrayList<WishReplyVo> getReplyByWishNo(int wish_no);
	
	public String getMemberIDByMemberNo(int member_no);
	
	public void replyReport(WishReplyWarnigVo wishReplyWarnigVo);
	
	public int getWishNoByWishReplyNo(int wish_reply_no);
	
	public void likeWish(WishLikeVo wishLikeVo);
	
	
	
	//카카오 오븐 18pg
	//otherWishPage 관련
	public ArrayList<WishVo> getWishOfOtherPeople(int member_no);
	
	public int getLikeCount(int wish_no);
	
	public String whoMadeThisWish(int writer_no);
	
	public String getSmallCategoryNameByWishNo(int wish_no);
	
	// big_category
	public ArrayList<BigCategoryVo> getBigCategory();
	
	// small_category
	public ArrayList<SmallCategoryVo> getSmallCategory();
	
	//<!-- 검색 옵션 - 아이디 -->
	public ArrayList<WishVo> getOtherWishSelectOptionID(@Param("member_no") int member_no, @Param("searchString") String searchString);
	
	//<!-- 검색 옵션 - 주제 -->
	public ArrayList<WishVo> getOtherWishSelectOptionTitle(@Param("member_no") int member_no, @Param("searchString") String searchString);
	
	
	
	
	
	
	
	
	
	// 카테고리 관련..
	// member_no로 small_category 불러오기.
	public SmallCategoryVo selectSmallCategoryByMemberNo(int member_no); 
	// small_category_no로 big_category 불러오기.
	public BigCategoryVo selectBigCategoryBySmallNo(int small_category_no);
	
	
	
	
	// wish 관련..
	// wish_run PK 생성하기.
	public int selectWishRunPK();
	// wish_no로 wish 검색하기.
	public WishVo selectWishByNo(int wish_no);
	
	
	
	// todo 관련...
	// wish_no로 todo 검색하기.
	public ArrayList<TodoVo> selectTodoByWishNo(int wish_no);
	// todo_no로 todo 불러오기.
	public TodoVo selectTodoByNo(int todo_no);
	
	
	
	// wish_run 관련...
	// wish_run 생성하기.
	public void insertWishRunByVo(WishRunVo vo);
	// wish_run_no로 wish_run 불러오기.
	public WishRunVo selectWishRunByNo(int wish_run_no);
	// member_no로 wish_run 불러오기.
	public ArrayList<WishRunVo> selectWishRunByMemberNo(int member_no);
	// member_no로 실행중인 wish_run 불러오기.
	public ArrayList<WishRunVo> selectRunningWishRunByMemberNo(int member_no);
	// wish_run quit_date 설정하기.
	public void updateWishRunQuitDateByNo(int wish_run_no);
	// member_no로 포기한 wish_run 불러오기.
	public ArrayList<WishRunVo> selectWishRunByEndDateAndMemberNo(int member_no);
	// member_no로 일정이 끝난 wish_run 불러오기.
	public ArrayList<WishRunVo> selectEndWishRunByMemberNo(int member_no);
	
	
	
	// todo_run 관련...
	// todo_run 생성하기.
	public void insertTodoRunByVo(TodoRunVo vo);
	// wish_run_no로 todo_run의 todo_day를 불러오기.
	public ArrayList<TodoRunVo> selectTodoRunDayByNo(int wish_run_no);
	// wish_run_no로 todo_run_date 얻기.
	public ArrayList<Date> selectTodoRunDateByWishRunNo(int wish_run_no);
	// todo_no와 check 여부로 todo_run 불러오기.
	public int selectTodoRunCountByVo(TodoRunVo vo);
	// todo_run 체크하기.
	public void updateTodoRunByNo(int no);
	
	
	
	// wish_reliability 관련..
	// wish_reliability 생성하기.
	public void insertReliabilityByVo(WishReliabilityVo vo);
	// wish_reliability 불러오기.
	public WishReliabilityVo selectMyReliabilityByMemberNo(int member_no);
	// good_bad로 Reliability 수정하기.
	public void updateReliabilityByVo(WishReliabilityVo vo);
	// wish_run_no로 Reliability 얻기.
	public int selectCountReliabilityByVo(WishReliabilityVo vo);
	// Reliability 삭제하기.
	public void deleteReliabilityByVo(int member_no);

	

	// wish_run_reply 관련...
	// wish_run_reply 불러오기.
	public ArrayList<WishRunReplyVo> selectWishRunReplyByWishRunNo(int wish_run_no);

	
	
	// 이상하게 작성한 것들..
	// todo_day로 wish_run_no 불러오기. (sql에서 결과값은 wish_run_no만 들어가있음)
	public ArrayList<TodoRunVo> selectTodoRunWishRunNoByDay(TodoRunVo vo);
	// todo_day로 todo_run 불러오기.
	public ArrayList<TodoRunVo> selectTodoRunByDay(@Param("todo_day")Date todo_day, @Param("member_no")int member_no);
	public ArrayList<TodoRunVo> selectTodoRunByVo(TodoRunVo vo);	
	
	
	
	
	// wish 상세페이지 관련...
	// wish_no로 위시런 실행 갯수 얻기.
	public int selectWishRunCountByWishNo(int wish_no);
	// wish_no로 위시런 포기 갯수 얻기.
	public int selectQuitWishRunByWishNo(int wish_no);
	// wish_no로 조회수 늘리기.
	public void updateWishReadCountByNo(int wish_no);
	
}
