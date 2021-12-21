package com.ja.shape.board.controller;

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

import com.ja.shape.board.service.QuestionBoardServiceImpl;
import com.ja.shape.vo.MemberVo;
import com.ja.shape.vo.QuestionImageVo;
import com.ja.shape.vo.QuestionReplyImageVo;
import com.ja.shape.vo.QuestionReplyVo;
import com.ja.shape.vo.QuestionVo;

@Controller
@RequestMapping("/board/")
public class QuestionBoardController {
	
	@Autowired
	private QuestionBoardServiceImpl questionBoardService;
	
	@RequestMapping("question.do")
	public String questionPage(Model model, String searchQuestionOption, String searchQuestionWord,
			@RequestParam(defaultValue = "1") int pageNum) {
		
		if(searchQuestionWord != null) {
			searchQuestionWord = searchQuestionWord.trim();
		}
		
		
		ArrayList<HashMap<String, Object>> list = questionBoardService.getListByNo(searchQuestionOption, searchQuestionWord, pageNum);
		
		int totalQuestionBoardCount = questionBoardService.getQuestionBoardCount(searchQuestionOption, searchQuestionWord);
		int totalPageCount = totalQuestionBoardCount/10;
		if(totalQuestionBoardCount%10 != 0) {
			totalPageCount++;
		}
		
		int beginQuestionPageNum = ((pageNum-1)/5)*5 +1;
		int endQuestionPageNum = ((pageNum-1)/5 +1)*(5);
		
		if(endQuestionPageNum>totalPageCount) {
			endQuestionPageNum = totalPageCount;
		}
		
		String addParams = "";
		if(searchQuestionOption != null && searchQuestionWord!=null) {
			addParams += "&searchQuestionOption=" + searchQuestionOption;
			addParams += "&searchQuestionWord=" + searchQuestionWord;
		}
		
		model.addAttribute("list" , list);
		model.addAttribute("totalQuestionBoardCount" , totalQuestionBoardCount);
		model.addAttribute("currentQuestionPageNum" , pageNum);
		model.addAttribute("beginQuestionPageNum" , beginQuestionPageNum);
		model.addAttribute("endQuestionPageNum" , endQuestionPageNum);
		model.addAttribute("addParams" , addParams);
		
		return "board/question";
	}
	
	@RequestMapping("expectedQuestion.do")
	public String expectedQuestion() {
		
		return "board/expectedQuestion";
	}
	
	@RequestMapping("writeQuestionPage.do")
	public String writeQuestionPage() {
		
		return "board/writeQuestion";
	}
	
	@RequestMapping("writeQuestionProcess.do")
	public String writeQuestionProcess(QuestionVo param, MultipartFile [] filesQuestion, HttpSession session) {
		
		String rootUploadFileFolderName ="C:/Project_shape_image/question";
		
		ArrayList<QuestionImageVo> imageVoList = new ArrayList<QuestionImageVo>();
		
		
		//파일 업로드
		for(MultipartFile file: filesQuestion) {
			
			if(file.isEmpty()) {
				continue;
			}
			
			String originalFileName =file.getOriginalFilename();
			String ext = originalFileName.substring(originalFileName.lastIndexOf("."));
			
			//파일명 변환: 랜덤+시간
			UUID uuid = UUID.randomUUID();
			//System.out.println("생성된 uuid"+uuid.toString());
			long currentTime = System.currentTimeMillis();
			
			String randomFileName = uuid.toString()+"_"+currentTime +ext;
			
			//날짜 폴더 생성
			Date today = new Date();//오늘 날짜 생성
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd"); //날짜-문자 변환
			String todayfoldername = sdf.format(today);
			
			//ex)c:efwrfwrfwrf/2021/10/12
			File todayfolder = new File(rootUploadFileFolderName+"/"+todayfoldername);
			
			if(!todayfolder.exists()) {
				todayfolder.mkdirs();
			}
			
			String uploadFilePath = rootUploadFileFolderName+"/"+todayfoldername+"/"+randomFileName;
			
			try {
				file.transferTo(new File(uploadFilePath));
			} catch (Exception e) {
				e.printStackTrace();//버그 찾기용
			}
			//db 데이터 구성
			QuestionImageVo imageVo = new QuestionImageVo();
			imageVo.setFile_name(originalFileName);
			imageVo.setFile_link(todayfoldername+"/"+randomFileName);
			imageVo.setUpload_date(today);
			
			imageVoList.add(imageVo);
			
		}
		
		MemberVo sessionUser = (MemberVo)session.getAttribute("user");
		int member_no = sessionUser.getNo();
		param.setMember_no(member_no);
		questionBoardService.writeContentByVo(param,imageVoList);
		
		
		return "redirect:./readQuestionPage.do?question_no="+param.getNo();
	}
	
