package com.ja.shape.wish.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ja.shape.vo.BigCategoryVo;
import com.ja.shape.vo.MemberVo;
import com.ja.shape.vo.SmallCategoryVo;
import com.ja.shape.vo.TodoRunVo;
import com.ja.shape.vo.TodoVo;
import com.ja.shape.vo.WishLikeVo;
import com.ja.shape.vo.WishReliabilityVo;
import com.ja.shape.vo.WishReplyWarnigVo;
import com.ja.shape.vo.WishRunVo;
import com.ja.shape.vo.WishVo;
import com.ja.shape.wish.service.WishServiceImpl;

@Controller
@RequestMapping("/wish/*")
public class WishController {
	
	@Autowired
	private WishServiceImpl wishService;
	
	// 메인 페이지.
	@RequestMapping("index.do")
	public String index(Model model, HttpSession session) {
		
		
		// 대분류
		ArrayList<BigCategoryVo> bigList = wishService.getBigCategoryVoList();
		model.addAttribute("bigList", bigList);
		// 소분류
		ArrayList<SmallCategoryVo> smallList = wishService.getSmallCategoryVoList();
		model.addAttribute("smallList", smallList);
		
		if(session.getAttribute("user") != null) {
			
			MemberVo memberVo = (MemberVo)session.getAttribute("user");
			int member_no = memberVo.getNo();
			
			HashMap<String, Object> myAllCategory = wishService.getMyAllCategory(member_no);
			model.addAttribute("myAllCategory", myAllCategory);
			
		}
		
		return "/wish/index";
		
	}
	
	
	//wish 만들기 버튼을 눌러서 wish 생성하기 페이지로 이동
	@RequestMapping("makeAWishPage.do")
	public String makeWish(Model model, HttpSession session) {

        if(session.getAttribute("user") == null) {
        	return "redirect:/member/login.do";
        }
		
		// 소분류
		ArrayList<SmallCategoryVo> smallList = wishService.getSmallCategoryVoList();
		model.addAttribute("smallList", smallList);
				
		return "/wish/makeAWishPage";//카카오 오븐 8페이지
	}
	
	//wish 생성 페이지에서 새로운 wish 생성 과정(make wish버튼을 눌렀을 경우의 동작)//
	@RequestMapping("makeAWishProcess.do")
	public String makeAWishProcess(Model model, MemberVo vo, WishVo param, HttpSession session) {
		
        if(session.getAttribute("user") == null) {
        	return "redirect:/member/login.do";
        }
		
		//로그인한 사용자 검색
		MemberVo user = (MemberVo)session.getAttribute("user");
		int member_no = user.getNo();
		
		param.setMember_no(member_no);
		
		//사용자가 생성한 위시를 wish테이블에 입력.
		wishService.makeAWish(param);
	
		return "redirect:./getWishAndToDoByMemberNo.do";
	}
		
	@RequestMapping("getWishAndToDoByMemberNo.do")	
	public String getWishAndToDoByMemberNo(Model model,  HttpSession session) {
		
		if(session.getAttribute("user") == null) {
	          return "redirect:/member/login.do";
	    }
		//로그인한 사용자 검색
		MemberVo user = (MemberVo)session.getAttribute("user");
		int member_no = user.getNo();

		//사용자 회원번호로 위시와 투두를 가져와서 보여주기
		ArrayList<HashMap<String, Object>> wishAndToDoPlanList =
									wishService.getWishAndToDoByMemberNo(member_no, true);
	    
		model.addAttribute("wishAndToDoPlanList", wishAndToDoPlanList);
		
		return "/wish/WishPlanPage";//여기는 오직 Plan의 대략적인 큰 개요. 카카오 오븐 9페이지로 이동.
	}
	
	
	//todo 계획 만들기 페이지로 이동..
	//사용자가 자신의 어떤 wish에 todo를 추가하려고 하는가???
	@RequestMapping("makeToDoPage.do")
	public String makeToDo(HttpSession session, int wish_no, Model model) {
		
        if(session.getAttribute("user") == null) {
        	return "redirect:/member/login.do";
        }
        
		WishVo wish = wishService.getWishByWishNo(wish_no);
		
		String title = wish.getTitle();
		
		model.addAttribute("title", title);
		model.addAttribute("wish_no", wish_no);
		
		return "/wish/makeToDoPage";//todo 입력 페이지로 이동하기
	}
	
	
	//todo를 생성하여 DB에 인서트 하는 프로세스 ... 끝니면 다시 wishplan으로 리다이렉트
	//사용자가 자신의 어떤 wish에 todo를 추가하려고 하는가???
	@RequestMapping("insertToDoProcess.do")
	public String insertToDoProcess(TodoVo todoVo) {
		
		wishService.insertToDo(todoVo);
		
		return "redirect:./getWishAndToDoByMemberNo.do";	
	}
	
	
	//여기도 손 좀 봐야함
	@RequestMapping("updatePlanCheck.do")
	public String updatePlanCheckProcess(int wishNo) {
		
		wishService.updatePlanCheck(wishNo);
		
		return "redirect:./getWishAndToDoByMemberNo.do";
	}
	
	

	
	//위시 삭제 프로세스
	@RequestMapping("deleteWishProcess.do")
	public String deleteWishProcess(int no) {
		
		wishService.deleteWish(no);
		
		return "redirect:./getWishAndToDoByMemberNo.do";
	}
	
	
	
