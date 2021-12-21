package com.ja.shape.wish.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.apache.commons.text.StringEscapeUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ja.shape.member.mapper.MemberRESTSQLMapper;
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
import com.ja.shape.wish.mapper.WishRESTSQLMapper;
import com.ja.shape.wish.mapper.WishSQLMapper;

@Service
public class WishRESTServiceImpl {

	@Autowired
	WishRESTSQLMapper wishRESTSQLMapper;
	@Autowired
	MemberRESTSQLMapper memberRESTSQLMapper;
	@Autowired
	WishSQLMapper wishSQLMapper;
	
	
	
	// wish_reliability 관련..(createReliability.do)
	public HashMap<String, Object> insertAndReliability(WishReliabilityVo vo) {
		
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		int member_no = vo.getMember_no();
		
		// reliability good_bad 확인하기.
		WishReliabilityVo prevMyReliabilityVo = getMyReliabilityVo(member_no);
		
		/*
		 * if(prevMyReliabilityVo != null) { System.out.println(vo.getGood_bad());
		 * System.out.println(prevMyReliabilityVo.getGood_bad()); }
		 */
		
		if(prevMyReliabilityVo == null) {
			//System.out.println("인서트 실행");
			wishRESTSQLMapper.insertReliabilityByVo(vo);
		} else if(vo.getGood_bad().equals(prevMyReliabilityVo.getGood_bad())) {
			System.out.println(prevMyReliabilityVo.getGood_bad());
			//System.out.println("딜리트 실행");
			wishRESTSQLMapper.deleteReliabilityByVo(member_no);
		} else {
			//System.out.println("업데이트 실행");
			wishRESTSQLMapper.updateReliabilityByVo(vo);
		}
		
		// reliability count구하기.
		vo.setGood_bad("y");
		double yCount = getReliability(vo);
		vo.setGood_bad("n");
		// System.out.println(yCount);
		double nCount = getReliability(vo);
		// System.out.println(nCount);
		double total = yCount + nCount;
		// System.out.println(total);
		String countReliability = "결과없음";
		
		if(total != 0) {
			double countReliabilty_ = (yCount/total)*100;
			// System.out.println(countReliabilty_);
			countReliability = Double.toString(countReliabilty_);
		}
		// System.out.println(countReliability);
		
		WishReliabilityVo myReliabilityVo = getMyReliabilityVo(member_no);
		
		map.put("countReliability", countReliability);
		map.put("myReliabilityVo", myReliabilityVo);
		
		return map;
		
	}
	// service 내부에서 사용하는 로직.
	private int getReliability(WishReliabilityVo vo) {
		return wishRESTSQLMapper.selectCountReliabilityByVo(vo);
	}
	// service 내부에서 사용하는 로직.
	private WishReliabilityVo getMyReliabilityVo(int member_no) {
		return wishRESTSQLMapper.selectMyReliabilityByMemberNo(member_no);
	}
	
	
	
	
	// wish_run_reply 관련... (createWishRunReply.do)
	// wish_run_reply 생성.
	public void createWishRunReply(WishRunReplyVo vo) {
		wishRESTSQLMapper.insertWishRunReplyByVo(vo);
	}
	// wish_run_no로 wish_run_reply 불러오기. (getWishRunReply.do)
	public ArrayList<HashMap<String, Object>> getWishRunReply(int wish_run_no, int login_member_no) {
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
		
		ArrayList<WishRunReplyVo> replyList = wishRESTSQLMapper.selectWishRunReplyByRunNo(wish_run_no);
		
		for(WishRunReplyVo wishRunReplyVo : replyList) {
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			
			int member_no = wishRunReplyVo.getMember_no();
			MemberVo memberVo = memberRESTSQLMapper.selectMemberByNo(member_no);
			
			int wish_run_reply_no = wishRunReplyVo.getNo();
			
			WishRunReplyWarningVo replyWarningVo = new WishRunReplyWarningVo();
			replyWarningVo.setMember_no(login_member_no);
			replyWarningVo.setWish_run_reply_no(wish_run_reply_no);
			WishRunReplyWarningVo wishRunReplyWarningVo = 
							wishRESTSQLMapper.selectRunReplyWarningByVo(replyWarningVo);
			
			map.put("wishRunReplyWarningVo",wishRunReplyWarningVo);
			map.put("memberVo", memberVo);
			map.put("wishRunReplyVo", wishRunReplyVo);
			
			list.add(map);
			
		}

		return list; 
		
	}
	// wish_run_reply 삭제하기. (deleteWishRunReply.do)
	public void deleteWishRunReply(int wish_run_reply_no) {
		wishRESTSQLMapper.deleteWishRunReplyByNo(wish_run_reply_no);
	}
	// wish_run_reply 업데이트하기. (updateWishRunReply.do)
	public void updateWishRunReply(WishRunReplyVo vo) {
		wishRESTSQLMapper.updateWishRunReplyByVo(vo);
	}
	
	
	
