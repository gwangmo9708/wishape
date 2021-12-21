package com.ja.shape.freeboard.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ja.shape.freeboard.service.FreeBoardServiceImpl;
import com.ja.shape.vo.FreeBoardLikeVo;
import com.ja.shape.vo.FreeBoardReplyVo;
import com.ja.shape.vo.FreeBoardReplyWarningVo;
import com.ja.shape.vo.MemberVo;

@Controller
@RequestMapping("/freeboard/*")
@ResponseBody //rest api
public class FreeBoardRESTController {
	
	@Autowired
	private FreeBoardServiceImpl freeBoardService;

	//댓글신고
	@RequestMapping("doReplyWarning.do")
	public void replyWarningProcess(FreeBoardReplyWarningVo vo, HttpSession session ) {
	 
		MemberVo memberVo = (MemberVo) session.getAttribute("user");
		int member_no = memberVo.getNo();
		
		vo.setMember_no(member_no);
		freeBoardService.replyWarning(vo);
		
	}

	//댓글수정...하지만 미완임..
	@RequestMapping("doUpdateReply.do")
	 public void updateReplyProcess(FreeBoardReplyVo vo,HttpSession session) {
		MemberVo memberVo = (MemberVo) session.getAttribute("user");
		int member_no = memberVo.getNo();
		
		vo.setMember_no(member_no);
		freeBoardService.updateReply(vo);
		
	}
	
}