	//위시 수정 페이지로 이동
	@RequestMapping("updateWishPage.do")
	public String updateWishPage(Model model, int wishNo) {
		
		// 소분류
		ArrayList<SmallCategoryVo> smallList = wishService.getSmallCategoryVoList();
		model.addAttribute("smallList", smallList);
		model.addAttribute("wishNo", wishNo);
		
		return "/wish/updateWishPage";
	}
	
	
	//위시 수정 프로세스	
	@RequestMapping("updateWishProcess.do")
	public String updateWishProcess(WishVo wishvo) {
		
		wishService.updateWish(wishvo);
		
		return "redirect:./getWishAndToDoByMemberNo.do";
	}
	
	//todo 수정 페이지로 이동
	@RequestMapping("updateToDoPage.do")
	public String updatetoDoPage(int toDoNo, String wishTitle, Model model) {
		
		model.addAttribute("wishTitle" , wishTitle);
		model.addAttribute("toDoNo", toDoNo);
		
		return "/wish/updateToDoPage";
	}
	
	@RequestMapping("updateToDoProccess.do")
	public String updateToDoProccess(TodoVo todoVo) {
		
		wishService.updateToDo(todoVo);
		
		return "redirect:./getWishAndToDoByMemberNo.do";
	}
	
	
	
	//헤더에서 other wish 누르면
	
	//위시 플랜 검색 페이지(18페이지)로 이동
	
	//위시 플랜 검색 기능 page
	
	//검색해서 원하는 남의 위시를 누르면 (이때 조회수가 하나 올라가도록 해야 한다)
	//이때 위시의 no를 날려주고  그걸 받았다고 가정 하도록 하자
	@RequestMapping("otherWishList.do")
	public String otherWishList(HttpSession session, Model model){
		
		// 로그인 하지 않았으면 로그인 페이지로 이동.
		if(session.getAttribute("user") == null) {
			return "redirect:/member/login.do";
		}
		
		//로그인한 사용자 검색
		MemberVo user = (MemberVo)session.getAttribute("user");
		int member_no = user.getNo();
		
		ArrayList<HashMap<String, Object>> OtherWishList = wishService.getWishOfOtherPeople(member_no);		
		
		model.addAttribute("OtherWishList", OtherWishList);
	
		//대분류 소분류 가져오기
		ArrayList<BigCategoryVo> bigList = wishService.getBigCategoryList();
		ArrayList<SmallCategoryVo> smallList = wishService.getSmallCategoryList();
		
		model.addAttribute("bigList", bigList);
		model.addAttribute("smallList", smallList);
		
		return "/wish/otherWishList";
	}
	
	
	//오븐 18페이지 (other wish)
	// 검색 옵션의 내용...
	@RequestMapping("searchWishByOption.do")
	public String searchWishByOption(String selectOption, String searchString, Model model, HttpSession session) {
		
		ArrayList<HashMap<String, Object>> OtherWishList = new ArrayList<HashMap<String,Object>>();
		
		if(selectOption.equals("writer")) {//아이디로 검색시 포워딩
			
			//로그인한 사용자 검색
			MemberVo user = (MemberVo)session.getAttribute("user");
			int member_no = user.getNo();
			
			OtherWishList = wishService.getOtherWishSelectOptionID(member_no, searchString);
			model.addAttribute("OtherWishList", OtherWishList);
			//대분류 소분류 가져오기
			ArrayList<BigCategoryVo> bigList = wishService.getBigCategoryList();
			ArrayList<SmallCategoryVo> smallList = wishService.getSmallCategoryList();
			
			model.addAttribute("bigList", bigList);
			model.addAttribute("smallList", smallList);
			
		}else if(selectOption.equals("title")){//위시 주제로 검색 시 포워딩
			
			//로그인한 사용자 검색
			MemberVo user = (MemberVo)session.getAttribute("user");
			int member_no = user.getNo();
			
			OtherWishList = wishService.getOtherWishSelectOptionTitle(member_no, searchString);
			model.addAttribute("OtherWishList", OtherWishList);
			//대분류 소분류 가져오기
			ArrayList<BigCategoryVo> bigList = wishService.getBigCategoryList();
			ArrayList<SmallCategoryVo> smallList = wishService.getSmallCategoryList();
			
			model.addAttribute("bigList", bigList);
			model.addAttribute("smallList", smallList);
		}
		
		return "/wish/otherWishList";		
	}
	
	
	//19페이지 내용
	
