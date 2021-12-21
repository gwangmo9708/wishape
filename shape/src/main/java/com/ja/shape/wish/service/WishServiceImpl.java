package com.ja.shape.wish.service;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.text.StringEscapeUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ja.shape.member.mapper.MemberSQLMapper;
import com.ja.shape.vo.BigCategoryVo;
import com.ja.shape.vo.MemberVo;
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
import com.ja.shape.wish.mapper.WishSQLMapper;

@Service
public class WishServiceImpl {
	
	@Autowired
	private MemberSQLMapper memberSQLMapper;
	@Autowired
	private WishSQLMapper wishSQLMapper;
	
	// index.do 관련... (index.do)
	// 대분류 불러오기.
	public ArrayList<BigCategoryVo> getBigCategoryVoList() {
		
		return memberSQLMapper.selectBigCategory();
	}
		
	// 소분류 불러오기.
	public ArrayList<SmallCategoryVo> getSmallCategoryVoList() {
		return memberSQLMapper.selectSmallCategory();
	}
	
	// index 페이지 member_category 불러오기.
	public HashMap<String, Object> getMyAllCategory(int memberNo) {
		
		HashMap<String, Object> allCategory = new HashMap<String, Object>();
		
		SmallCategoryVo smallCategoryVo = wishSQLMapper.selectSmallCategoryByMemberNo(memberNo);
		
		int smallCategoryNo = smallCategoryVo.getNo();
		BigCategoryVo bigCategoryVo = wishSQLMapper.selectBigCategoryBySmallNo(smallCategoryNo);
		
		allCategory.put("smallCategoryVo", smallCategoryVo);
		allCategory.put("bigCategoryVo", bigCategoryVo);
		
		return allCategory;
		
	}	
	
	
	
	
	//새로운 위시를 생성(insert)
	public void makeAWish(WishVo param) {
		
		wishSQLMapper.makeAWish(param);//wish 테이블에 insert
		
	}
	
	//회원의 회원번호로 조회한 위시를 조회 해 오기
	public ArrayList<HashMap<String, Object>> getWishAndToDoByMemberNo(int member_no, boolean isEscape) {
		
		ArrayList<HashMap<String, Object>> wishAndToDoPlanList =
				new ArrayList<HashMap<String,Object>>();
		
	    ArrayList<WishVo> wishList = wishSQLMapper.getWishList(member_no);
	  
	    for(WishVo wishVo : wishList) {
	    	
	    	int wish_no = wishVo.getNo();//여기서 위시의 번호를 얻어서 그 번호로  반복문을 돌려야 올바른 순서
	    	
	    	ArrayList<TodoVo> todoList = wishSQLMapper.getToDoList(wish_no);
	    	
	    	
			if(isEscape) {
				
				// HTML 태그를 사용할 수 없도록 만들어줌.
				String str1 = StringEscapeUtils.escapeHtml4(wishVo.getContent());
				str1 = str1.replaceAll("\n", "<br>");
				wishVo.setContent(str1);
				
				String str2 = StringEscapeUtils.escapeHtml4(wishVo.getTitle());
				str2 = str2.replaceAll("\n", "<br>");
				wishVo.setTitle(str2);
				
			}
			
	    	HashMap<String, Object> map = new HashMap<String, Object>();
	    	map.put("wishVo", wishVo);
	    	map.put("todoList", todoList);
	    	
	    	wishAndToDoPlanList.add(map);
	    	
	    	
	    }
	    
	    return wishAndToDoPlanList;
	}
	
	
	public WishVo getWishByWishNo(int wish_no) {
		
		WishVo wish = wishSQLMapper.getWishByWishNo(wish_no);
		
		return wish;
	}
	
	//위시에 새 todo를 인서트 하기(insert)
	public void insertToDo(TodoVo todoVo) {
		
		wishSQLMapper.insertToDo(todoVo);
		
	}
	
	
	//wish 확정 (Y로 바꾸기)
	public void updatePlanCheck(int wishNo) {
		
		wishSQLMapper.updatePlanCheck(wishNo);
	}
	
	
	//위시 삭제 
	public void deleteWish(int no) {
		
		wishSQLMapper.deleteWish(no);
	}
	
	//위시 수정
	public void updateWish(WishVo wishvo) {
		
		wishSQLMapper.updateWish(wishvo);
		
	}
	