	@RequestMapping("readQuestionPage.do")
	public String readQuestionPage(int question_no, Model model) {
		
		HashMap<String, Object> data = questionBoardService.getQuestionByNo(question_no, true);
		HashMap<String, Object> data2 = questionBoardService.getReplyByNo(question_no, true);
		
		model.addAttribute("data",data);
		model.addAttribute("data2",data2);
		
		return "board/readQuestionPage";
	}
	
	@RequestMapping("writeQuestionReplyProcess.do")
	public String writeQuestionReplyProcess(int question_no, MultipartFile [] filesQuestion, QuestionReplyVo reply) {
		String rootUploadFileFolderName ="C:/Project_shape_image/reply";
		
		ArrayList<QuestionReplyImageVo> imageVoList = new ArrayList<QuestionReplyImageVo>();
		
		
		//파일 업로드
		for(MultipartFile file: filesQuestion) {
			
			if(file.isEmpty()) {
				continue;
			}
			
			String originalFileName =file.getOriginalFilename();
			String ext = originalFileName.substring(originalFileName.lastIndexOf("."));
			
			//파일명 변환: 랜덤+시간
			UUID uuid = UUID.randomUUID();
			long currentTime = System.currentTimeMillis();
			
			String randomFileName = uuid.toString()+"_"+currentTime +ext;
			
			//날짜 폴더 생성
			Date today = new Date();//오늘 날짜 생성
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd"); //날짜-문자 변환
			String todayfoldername = sdf.format(today);
			
			//ex)c:efwrfwrfwrf/2021/10/12
			File todayfolder = new File(rootUploadFileFolderName+"/"+todayfoldername);
			
			if(!todayfolder.exists()) {
				todayfolder.mkdirs();
			}
			
			String uploadFilePath = rootUploadFileFolderName+"/"+todayfoldername+"/"+randomFileName;
			
			try {
				file.transferTo(new File(uploadFilePath));
			} catch (Exception e) {
				e.printStackTrace();//버그 찾기용
			}
			//db 데이터 구성
			QuestionReplyImageVo imageVo = new QuestionReplyImageVo();
			imageVo.setFile_name(originalFileName);
			imageVo.setFile_link(todayfoldername+"/"+randomFileName);
			imageVo.setUpload_date(today);
			
			imageVoList.add(imageVo);
			
		}
		
		
		reply.setQuestion_no(question_no);
		questionBoardService.writeReplyByVo(reply, imageVoList);
		
		return "redirect:./readQuestionPage.do?question_no="+question_no;
	}
	
	
	@RequestMapping("deleteQuestionProcess.do")
	public String deleteQuestionProcess(int question_no) {
		
		questionBoardService.deleteQuestion(question_no);
		
		return"redirect:./question.do";
	}
	
	
	@RequestMapping("updateQuestionPage.do")
	public String updateQuestionPage(int question_no, Model model) {
		
		HashMap<String, Object> data = questionBoardService.getQuestionByNo(question_no, false);
		model.addAttribute("data",data);
		
		return "board/updateQuestionPage";
	}
	
	
	
	@RequestMapping("updateQuestionProcess.do")
	public String updateQuestionProcess(QuestionVo vo) {
		
		questionBoardService.updateQuestion(vo);
		
		return "redirect:./readQuestionPage.do?question_no="+vo.getNo();
	}
	
	@RequestMapping("deleteReplyProcess.do")
	public String deleteReplyProcess(int reply_no, QuestionReplyVo vo) {
		questionBoardService.deleteReply(reply_no);
		
		
		return "redirect:./readQuestionPage.do?question_no="+vo.getQuestion_no();
	}
	
	
	
	
}