	// wish_run_reply_warning 관련.. (createWishRunReplyWarning.do)
	// wish_run_reply_warning 생성하기.
	public void createWishRunReplyWarning(WishRunReplyWarningVo vo) {
		wishRESTSQLMapper.insertWishRunReplyWarningByVo(vo);
	}
	
	
	
	
	
	// member_no로 todoRunDateList 가져오기. (getTodoRunDate.do)
	public ArrayList<HashMap<String, Object>> getTodoRunDateList(int member_no) {
		
		ArrayList<HashMap<String, Object>> wishRunTodoRunDateList = new ArrayList<>();
		
		ArrayList<WishRunVo> wishRunList = wishRESTSQLMapper.selectWishRunByMemberNo(member_no);
		
		for(WishRunVo wishRunVo : wishRunList) {
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			
			int wish_run_no = wishRunVo.getNo();
			
			ArrayList<Date> todoRunDateList = wishRESTSQLMapper.selectTodoRunByWishRunNo(wish_run_no);
			
			map.put("wishRunVo",wishRunVo);
			map.put("todoRunDateList",todoRunDateList);
			
			wishRunTodoRunDateList.add(map);
			
		}
		
		return wishRunTodoRunDateList;
		
	}
	
	
	
	// 일지 관련...
	// wish_run_comment 생성하기.(createComment.do) 
	public void createComment(WishRunCommentVo vo) {
		
		wishRESTSQLMapper.insertWishRunCommentByVo(vo);
		
	}
	// wish_run_comment 수정하기.(updateComment.do)
	public void updateComment(WishRunCommentVo vo) {
		
		wishRESTSQLMapper.updateWishRunCommentByVo(vo);
	}
	// wish_run 불러오기. (getWishRunList.do)
	public ArrayList<HashMap<String, Object>> getWishRunList(String todo_day, int member_no, boolean isEscape) {

		
		
		
		ArrayList<HashMap<String, Object>> wishAndWishRunList = new ArrayList<>();
		
		ArrayList<WishRunVo> wishRunList = wishRESTSQLMapper.selectWishRunByDay(todo_day, member_no);
		
		for(WishRunVo wishRunVo : wishRunList) {
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			
			
			int wish_no = wishRunVo.getWish_no();
			WishVo wishVo = wishRESTSQLMapper.selectWishByNo(wish_no);
			if(isEscape) {
				
				// HTML 태그를 사용할 수 없도록 만들어줌.
				String str1 = StringEscapeUtils.escapeHtml4(wishVo.getContent());
				str1 = str1.replaceAll("\n", "<br>");
				wishVo.setContent(str1);
				
				String str2 = StringEscapeUtils.escapeHtml4(wishVo.getTitle());
				str2 = str2.replaceAll("\n", "<br>");
				wishVo.setTitle(str2);
				
			}
			
			
			int wish_run_no = wishRunVo.getNo();
			WishRunCommentVo wishRunCommentVo = 
								wishRESTSQLMapper.selectWishRunCommentByWishRunNo(wish_run_no, todo_day);
			
			map.put("wishVo",wishVo);
			map.put("wishRunVo",wishRunVo);
			map.put("wishRunCommentVo",wishRunCommentVo);
			
			
			
			wishAndWishRunList.add(map);
			
			
		}
		
		return wishAndWishRunList;
		
	}
	// wish_run_image 생성하기. (createWishRunImage.do)
	public void createWishRunImage(WishRunImageVo vo) {
		
		wishRESTSQLMapper.insertWishRunImageByVo(vo);
		
	}
	// wish_run_image 불러오기. (getWishRunImageList.do)
	public ArrayList<WishRunImageVo> getWishRunImageList(String todo_day) {
		
		return wishRESTSQLMapper.selectWishRunImageByTodoDay(todo_day);
		
	}
	
	
	