	//투두 수정 
	public void updateToDo(TodoVo todoVo) {
		
		wishSQLMapper.updateToDo(todoVo);
	}
	
	
	
	
	//위시 플랜 조회수 증가 
	public void addReadCount(int wish_no) {
		wishSQLMapper.addReadCount(wish_no);
	}
	
	
	
	//19페이지
	//위시의 no로 위시의 내용과 그 위시의 투두들을 묶어서 보내야 한다
	public HashMap<String, Object> getWishAndToDoByWishNo(int wish_no, boolean isEscape){
		
		HashMap<String, Object> wishAndToDoByWishNo = new HashMap<String,Object>();
		
		WishVo wishData = wishSQLMapper.getWishByWishNo(wish_no);
		ArrayList<TodoVo> toDoData =  wishSQLMapper.getToDoList(wish_no);
		
		
		if(isEscape) {
			
			// HTML 태그를 사용할 수 없도록 만들어줌.
			String str1 = StringEscapeUtils.escapeHtml4(wishData.getContent());
			str1 = str1.replaceAll("\n", "<br>");
			wishData.setContent(str1);
			
			String str2 = StringEscapeUtils.escapeHtml4(wishData.getTitle());
			str2 = str2.replaceAll("\n", "<br>");
			wishData.setTitle(str2);
			
		}
		
		
		
		int member_no = wishData.getMember_no();
		MemberVo memberVo = memberSQLMapper.getMemberByNo(member_no);
		
		
		wishAndToDoByWishNo.put("memberVo", memberVo);
		wishAndToDoByWishNo.put("wishData", wishData);
		wishAndToDoByWishNo.put("toDoData", toDoData);
		
		return wishAndToDoByWishNo;
		
	}
	
	
	//댓글 추가하기
	public void insertReply(int wish_no, int member_no, String content) {
		
		wishSQLMapper.insertReply(wish_no, member_no, content);
		
	}
	
	// + 댓글 기능때문에 아이디가 필요하므로 멤버가 필요함.
	public ArrayList<HashMap<String, Object>> getReplyByWishNo(int wish_no, boolean isEscape) {
		
		ArrayList<HashMap<String, Object>> replyListPlusID = new ArrayList<HashMap<String,Object>>();
		 
		
		ArrayList<WishReplyVo> replyList = wishSQLMapper.getReplyByWishNo(wish_no);
		
		//댓글 정보에서 댓 작성자의 no를 찾아다가 아이디를 알아와서 넘겨줘야 한다
		for(WishReplyVo wishReplyVo : replyList) {
			
			int member_no = wishReplyVo.getMember_no();	
			String ID = wishSQLMapper.getMemberIDByMemberNo(member_no);
			
			
			if(isEscape) {
				
				// HTML 태그를 사용할 수 없도록 만들어줌.
				String str1 = StringEscapeUtils.escapeHtml4(wishReplyVo.getContent());
				str1 = str1.replaceAll("\n", "<br>");
				wishReplyVo.setContent(str1);
				
			}
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("ID", ID);
			map.put("replyList", replyList);
			
			replyListPlusID.add(map);
		}
		
		
		return replyListPlusID;
	}
	
	//댓글 신고 인서트
	public void insertReplyReport(WishReplyWarnigVo wishReplyWarnigVo) {
		
		wishSQLMapper.replyReport(wishReplyWarnigVo);
	}
	
	//댓글 신고 부분
	public int getWishNoByWishReplyNo(int wish_reply_no) {
		
		return wishSQLMapper.getWishNoByWishReplyNo(wish_reply_no);
	
	}
	