	//18페이지에서 원하는 위시를 클릭하면 ->
	@RequestMapping("getWishDataByWishNo.do")
	public String getWishDataByWishNo(int wish_no, Model model, HttpSession session) {
		
        if(session.getAttribute("user") == null) {
        	return "redirect:/member/login.do";
        }
		
        wishService.increaseReadCount(wish_no);
        
		HashMap<String, Object> wishAndToDoByWishNo = wishService.getWishAndToDoByWishNo(wish_no, true);
		
		model.addAttribute("wishAndToDoByWishNo", wishAndToDoByWishNo); 
		
		//이 위시의 댓글들을 가져오기
		//멤버 아이디가 안들어 있어서 멤버 테이블과 엮어야 함.. ArrayList 랑 해쉬맵 또 써야...
		//댓글의 아이디 = 댓글을 단 사람의 아이디
		ArrayList<HashMap<String, Object>> replyListPlusID = wishService.getReplyByWishNo(wish_no, true);
		model.addAttribute("replyListPlusID", replyListPlusID);
		
		
		// wishRankData 가져오기.
		HashMap<String, Object> wishRankData = wishService.getWishRankData(wish_no);
		model.addAttribute("wishRankData", wishRankData);
		
		return "/wish/showWishToDoReplyLikePage";
		
	}
	
	
	
	//위시 퍼감 댓글 달기
	//댓글달기 누르면 인서트가 되야 한다
	@RequestMapping("insertReplyProcess.do")
	public String insertReplyProcess(int wish_no, String content, HttpSession session, Model model) {
	    
		if(session.getAttribute("user") == null) {
			return "redirect:/member/login.do";
	    }
		
		//로그인한 사용자 검색
		MemberVo user = (MemberVo)session.getAttribute("user");
		int member_no = user.getNo();
		
		wishService.insertReply(wish_no, member_no, content);
		
		//인서트 끝나고 위시 no를 리다이렉트해 줘야 한다.
		model.addAttribute("wish_no", wish_no);
		
		return "redirect:./getWishDataByWishNo.do";
	}
	
	
	
	//위시 퍼감 댓글 신고 버튼 누르기
	@RequestMapping("reportReply.do")
	public String reportReply(int wish_reply_no, HttpSession session, Model model) {
		
		if(session.getAttribute("user") == null) {
	          return "redirect:/member/login.do";
	       }
		
		model.addAttribute("wish_reply_no", wish_reply_no);
		
		return "/wish/reportReplyPage";
		
	}
	
	//위시 퍼감 댓글 신고기능
	@RequestMapping("reportReplyProcess.do")
	public String reportReplyProcess(WishReplyWarnigVo wishReplyWarnigVo, HttpSession session, int wish_reply_no, Model model) {

		if(session.getAttribute("user") == null) {
	          return "redirect:/member/login.do";
	    }
		
		//로그인한 사용자 검색
		MemberVo user = (MemberVo)session.getAttribute("user");
		int member_no = user.getNo();		
		
		wishReplyWarnigVo.setMember_no(member_no);
		
		wishService.insertReplyReport(wishReplyWarnigVo);
		
		//인서트 끝나고 위시 no를 리다이렉트해 줘야 한다.
		int wish_no = wishService.getWishNoByWishReplyNo(wish_reply_no);
		model.addAttribute("wish_no", wish_no);
		
		return "redirect:./getWishDataByWishNo.do";
	}	
	
	
	//위시 좋아요 기능
	@RequestMapping("insertInToWishRun.do")
	public String likeWish(WishLikeVo wishLikeVo, HttpSession session, int wish_no, Model model) {
		
		if(session.getAttribute("user") == null) {
	          return "redirect:/member/login.do";
	    }
		
		//로그인한 사용자 검색
		MemberVo user = (MemberVo)session.getAttribute("user");
		int member_no = user.getNo();
		
		wishLikeVo.setMember_no(member_no);
		wishLikeVo.setWish_no(wish_no);
		
		wishService.likeWish(wishLikeVo);
		
		model.addAttribute("wish_no", wish_no);
		
		return "redirect:./getWishDataByWishNo.do";
	}
	
	
	
