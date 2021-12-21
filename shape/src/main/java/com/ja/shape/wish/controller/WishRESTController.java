package com.ja.shape.wish.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.ja.shape.vo.BigCategoryVo;
import com.ja.shape.vo.MemberVo;
import com.ja.shape.vo.SmallCategoryVo;
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
import com.ja.shape.wish.service.WishRESTServiceImpl;
import com.ja.shape.wish.service.WishServiceImpl;


@ResponseBody
@Controller
@RequestMapping("/wish/")
public class WishRESTController {

	@Autowired
	WishRESTServiceImpl wishRestService;
	@Autowired
	WishServiceImpl wishService;
	
	
	// Reliability 관련..
	@RequestMapping("createReliability.do")
	public HashMap<String, Object> getReliability(WishReliabilityVo param, HttpSession session){
		
		// System.out.println("실행완료");
		
		// 로그인한 본인 member_no 설정.
		MemberVo memberVo = (MemberVo)session.getAttribute("user");
		int member_no = memberVo.getNo();
		param.setMember_no(member_no);
		
		return wishRestService.insertAndReliability(param);
		
	} 
	
	
	
	// wish_run_reply 관련...
	// wish_run_reply 생성.
	@RequestMapping("createWishRunReply.do")
	public void createWishRunReply(WishRunReplyVo param, HttpSession session) {
		
		MemberVo memberVo = (MemberVo)session.getAttribute("user");
		int member_no = memberVo.getNo();
		
		param.setMember_no(member_no);
		wishRestService.createWishRunReply(param);
		
	}
	// wish_run_reply list가져오기.
	@RequestMapping("getWishRunReply.do")
	public HashMap<String, Object> getWishRunReply(int wish_run_no, HttpSession session) {
	
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		MemberVo memberVo = (MemberVo)session.getAttribute("user");
		int member_no = memberVo.getNo();
		
		ArrayList<HashMap<String, Object>> wishRunReplyList = wishRestService.getWishRunReply(wish_run_no, member_no);
		data.put("wishRunReplyList", wishRunReplyList);
		
		return data;
		
	}
	// wish_run_reply 삭제하기.
	@RequestMapping("deleteWishRunReply.do")
	public void deleteWishRunReply(int wish_run_reply_no) {
		wishRestService.deleteWishRunReply(wish_run_reply_no);
	}
	// wish_run_reply 수정하기.
	@RequestMapping("updateWishRunReply.do")
	public void updateWishRunReply(WishRunReplyVo param) {
		System.out.println(param.getContent());
		wishRestService.updateWishRunReply(param);
	}
	
	
	
	// wish_run_reply_warning 관련..
	@RequestMapping("createWishRunReplyWarning.do")
	public void createWishRunReplyWarning(WishRunReplyWarningVo param, HttpSession session) {
		MemberVo memberVo = (MemberVo)session.getAttribute("user");
		int member_no = memberVo.getNo();
		
		param.setMember_no(member_no);
		wishRestService.createWishRunReplyWarning(param);
	}
	
	
	
	// member_no로 일정 확인하기.
	@RequestMapping("getTodoRunDate.do")
	public HashMap<String, Object> getTodoRunDate(HttpSession session){
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		MemberVo memberVo = (MemberVo)session.getAttribute("user");
		int member_no = memberVo.getNo();
		
		ArrayList<HashMap<String, Object>> wishRunTodoRunDateList = 
										wishRestService.getTodoRunDateList(member_no);
		
		map.put("wishRunTodoRunDateList", wishRunTodoRunDateList);
		
		return map;
		
	}
	
	
	
