package com.ja.shape.wish.mapper;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import org.apache.ibatis.annotations.Param;

import com.ja.shape.vo.BigCategoryVo;
import com.ja.shape.vo.MemberVo;
import com.ja.shape.vo.SmallCategoryVo;
import com.ja.shape.vo.TodoVo;
import com.ja.shape.vo.WishLikeVo;
import com.ja.shape.vo.WishReliabilityVo;
import com.ja.shape.vo.WishReplyVo;
import com.ja.shape.vo.WishReplyWarnigVo;
import com.ja.shape.vo.WishRunCommentVo;
import com.ja.shape.vo.WishRunEpiloguePlaceVo;
import com.ja.shape.vo.WishRunEpilogueVo;
import com.ja.shape.vo.WishRunImageVo;
import com.ja.shape.vo.WishRunReplyVo;
import com.ja.shape.vo.WishRunReplyWarningVo;
import com.ja.shape.vo.WishRunVo;
import com.ja.shape.vo.WishVo;

public interface WishRESTSQLMapper {


	// Reliability 관련..
	// wish_reliability 생성하기
	public void insertReliabilityByVo(WishReliabilityVo vo);
	// Reliability 삭제하기.
	public void deleteReliabilityByVo(int member_no);
	// good_bad로 Reliability 수정하기.
	public void updateReliabilityByVo(WishReliabilityVo vo);
	// wish_run_no로 Reliability 얻기.
	public int selectCountReliabilityByVo(WishReliabilityVo vo);
	// wish_reliability 불러오기.
	public WishReliabilityVo selectMyReliabilityByMemberNo(int member_no);

	
	
	
	// wish_run_reply 관련..
	// wish_run_reply 생성하기.
	public void insertWishRunReplyByVo(WishRunReplyVo vo);
	// wish_run_reply 불러오기.
	public ArrayList<WishRunReplyVo> selectWishRunReplyByRunNo(int wish_run_no);
	// wish_run_reply 삭제하기.
	public void deleteWishRunReplyByNo(int no);
	// wish_run_reply 수정하기.
	public void updateWishRunReplyByVo(WishRunReplyVo vo);
	
	
	
	
	// wish_run_reply_warning 관련..
	// wish_run_reply_warning 생성하기.
	public void insertWishRunReplyWarningByVo(WishRunReplyWarningVo vo);
	// wish_run_reply_warning 불러오기.
	public WishRunReplyWarningVo selectRunReplyWarningByVo(WishRunReplyWarningVo vo);
	
	
	
	
	// todoRunDate 불러오기 관련...
	// 로그인 사용자의 wishRun 불러오기.
	public ArrayList<WishRunVo> selectWishRunByMemberNo(int member_no);
	// wish_run_no로 todoRun 불러오기.
	public ArrayList<Date> selectTodoRunByWishRunNo(int wish_run_no);
	
	
	
	
	
	// 일지관련....
	// wish_run_comment 생성하기.
	public void insertWishRunCommentByVo(WishRunCommentVo vo);
	// 날짜를 통해 wish_run 불러오기.
	public ArrayList<WishRunVo> selectWishRunByDay(@Param("todo_day")String todo_day, @Param("member_no")int member_no);
	// wish_no로 wish 불러오기.
	public WishVo selectWishByNo(int wish_no);
	// wish_run_no로 wish_run_comment 불러오기.
	public WishRunCommentVo selectWishRunCommentByWishRunNo(@Param("wish_run_no") int wish_run_no, 
															@Param("todo_day")String todo_day);
	// wish_run_comment 수정하기.
	public void updateWishRunCommentByVo(WishRunCommentVo vo);
	// wish_run_image 생성하기.
	public void insertWishRunImageByVo(WishRunImageVo vo);
	// wish_run_image 불러오기.
	public ArrayList<WishRunImageVo> selectWishRunImageByTodoDay(String todo_day);
	
	
	
	
	// index 페이지 랭킹 관련..
	// 많은 사람들이 실행하고 있는 wish 3개 불러오기.
	public ArrayList<WishVo> selectRunningWishRank();
	// 좋아요 랭킹 wish 3개 불러오기.
	public ArrayList<WishVo> selectLikeWishRank();
	// 조회수 랭킹 wish 3개 불러오기.
	public ArrayList<WishVo> selectReadCountWishRank();
	// 포기 랭킹 wish 3개 불러오기.
	public ArrayList<WishVo> selectQuitWishRank();
	// wish의 todo 불러오기.
	public ArrayList<TodoVo> selectTodoByWishNo(int wish_no);
	// wish의 member 불러오기.
	public MemberVo selectMemberByNo(int member_no);
	// 카테고리별 실행하는 사람 수 랭킹 wish 3개 불러오기.
	public ArrayList<WishVo> selectRunningWishRankBySmallCategoryNo(int small_category_no);
	// 카테고리별 좋아요 랭킹 wish 3개 불러오기.
	public ArrayList<WishVo> selectLikeWishRankBySmallCategoryNo(int small_category_no);
	// 카테고리별 조회수 랭킹 wish 3개 불러오기.
	public ArrayList<WishVo> selectReadCountWishRankBySmallCategoryNo(int small_category_no);
	// 카테고리별 포기 랭킹 wish 3개 불러오기.
	public ArrayList<WishVo> selectQuitWishRankBySmallCategoryNo(int small_category_no);	
	
	
	
	
	// readWishRun 페이지 위시 런 후기 관련....
	// wish_run_epilogue pk 생성하기.
	public int selectWishRunEpiloguePK();
	// wish_run_epilogue 생성하기.
	public void insertWishRunEpilogueByVo(WishRunEpilogueVo vo);
	// wish_run_epilogue_place 생성하기.
	public void insertWishRunEpiloguePlaceByVo(WishRunEpiloguePlaceVo vo);
	// wish_run_epilogue 불러오기.
	public WishRunEpilogueVo selectWishRunEpilogueByNo(int wish_run_no);
	// wish_run_epilogue_place 불러오기.
	public WishRunEpiloguePlaceVo selectWishRunEpiloguePlaceByEpilogueNo(int wish_run_epilogue_no);
	// wish_run_epilogue 수정하기.
	public void updateWishRunEpilogueByVo(WishRunEpilogueVo vo);
	// wish_run_epilogue_place 수정하기
	public void updateWishRunEpiloguePlaceByVo(WishRunEpiloguePlaceVo vo);
	
	
	