	// index 페이지 랭킹 관련...
	// 많은 사람들이 실행하고 있는 wish. (getRunningWishRank.do)
	public ArrayList<HashMap<String, Object>> getRunningWishRank(boolean isEscape){
		
		ArrayList<HashMap<String, Object>> runningWishRankList = new ArrayList<HashMap<String,Object>>();
		
		ArrayList<WishVo> runningWishList = wishRESTSQLMapper.selectRunningWishRank();
		
		for(WishVo wishVo : runningWishList) {
			
			// HTML Escape
			if(isEscape) {
				
				// HTML 태그를 사용할 수 없도록 만들어줌.
				String str1 = StringEscapeUtils.escapeHtml4(wishVo.getContent());
				str1 = str1.replaceAll("\n", "<br>");
				wishVo.setContent(str1);
				
				String str2 = StringEscapeUtils.escapeHtml4(wishVo.getTitle());
				str2 = str2.replaceAll("\n", "<br>");
				wishVo.setTitle(str2);
				
			}
			
			HashMap<String, Object> map = new HashMap<>();
			
			int wish_no = wishVo.getNo();
			int member_no = wishVo.getMember_no();
			
			ArrayList<TodoVo> todoList =  wishRESTSQLMapper.selectTodoByWishNo(wish_no);
			MemberVo memberVo = wishRESTSQLMapper.selectMemberByNo(member_no);
			
			map.put("wishVo", wishVo);
			map.put("todoList", todoList);
			map.put("memberVo", memberVo);
			
			runningWishRankList.add(map);
			
		}
		
		return runningWishRankList;
		
	} 
	// 좋아요 많은 wish 불러오기. (getLikeWishRank.do)
	public ArrayList<HashMap<String, Object>> getLikeWishRank(boolean isEscape) {
		
		ArrayList<HashMap<String, Object>> likeWishRankList = new ArrayList<HashMap<String,Object>>();
		
		ArrayList<WishVo> likeWishList = wishRESTSQLMapper.selectLikeWishRank();
		
		for(WishVo wishVo : likeWishList) {
			
			// HTML Escape
			if(isEscape) {
				
				// HTML 태그를 사용할 수 없도록 만들어줌.
				String str1 = StringEscapeUtils.escapeHtml4(wishVo.getContent());
				str1 = str1.replaceAll("\n", "<br>");
				wishVo.setContent(str1);
				
				String str2 = StringEscapeUtils.escapeHtml4(wishVo.getTitle());
				str2 = str2.replaceAll("\n", "<br>");
				wishVo.setTitle(str2);
				
			}
			
			HashMap<String, Object> map = new HashMap<>();
			
			int wish_no = wishVo.getNo();
			int member_no = wishVo.getMember_no();
			
			ArrayList<TodoVo> todoList =  wishRESTSQLMapper.selectTodoByWishNo(wish_no);
			MemberVo memberVo = wishRESTSQLMapper.selectMemberByNo(member_no);
			
			map.put("wishVo", wishVo);
			map.put("todoList", todoList);
			map.put("memberVo", memberVo);
			
			likeWishRankList.add(map);
			
		}
		
		return likeWishRankList;
	}
	// 조회수 많은 wish 불러오기. (getReadCountWishRank.do)
	public ArrayList<HashMap<String, Object>> getReadCountWishRank(boolean isEscape) {
		
		ArrayList<HashMap<String, Object>> readCountWishRankList = new ArrayList<HashMap<String,Object>>();
		
		ArrayList<WishVo> readCountWishList = wishRESTSQLMapper.selectReadCountWishRank();
		
		for(WishVo wishVo : readCountWishList) {
			
			// HTML Escape
			if(isEscape) {
				
				// HTML 태그를 사용할 수 없도록 만들어줌.
				String str1 = StringEscapeUtils.escapeHtml4(wishVo.getContent());
				str1 = str1.replaceAll("\n", "<br>");
				wishVo.setContent(str1);
				
				String str2 = StringEscapeUtils.escapeHtml4(wishVo.getTitle());
				str2 = str2.replaceAll("\n", "<br>");
				wishVo.setTitle(str2);
				
			}
			
			HashMap<String, Object> map = new HashMap<>();
			
			int wish_no = wishVo.getNo();
			int member_no = wishVo.getMember_no();
			
			ArrayList<TodoVo> todoList =  wishRESTSQLMapper.selectTodoByWishNo(wish_no);
			MemberVo memberVo = wishRESTSQLMapper.selectMemberByNo(member_no);
			
			map.put("wishVo", wishVo);
			map.put("todoList", todoList);
			map.put("memberVo", memberVo);
			
			readCountWishRankList.add(map);
			
		}
		
		return readCountWishRankList;
	}
	// 포기가 많은 wish 불러오기. (getQuitWishRank.do)
	public ArrayList<HashMap<String, Object>> getQuitWishRank(boolean isEscape) {
		
		ArrayList<HashMap<String, Object>> quitWishRankList = new ArrayList<HashMap<String,Object>>();
		
		ArrayList<WishVo> readCountWishList = wishRESTSQLMapper.selectQuitWishRank();
		
		for(WishVo wishVo : readCountWishList) {
			
			//HTML Escape
			if(isEscape) {
				
				// HTML 태그를 사용할 수 없도록 만들어줌.
				String str1 = StringEscapeUtils.escapeHtml4(wishVo.getContent());
				str1 = str1.replaceAll("\n", "<br>");
				wishVo.setContent(str1);
				
				String str2 = StringEscapeUtils.escapeHtml4(wishVo.getTitle());
				str2 = str2.replaceAll("\n", "<br>");
				wishVo.setTitle(str2);
				
			}
			
			HashMap<String, Object> map = new HashMap<>();
			
			int wish_no = wishVo.getNo();
			int member_no = wishVo.getMember_no();
			
			ArrayList<TodoVo> todoList =  wishRESTSQLMapper.selectTodoByWishNo(wish_no);
			MemberVo memberVo = wishRESTSQLMapper.selectMemberByNo(member_no);
			
			map.put("wishVo", wishVo);
			map.put("todoList", todoList);
			map.put("memberVo", memberVo);
			
			quitWishRankList.add(map);
			
		}
		
		return quitWishRankList;
	}
	// 가장 많은 사람들이 실행하는 위시 랭킹 top3. (getCategoryRunningWishRank.do)
	public ArrayList<HashMap<String, Object>> getCategoryRunningWishRank(int small_category_no, boolean isEscape){
		
		ArrayList<HashMap<String, Object>> runningWishList = new ArrayList<>();
		
		ArrayList<WishVo> wishList = wishRESTSQLMapper.selectRunningWishRankBySmallCategoryNo(small_category_no);
		
		for(WishVo wishVo : wishList) {
			
			// HTML Escape
			if(isEscape) {
				
				// HTML 태그를 사용할 수 없도록 만들어줌.
				String str1 = StringEscapeUtils.escapeHtml4(wishVo.getContent());
				str1 = str1.replaceAll("\n", "<br>");
				wishVo.setContent(str1);
				
				String str2 = StringEscapeUtils.escapeHtml4(wishVo.getTitle());
				str2 = str2.replaceAll("\n", "<br>");
				wishVo.setTitle(str2);
				
			}
			
			
			HashMap<String, Object> map = new HashMap<>();
			
			int wish_no = wishVo.getNo();
			int member_no = wishVo.getMember_no();
			
			ArrayList<TodoVo> todoList =  wishRESTSQLMapper.selectTodoByWishNo(wish_no);
			MemberVo memberVo = wishRESTSQLMapper.selectMemberByNo(member_no);
			
			map.put("wishVo", wishVo);
			map.put("todoList", todoList);
			map.put("memberVo", memberVo);
			
			runningWishList.add(map);
			
		}
		
		return runningWishList;
		
	}
	// 가장 좋아요 수가 많은 랭킹 탑 3. (getCategoryLikeWishRank.do)
	public ArrayList<HashMap<String, Object>> getCategoryLikeWishRank(int small_category_no, boolean isEscape){
		
		ArrayList<HashMap<String, Object>> likeWishList = new ArrayList<>();
		
		ArrayList<WishVo> wishList = wishRESTSQLMapper.selectLikeWishRankBySmallCategoryNo(small_category_no);
		
		for(WishVo wishVo : wishList) {
			
			// HTML Escape
			if(isEscape) {
				
				// HTML 태그를 사용할 수 없도록 만들어줌.
				String str1 = StringEscapeUtils.escapeHtml4(wishVo.getContent());
				str1 = str1.replaceAll("\n", "<br>");
				wishVo.setContent(str1);
				
				String str2 = StringEscapeUtils.escapeHtml4(wishVo.getTitle());
				str2 = str2.replaceAll("\n", "<br>");
				wishVo.setTitle(str2);
				
			}
			
			HashMap<String, Object> map = new HashMap<>();
			
			int wish_no = wishVo.getNo();
			int member_no = wishVo.getMember_no();
			
			ArrayList<TodoVo> todoList =  wishRESTSQLMapper.selectTodoByWishNo(wish_no);
			MemberVo memberVo = wishRESTSQLMapper.selectMemberByNo(member_no);
			
			map.put("wishVo", wishVo);
			map.put("todoList", todoList);
			map.put("memberVo", memberVo);
			
			likeWishList.add(map);
			
		}
		
		return likeWishList;
		
	}
	// 가장 조회수 많은 랭킹 탑 3. (getCategoryReadCountWishRank.do)
	public ArrayList<HashMap<String, Object>> getCategoryReadCountWishRank(int small_category_no, boolean isEscape){
		
		ArrayList<HashMap<String, Object>> readCountWishList = new ArrayList<>();
		
		ArrayList<WishVo> wishList = wishRESTSQLMapper.selectReadCountWishRankBySmallCategoryNo(small_category_no);
		
		for(WishVo wishVo : wishList) {
			
			// HTML Escape
			if(isEscape) {
				
				// HTML 태그를 사용할 수 없도록 만들어줌.
				String str1 = StringEscapeUtils.escapeHtml4(wishVo.getContent());
				str1 = str1.replaceAll("\n", "<br>");
				wishVo.setContent(str1);
				
				String str2 = StringEscapeUtils.escapeHtml4(wishVo.getTitle());
				str2 = str2.replaceAll("\n", "<br>");
				wishVo.setTitle(str2);
				
			}
			
			HashMap<String, Object> map = new HashMap<>();
			
			int wish_no = wishVo.getNo();
			int member_no = wishVo.getMember_no();
			
			ArrayList<TodoVo> todoList =  wishRESTSQLMapper.selectTodoByWishNo(wish_no);
			MemberVo memberVo = wishRESTSQLMapper.selectMemberByNo(member_no);
			
			map.put("wishVo", wishVo);
			map.put("todoList", todoList);
			map.put("memberVo", memberVo);
			
			readCountWishList.add(map);
			
		}
		
		return readCountWishList;
		
	}
	// 가장 포기한 위시가 많은 랭킹 탑 3. (getCategoryQuitWishRank.do)
	public ArrayList<HashMap<String, Object>> getCategoryQuitWishRank(int small_category_no, boolean isEscape){
		
		ArrayList<HashMap<String, Object>> readQuitWishList = new ArrayList<>();
		
		ArrayList<WishVo> wishList = wishRESTSQLMapper.selectQuitWishRankBySmallCategoryNo(small_category_no);		
		for(WishVo wishVo : wishList) {
			
			// HTML Escape
			if(isEscape) {
				
				// HTML 태그를 사용할 수 없도록 만들어줌.
				String str1 = StringEscapeUtils.escapeHtml4(wishVo.getContent());
				str1 = str1.replaceAll("\n", "<br>");
				wishVo.setContent(str1);
				
				String str2 = StringEscapeUtils.escapeHtml4(wishVo.getTitle());
				str2 = str2.replaceAll("\n", "<br>");
				wishVo.setTitle(str2);
				
			}
			
			
			HashMap<String, Object> map = new HashMap<>();
			
			int wish_no = wishVo.getNo();
			int member_no = wishVo.getMember_no();
			
			ArrayList<TodoVo> todoList =  wishRESTSQLMapper.selectTodoByWishNo(wish_no);
			MemberVo memberVo = wishRESTSQLMapper.selectMemberByNo(member_no);
			
			map.put("wishVo", wishVo);
			map.put("todoList", todoList);
			map.put("memberVo", memberVo);
			
			readQuitWishList.add(map);
			
		}
		
		return readQuitWishList;
		
	}

	
	
	
	// readWishRun 페이지 위시 런 후기 관련....
	// wish_run_epilogue 생성하기. (createEpilogue.do)
	public void createWishRunEpilogue(WishRunEpilogueVo vo, WishRunEpiloguePlaceVo vo2) {
		
		int WishRunEpilogueNo = wishRESTSQLMapper.selectWishRunEpiloguePK();
		
		vo.setNo(WishRunEpilogueNo);
		wishRESTSQLMapper.insertWishRunEpilogueByVo(vo);
		
		vo2.setWish_run_epilogue_no(WishRunEpilogueNo);
		wishRESTSQLMapper.insertWishRunEpiloguePlaceByVo(vo2);
		
		
	}
	// wish_run_epilogue 불러오기. (getEpilogue.do)
	public HashMap<String, Object> getWishRunEpilogue(int wishRunNo) {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		WishRunEpilogueVo wishRunEpilogueVo = wishRESTSQLMapper.selectWishRunEpilogueByNo(wishRunNo);
		
		
		if(wishRunEpilogueVo != null) {

			int wishRunEpilogueNo = wishRunEpilogueVo.getNo();
			WishRunEpiloguePlaceVo wishRunEpiloguePlaceVo = wishRESTSQLMapper.selectWishRunEpiloguePlaceByEpilogueNo(wishRunEpilogueNo);
			map.put("wishRunEpiloguePlaceVo", wishRunEpiloguePlaceVo);
			
		}
		
		map.put("wishRunEpilogueVo", wishRunEpilogueVo);
		
		
		return map;
		
	}
	// wish_run_epilogue 수정하기. (updateEpilogue.do)
	public void updateWishRunEpilogue(WishRunEpilogueVo vo, WishRunEpiloguePlaceVo vo2) {
		
		wishRESTSQLMapper.updateWishRunEpilogueByVo(vo);
		wishRESTSQLMapper.updateWishRunEpiloguePlaceByVo(vo2);
		
		
	}
	
	
	
