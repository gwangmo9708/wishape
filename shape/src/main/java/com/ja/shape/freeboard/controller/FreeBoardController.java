package com.ja.shape.freeboard.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.ja.shape.freeboard.service.FreeBoardServiceImpl;
import com.ja.shape.vo.FreeBoardImageVo;
import com.ja.shape.vo.FreeBoardLikeVo;
import com.ja.shape.vo.FreeBoardReplyVo;
import com.ja.shape.vo.FreeBoardReplyWarningVo;
import com.ja.shape.vo.FreeBoardVo;
import com.ja.shape.vo.MemberVo;

@Controller
@RequestMapping("/freeboard/*")
public class FreeBoardController {
	
	@Autowired
	private FreeBoardServiceImpl freeBoardService;
	
	//메인페이지
	@RequestMapping("mainPage.do")
	public String mainPage(Model model, String searchOptionFreeBoard,String searchWordFreeBoard,
			@RequestParam(defaultValue = "1") int fbPageNum) {
		
		if(searchWordFreeBoard != null) {
			searchWordFreeBoard = searchWordFreeBoard.trim();
		}
		
		ArrayList<HashMap<String, Object>> list =freeBoardService.getFreeBoardList(searchOptionFreeBoard,searchWordFreeBoard, fbPageNum,true);
		
		int totalFreeBoardCount = freeBoardService.getTotalFreeBoardCount(searchOptionFreeBoard, searchWordFreeBoard);
		int totalFbPageCount = totalFreeBoardCount/10;
		if(totalFreeBoardCount%10 !=0) {
			totalFbPageCount++;
		}
		
		int beginFbPageNum= ((fbPageNum-1)/5)*5+1;
		int endFbPageNum= ((fbPageNum-1)/5+1)*(5);
		
		if(endFbPageNum > totalFbPageCount) {
			endFbPageNum = totalFbPageCount;
		}
		
		String addFbParams = "";
		if(searchOptionFreeBoard !=null && searchWordFreeBoard !=null) {
			addFbParams += "&searchOptionFreeBoard=" + searchOptionFreeBoard;
			addFbParams += "&searchWordFreeBoard=" + searchWordFreeBoard;
		}
		
		
		model.addAttribute("list",list);
		model.addAttribute("totalFbPageCount", totalFbPageCount);
		model.addAttribute("currentFbPageNum", fbPageNum);
		model.addAttribute("beginFbPageNum", beginFbPageNum);
		model.addAttribute("endFbPageNum", endFbPageNum);
		model.addAttribute("addFbParams", addFbParams);
		
		return "freeboard/mainPage";
	}
	
	//글작성하기관련
	@RequestMapping("writeContentPage.do")
	public String writeContentPage() {
		
		return "freeboard/writeContentPage";
	}
	
	@RequestMapping("writeContentProcess.do")
	public String writeContentProcess(FreeBoardVo param,MultipartFile[] files, HttpSession session) {
        String rootUploadFileFolderName = "C:/Project_shape_image/freeboard";
        
        ArrayList<FreeBoardImageVo> imageVoList = new ArrayList<FreeBoardImageVo>();
        
		//파일업로드
		for(MultipartFile file : files) {
			
			if(file.isEmpty()) {
				continue;
			}
			
			String fileName= file.getOriginalFilename();
			String ext = fileName.substring(fileName.lastIndexOf("."));
			//파일명변환하기
			UUID uuid = UUID.randomUUID();
			System.out.println("생성된 uuid: "+uuid.toString());
			 long currentTime =System.currentTimeMillis();
			 
			 String randomFileName=uuid.toString()+"_"+currentTime+ext;
			 //날짜별폴더생성
			 Date today = new Date();
			 SimpleDateFormat sdf = new SimpleDateFormat("yy/MM/dd");//날짜 문자변환
			 String todayFolderName =  sdf.format(today);
			 
			 File todayFolder = new File(rootUploadFileFolderName+"/"+todayFolderName);
			 if(todayFolder.exists()){
				 todayFolder.mkdirs();
			 }
			String uploadFilePath = rootUploadFileFolderName+"/"+todayFolderName+"/"+randomFileName;
			
			try {
			file.transferTo(new File(uploadFilePath));
			}catch(Exception e) {
				e.printStackTrace();
			}
			
			//데이터구성
			FreeBoardImageVo imageVo = new FreeBoardImageVo();
			imageVo.setFile_name(fileName);
			imageVo.setFile_link(todayFolderName+"/"+randomFileName);
			imageVo.setUpload_date(today);
			imageVoList.add(imageVo);
		}
		
		
		
		MemberVo user = (MemberVo) session.getAttribute("user");
        int member_no =user.getNo();
        param.setMember_no(member_no);
        freeBoardService.writeContent(param,imageVoList);
		return "redirect:./mainPage.do";
	}
	
