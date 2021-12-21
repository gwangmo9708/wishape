package com.ja.shape.story.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ja.shape.story.service.StoryServiceImpl;
import com.ja.shape.vo.MemberVo;
import com.ja.shape.vo.StoryLikeVo;
import com.ja.shape.vo.StoryVo;

@Controller
@RequestMapping("/story/*")
@ResponseBody
public class StoryRESTController {

	@Autowired
	private StoryServiceImpl storyService;
	

	@RequestMapping("updateStoryProcess.do")
	public void updateStoryProcess(StoryVo param) {
		
		storyService.updateStory(param);
	}
	

	@RequestMapping("doStoryLike.do")
     public void doLike(StoryLikeVo param , HttpSession session) {
		
		MemberVo sessionUser = (MemberVo)session.getAttribute("user");
		param.setMember_no(sessionUser.getNo());
		
		
		storyService.storyLikeProcess(param);
	}	
	
	@RequestMapping("getMyLikeCount.do")
	public HashMap<String, Object> getMyLikeCount(StoryLikeVo param , HttpSession session) {
		
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		MemberVo sessionUser = (MemberVo)session.getAttribute("user");
		param.setMember_no(sessionUser.getNo());
		
		
		int myLikeCount = storyService.getMyStoryLikeCount(param);
		int totalLikeCount = storyService.getStoryTotalLikeCount(param.getStory_no());
		
		
		data.put("myLikeCount", myLikeCount);
		data.put("totalLikeCount", totalLikeCount);
		
		
		
		return data;
	}	
}