	// 그래프 관련..
	// wish에 따른 남녀 성비 구하기. (getCountWishGender.do)
	public ArrayList<HashMap<String, Object>> getCountWishGender(int wish_no){
		
		return wishRESTSQLMapper.selectWishJoinByNo(wish_no);
		
	}
	// wish_no로 todoRun 실행 그래프 구하기.
	public ArrayList<HashMap<String, Object>> getTodoRunGraph(int wish_no) {
		
		return wishRESTSQLMapper.selectTodoRunGraphByWishNo(wish_no);
		
	}
	// wish_no로 날짜별 wish_like 그래프 구하기.
	public ArrayList<HashMap<String, Object>> getWishLikeGraph(int wish_no) {
		
		return wishRESTSQLMapper.selectWishLikeGraphByWishNo(wish_no);
		
	}
	// wish_no로 날짜별 quit wish 그래프 구하기.
	public ArrayList<HashMap<String, Object>> getQuitWishGraph(int wish_no) {
		
		return wishRESTSQLMapper.selectQuitWishGraphByWishNo(wish_no);
		
	}
	
	
	
	
	// wish_like 관련...
	// wish_like가 존재하면 생성하고, 없으면 제거하기.
	public void wishLikeProcess(WishLikeVo vo) {
		
		int countMyLike = getMyWishLike(vo);
		
		if(countMyLike < 1) {
			// 생성하기.
			wishRESTSQLMapper.insertWishLikeByVo(vo);
		} else {
			
			// 제거하기.
			wishRESTSQLMapper.deleteWishLikeByVo(vo);
		}
	
	}
	// 내  wish_like 확인.
	public int getMyWishLike(WishLikeVo vo) {
		
		return wishRESTSQLMapper.selectMyWishLikeByVo(vo);
		
	}
	// wish_like 전체 개수 불러오기.
	public int getWishLikeCount(int wish_no) {
		
		return wishRESTSQLMapper.selectWishLikeCountByWishNo(wish_no);
		
	}
	
	
	
	
	