	//위시에 좋아요 날리기
	public void likeWish(WishLikeVo wishLikeVo) {
		
		wishSQLMapper.likeWish(wishLikeVo);
		
	}
	
	
	
	
	
	
	//otherWish 페이지 부분
	//오븐 18 페이지
	//다른 사람들의 위시를 검색하고 public/onlyfriends 옵션인 위시만 가져와야 한다.
	public ArrayList<HashMap<String, Object>> getWishOfOtherPeople(int member_no){
		
		ArrayList<HashMap<String, Object>> OtherWishList = 
				new ArrayList<HashMap<String,Object>>();
		
		ArrayList<WishVo> WishOfOtherPeople = wishSQLMapper.getWishOfOtherPeople(member_no);

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
	// 대분류 불러오기.
	public ArrayList<BigCategoryVo> getBigCategoryList() {
		return wishSQLMapper.getBigCategory();
	}
	// 소분류 불러오기.
	public ArrayList<SmallCategoryVo> getSmallCategoryList() {
		return wishSQLMapper.getSmallCategory();
	}
	
	
	
	
	//검색 옵션 - 아이디
	public ArrayList<HashMap<String, Object>> getOtherWishSelectOptionID(int member_no, String searchString){
		
		
		ArrayList<HashMap<String, Object>> OtherWishList = 
				new ArrayList<HashMap<String,Object>>();
		
		ArrayList<WishVo> WishOfOtherPeople = wishSQLMapper.getOtherWishSelectOptionID(member_no, searchString);

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
	
	
	//검색 옵션 - 주제
	public ArrayList<HashMap<String, Object>> getOtherWishSelectOptionTitle(int member_no, String searchString){
		
		
		ArrayList<HashMap<String, Object>> OtherWishList = 
				new ArrayList<HashMap<String,Object>>();
		
		ArrayList<WishVo> WishOfOtherPeople = wishSQLMapper.getOtherWishSelectOptionTitle(member_no, searchString);

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
	
	
	
	
	
	
	// wish_run todo_run 생성 전 입력을 받기 위해  wish, todo 불러오는 페이지. (notYetWish.do)
	// wish_no로 wish, todo 불러오기.
	public HashMap<String, Object> getWishTodoList(int wish_no, boolean isEscape) {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		ArrayList<TodoVo> todoVoList = wishSQLMapper.selectTodoByWishNo(wish_no);
		WishVo wishVo = wishSQLMapper.selectWishByNo(wish_no);
		
		if(isEscape) {
			
			// HTML 태그를 사용할 수 없도록 만들어줌.
			String str1 = StringEscapeUtils.escapeHtml4(wishVo.getContent());
			str1 = str1.replaceAll("\n", "<br>");
			wishVo.setContent(str1);
			
			String str2 = StringEscapeUtils.escapeHtml4(wishVo.getTitle());
			str2 = str2.replaceAll("\n", "<br>");
			wishVo.setTitle(str2);
			
		}
		
		map.put("todoVoList", todoVoList);
		map.put("wishVo", wishVo);
		
		return map;
	} 	
	
	
	// wish_run todo_run 생성관련... (wishTodoRunProcess.do)
	// wish_run_seq 불러오기.
	public int getWishRunPK() {
		return wishSQLMapper.selectWishRunPK();
	}
	// wish_run 생성 준비 및  wish_run 생성 메소드 호출.
	public void createWishRun(WishRunVo wishRunVo) {
		
		// wish_run_no 생성하기.
		int wish_run_no = wishRunVo.getNo();
						
		// wish_run 생성 메소드 호출.
		wishRunVo.setNo(wish_run_no);
		createProcessWishRun(wishRunVo);
		
	}
	
	
	// todo_run 생성 준비 및 todo_run 생성 메소드 호출.
	public void createTodoRun(WishRunVo wishRunVo, int todo_no, int week) {
		
		// wish_run_no 생성하기.
		int wish_run_no = wishRunVo.getNo();
		
		// todo_run 생성 메소드 호출.
		TodoRunVo todoRunVo = new TodoRunVo();
		todoRunVo.setTodo_no(todo_no);
		todoRunVo.setWish_run_no(wish_run_no);
		createProcessTodoRun(week, todoRunVo, wishRunVo);
		
	}	
	
	// wish_run 생성 메소드. (service 내부에서 사용)
	private void createProcessWishRun(WishRunVo vo) {
		
		wishSQLMapper.insertWishRunByVo(vo);
		
	}	
	
	// todo_run 날짜 설정 및 생성 메소드. (service 내부에서 사용)
	private void createProcessTodoRun(int week, TodoRunVo todoRunVo, WishRunVo wishRunVo) {
		
		// endDate, startDate 설정.
		Date endDate_ = wishRunVo.getEnd_date();
		Date startDate_ = wishRunVo.getStart_date();
		Calendar endDate = Calendar.getInstance();
		Calendar startDate = Calendar.getInstance();
		endDate.setTime(endDate_);
		startDate.setTime(startDate_);
		
		// 요일을 위한 Calendar 설정.
		Calendar cal = Calendar.getInstance();
		cal.setTime(startDate_);
		
		switch (week) {
		case 1:
			cal.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);
			break;
		case 2:
			cal.set(Calendar.DAY_OF_WEEK, Calendar.TUESDAY);
			break;
		case 3:
			cal.set(Calendar.DAY_OF_WEEK, Calendar.WEDNESDAY);
			break;
		case 4:
			cal.set(Calendar.DAY_OF_WEEK, Calendar.THURSDAY);
			break;
		case 5:
			cal.set(Calendar.DAY_OF_WEEK, Calendar.FRIDAY);
			break;
		case 6:
			cal.set(Calendar.DAY_OF_WEEK, Calendar.SATURDAY);
			break;
		case 7:
			cal.set(Calendar.DAY_OF_WEEK, Calendar.SUNDAY);
			break;
		}
		
		while(true) {
			
			long nowTime = cal.getTimeInMillis();
			long startTime = startDate.getTimeInMillis();
			long endTime = endDate.getTimeInMillis();
			
			
			System.out.println(nowTime);
			System.out.println(startTime);
			System.out.println(endTime);
			
			if(nowTime > endTime) {
				break;
			}
			
			if(nowTime < startTime) {
				cal.add(Calendar.DATE, 7);
				continue;
			}
			
			todoRunVo.setTodo_day(cal.getTime());
			wishSQLMapper.insertTodoRunByVo(todoRunVo);
			
			cal.add(Calendar.DATE, 7);
			
			System.out.println("잘되나?");
		}
		
	}
	
	
	// 나의 시작한 위시리스트 페이지 관련.... (myWishList.do)
	// wish, todo, wish_run, todo_run 등 필요한 데이터 모두 셀렉트하기.
	public ArrayList<HashMap<String, Object>> getMyRelatedWishList(int member_no, boolean isEscape) {
		
		ArrayList<HashMap<String, Object>> relatedWish = new ArrayList<>();
		
		ArrayList<WishRunVo> wishRunList = wishSQLMapper.selectRunningWishRunByMemberNo(member_no);
		for(WishRunVo wishRunVo : wishRunList) {
			HashMap<String, Object> map = new HashMap<>();
			
			// 실행중인 wish_no 얻기.
			int wish_run_no = wishRunVo.getNo();
			int wish_no = wishRunVo.getWish_no();
			map.put("wishRunVo", wishRunVo);
			
			
			
			// 실행중인 wish 얻기.
			WishVo wishVo = wishSQLMapper.selectWishByNo(wish_no);
			// html escape.
			if(isEscape) {
				
				// HTML 태그를 사용할 수 없도록 만들어줌.
				String str1 = StringEscapeUtils.escapeHtml4(wishVo.getContent());
				str1 = str1.replaceAll("\n", "<br>");
				wishVo.setContent(str1);
				
				String str2 = StringEscapeUtils.escapeHtml4(wishVo.getTitle());
				str2 = str2.replaceAll("\n", "<br>");
				wishVo.setTitle(str2);
				
			}
			map.put("wishVo", wishVo);
			
			// 실행중인 wish의 todo 얻기.
			ArrayList<TodoVo> todoList = wishSQLMapper.selectTodoByWishNo(wish_no);
			ArrayList<HashMap<String, Object>> todoAndCheckList = new ArrayList<>();
			
			// 실행중인 wish의 todo_run check y갯수, n갯수 얻기.
			for(TodoVo todoVo : todoList) {
				
				HashMap<String, Object> todoAndCheckMap = new HashMap<>();

				String totalCount = "결과 없음";
				int todo_no = todoVo.getNo();
				
				TodoRunVo todoRunCheck = new TodoRunVo();
				todoRunCheck.setTodo_no(todo_no);
				todoRunCheck.setWish_run_no(wish_run_no);
				todoRunCheck.setCheck("y");
				double yCount = wishSQLMapper.selectTodoRunCountByVo(todoRunCheck);
				todoRunCheck.setCheck("n");
				double nCount = wishSQLMapper.selectTodoRunCountByVo(todoRunCheck);
				double total = yCount + nCount;
				if(yCount != 0) {
					totalCount = Integer.toString((int)((yCount/total)*100));
					System.out.println(totalCount);
				}
				
				todoAndCheckMap.put("todoVo", todoVo);
				todoAndCheckMap.put("todoCount", totalCount);
			
				todoAndCheckList.add(todoAndCheckMap);
			}
			
			map.put("todoAndCheckList", todoAndCheckList);
			
			relatedWish.add(map);
		}

		return relatedWish;
	}
	
	
	// wish_run quit_date 설정하기. (quitWishRunProcess.do)
	public void setWishRunQuitDate(int wish_run_no) {
		
		wishSQLMapper.updateWishRunQuitDateByNo(wish_run_no);
		
	}
	
	
	// 위시 상세보기 페이지 관련.. (readWishRun.do)
	// wish, todo, wish_run, Dday, member 등 필요한 데이터 모두 셀렉트하기.
	public HashMap<String, Object> getRelatedWish(int wish_run_no, boolean isEscape){
		
		HashMap<String, Object> relatedWish = new HashMap<>();
		
		// wishRunVO 얻기.
		WishRunVo wishRunVo = wishSQLMapper.selectWishRunByNo(wish_run_no);
		int member_no = wishRunVo.getMember_no();
		relatedWish.put("wishRunVo", wishRunVo);
		
		// D-Day 얻기.
		Date endDate = wishRunVo.getEnd_date();
		Date nowDate = new Date();
		long end = endDate.getTime();
		long now = nowDate.getTime();
		System.out.println(end);
		System.out.println(now);
		long dDay_ = (end - now);
		System.out.println(dDay_);
		
		int dDay =(int)(dDay_/(1000*60*60*24))+1;
		
		relatedWish.put("Dday", dDay);
		
		// wish_run_no 얻기.
		
		// wishVo 얻기.
		int wish_no = wishRunVo.getWish_no();
		WishVo wishVo = wishSQLMapper.selectWishByNo(wish_no);
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
		relatedWish.put("wishVo", wishVo);
		
		
		// wish 작성자 memberVo 얻기.
		int wishMemberNo = wishVo.getMember_no();
		MemberVo wishMemberVo = memberSQLMapper.getMemberByNo(wishMemberNo);
		relatedWish.put("wishMemberVo", wishMemberVo);
		
		int wishRunMemberNo = wishRunVo.getMember_no();
		MemberVo wishRunMemberVo = memberSQLMapper.getMemberByNo(wishRunMemberNo);
		relatedWish.put("wishRunMemberVo", wishRunMemberVo);
		
		// todo와 todoRun 진행상황 묶기.
		ArrayList<HashMap<String,Object>> relatedTodoList = new ArrayList<>();
		ArrayList<TodoVo> todoVoList = wishSQLMapper.selectTodoByWishNo(wish_no);
		for(TodoVo todoVo : todoVoList) {
			
			HashMap<String, Object> map = new HashMap<>();
			String totalCount = "결과 없음";
			int todo_no = todoVo.getNo();
			
			TodoRunVo todoRunCheck = new TodoRunVo();
			todoRunCheck.setTodo_no(todo_no);
			todoRunCheck.setWish_run_no(wish_run_no);
			todoRunCheck.setCheck("y");
			double yCount = wishSQLMapper.selectTodoRunCountByVo(todoRunCheck);
			todoRunCheck.setCheck("n");
			double nCount = wishSQLMapper.selectTodoRunCountByVo(todoRunCheck);
			double total = yCount + nCount;
			if(yCount != 0) {
				totalCount = Integer.toString((int)((yCount/total)*100));
				System.out.println(totalCount);
			}
			

			map.put("totalCount", totalCount);
			map.put("todoVo", todoVo);
			
			relatedTodoList.add(map);
		}
		
		relatedWish.put("relatedTodoList",relatedTodoList);
		
		// wish에 대한 todo_run에 todo_day얻기.
		ArrayList<Date> todoDayList = wishSQLMapper.selectTodoRunDateByWishRunNo(wish_run_no);
		// 날짜별 todoList, todoRunList 묶기.
		ArrayList<HashMap<String, Object>> relatedTodoDayList = new ArrayList<>();
		
		for(Date todo_day : todoDayList) {
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			
			
			// 날짜별 todoList, todoRunList 묶기.
			ArrayList<HashMap<String, Object>> relatedWishTodoDayList = new ArrayList<>();
			
			TodoRunVo todoRunVo = new TodoRunVo();
			todoRunVo.setTodo_day(todo_day);
			ArrayList<TodoRunVo> todoList = wishSQLMapper.selectTodoRunByDay(todo_day, member_no);
			
			for(TodoRunVo todoRunDay : todoList) {
				
				HashMap<String, Object> map2 = new HashMap<String, Object>();
				
				// todo_run, todo HashMap으로 묶기.
				int todo_no = todoRunDay.getTodo_no();
				TodoVo todoDay = wishSQLMapper.selectTodoByNo(todo_no);
				
				map2.put("todo", todoDay);
				map2.put("todoRun", todoRunDay);
				
				relatedWishTodoDayList.add(map2);
				
			}
			
			
			map.put("relatedWishTodoDayList", relatedWishTodoDayList);
			map.put("todo_day",todo_day);
			
			relatedTodoDayList.add(map);
			
		}
		
		relatedWish.put("relatedTodoDayList", relatedTodoDayList);
		
		
		// 댓글 셀렉트하기.
		ArrayList<WishRunReplyVo> wishRunReplyList = wishSQLMapper.selectWishRunReplyByWishRunNo(wish_run_no);
		ArrayList<HashMap<String, Object>> wishRunReplyAndWriterList = new ArrayList<>();
		
		for(WishRunReplyVo wishRunReplyVo: wishRunReplyList) {
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			
			int writer_no = wishRunReplyVo.getMember_no();
			MemberVo writerVo = memberSQLMapper.getMemberByNo(writer_no);
			
			map.put("wishRunReplyVo", wishRunReplyVo);
			map.put("writerVo", writerVo);
			
			wishRunReplyAndWriterList.add(map);
		}
		
		relatedWish.put("wishRunReplyAndWriterList", wishRunReplyAndWriterList);
		
		return relatedWish;
		
	}
	// 위시 상세보기 페이지 reliability count구하기. (readWishRun.do)
	public HashMap<String, Object> getCountReliability(WishReliabilityVo vo) {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		// reliability count구하기.
		vo.setGood_bad("y");
		double yCount = getReliability(vo);
		vo.setGood_bad("n");
		double nCount = getReliability(vo);
		double total = yCount + nCount;
		String countReliability = "결과없음";
		if(total != 0) {
			double countReliabilty_ = (yCount/total)*100;
			countReliability = Double.toString(countReliabilty_);
		}
		
		
		int member_no = vo.getMember_no();
		
		// reliability good_bad 확인하기.
		// reliability good_bad 확인하기.
		WishReliabilityVo myReliabilityVo = getMyReliabilityVo(member_no);
		
	
		map.put("countReliability", countReliability);
		map.put("myReliabilityVo", myReliabilityVo);
		
		return map;
		
	}
	// count wishReliability 얻기. (service 내부에서 사용)
	private int getReliability(WishReliabilityVo vo) {	
		return wishSQLMapper.selectCountReliabilityByVo(vo);
	}
	// 내 wishReliability 얻기. (service 내부에서 사용)
	private WishReliabilityVo getMyReliabilityVo(int member_no) {
		return wishSQLMapper.selectMyReliabilityByMemberNo(member_no);
	}
	
	
	
	// todo_run 상세보기 페이지 관련.. (readTodoRun.do)
	// wish, todo, wish_run, todo_run 등 필요한 데이터 모두 불러오기.
	public ArrayList<HashMap<String, Object>> getRelatedTodoRunList(TodoRunVo todoRunVo, int member_no, boolean isEscape){
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<>();
		
		ArrayList<WishRunVo> wishRunList = wishSQLMapper.selectWishRunByMemberNo(member_no);
		
		for(WishRunVo wishRun : wishRunList) {
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			
			// wishVo 얻기.
			int wish_no = wishRun.getWish_no();
			WishVo wish = wishSQLMapper.selectWishByNo(wish_no);
			if(isEscape) {
				
				// HTML 태그를 사용할 수 없도록 만들어줌.
				String str1 = StringEscapeUtils.escapeHtml4(wish.getContent());
				str1 = str1.replaceAll("\n", "<br>");
				wish.setContent(str1);
				
				String str2 = StringEscapeUtils.escapeHtml4(wish.getTitle());
				str2 = str2.replaceAll("\n", "<br>");
				wish.setTitle(str2);
				
			}
			// wishVo, wishRunVo map에 넣기.
			map.put("wish", wish);
			map.put("wishRun", wishRun);
			
			// ArrayList<HashMap>에 todo와 해당 요일에 todoRun묶기.
			ArrayList<HashMap<String, Object>> relatedTodoList = new ArrayList<HashMap<String,Object>>();

			// todoRunVo
			int wish_run_no = wishRun.getNo();
			todoRunVo.setWish_run_no(wish_run_no);
			ArrayList<TodoRunVo> todoRunList = wishSQLMapper.selectTodoRunByVo(todoRunVo);
			
			for(TodoRunVo todoRunDay : todoRunList) {
			
				HashMap<String, Object> map2 = new HashMap<String, Object>();
				
				int todo_no = todoRunDay.getTodo_no();
				TodoVo todoDay = wishSQLMapper.selectTodoByNo(todo_no);
				
				
				ArrayList<HashMap<String, Object>> relatedWishDateList = new ArrayList<>();
				ArrayList<TodoRunVo> wishRunNoList 
											= wishSQLMapper.selectTodoRunWishRunNoByDay(todoRunDay);
				
				for(TodoRunVo tempTodoRunVo : wishRunNoList) {
					
					HashMap<String, Object> map3 = new HashMap<String, Object>();
					
					int wishRunNo = tempTodoRunVo.getWish_run_no();
					
					WishRunVo wishRunVo = wishSQLMapper.selectWishRunByNo(wishRunNo);
					int wishNo = wishRunVo.getWish_no();
					
					WishVo wishVo = wishSQLMapper.selectWishByNo(wishNo);
					
					map3.put("wishRunNo", wishRunNo);
					map3.put("wishVo", wishVo);
					
					relatedWishDateList.add(map3);
				}
				
	
				// HashMap에 todoRun, todo 넣기.
				map2.put("relatedWishDateList", relatedWishDateList);
				map2.put("todoRun",todoRunDay);
				map2.put("todo", todoDay);
				
				// ArrayList에 정리.
				relatedTodoList.add(map2);
				
			}
			
			map.put("relatedTodoList", relatedTodoList);
			list.add(map);
			
		}
		
		return list;
		
	}
	
	
	
	// 투두런 체크시 실행되는 로직.(checkTodoRunProcess.do)
	public void checkTodoRun(int no) {
		
		wishSQLMapper.updateTodoRunByNo(no);
	}
	
	
	
	
	// 내 종료 위시 페이지 관련.. (myEndWishList.do)
	// wish, todo, wish_run, todo_run 등 포기한 위시 관련 데이터 모두 불러오기.
	public ArrayList<HashMap<String, Object>> getQuitWishList(int member_no, boolean isEscape) {
		
		ArrayList<HashMap<String, Object>> endWishList = new ArrayList<>();
		
		ArrayList<WishRunVo> wishRunList = wishSQLMapper.selectWishRunByEndDateAndMemberNo(member_no);
		
		for(WishRunVo wishRunVo : wishRunList) {
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			
			// wishVo 얻기.
			int wish_no = wishRunVo.getWish_no();
			WishVo wishVo = wishSQLMapper.selectWishByNo(wish_no);
			// html escape
			if(isEscape) {
				
				// HTML 태그를 사용할 수 없도록 만들어줌.
				String str1 = StringEscapeUtils.escapeHtml4(wishVo.getContent());
				str1 = str1.replaceAll("\n", "<br>");
				wishVo.setContent(str1);
				
				String str2 = StringEscapeUtils.escapeHtml4(wishVo.getTitle());
				str2 = str2.replaceAll("\n", "<br>");
				wishVo.setTitle(str2);
				
			}
			
			
			// wish_run_no 얻기.
			int wish_run_no = wishRunVo.getNo();
			
			ArrayList<HashMap<String, Object>> relatedTodoList = new ArrayList<HashMap<String,Object>>();
			ArrayList<TodoVo> todoList = wishSQLMapper.selectTodoByWishNo(wish_no); 
			
			for(TodoVo todoVo : todoList) {
				
				HashMap<String, Object> map2 = new HashMap<>();
				String totalCount = "결과 없음";
				int todo_no = todoVo.getNo();
				
				TodoRunVo todoRunCheck = new TodoRunVo();
				todoRunCheck.setTodo_no(todo_no);
				todoRunCheck.setWish_run_no(wish_run_no);
				todoRunCheck.setCheck("y");
				double yCount = wishSQLMapper.selectTodoRunCountByVo(todoRunCheck);
				todoRunCheck.setCheck("n");
				double nCount = wishSQLMapper.selectTodoRunCountByVo(todoRunCheck);
				double total = yCount + nCount;
				if(yCount != 0) {
					totalCount = Integer.toString((int)((yCount/total)*100));
					System.out.println(totalCount);
				}
				

				map2.put("totalCount", totalCount);
				map2.put("todoVo", todoVo);
				
				relatedTodoList.add(map2);
				
				
			}
			
			map.put("relatedTodoList",relatedTodoList);
			map.put("wishRunVo", wishRunVo);
			map.put("wishVo", wishVo);
			
			endWishList.add(map);
			
		}
		
		return endWishList;
		
	}
	// wish, todo, wish_run, todo_run 등 포기한 위시 관련 데이터 모두 불러오기. (myEndWishList.do)
	public ArrayList<HashMap<String, Object>> getEndWishList(int member_no, boolean isEscape) {
		
		ArrayList<HashMap<String, Object>> relatedWish = new ArrayList<>();
		
		ArrayList<WishRunVo> wishRunList = wishSQLMapper.selectEndWishRunByMemberNo(member_no);
		for(WishRunVo wishRunVo : wishRunList) {
			HashMap<String, Object> map = new HashMap<>();
			
			// 실행중인 wish_no 얻기.
			int wish_run_no = wishRunVo.getNo();
			int wish_no = wishRunVo.getWish_no();
			map.put("wishRunVo", wishRunVo);
			
			// 실행중인 wish 얻기.
			WishVo wishVo = wishSQLMapper.selectWishByNo(wish_no);
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
			map.put("wishVo", wishVo);
			
			
			// 실행중인 wish의 todo 얻기.
			ArrayList<TodoVo> todoList = wishSQLMapper.selectTodoByWishNo(wish_no);
			ArrayList<HashMap<String, Object>> todoAndCheckList = new ArrayList<>();
			
			// 실행중인 wish의 todo_run check y갯수, n갯수 얻기.
			for(TodoVo todoVo : todoList) {
				
				HashMap<String, Object> todoAndCheckMap = new HashMap<>();

				String totalCount = "결과 없음";
				int todo_no = todoVo.getNo();
				
				TodoRunVo todoRunCheck = new TodoRunVo();
				todoRunCheck.setTodo_no(todo_no);
				todoRunCheck.setWish_run_no(wish_run_no);
				todoRunCheck.setCheck("y");
				double yCount = wishSQLMapper.selectTodoRunCountByVo(todoRunCheck);
				todoRunCheck.setCheck("n");
				double nCount = wishSQLMapper.selectTodoRunCountByVo(todoRunCheck);
				double total = yCount + nCount;
				if(yCount != 0) {
					totalCount = Integer.toString((int)((yCount/total)*100));
					System.out.println(totalCount);
				}
				
				
				
				todoAndCheckMap.put("todoVo", todoVo);
				todoAndCheckMap.put("todoCount", totalCount);
			
				todoAndCheckList.add(todoAndCheckMap);
			}
			
			map.put("todoAndCheckList", todoAndCheckList);
			
			relatedWish.add(map);
		}

		return relatedWish;
	}	
	
	
	
	
	// wish 상세페이지 관련..
	// wish 랭킹과 관련된 데이터 불러오기.
	public HashMap<String, Object> getWishRankData(int wish_no) {
		
		HashMap<String, Object> wishRankData = new HashMap<String, Object>();
		
		int runWishCount = wishSQLMapper.selectWishRunCountByWishNo(wish_no);
		wishRankData.put("runWishCount", runWishCount);
		int quitWishCount = wishSQLMapper.selectQuitWishRunByWishNo(wish_no);
		wishRankData.put("quitWishCount", quitWishCount);
				
		return wishRankData;
		
	}
	// 조회수 업데이트.
	public void increaseReadCount(int wish_no) {
		wishSQLMapper.updateWishReadCountByNo(wish_no);
	}
	
	
}
