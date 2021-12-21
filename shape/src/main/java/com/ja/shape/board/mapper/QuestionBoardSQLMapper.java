package com.ja.shape.board.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.ja.shape.vo.QuestionImageVo;
import com.ja.shape.vo.QuestionReplyImageVo;
import com.ja.shape.vo.QuestionReplyVo;
import com.ja.shape.vo.QuestionVo;

public interface QuestionBoardSQLMapper {

	//질문 쓰기
	public void writeContentByVo(QuestionVo vo);
	
	//질문 리스트 불러오기
	public ArrayList<QuestionVo> getListByNo(
			@Param("searchQuestionOption") String searchQuestionOption, 
			@Param("searchQuestionWord")String searchQuestionWord,
			@Param("pageNum")int pageNum
			);
	
	//페이징
	public int getQuestionBoardCount(
			@Param("searchQuestionOption") String searchQuestionOption, 
			@Param("searchQuestionWord")String searchQuestionWord
			);
	
	//각 질문을 번호로 호출
	public QuestionVo getQuestionByNo(int no);
	
	//질문 답변 쓰기
	public void writeReplyByVo(QuestionReplyVo vo);
	
	//질문 답변 번호로 불러오기
	public QuestionReplyVo getReplyByNo(int no);
	
	//질문 답변 번호로 불러오기
	public QuestionReplyVo getReplyByQuestionNo(int question_no);

	//유저가 질문 지우기 
	public void deleteQuestionByNo(int question_no);
	
	//질문과 같이 지워지는 답변
	public void deleteReplyWithQuestion(int question_no);
	
	//질문 수정
	public void updateQuestionByNo(QuestionVo vo);
	
	//답변 지우기
	public void deleteReplyByNo(int no);
	
	//question 이미지 등록
	public void registerQuestionImage(QuestionImageVo vo);
	
	//question 이미지 불러오기
	public ArrayList<QuestionImageVo> getQuestionImageByQuestionNo(int question_no);
	
	//questionNo 뜯어내기
	public int createQuestionNoForImageVo();
	
	//question 이미지 지우기
	public void deleteQuestionImageByNo(int question_no);
	
	//question reply 이미지 등록
	public void registerReplyImage(QuestionReplyImageVo vo);
	
	//question reply 이미지 불러오기
	public ArrayList<QuestionReplyImageVo> getReplyImageByReplyNo(int question_reply_no);
	
	//questionReplyNo 뜯어내기
	public int createReplyNoForImageVo();
	
	//question reply 이미지 지우기/ 댓글과 함께
	public void deleteReplyImageByNo(int question_reply_no);
	
	//reply 수 세기
	public int countReplyByQuestionNo(int question_no);
	
	//이미지 수 세기
	public int imageExistance(int question_no);
	
	
	
}