	// wish_run & Todo_run 입력 페이지.
	@RequestMapping("wishTodoRun.do")
	public String wishTodoRun(int wish_no, Model model) {
		
		HashMap<String, Object> map = wishService.getWishTodoList(wish_no, true);	
		model.addAttribute("map", map);
	
		return "/wish/wishTodoRun";
	}
	
	
	
	// wish_run & todo_run 생성 프로세스 페이지.
	@RequestMapping("wishTodoRunProcess.do")
	public String wishTodoRunProcess(int wish_no,
									WishRunVo wishRunVo,
									HttpSession session,
									@RequestParam(name="mon", required = false) int[] mons,
									@RequestParam(name="tue", required = false) int[] tues,
									@RequestParam(name="thur", required = false) int[] thurs,
									@RequestParam(name="wed", required = false) int[] weds,
									@RequestParam(name="fri", required = false) int[] fris,
									@RequestParam(name="sat", required = false) int[] sats,
									@RequestParam(name="sun", required = false) int[] suns ) {
		
		
		// 로그인 하지 않았으면 로그인 페이지로 이동.
		if(session.getAttribute("user") == null) {
			return "redirect:/member/login.do";
		}
		
		// 로그인 회원 member_no 구하기.
		MemberVo memberVo = (MemberVo) session.getAttribute("user");
		int member_no = memberVo.getNo();
		
		// WishRunVo 설정.
		int wish_run_no = wishService.getWishRunPK();
		wishRunVo.setNo(wish_run_no);
		wishRunVo.setMember_no(member_no);
		wishRunVo.setWish_no(wish_no);
		
		// WishRun 생성하기.
		wishService.createWishRun(wishRunVo);
		
		// TodoRun 생성하기.
		if(mons != null) {
			for(int mon : mons) {
				wishService.createTodoRun(wishRunVo, mon, 1);
			}
		}
		if(tues != null) {
			for(int tue : tues) {
				wishService.createTodoRun(wishRunVo, tue, 2);
			}
		}
		if(weds != null) {
			for(int wed : weds) {
				wishService.createTodoRun(wishRunVo, wed, 3);
			}
		}
		if(thurs != null) {
			for(int thur : thurs) {
				wishService.createTodoRun(wishRunVo, thur, 4);
			}
		}
		if(fris != null) {
			for(int fri : fris) {
				wishService.createTodoRun(wishRunVo, fri, 5);
			}
		}
		if(sats != null) {
			for(int sat : sats) {
				wishService.createTodoRun(wishRunVo, sat, 6);
			}
		}
		if(suns != null) {
			for(int sun : suns) {
				wishService.createTodoRun(wishRunVo, sun, 7);
			}
		}
		
		return "redirect:./myWishList.do";
	}
	
	
	
	// 나의 시작한 wishList 보여주기.
	@RequestMapping("myWishList.do")
	public String myWishList(HttpSession session,Model model) {
		
		// 로그인 하지 않았으면 로그인 페이지로 이동.
		if(session.getAttribute("user") == null) {
			return "redirect:/member/login.do";
		}
		
		MemberVo memverVo =(MemberVo) session.getAttribute("user");
		int member_no = memverVo.getNo();
		
		// 실행중인 wish, wishRun, todo, todoRun 가져오기. 
		ArrayList<HashMap<String, Object>> relatedWishList = wishService.getMyRelatedWishList(member_no, true);
		model.addAttribute("relatedWishList", relatedWishList);
		
		return "/wish/myWishList";
	}
	
	
	
	// wish_run 포기하기 설정 프로세스.
	@RequestMapping("quitWishRunProcess.do")
	public String quitWishRunProcess(int wish_run_no) {
		
		wishService.setWishRunQuitDate(wish_run_no);
		
		return "redirect:myWishList.do";
		
	}
	