	//글상세보기
	@RequestMapping("readContentPage.do")
	public String readContentPage(int no,Model model,HttpSession session) {
	    HashMap<String, Object> data = freeBoardService.getFreeBoard(no,true);
	   ArrayList<HashMap<String, Object>>  data2 = freeBoardService.getFreeBoardReply(no,true);
	    
		model.addAttribute("data", data);
		model.addAttribute("data2", data2);
		
		MemberVo sessionUser =(MemberVo) session.getAttribute("user");
		
		//좋아요
		if(sessionUser!=null) {
			int member_no =sessionUser.getNo();
			FreeBoardLikeVo freeBoardLikeVo = new FreeBoardLikeVo();
			freeBoardLikeVo.setFree_board_no(no);
			freeBoardLikeVo.setMember_no(member_no);
			int myLikeCount =freeBoardService.getMyLikeCount(freeBoardLikeVo);
			model.addAttribute("myLikeCount", myLikeCount);
		}
		int totalLikeCount=freeBoardService.getTotalLikeCount(no);
		model.addAttribute("totalLikeCount", totalLikeCount);
		return "freeboard/readContentPage";
		
		

		
	}
	//글삭제
	@RequestMapping("deleteContentProcess.do")
	public String deleteContentProcess(int no) {
	
		freeBoardService.deleteContent(no);
		
		return "redirect:./mainPage.do";
	}
	//글수정관련
	@RequestMapping("updateContentPage.do")
	public String updateContentPage(int no,Model model) {
		HashMap<String, Object> data = freeBoardService.getFreeBoard(no,false);
		model.addAttribute("data", data);
		return "freeboard/updateContentPage";
	}
	
	@RequestMapping("updateContentProcess.do")
	 public String updateContentProcess(FreeBoardVo vo) {
		freeBoardService.updateContent(vo);
		return "redirect:./mainPage.do";
	}
	
	//좋아요 
	@RequestMapping("doLike.do")
	public String doLike(FreeBoardLikeVo param, HttpSession session) {
		MemberVo user = (MemberVo) session.getAttribute("user");
		int member_no =user.getNo();
		param.setMember_no(member_no);
		freeBoardService.doLikeProcess(param);
		return "redirect:./readContentPage.do?no="+param.getFree_board_no();
	}
	
	//댓글 쓰기
	@RequestMapping("writeReplyProcess.do")
	public String writeReplyProcess(FreeBoardReplyVo param,HttpSession session) {
		MemberVo user = (MemberVo) session.getAttribute("user");
		int member_no =user.getNo();
		param.setMember_no(member_no);
		freeBoardService.writeReply(param);
		return "redirect:./readContentPage.do?no="+param.getFree_board_no();
	}
	//댓글삭제
	@RequestMapping("deleteReplyProcess.do")
	public String deleteReplyProcess(int free_board_reply_no,int free_board_no) {
		freeBoardService.deleteReply(free_board_reply_no);
		return "redirect:./readContentPage.do?no="+free_board_no;
	}
	
	//댓글 페이지로 넘어가서 수정하는방법인데....
	@RequestMapping("updateReplyPage.do")
	public String updateReplyPage(int free_board_reply_no,Model model) {
		FreeBoardReplyVo freeBoardReplyVo = freeBoardService.getMyFreeBoardReplyByNo(free_board_reply_no);
		model.addAttribute("freeBoardReplyVo",freeBoardReplyVo);
		return "freeboard/updateReplyPage";
	}
	
	@RequestMapping("updateReplyProcess.do")
	 public String updateReplyProcess(FreeBoardReplyVo vo) {
		freeBoardService.updateReply(vo);
		return "redirect:./readContentPage.do?no="+vo.getFree_board_no();
	}
	

}
