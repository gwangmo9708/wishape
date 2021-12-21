package com.ja.shape.story.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.ja.shape.vo.FriendsVo;
import com.ja.shape.vo.StoryLikeVo;
import com.ja.shape.vo.StoryReplyVo;
import com.ja.shape.vo.StoryVo;
import com.ja.shape.vo.WishVo;

public interface StorySQLMapper {
	    //스토리 쓰기
		public void writeStoryByVo(StoryVo vo);
		
		//스토리 리스트 불러오기
		public ArrayList<StoryVo> getStoryList(int member_no);
		
		// 스토리 불러오기
		public StoryVo getStoryByNo(int no);
		
		//스토리 이미지 불러오기
		public StoryVo getImageFileLinkByNo(int no);
		
		//스토리 댓글쓰기
		public void writeStoryReplyByVo(StoryReplyVo vo);
		
		//스토리 댓글 리스트로 불러오기
		public  ArrayList<StoryReplyVo> getStoryReplyList(int story_no);
		
		//스토리 댓글 번호로 불러오기
		public ArrayList<StoryReplyVo> getStoryReplyByNo(int story_no);
		
		
		//스토리 삭제
		public void deleteStoryByNo(int no);
		
		//스토리와 같이 지워지는 댓글
		public void deleteStoryReplyWithStory(int story_no);
		
		//스토리 댓글 삭제
		public void deleteStoryReplyByNo(int no);
		
		
		
		//스토리 좋아요
		public void storyLike(StoryLikeVo vo);
		//스토리 좋아요취소
		public void storyUnlike(StoryLikeVo vo);
		//내가 스토리에 좋아요를 눌럿나
		public int myStoryLikeCount(StoryLikeVo vo);
		//스토리 총 좋아요개수
		public int totalStoryLikeCount(int story_no);
		
		
		//스토리 수정
		public void updateStoryByNo(StoryVo vo);
		
		//스토리 이미지 갯수
		public int countStoryImage(int story_no);
		
		
		//프로필 페이지 스토리 리스트
		public ArrayList<StoryVo> getProfileStoryListByNo(int member_no);
		
		//프로필 페이지 위시 리스트
				public ArrayList<WishVo> getWishListInStoryByNo(
						@Param("member_no")int member_no, 
						@Param("user_no")int user_no);
				
		
		

}