	// 일지관련...
	// wish_run_comment 생성하기.
	@RequestMapping("createComment.do")
	public void createComment(WishRunCommentVo param) {
	
		wishRestService.createComment(param);
		
	}
	// wish_run_comment 수정하기.
	@RequestMapping("updateComment.do")
	public void updateComment(WishRunCommentVo param) {
		
		System.out.println(param.getNo());
		
		wishRestService.updateComment(param);
		
	}
	// 일지 작성을 위한 wishRunList 구해오기.
	@RequestMapping("getWishRunList.do")
	public HashMap<String, Object> getWishRunList(String todo_day, HttpSession session){
		
		//로그인한 사용자 검색
		MemberVo user = (MemberVo)session.getAttribute("user");
		int member_no = user.getNo();

		
		
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		ArrayList<HashMap<String, Object>> wishAndWishRunList = wishRestService.getWishRunList(todo_day, member_no, true);
		data.put("wishAndWishRunList", wishAndWishRunList);
		
		return data;
		
	}
	// wish_run_image 생성하기. (미완성)
	@RequestMapping("createWishRunImage.do")
	public void createWishRunImage(MultipartFile[] uploadFiles, int wish_run_no) {
		
		String tempPath = "C:/Project_shape_image/wish";
		

		for(MultipartFile file : uploadFiles) {
			
			if(file.isEmpty()) {
				continue;
			}
			
			String originFileName = file.getOriginalFilename();
			String ext = originFileName.substring(originFileName.lastIndexOf("."));
			
			UUID uuid = UUID.randomUUID();
			long currentTime = System.currentTimeMillis();
			
			String randomName = uuid.toString() + "_" + currentTime;
			
			Date now = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
			String datePath = sdf.format(now);
			
			String todayFolderName = tempPath + File.separator + datePath;
			
			File pathFile = new File(todayFolderName);
			
			if(!pathFile.exists()) {
				pathFile.mkdirs();
			}
			
			String uploadfilePath = todayFolderName + File.separator + randomName + ext;
		
			try {
				file.transferTo(new File(uploadfilePath));
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
			
			String fileLink = datePath + File.separator + randomName + ext;
			
			
			WishRunImageVo wishRunImageVo = new WishRunImageVo();
			wishRunImageVo.setFile_link(fileLink);
			wishRunImageVo.setWish_run_no(wish_run_no);
			wishRunImageVo.setFile_name(originFileName);
			
			wishRestService.createWishRunImage(wishRunImageVo);
			
		}
		
	}
	// wish_run_image 불러오기.
	@RequestMapping("getWishRunImageList.do")
	public HashMap<String, Object> getWishRunImageList(String todo_day) {
		
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		ArrayList<WishRunImageVo> wishRunImageList = wishRestService.getWishRunImageList(todo_day);
		data.put("wishRunImageList", wishRunImageList);
		
		return data;
		
	}
	
	
	
	
	
	// index 페이지 관련.. (랭킹)
	// 많은 사람들이 실행하고 있는 위시 탑3.
	@RequestMapping("getRunningWishRank.do")
	public HashMap<String, Object> getRunningWishRank(){
		
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		ArrayList<HashMap<String, Object>> runningWishRankList = wishRestService.getRunningWishRank(true);
		data.put("runningWishRankList",runningWishRankList);
		
		return data;
		
	}
	// 좋아요 위시 랭킹.
	@RequestMapping("getLikeWishRank.do")
	public HashMap<String, Object> getLikeWishRank() {
		
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		ArrayList<HashMap<String, Object>> likeWishRankList = wishRestService.getLikeWishRank(true);
		data.put("likeWishRankList",likeWishRankList);
		
		return data;
	}
	// 조회수 위시 랭킹.
	@RequestMapping("getReadCountWishRank.do")
	public HashMap<String, Object> getReadCountWishRank() {
		
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		ArrayList<HashMap<String, Object>> readCountWishRankList = wishRestService.getReadCountWishRank(true);
		data.put("readCountWishRankList",readCountWishRankList);
		
		return data;
	}
	// 포기 위시 랭킹.
	@RequestMapping("getQuitWishRank.do")
	public HashMap<String, Object> getQuitWishRank() {
		
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		ArrayList<HashMap<String, Object>> quitWishRankList = wishRestService.getQuitWishRank(true);
		data.put("quitWishRankList",quitWishRankList);
		
		return data;
	} 
	// 카테고리별 많은 사람들이 실행하고 있는 위시 탑3.
	@RequestMapping("getCategoryRunningWishRank.do") 
	public HashMap<String, Object> getCategoryRunningWishRank(int small_category_no) {
		
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		ArrayList<HashMap<String, Object>> runningWishList = wishRestService.getCategoryRunningWishRank(small_category_no, true);
		data.put("runningWishList", runningWishList);
		
		return data;
		
	}
	// 카테고리별 좋아요 위시 랭킹.
	@RequestMapping("getCategoryLikeWishRank.do")
	public HashMap<String, Object> getCategoryLikeWishRank(int small_category_no) {
		
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		ArrayList<HashMap<String, Object>> likeWishList = wishRestService.getCategoryLikeWishRank(small_category_no, true);
		data.put("likeWishList", likeWishList);
		
		return data;
		
	}
	// 카테고리별 조회수 위시 랭킹.
	@RequestMapping("getCategoryReadCountWishRank.do")
	public HashMap<String, Object> getCategoryReadCountWishRank(int small_category_no) {
		
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		ArrayList<HashMap<String, Object>> readCountWishList = wishRestService.getCategoryReadCountWishRank(small_category_no, true);
		data.put("readCountWishList", readCountWishList);
		
		return data;
		
	}
	// 카테고리별 포기 위시 랭킹.
	@RequestMapping("getCategoryQuitWishRank.do")
	public HashMap<String, Object> getCategoryQuitWishRank(int small_category_no) {
		
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		ArrayList<HashMap<String, Object>> readQuitWishList = wishRestService.getCategoryQuitWishRank(small_category_no, true);
		data.put("readQuitWishList", readQuitWishList);
		
		return data;
		
	}
	
	
	
	// readWishRun페이지 관련..
	// 위시 런 후기 작성하기.
	@RequestMapping("createEpilogue.do")
	public void createEpilogue(WishRunEpilogueVo param, WishRunEpiloguePlaceVo param2) {
		
		wishRestService.createWishRunEpilogue(param, param2);
		
	}
	// 위시 런 후기 불러오기.
	@RequestMapping("getEpilogue.do")
	public HashMap<String, Object> getEpilogue(int wish_run_no) {
		
		HashMap<String, Object> data = wishRestService.getWishRunEpilogue(wish_run_no);

		return data;
		
	}
	// 위시 런 후기 수정하기.
	@RequestMapping("updateEpilogue.do")
	public void updateEpilogue(WishRunEpilogueVo param, WishRunEpiloguePlaceVo param2) {
		
		wishRestService.updateWishRunEpilogue(param, param2);
		
	}
	
	
	
	
	
	// 그래프 관련..
	// 남녀 성비
	@RequestMapping("getCountWishGender.do")
	public HashMap<String, Object> getCountWishGender(int wish_no){
		
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		ArrayList<HashMap<String, Object>> getCountGender = wishRestService.getCountWishGender(wish_no);
		data.put("getCountGender",getCountGender);
		
		
		return data;

	}
	// todo_run 실행여부 그래프.
	@RequestMapping("getTodoRunGraph.do")
	public HashMap<String, Object> getTodoRunGraph(int wish_no) {
		
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		ArrayList<HashMap<String, Object>> todoRunGraph = wishRestService.getTodoRunGraph(wish_no);
		data.put("todoRunGraph", todoRunGraph);
		
		return data;
		
	}
	// 날짜별 wish_like 그래프.
	@RequestMapping("getWishLikeGraph.do")
	public HashMap<String, Object> getWishLikeGraph(int wish_no) {
		
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		ArrayList<HashMap<String, Object>> wishLikeGraph = wishRestService.getWishLikeGraph(wish_no);
		data.put("wishLikeGraph", wishLikeGraph);
		
		return data;
		
	}
	// 날짜별 quit wish 그래프.
	@RequestMapping("getQuitWishGraph.do")
	public HashMap<String, Object> getQuitWishGraph(int wish_no) {
		
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		ArrayList<HashMap<String, Object>> quitWishGraph = wishRestService.getQuitWishGraph(wish_no);
		data.put("quitWishGraph", quitWishGraph);
		
		return data;
		
	}
	
	
	
	
	// 좋아요 관련 기능..
	// 좋아요 클릭마다 생성하거나 지우기.
	@RequestMapping("wishLikeProcess.do")
	public void wishLikeProcess(WishLikeVo param, HttpSession session) {
		
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		MemberVo memberVo = (MemberVo)session.getAttribute("user");
		int member_no = memberVo.getNo();
		
		param.setMember_no(member_no);
		
		wishRestService.wishLikeProcess(param);	
		
	}
	// 내 좋아요 확인하기.
	@RequestMapping("getMyWishLikeCount.do")
	public HashMap<String, Object> getMyWishLikeCount(WishLikeVo param, HttpSession session) {
		
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		MemberVo memberVo = (MemberVo)session.getAttribute("user");
		int member_no = memberVo.getNo();
		param.setMember_no(member_no);
		
		int myWishLikeCount = wishRestService.getMyWishLike(param);
		data.put("myWishLikeCount", myWishLikeCount);
		
		return data;
		
	}
	// 전체 좋아요 수 확인하기.
	@RequestMapping("getWishLikeCount.do")
	public HashMap<String, Object> getWishLikeCount(int wish_no) {
		
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		int wishLikeCount = wishRestService.getWishLikeCount(wish_no);
		data.put("wishLikeCount", wishLikeCount);
		
		return data;
		
	}
	
	
	
	// 댓글 기능 관련..
	// 댓글 생성하기.
	@RequestMapping("createWishReply.do")
	public void createWishReply(WishReplyVo param , HttpSession session) {
		
		MemberVo memberVo = (MemberVo)session.getAttribute("user");
		int member_no = memberVo.getNo();
		
		param.setMember_no(member_no);
		
		wishRestService.createWishReply(param);
		
	}
	// wish_reply list가져오기.
	@RequestMapping("getWishReply.do")
	public HashMap<String, Object> getWishReply(int wish_no, HttpSession session) {
	
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		MemberVo memberVo = (MemberVo)session.getAttribute("user");
		int member_no = memberVo.getNo();
		
		ArrayList<HashMap<String, Object>> wishReplyList = wishRestService.getWishReply(wish_no, member_no);
		data.put("wishReplyList", wishReplyList);
		
		return data;
		
	}
	// wish_run_reply 삭제하기.
	@RequestMapping("deleteWishReply.do")
	public void deleteWishReply(int wish_reply_no) {
		wishRestService.deleteWishReply(wish_reply_no);
	}
	// wish_run_reply 수정하기.
	@RequestMapping("updateWishReply.do")
	public void updateWishReply(WishReplyVo param) {
		wishRestService.updateWishReply(param);
	}
	
	
	
	
	// wish_reply_warning 관련..
	// wish_reply_warning 생성하기..
	@RequestMapping("createWishReplyWarning.do")
	public void createWishReplyWarning(WishReplyWarnigVo param, HttpSession session) {
		MemberVo memberVo = (MemberVo)session.getAttribute("user");
		int member_no = memberVo.getNo();
		
		param.setMember_no(member_no);
		wishRestService.createWishReplyWarning(param);
	}
	
	
	
	
	
	//other wish 페이지 관련 
	@RequestMapping("getSmallCategoryList.do")
	public HashMap<String, Object> getSmallCategoryList(int big_category_no){
		
		HashMap<String, Object> data4 = new HashMap<String, Object>();
		
		ArrayList<SmallCategoryVo> smallCategoryVo = wishRestService.getSmallCategoryListForOtherWish(big_category_no);
		
		data4.put("smallCategoryList", smallCategoryVo);
		
		return data4;
	}
	
	
	
	@RequestMapping("sortWishByOption.do")
	public HashMap<String, Object> sortWishByOption(String selectOption, String searchString, HttpSession session, int small_category_no) {
		
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		if(selectOption.equals("writer")) {//아이디로 검색시 포워딩
			
			//로그인한 사용자 검색
			MemberVo user = (MemberVo)session.getAttribute("user");
			int member_no = user.getNo();
			
			ArrayList<HashMap<String, Object>> otherWishList = wishRestService.getOtherWishSelectOptionIDAndSmallCategory(member_no, searchString, small_category_no);
			data.put("otherWishList", otherWishList);
			//대분류 소분류 가져오기
			ArrayList<BigCategoryVo> bigList = wishService.getBigCategoryList();
			ArrayList<SmallCategoryVo> smallList = wishService.getSmallCategoryList();
			
			data.put("bigList", bigList);
			data.put("smallList", smallList);
			
		} else if(selectOption.equals("title")){//위시 주제로 검색 시 포워딩
			
			//로그인한 사용자 검색
			MemberVo user = (MemberVo)session.getAttribute("user");
			int member_no = user.getNo();
			
			ArrayList<HashMap<String, Object>> otherWishList = wishRestService.getOtherWishSelectOptionTitleAndSmallCategory(member_no, searchString, small_category_no);
			data.put("otherWishList", otherWishList);
			//대분류 소분류 가져오기
			ArrayList<BigCategoryVo> bigList = wishService.getBigCategoryList();
			ArrayList<SmallCategoryVo> smallList = wishService.getSmallCategoryList();
			
			data.put("bigList", bigList);
			data.put("smallList", smallList);
		}
		
		return data;
	}
	
	
	
	
	
	
}




