package com.ja.shape.board.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.commons.text.StringEscapeUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ja.shape.board.mapper.QuestionBoardSQLMapper;
import com.ja.shape.member.mapper.MemberSQLMapper;
import com.ja.shape.vo.MemberVo;
import com.ja.shape.vo.QuestionImageVo;
import com.ja.shape.vo.QuestionReplyImageVo;
import com.ja.shape.vo.QuestionReplyVo;
import com.ja.shape.vo.QuestionVo;

@Service
public class QuestionBoardServiceImpl {

	@Autowired
	private QuestionBoardSQLMapper questionBoardSQLMapper;
	@Autowired
	private MemberSQLMapper memberSQLMapper;
	
	
	//질문 쓰기
	public void writeContentByVo(QuestionVo vo, ArrayList<QuestionImageVo> imageVoList ) {
		//question_no를 따로 떼내서 no로 넣기
		int question_no = questionBoardSQLMapper.createQuestionNoForImageVo();
		vo.setNo(question_no);
		questionBoardSQLMapper.writeContentByVo(vo);
				
		//이미지 정보 insert
		for(QuestionImageVo imageVo :imageVoList) {
			imageVo.setQuestion_no(question_no);
			questionBoardSQLMapper.registerQuestionImage(imageVo);
		}
		
	}
	
	
	//질문 리스트 불러오기
	public ArrayList<HashMap<String, Object>> getListByNo(String searchQuestionOption, String searchQuestionWord, int pageNum){
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
		
		ArrayList<QuestionVo> questionList = questionBoardSQLMapper.getListByNo(searchQuestionOption, searchQuestionWord, pageNum); //SELECT * FROM question ORDER BY no DESC;
		
		
		for(QuestionVo questionVo : questionList) {
			int member_no = questionVo.getMember_no();
			int question_no = questionVo.getNo();
			
			MemberVo memberVo = memberSQLMapper.getMemberByNo(member_no);  //SELECT * FROM member WHERE member_no = ?;
			int replyCount = questionBoardSQLMapper.countReplyByQuestionNo(question_no);
			int countImage = questionBoardSQLMapper.imageExistance(question_no);
			
			System.out.println();
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("memberVo", memberVo);
			map.put("questionVo", questionVo);
			map.put("replyCount", replyCount);
			map.put("countImage", countImage);
			
			list.add(map);
		}
		
		return list;
	}
	
	//페이징
	public int getQuestionBoardCount(String searchQuestionOption, String searchQuestionWord) {
		return questionBoardSQLMapper.getQuestionBoardCount(searchQuestionOption, searchQuestionWord);
	}
	
	
	//각 질문을 번호로 호출
	public HashMap<String, Object> getQuestionByNo(int no, boolean escape){
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		QuestionVo questionVo = questionBoardSQLMapper.getQuestionByNo(no);
		MemberVo memberVo = memberSQLMapper.getMemberByNo(questionVo.getMember_no());
		
		//html escape
		if(escape) {
			String str = StringEscapeUtils.escapeHtml4(questionVo.getContent());
			//줄 바꿈 엔터 설정
			str = str.replaceAll("\n", "<br>");
			questionVo.setContent(str);
		}
		
		//이미지 리스트
		ArrayList<QuestionImageVo> imageVoList = questionBoardSQLMapper.getQuestionImageByQuestionNo(no);
		
		map.put("questionVo", questionVo);
		map.put("memberVo", memberVo);
		map.put("imageVoList", imageVoList);
		
		return map;
	}
	
	//질문 답변 쓰기
	public void writeReplyByVo(QuestionReplyVo vo, ArrayList<QuestionReplyImageVo> vo2) {
		
		int reply_pk = questionBoardSQLMapper.createReplyNoForImageVo();
		vo.setNo(reply_pk);
		questionBoardSQLMapper.writeReplyByVo(vo);
		
		for(QuestionReplyImageVo imageVo :vo2) {
			imageVo.setQuestion_reply_no(reply_pk);
			questionBoardSQLMapper.registerReplyImage(imageVo);
		}
		
		
	}
	
	//질문 답변 번호로 불러오기
	public HashMap<String, Object> getReplyByNo(int question_no, boolean escape){
		HashMap<String, Object> map2 = new HashMap<String, Object>();
		
		QuestionVo questionVo = questionBoardSQLMapper.getQuestionByNo(question_no);
		QuestionReplyVo questionReplyVo = questionBoardSQLMapper.getReplyByQuestionNo(questionVo.getNo());
		
		//html escape
		if(escape && questionReplyVo != null) {
			
			String str = StringEscapeUtils.escapeHtml4(questionReplyVo.getContent());
			//줄 바꿈 엔터 설정
			str = str.replaceAll("\n", "<br>");
			questionReplyVo.setContent(str);
		}
		 
		//답글이 없으면....이미지가...안되니까? 영문을 모르겠...
		if( questionReplyVo != null ) {
			int question_reply_no = questionReplyVo.getNo();
			ArrayList<QuestionReplyImageVo> imageVoList = questionBoardSQLMapper.getReplyImageByReplyNo(question_reply_no);
			map2.put("imageVoList", imageVoList);
		}
		

		//이미지 리스트
		map2.put("questionVo", questionVo);
		map2.put("questionReplyVo", questionReplyVo);
		
		
		return map2;
		
	}
	
	
	//유저가 질문 지우기 
	public void deleteQuestion(int question_no) {
		
		questionBoardSQLMapper.deleteReplyWithQuestion(question_no);
		questionBoardSQLMapper.deleteQuestionImageByNo(question_no);
		questionBoardSQLMapper.deleteQuestionByNo(question_no);
		
	}
	
	
	//질문 수정
	public void updateQuestion(QuestionVo vo) {
		questionBoardSQLMapper.updateQuestionByNo(vo);
		
	}
	
	//답변 지우기
	public void deleteReply(int no) {
		
		QuestionReplyVo questionReplyVo = questionBoardSQLMapper.getReplyByNo(no);
		int question_reply_no = questionReplyVo.getNo();
		
		questionBoardSQLMapper.deleteReplyImageByNo(question_reply_no);
		questionBoardSQLMapper.deleteReplyByNo(no);
		
	}
	
	
}
