package com.ja.shape.freeboard.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.commons.text.StringEscapeUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ja.shape.freeboard.mapper.FreeBoardSQLMapper;
import com.ja.shape.member.mapper.MemberSQLMapper;
import com.ja.shape.vo.FreeBoardImageVo;
import com.ja.shape.vo.FreeBoardLikeVo;
import com.ja.shape.vo.FreeBoardReplyVo;
import com.ja.shape.vo.FreeBoardReplyWarningVo;
import com.ja.shape.vo.FreeBoardVo;
import com.ja.shape.vo.MemberVo;

@Service
public class FreeBoardServiceImpl {
    
	@Autowired
	private FreeBoardSQLMapper freeBoardSQLMapper;
	@Autowired
	private MemberSQLMapper memberSQLMapper;
	
	//프리보드글작성
	public void writeContent(FreeBoardVo vo,ArrayList<FreeBoardImageVo> imageVoList) {
	   int free_board_no = freeBoardSQLMapper.createFreeBoardPK();
			vo.setNo(free_board_no);
			freeBoardSQLMapper.writeContent(vo);
			//이미지정보insert
			for(FreeBoardImageVo imageVo : imageVoList) {
				imageVo.setFree_board_no(free_board_no);
				freeBoardSQLMapper.registerImage(imageVo);
			}
		
	}
	
	//글목록,검색
	public ArrayList<HashMap<String, Object>> getFreeBoardList(String searchOptionFreeBoard,String searchWordFreeBoard,int fbPageNum,boolean escape){//,
		
		ArrayList<HashMap<String, Object>> list =
				new ArrayList<HashMap<String,Object>>();
		
		ArrayList<FreeBoardVo> freeBoardList = freeBoardSQLMapper.getFreeBoardList(searchOptionFreeBoard,searchWordFreeBoard,fbPageNum);
		for(FreeBoardVo freeBoardVo :freeBoardList) {
			 int member_no = freeBoardVo.getMember_no();
			 int freeBoardNo = freeBoardVo.getNo();
			 int totalReplyCount = freeBoardSQLMapper.totalReplyCount(freeBoardNo);
			 int  imageExist= freeBoardSQLMapper.imageExist(freeBoardNo);
			
			MemberVo memberVo =  memberSQLMapper.getMemberByNo(member_no);
			
			 if(escape) {
					String str1 =StringEscapeUtils.escapeHtml4(freeBoardVo.getTitle());
					str1 =str1.replaceAll("\n", "<br>");
					freeBoardVo.setTitle(str1);
					
				 }
				
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("memberVo", memberVo);
			map.put("freeBoardVo", freeBoardVo);
			map.put("totalReplyCount", totalReplyCount);
			map.put("imageExist", imageExist);
			
			list.add(map);
		}
		return list;
	}
	
	//검색관련
	public int getTotalFreeBoardCount(String searchOptionFreeBoard,String searchWordFreeBoard) {
		return freeBoardSQLMapper.getTotalFreeBoardCount(searchOptionFreeBoard, searchWordFreeBoard);
	}
	
	//작성글상세보기
	public HashMap<String, Object> getFreeBoard(int no, boolean escape){
		
		freeBoardSQLMapper.increaseReadCount(no);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		 FreeBoardVo freeBoardVo =freeBoardSQLMapper.getFreeBoardByNo(no);
		 int member_no=freeBoardVo.getMember_no();
		 int freeBoardNo = freeBoardVo.getNo();
		 int totalReplyCount=freeBoardSQLMapper.totalReplyCount(freeBoardNo);
		 MemberVo memberVo= memberSQLMapper.getMemberByNo(member_no);
		 
		 //html문법해당문자바꾸기
		 if(escape) {
			String str = StringEscapeUtils.escapeHtml4(freeBoardVo.getContent());
			str = str.replaceAll("\n","<br>");
			freeBoardVo.setContent(str);
			
			String str1 =StringEscapeUtils.escapeHtml4(freeBoardVo.getTitle());
			str1 =str1.replaceAll("\n", "<br>");
			freeBoardVo.setTitle(str1);
			
		 }
		
		 //image가져오기
		ArrayList<FreeBoardImageVo> imageVoList = 
				freeBoardSQLMapper.getFreeBoardImagesByBoardNo(no);
		 
		 map.put("memberVo", memberVo);
		 map.put("freeBoardVo", freeBoardVo);
		 map.put("imageVoList", imageVoList);
		 map.put("totalReplyCount", totalReplyCount);
		 
		return map ;
	}
	
	//글삭제
	public void deleteContent(int no) {
		freeBoardSQLMapper.deleteReplyByNo(no);
		freeBoardSQLMapper.deleteImageByNo(no);
		freeBoardSQLMapper.deleteByNo(no);
		
	}
	
	//글수정
	public void updateContent(FreeBoardVo vo) {
		freeBoardSQLMapper.update(vo);
	}
	
	//좋아요
	public void doLikeProcess(FreeBoardLikeVo vo) {
		
		int myCount =freeBoardSQLMapper.myLikeCount(vo);
		if(myCount>0) {
			freeBoardSQLMapper.unLike(vo);
		} else {
			freeBoardSQLMapper.like(vo);
		}
	}
	//전체좋아요
	public int getTotalLikeCount(int freeBoardNo) {
		return freeBoardSQLMapper.totalLikeCount(freeBoardNo);
	}
	//내가좋아요했나
	public int getMyLikeCount(FreeBoardLikeVo vo) {
		return freeBoardSQLMapper.myLikeCount(vo);
	}
	
	//댓글관련
	public void writeReply(FreeBoardReplyVo vo) {
		int free_board_reply_no =freeBoardSQLMapper.createFreeBoardReplyPK();
		vo.setNo(free_board_reply_no);
		freeBoardSQLMapper.writeReply(vo);
	}
			
	
	public ArrayList<HashMap<String, Object>> getFreeBoardReply(int no,boolean escape){
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
	
		 ArrayList<FreeBoardReplyVo> freeBoardReplyList =freeBoardSQLMapper.getFreeBoardReplyByNo(no);
		 for(FreeBoardReplyVo freeBoardReplyVo : freeBoardReplyList) {
			 int member_no = freeBoardReplyVo.getMember_no();
		     MemberVo memberVo= memberSQLMapper.getMemberByNo(member_no);
		 
	
			 if(escape) {
				String str1 = StringEscapeUtils.escapeHtml4(freeBoardReplyVo.getContent());
				str1 = str1.replaceAll("\n","<br>");
				freeBoardReplyVo.setContent(str1);
			 }
	     		HashMap<String, Object> map = new HashMap<String, Object>();
				map.put("memberVo", memberVo);
				map.put("freeBoardReplyVo", freeBoardReplyVo);
				list.add(map);
		}
		return list;
	
	}
	
	public FreeBoardReplyVo getMyFreeBoardReplyByNo(int no){
		
		return freeBoardSQLMapper.getMyFreeBoardReplyVoByNo(no);
	}
	
	public void deleteReply(int no) {
		freeBoardSQLMapper.deleteReplyByNo(no);
	}
	
	public void updateReply(FreeBoardReplyVo vo) {
		freeBoardSQLMapper.updateReply(vo);
	}
	
	public void replyWarning(FreeBoardReplyWarningVo vo) {
		freeBoardSQLMapper.replyWarning(vo);
	}
	
}