	// wish_reply 관련..
	// wish_reply 생성하기.
	public void createWishReply(WishReplyVo vo) {
		
		wishRESTSQLMapper.insertWishReplyByVo(vo);
		
	}
	// wish_reply 불러오기.
	public ArrayList<HashMap<String, Object>> getWishReply(int wish_no, int login_member_no) {
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
		
		ArrayList<WishReplyVo> replyList = wishRESTSQLMapper.selectWishReplyByWishNo(wish_no);
		
		for(WishReplyVo wishReplyVo : replyList) {
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			
			int member_no = wishReplyVo.getMember_no();
			MemberVo memberVo = memberRESTSQLMapper.selectMemberByNo(member_no);
			
			int wish_reply_no = wishReplyVo.getNo();
			
			WishReplyWarnigVo replyWarningVo = new WishReplyWarnigVo();
			replyWarningVo.setMember_no(login_member_no);
			replyWarningVo.setWish_reply_no(wish_reply_no);
			WishReplyWarnigVo wishReplyWarningVo = 
								wishRESTSQLMapper.selectWishReplyWarningByVo(replyWarningVo);
			
			map.put("wishReplyWarningVo",wishReplyWarningVo);
			map.put("memberVo", memberVo);
			map.put("wishReplyVo", wishReplyVo);
			
			list.add(map);
			
		}

		return list; 

	}
	// wish_reply 삭제하기.
	public void deleteWishReply(int wish_reply_no) {
		
		wishRESTSQLMapper.deleteWishReplyByNo(wish_reply_no);
		
	}
	// wish_reply 수정하기.
	public void updateWishReply(WishReplyVo vo) {
		
		wishRESTSQLMapper.updateWishReplyByVo(vo);
		
	}
	
	
	
