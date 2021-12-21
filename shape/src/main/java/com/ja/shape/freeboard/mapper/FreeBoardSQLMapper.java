package com.ja.shape.freeboard.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.ja.shape.vo.FreeBoardImageVo;
import com.ja.shape.vo.FreeBoardLikeVo;
import com.ja.shape.vo.FreeBoardReplyVo;
import com.ja.shape.vo.FreeBoardReplyWarningVo;
import com.ja.shape.vo.FreeBoardVo;

public interface FreeBoardSQLMapper {

	public int createFreeBoardPK();

	//글쓰기
	public void writeContent(FreeBoardVo vo);
	
	//글목록
	public ArrayList<FreeBoardVo> getFreeBoardList(
			@Param("searchOptionFreeBoard") String searchOptionFreeBoard, 
			@Param("searchWordFreeBoard") String searchWordFreeBoard,
			@Param("fbPageNum") int fbPageNum
			);
	
	//검색용
	public int getTotalFreeBoardCount(
			@Param("searchOptionFreeBoard") String searchOptionFreeBoard, 
			@Param("searchWordFreeBoard") String searchWordFreeBoard
			);
	
	//글상세보기관련
	public FreeBoardVo getFreeBoardByNo(int no);
	
	//조회수
	public void increaseReadCount(int no);
	
	//삭제수정
    public void deleteByNo(int no);
    public void update(FreeBoardVo vo);
    
    //좋아요
    public void like(FreeBoardLikeVo vo);
    public void unLike(FreeBoardLikeVo vo);
    public int myLikeCount(FreeBoardLikeVo vo);
    public int totalLikeCount(int freeBoardNo);
    
    //이미지
    public void registerImage(FreeBoardImageVo vo);
    public ArrayList<FreeBoardImageVo> getFreeBoardImagesByBoardNo(int freeBoardNo);
    public void deleteImageByNo(int no);
    public int imageExist(int freeBoardNo);
    
    //댓글관련
    public int createFreeBoardReplyPK();
    public void writeReply(FreeBoardReplyVo vo);
    public ArrayList<FreeBoardReplyVo> getFreeBoardReplyByNo(int no);
    public void deleteReplyByNo(int no);
    public FreeBoardReplyVo getMyFreeBoardReplyVoByNo(int no);
    public void updateReply(FreeBoardReplyVo vo);
    public int totalReplyCount(int freeBoardNo);
  
    //댓글신고
    public void replyWarning(FreeBoardReplyWarningVo vo);
}
