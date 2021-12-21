package com.ja.shape.story.controller;

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
import org.springframework.web.multipart.MultipartFile;

import com.ja.shape.story.service.StoryServiceImpl;
import com.ja.shape.vo.MemberVo;
import com.ja.shape.vo.StoryLikeVo;
import com.ja.shape.vo.StoryReplyVo;
import com.ja.shape.vo.StoryVo;

@Controller
@RequestMapping("/story/*")
public class StoryController {

	@Autowired
	private StoryServiceImpl storyService;
	
	@RequestMapping("storyHome.do")
	public String storyHome(StoryLikeVo param,Model model,HttpSession session) {
		
		//메인에서 read가 되어야
		
		/*
		 * HashMap<String, Object> data = storyService.getStory(no); HashMap<String,
		 * Object> data2 =storyService.getStoryReplyByNo(no);
		 */
		if(session.getAttribute("user") == null) {
	         return "redirect:/member/login.do";
	      }
		
		MemberVo sessionUser =(MemberVo) session.getAttribute("user");
		
		ArrayList<HashMap<String,Object>> relatedStoryList = storyService.getStoryList(sessionUser.getNo(), true);
		model.addAttribute("relatedStoryList",relatedStoryList);
   
		
		//좋아요
		if(sessionUser!=null) {
			int member_no=sessionUser.getNo();
			StoryLikeVo storyLikeVo = new StoryLikeVo();
			storyLikeVo.setMember_no(member_no);
			storyLikeVo.setStory_no(param.getNo());
			int myStoryLikeCount = storyService.getMyStoryLikeCount(storyLikeVo);
			model.addAttribute("myStoryLikeCount", myStoryLikeCount);
		}
		int totalStoryLikeCount = storyService.getStoryTotalLikeCount(param.getStory_no());
		model.addAttribute("totalStoryLikeCount", totalStoryLikeCount);
		
		return "story/storyHome";
	}
	
	@RequestMapping("writeStoryProcess.do")
	public String writeStoryProcess(StoryVo param ,MultipartFile file, HttpSession session) {
		String rootUploadFileFolderName ="C:/Project_shape_image/story";
		
		
		//파일 업로드
		if(file != null && !file.isEmpty()) {		
			String originalFileName = file.getOriginalFilename();
			
			System.out.println("dadwad : " + originalFileName);
			
			String ext = "";
			if(originalFileName.lastIndexOf(".") != -1) {
				ext = originalFileName.substring(originalFileName.lastIndexOf("."));
			}
			
			//파일명 변환 목표 : 파일명 충돌 방지, 방법 : 랜덤 + 시간
			UUID uuid = UUID.randomUUID();
			System.out.println("생성된 uuid"+ uuid.toString());
			long currentTime = System.currentTimeMillis();
			
			String randomFileName = uuid.toString()+ "_" + currentTime  + ext;
			
			//날짜 폴더 생성..
			 Date today = new Date();//오늘 날짜 생성
			 SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");//날짜 ->문자 변환 객체 생성
			 String todayFolderName = sdf.format(today);
			 
			 //ex) C:/uploadFiles/2021/10/26
			 File todayFolder = new File(rootUploadFileFolderName + "/" +todayFolderName);
			
			 if(!todayFolder.exists()) {
				 todayFolder.mkdirs();
			 }
			
			
			String uploadFilePath = 
					rootUploadFileFolderName + "/" + todayFolderName+"/"+randomFileName;
			
			try {
			 file.transferTo(new File(uploadFilePath));
			}catch(Exception e) {
				//실무에서는 여기가 제일 어렵고 중요
				e.printStackTrace();
			}
			
			param.setImage_file_name(originalFileName);
			param.setImage_file_link(todayFolderName+"/"+randomFileName);
		}
		
		if(session.getAttribute("user") == null) {
	         return "redirect:/member/login.do";
	      }
		
		MemberVo user =  (MemberVo)session.getAttribute("user");
		int member_no = user.getNo();
		param.setMember_no(member_no);
		
		storyService.writeStory(param);
		
		return "redirect:./storyHome.do";
	}
	
	@RequestMapping("writeStoryReplyProcess.do")
	public String writeStoryReplyProcess(StoryReplyVo param,HttpSession session) {
		MemberVo user = (MemberVo) session.getAttribute("user");
		int member_no =user.getNo();
		param.setMember_no(member_no);
		storyService.writeStoryReplyByVo(param);
		
		if(session.getAttribute("user") == null) {
	         return "redirect:/member/login.do";
	      }
		
		return "redirect:./storyHome.do?no="+param.getStory_no();
	}
	
	
	
	
	//스토리 삭제/ 댓글과 같이
	@RequestMapping("deleteStoryProcess.do")
	public String deleteStoryProcess(int no) {
		
		storyService.deleteStory(no);
		
		return "redirect:./storyHome.do";
	}
	
	
	//댓글 삭제
	@RequestMapping("deleteStoryReplyProcess.do")
	public String deleteStoryReplyProcess(int reply_no, int story_no) {
		storyService.deleteStoryReply(reply_no);
		
		return "redirect:./storyHome.do?no="+story_no;
	}
	
	
	
	//스토리 프로필 페이지 글 리스트
	@RequestMapping("storyUserProfile.do")
	public String storyUserProfile(int friend_member_no, StoryLikeVo param, Model model, HttpSession session) {
		
		if(session.getAttribute("user") == null) {
	         return "redirect:/member/login.do";
	      }
		
		MemberVo sessionUser =(MemberVo) session.getAttribute("user");
		
		ArrayList<HashMap<String,Object>> relatedProfileStoryList = storyService.getProfileStoryList(friend_member_no);
		model.addAttribute("relatedProfileStoryList",relatedProfileStoryList);
  
		ArrayList<HashMap<String, Object>> list2 = storyService.getWishListInStory(friend_member_no, sessionUser.getNo());
		
		//좋아요
		if(sessionUser!=null) {
			int member_no=sessionUser.getNo();
			StoryLikeVo storyLikeVo = new StoryLikeVo();
			storyLikeVo.setMember_no(member_no);
			storyLikeVo.setStory_no(param.getNo());
			int myStoryLikeCount = storyService.getMyStoryLikeCount(storyLikeVo);
			model.addAttribute("myStoryLikeCount", myStoryLikeCount);
		}
		int totalStoryLikeCount = storyService.getStoryTotalLikeCount(param.getStory_no());
		model.addAttribute("totalStoryLikeCount", totalStoryLikeCount);
		model.addAttribute("list2", list2);
	
		
		return "story/storyUserProfile";
	}
	
	
	//스토리 프로필 페이지에서 댓글 쓰고 redirect
	@RequestMapping("writeProfileStoryReplyProcess.do")
	public String writeProfileStoryReplyProcess(int friend_member_no, StoryReplyVo param,HttpSession session) {
		MemberVo user = (MemberVo) session.getAttribute("user");
		int member_no =user.getNo();
		param.setMember_no(member_no);
		storyService.writeStoryReplyByVo(param);
		
		if(session.getAttribute("user") == null) {
	         return "redirect:/member/login.do";
	      }
		
		return "redirect:./storyUserProfile.do?friend_member_no="+friend_member_no;
	}
	
	
	
	
	
	
	
}
