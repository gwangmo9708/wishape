package com.ja.shape.member.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ja.shape.member.service.MemberServiceImpl;
import com.ja.shape.vo.BigCategoryVo;
import com.ja.shape.vo.FriendsGroupVo;
import com.ja.shape.vo.FriendsVo;
import com.ja.shape.vo.MemberCategoryVo;
import com.ja.shape.vo.MemberVo;
import com.ja.shape.vo.MessageVo;
import com.ja.shape.vo.SmallCategoryVo;

@Controller
@RequestMapping("/member/")
public class MemberController {
	
	@Autowired
	private MemberServiceImpl memberService;
	
	
	// 로그인 페이지.
	@RequestMapping("login.do")
	public String login() {
		
		return "/member/login";
		
	}
	
	// 로그인 프로세스.
	@RequestMapping("loginProcess.do")
	public String loginProcess(MemberVo vo, HttpSession session) {
		
		MemberVo user = memberService.login(vo);
		session.setAttribute("user", user);
		return "redirect: ../wish/index.do";
	}
	
	// 회원가입 페이지.
	@RequestMapping("joinMember.do")
	public String joinMember(Model model) {

		// 대분류
		ArrayList<BigCategoryVo> bigList = memberService.getBigCategoryVoList();
		model.addAttribute("bigList", bigList);
		// 소분류
		ArrayList<SmallCategoryVo> smallList = memberService.getSmallCategoryVoList();
		model.addAttribute("smallList", smallList);
		
		return "/member/joinMember";
	}
	
	// 회원가입 프로세스.
	@RequestMapping("joinMemberProcess.do")
	public String joinMemberProcess(MemberVo memberVo, MemberCategoryVo memberCategoryVo) {
		
		memberService.joinMember(memberVo, memberCategoryVo);
		return "/member/joinMemberProcess";
		
	}
	
	//로그아웃
	@RequestMapping("logout.do")
	public String logout(HttpSession session, HttpServletRequest request) {
      
		String referer = (String)request.getHeader("REFERER");
		System.out.println(referer);
		String path_ = referer.substring(referer.lastIndexOf("/shape/")+6);

		System.out.println(path_);

		session.invalidate();
      
		return "redirect:.."+path_;
	}
	
	
	
	
	
	
	// 친구 관련... (슬기형)
	@RequestMapping("friends.do")
	public String friends(Model model,HttpSession session,String searchWord) {
	      if(session.getAttribute("user") == null) {
	          return "redirect:/member/login.do";
	       }
		
		MemberVo memberVo = (MemberVo) session.getAttribute("user");				
				
		int member_no=memberVo.getNo();
				
		ArrayList<HashMap<String, Object>> member_list = memberService.getFriendsByMember(member_no,searchWord);
		model.addAttribute("member_list", member_list);
						
		ArrayList<HashMap<String, Object>> friends_list = memberService.getFriendsByNo(member_no);
		model.addAttribute("friends_list", friends_list);
				
		return "/member/friends";
		
	}
	
	@RequestMapping("addFriends.do")
	public String createFriends(HttpSession session, Model model, int no) {
	      if(session.getAttribute("user") == null) {
	          return "redirect:/member/login.do";
	       }
		
		MemberVo memberVo =(MemberVo) session.getAttribute("user");
		int member_no =memberVo.getNo(); // 내 member_no. 
		
		model.addAttribute("member_no", no);
		
		ArrayList<FriendsGroupVo> FG = memberService.getFriendsGroupByNo(member_no);
		model.addAttribute("FG", FG);
		
		
		return "/member/addFriends";
	}
	
	@RequestMapping("friendsProcess.do")
	public String friendsProcess(FriendsVo vo) {
		
		memberService.insertFriends(vo);
		
		return "redirect:../member/friends.do";
		
	}
	@RequestMapping("deleteFriends.do")
	public String deleteFriends(int member_no) {
						
		memberService.deleteFriendsList(member_no);
		
		return "redirect:../member/friends.do";
	}
	@RequestMapping("addFriendsGroup.do")
	public String createFriendsGroup(HttpSession session,Model model) {
		
	      if(session.getAttribute("user") == null) {
	          return "redirect:/member/login.do";
	       }
		
		MemberVo memberVo = (MemberVo) session.getAttribute("user");				
		int member_no=memberVo.getNo();
										
		ArrayList<FriendsGroupVo> FG = memberService.getFriendsGroupByNo(member_no);
		model.addAttribute("FG", FG);
						
		return "/member/addFriendsGroup";
		
	}
	@RequestMapping("groupProcess.do")
	public String groupProcess(FriendsGroupVo vo,HttpSession session) {
	      if(session.getAttribute("user") == null) {
	          return "redirect:/member/login.do";
	       }
		
		MemberVo memberVo = (MemberVo) session.getAttribute("user");				
		int member_no=memberVo.getNo();
		vo.setMember_no(member_no);
		
		memberService.insertFriendsGroup(vo);
		
		return "redirect:../member/addFriendsGroup.do";
	}
	