	// 위시 상세보기 페이지.
	@RequestMapping("readWishRun.do")
	public String readWishRun(int wish_run_no, Model model, HttpSession session) {
		
		// 로그인 하지 않았으면 로그인 페이지로 이동.
		if(session.getAttribute("user") == null) {
			return "redirect:/member/login.do";
		}
		
		// session에서 member_no 불러오기.
		MemberVo memberVo = (MemberVo) session.getAttribute("user");
		int member_no = memberVo.getNo();
		
		// relatedWishList 얻고 보내기.
		HashMap<String, Object> relatedWishMap = wishService.getRelatedWish(wish_run_no, true);
		model.addAttribute("relatedWishMap", relatedWishMap);
		
		// reliability count 얻기.
		WishReliabilityVo vo = new WishReliabilityVo();
		vo.setMember_no(member_no);
		vo.setWish_run_no(wish_run_no);
		HashMap<String, Object> reliabilityMap =  wishService.getCountReliability(vo);
		model.addAttribute("reliabilityMap", reliabilityMap);
		
		Date nowDate = new Date();
		model.addAttribute("nowDate", nowDate);
		
		return "/wish/readWishRun";
	}
	
	

	// 투두런 상세 보기 페이지.
	@RequestMapping("readTodoRun.do")
	public String readTodoRun(String todo_day, Model model, HttpSession session) {
		
		// 로그인 하지 않았으면 로그인 페이지로 이동.
		if(session.getAttribute("user") == null) {
			return "redirect:/member/login.do";
		}
		
		// 실행하는 사람.
		MemberVo memberVo = (MemberVo) session.getAttribute("user");
		int member_no = memberVo.getNo();
		
		// String todo_day 날짜로 변경. 
		System.out.println(todo_day);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date;
		
		try {
			date = new Date(sdf.parse(todo_day).getTime());
			System.out.println(date);
			TodoRunVo todoRunVo = new TodoRunVo();
			todoRunVo.setTodo_day(date);
			ArrayList<HashMap<String, Object>> relatedTodoRunList =
											wishService.getRelatedTodoRunList(todoRunVo, member_no, true);
			
			model.addAttribute("relatedTodoRunList", relatedTodoRunList);
			model.addAttribute("todoDay", date);
			model.addAttribute("selectTodoDay", todo_day);
			System.out.println(todo_day);
		} catch (ParseException e) {
			e.printStackTrace();
		}	
		
		// 현재 날짜 구하기.
		Date today = new Date();
		String now = sdf.format(today);
		
		System.out.println(now);
		
		model.addAttribute("nowDate", now);
		
		return "/wish/readTodoRun";
	}
	
	
	
	// 투두런 체크 클릭 로직.
	@RequestMapping("checkTodoRunProcess.do")
	public String checkTodoRunProcess(int todo_run_no, String todo_day) {
		
		// check todo_run.
		wishService.checkTodoRun(todo_run_no);
		return "redirect: ./readTodoRun.do?todo_day="+todo_day;
		
	}
	
	
	
	// 끝난 위시 페이지.
	@RequestMapping("myEndWishList.do")
	public String myEndWishList(Model model,HttpSession session) {
		
		// 로그인 하지 않았으면 로그인 페이지로 이동.
		if(session.getAttribute("user") == null) {
			return "redirect:/member/login.do";
		}
		
		// 실행하는 사람.
		MemberVo memberVo = (MemberVo) session.getAttribute("user");
		int member_no = memberVo.getNo();
		
	 	Date nowDate = new Date();
		
		// 실행중인 wish, wishRun, todo, todoRun 가져오기. 
		ArrayList<HashMap<String, Object>> endWishDate = wishService.getEndWishList(member_no, true);
		model.addAttribute("endWishDate", endWishDate);
		
		ArrayList<HashMap<String, Object>> quitWishList = wishService.getQuitWishList(member_no, true);
		
		model.addAttribute("quitWishList", quitWishList);
		model.addAttribute("nowDate", nowDate);
		
		return "/wish/myEndWishList";
		
	}	

//	// 다른 사람 위시 보기 페이지. (아직 구현 X)
//	@RequestMapping("otherWishList.do")
//	public String otherWishList(HttpSession session, Model model) {
//		
//		return "/wish/otherWishList";
//		
//	}
//	
//	
//	
//	// 시작하지 않은 wish 보여주는 페이지. ( 아직 구현 X 광모님이랑 합칠 부분 )
//	@RequestMapping("notYetWish.do")
//	public String notYetWish(Model model, HttpSession session) {
//		
//		// 로그인 하지 않았으면 로그인 페이지로 이동.
//		if(session.getAttribute("user") == null) {
//			return "redirect:/member/login.do";
//		}
//		
//		MemberVo memberVo = (MemberVo)session.getAttribute("user");
//		int member_no = memberVo.getNo();
//		
//		return "/wish/notYetWish";
//	}	
	
	
}