	// wish_reply_warning 관련...
	// wish_reply_warning 생성하기.
	public void createWishReplyWarning(WishReplyWarnigVo param) {
		
		wishRESTSQLMapper.insertWishReplyWarningByVo(param);
		
	}
	
	
	
	
	
	//Other Wish 페이지 관련
	
	public ArrayList<BigCategoryVo> getBigCategoryForOtherWish(){
		
		return wishRESTSQLMapper.getBigcategoryForOtherWish();
		
	}
	
	
	public ArrayList<SmallCategoryVo> getAllSmallCategoryListForOtherWish(){
		
		return wishRESTSQLMapper.getAllSmallCategoryForOtherWish();
		
	}
	
	// big_category_no로 small_category 불러오기.
	public ArrayList<SmallCategoryVo> getSmallCategoryListForOtherWish(int big_category_no){
		
		return wishRESTSQLMapper.getSmallCatrgoryByBigNoForOtherWish(big_category_no);
		
	}
	
	
	//검색 옵션 - 아이디  + 소분류 정렬
	public ArrayList<HashMap<String, Object>> getOtherWishSelectOptionIDAndSmallCategory(int member_no, String searchString, int small_category_no){
		
		
		ArrayList<HashMap<String, Object>> OtherWishList = 
				new ArrayList<HashMap<String,Object>>();
		
		ArrayList<WishVo> WishOfOtherPeople = wishRESTSQLMapper.getOtherWishSelectOptionIDAndSmallCategory(member_no, searchString, small_category_no);

		for(WishVo wishVo : WishOfOtherPeople) {
			
			int wish_no = wishVo.getNo();
					
			HashMap<String, Object> map = new HashMap<String, Object>();
			//이 위시의 번호로 좋아요 수 가져오기
			int wish_like_count = wishSQLMapper.getLikeCount(wish_no);			
			
			map.put("wish_like_count", wish_like_count);//위시의 좋아요 수
			
			String small_name = wishSQLMapper.getSmallCategoryNameByWishNo(wish_no);
			
			map.put("small_name", small_name);//위시의 소분류 이름
			
			int writer_no = wishVo.getMember_no();
			String writer_ID = wishSQLMapper.whoMadeThisWish(writer_no);
			
			map.put("writer_ID", writer_ID);//위시 작성자 아이디
			
			map.put("wishVo", wishVo);//위시 내용
			
			wishSQLMapper.selectSmallCategoryByMemberNo(writer_no);
			
			
			OtherWishList.add(map);			
		}	
		
		
		return OtherWishList;
	}
	
	
	
	
	
	
	//검색 옵션 - 주제  + 소분류 정렬
	public ArrayList<HashMap<String, Object>> getOtherWishSelectOptionTitleAndSmallCategory(int member_no, String searchString,  int small_category_no){
		
		
		ArrayList<HashMap<String, Object>> OtherWishList = 
				new ArrayList<HashMap<String,Object>>();
		
		ArrayList<WishVo> WishOfOtherPeople = wishRESTSQLMapper.getOtherWishSelectOptionTitleAndSmallCategory(member_no, searchString, small_category_no);

		for(WishVo wishVo : WishOfOtherPeople) {
			
			int wish_no = wishVo.getNo();
					
			HashMap<String, Object> map = new HashMap<String, Object>();
			//이 위시의 번호로 좋아요 수 가져오기
			int wish_like_count = wishSQLMapper.getLikeCount(wish_no);			
			
			map.put("wish_like_count", wish_like_count);//위시의 좋아요 수
			
			String small_name = wishSQLMapper.getSmallCategoryNameByWishNo(wish_no);
			
			map.put("small_name", small_name);//위시의 소분류 이름
			
			int writer_no = wishVo.getMember_no();
			String writer_ID = wishSQLMapper.whoMadeThisWish(writer_no);
			
			map.put("writer_ID", writer_ID);//위시 작성자 아이디
			
			map.put("wishVo", wishVo);//위시 내용
			
			wishSQLMapper.selectSmallCategoryByMemberNo(writer_no);
			
			
			OtherWishList.add(map);			
		}	
		
		
		return OtherWishList;
	}		
	
	
	
	
	
	
}