	// 그래프관련...
	// 남녀 성비 카운트
	public ArrayList<HashMap<String, Object>> selectWishJoinByNo(int wish_no);
	// todoRun 실행 날짜별 그래프.
	public ArrayList<HashMap<String, Object>> selectTodoRunGraphByWishNo(int wish_no);
	// wish_like 날짜별 그래프.
	public ArrayList<HashMap<String, Object>> selectWishLikeGraphByWishNo(int wish_no);
	// quit Wish 날짜별 그래프.
	public ArrayList<HashMap<String, Object>> selectQuitWishGraphByWishNo(int wish_no);
	
	
	
	
	// 좋아요 관련...
	// wish_like 생성하기.
	public void insertWishLikeByVo(WishLikeVo vo);
	// wish_like 제거하기.
	public void deleteWishLikeByVo(WishLikeVo vo);
	// wish_like 내거 확인하기.
	public int selectMyWishLikeByVo(WishLikeVo vo);
	// wish_like 전체 개수 확인하기.
	public int selectWishLikeCountByWishNo(int wish_no);
	
	
	
	
	// 댓글 관련...
	// wish_reply 생성하기.
	public void insertWishReplyByVo(WishReplyVo vo);
	// wish_reply 불러오기.
	public ArrayList<WishReplyVo> selectWishReplyByWishNo(int wish_no);
	// wish_reply 삭제하기.
	public void deleteWishReplyByNo(int no);
	// wish_reply 수정하기.
	public void updateWishReplyByVo(WishReplyVo vo);
	
	
	
	
	
	// wish_reply_warning 관련..
	// wish_reply_warning 생성하기.
	public void insertWishReplyWarningByVo(WishReplyWarnigVo vo);
	// wish_reply_warning 불러오기.
	public WishReplyWarnigVo selectWishReplyWarningByVo(WishReplyWarnigVo vo);
	
	
	
	
	
	// Other Wish 페이지  
	// 대분류 가져오기
	public ArrayList<BigCategoryVo> getBigcategoryForOtherWish();
	
	// 모든 small_category 불러오기.
	public ArrayList<SmallCategoryVo> getAllSmallCategoryForOtherWish();
	
	// big_category_no로 small_category 불러오기.
	public ArrayList<SmallCategoryVo> getSmallCatrgoryByBigNoForOtherWish(int big_category_no);	
	
	//검색 옵션 - 아이디  + 소분류 정렬
	public ArrayList<WishVo> getOtherWishSelectOptionIDAndSmallCategory(
			@Param("member_no") int member_no, @Param("searchString") String searchString, @Param("small_category_no") int small_category_no); 
	//검색 옵션 - 주제  + 소분류 정렬
	public ArrayList<WishVo> getOtherWishSelectOptionTitleAndSmallCategory(
			@Param("member_no") int member_no, @Param("searchString") String searchString, @Param("small_category_no") int small_category_no);
	
	
	
}