	@RequestMapping("updateFriendsGroup.do")
	public String updateGroup(HttpSession session, Model model) {
	      if(session.getAttribute("user") == null) {
	          return "redirect:/member/login.do";
	       }
		
		MemberVo memberVo = (MemberVo) session.getAttribute("user");				
		int member_no=memberVo.getNo();
		
		ArrayList<FriendsGroupVo> UpFG = memberService.getFriendsGroupByNo(member_no);
		model.addAttribute("UpFG", UpFG);
		
				
		return "/member/updateFriendsGroup";
		
	}
	@RequestMapping("updateGroupProcess.do")
	public String updateGroupProcess(FriendsGroupVo param) {
				
		memberService.updateFriendsGroup(param);
		
		return "redirect:../member/updateFriendsGroup.do";
		
	}
	@RequestMapping("updateFriendsMove.do")
	public String updateFriendsMove(int no,HttpSession session,Model model) {
	      
		if(session.getAttribute("user") == null) {
	          return "redirect:/member/login.do";
	       }		
		
		MemberVo memberVo = (MemberVo) session.getAttribute("user");
		int memberNo = memberVo.getNo();
		
		HashMap<String,Object> map = memberService.getFriends(no,memberNo);
		model.addAttribute("map", map);
		
		ArrayList<FriendsGroupVo> FriendsGroupList = memberService.getFriendsGroupByNo(memberNo);
		model.addAttribute("FriendsGroupList", FriendsGroupList);
		
		return "/member/updateFriendsMove";
	}
	
	@RequestMapping("updateFriendsMoveProcess.do")
	public String updateFriendsMoveProcess(FriendsVo vo) {
		
		memberService.updateFriendsMove(vo);
		
		return "redirect:../member/updateFriendsMove.do?no="+vo.getNo();
		
	}

	@RequestMapping("updateFriendsToProcess.do")
	public String updateFriendsGroupToDefault(int friends_group_no,HttpSession session) {
		
	      if(session.getAttribute("user") == null) {
	          return "redirect:/member/login.do";
	       }
		
		MemberVo memberVo = (MemberVo) session.getAttribute("user");
		int memberNo = memberVo.getNo();
				
		int friendsGroupNo = memberService.selectFriendsGroupByMemberNo(memberNo);
		
		memberService.updateFriendsToDefault(friends_group_no,friendsGroupNo);
		
		memberService.deleteFriendsGroup(friends_group_no);
		
		return "redirect:../member/friends.do";
		
	}
		
	//메시지 관련
	@RequestMapping("message.do")
	public String message(Model model,HttpSession session, String searchWord,@RequestParam(defaultValue = "1") int pageNum) {
				
		 if(session.getAttribute("user") == null) {
	          return "redirect:/member/login.do";
	       }
		
		MemberVo memberVo = (MemberVo) session.getAttribute("user");
		int memberNo = memberVo.getNo();				
		
		ArrayList<MemberVo> members = memberService.getMembersAll(searchWord,pageNum);
		
		int totalMemberCount = memberService.selectMemberTotalCount(searchWord);
		int totalPageCount = totalMemberCount/10;
		
		if(totalMemberCount%10 != 0) {
			totalPageCount++;
		}
		int beginPageNumber = ((pageNum-1)/5)*5 + 1;
		int endPageNumber = ((pageNum-1)/5 + 1)*(5);
		
		if(endPageNumber > totalPageCount) {
			endPageNumber = totalPageCount;
		}
		String addParams = "";
		if(searchWord != null) {
			addParams += "&searchWord=" + searchWord;
		}
		
		model.addAttribute("members", members);
		model.addAttribute("totalPageCount", totalPageCount);
		model.addAttribute("pageNum", pageNum);//현재 페이지
		model.addAttribute("beginPageNumber", beginPageNumber);
		model.addAttribute("endPageNumber", endPageNumber);
		model.addAttribute("addParams", addParams);
		
		ArrayList<HashMap<String, Object>> toList = memberService.getMessageToNo(memberNo,true);
		model.addAttribute("toList", toList);
		
	return "/member/message";
		
	}
	@RequestMapping("sendMessage.do")
	public String sendMessage(Model model,int no) {
				
		HashMap<String, Object> map =  memberService.getToMember(no);
		model.addAttribute("map", map);
		
		return "/member/sendMessage";
	}
	@RequestMapping("sendMessageProcess.do")
	public String sendMessageProcess(MessageVo vo) {
		
		memberService.insertMessage(vo);
		
		return "redirect:../member/message.do";
	}
	//내가 받는거
	@RequestMapping("receivedMessage.do")
	public String receivedMessage(HttpSession session,Model model) {
		
	      if(session.getAttribute("user") == null) {
	          return "redirect:/member/login.do";
	       }
		
		MemberVo memberVo = (MemberVo) session.getAttribute("user");
		int memberNo = memberVo.getNo();
		
		ArrayList<HashMap<String, Object>> toList = memberService.getMessageToNo(memberNo,true);
		model.addAttribute("toList", toList);
				
		memberService.updateReadCheck(memberNo);
				
		return "./member/receivedMessage";
		
	}
	@RequestMapping("deleteReceivedMessage.do")
	public String deleteReceivedMessage(int no) {
								
		memberService.updateDeleteCheckMessage(no);
		
		return "redirect:../member/receivedMessage.do";
		
	}
	   
	   
	   
		
	   
}






