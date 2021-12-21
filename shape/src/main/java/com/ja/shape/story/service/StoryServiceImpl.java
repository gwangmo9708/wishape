package com.ja.shape.story.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.commons.text.StringEscapeUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ja.shape.member.mapper.MemberSQLMapper;
import com.ja.shape.story.mapper.StorySQLMapper;
import com.ja.shape.vo.FriendsVo;
import com.ja.shape.vo.MemberVo;
import com.ja.shape.vo.StoryLikeVo;
import com.ja.shape.vo.StoryReplyVo;
import com.ja.shape.vo.StoryVo;
import com.ja.shape.vo.WishVo;

@Service
public class StoryServiceImpl {
    
	@Autowired
	private StorySQLMapper storySQLMapper;
	
	@Autowired
	private MemberSQLMapper memberSQLMapper; 
	
      public void writeStory(StoryVo vo) {
		
		storySQLMapper.writeStoryByVo(vo);
		
		String image_file_link = vo.getImage_file_link();
		vo.setImage_file_link(image_file_link);
		
      	}
      
      public ArrayList<HashMap<String, Object>> getStoryList(int sessionMemberNo,boolean escape) {
  		
  		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
  		
  		ArrayList<StoryVo> storyList = storySQLMapper.getStoryList(sessionMemberNo);
  		
  		for(StoryVo storyVo : storyList) {
  			int member_no = storyVo.getMember_no();
  			int story_no = storyVo.getNo();
  			
  			MemberVo memberVo = memberSQLMapper.getMemberByNo(member_no);
  			String imagelink = storyVo.getImage_file_link();
  			int countStoryImage = storySQLMapper.countStoryImage(story_no);
  			
  			// story_reply List 넣기.
  			int storyNo = storyVo.getNo();
  			 
  			ArrayList<HashMap<String, Object>> storyReplyMemberList = new ArrayList<>();
  			ArrayList<StoryReplyVo> storyReplyList = storySQLMapper.getStoryReplyByNo(storyNo);
  			
  			for(StoryReplyVo storyReplyVo : storyReplyList ) {
  				
  				HashMap<String,Object> map = new HashMap<String, Object>();
  				
  				int memberNo =  storyReplyVo.getMember_no();
  				
  				MemberVo replyMemberVo = memberSQLMapper.getMemberByNo(memberNo);
  				
  				map.put("replyMemberVo", replyMemberVo);
  				map.put("storyReplyVo",storyReplyVo);
  				
  				storyReplyMemberList.add(map);
  				
  			}
  			
  			
  			HashMap<String, Object> map = new HashMap<String, Object>();
  			map.put("memberVo", memberVo);
  			map.put("storyVo", storyVo);
  			
  			map.put("imagelink", imagelink);
  			map.put("countStoryImage", countStoryImage);
  			map.put("storyReplyMemberList", storyReplyMemberList);
  			
  			
  			StoryLikeVo storyLikeVo = new StoryLikeVo();
  			storyLikeVo.setMember_no(sessionMemberNo);
  			storyLikeVo.setStory_no(storyNo);
  			
  			
  			int myCount = storySQLMapper.myStoryLikeCount(storyLikeVo);
  			int totalCount=storySQLMapper.totalStoryLikeCount(storyNo);
  			map.put("myStoryLikeCount", myCount);
  			map.put("totalStoryLikeCount",totalCount);
  			
  			list.add(map);
  			
  		
  			//html escape
  			if(escape) {
  				String str = StringEscapeUtils.escapeHtml4(storyVo.getContent());
  				//줄 바꿈 엔터 설정
  				str = str.replaceAll("\n", "<br>");
  				storyVo.setContent(str);
  			}
  		}
  		return list;
  	}
      
    //좋아요기능 
      public void storyLikeProcess(StoryLikeVo vo) {
     	 int myStoryLikeCount=storySQLMapper.myStoryLikeCount(vo);
     	 if(myStoryLikeCount>0) {
     		 storySQLMapper.storyUnlike(vo);
     	 }else {
     		 storySQLMapper.storyLike(vo);
     	 }
      }
      
      public int getMyStoryLikeCount(StoryLikeVo vo) {
     	 return storySQLMapper.myStoryLikeCount(vo);
      }
      
      public int getStoryTotalLikeCount(int story_no) {
     	 return storySQLMapper.totalStoryLikeCount(story_no);
      }
      
	/*
	 * public HashMap<String, Object> getStory(int no){
	 * 
	 * HashMap<String, Object> map = new HashMap<String, Object>();
	 * 
	 * StoryVo storyVo =storySQLMapper.getStoryByNo(no); StoryVo imagelink
	 * =storySQLMapper.getImageFileLinkByNo(no); int member_no =
	 * storyVo.getMember_no(); MemberVo memberVo =
	 * memberSQLMapper.getMemberByNo(member_no);
	 * 
	 * 
	 * map.put("storyVo", storyVo); map.put("memberVo", memberVo);
	 * map.put("imagelink", imagelink);
	 * 
	 * return map;
	 * 
	 * }
	 */
  	
    //스토리 댓글쓰기 
    public void writeStoryReplyByVo(StoryReplyVo vo) {
    	storySQLMapper.writeStoryReplyByVo(vo);
    }
      
    public ArrayList<HashMap<String, Object>> getStoryReplyList(int story_no, boolean escape){
    	ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
    	
    	ArrayList<StoryReplyVo> storyReplyList = storySQLMapper.getStoryReplyList(story_no);
    	for(StoryReplyVo storyReplyVo : storyReplyList) {
    		int member_no =storyReplyVo.getMember_no(); 
    	    MemberVo memberVo=memberSQLMapper.getMemberByNo(member_no);
    		
    	
    		HashMap<String, Object> map = new HashMap<String, Object>();
        	map.put("memberVo", memberVo);
        	map.put("storyReplyVo", storyReplyVo);
        	
        	list.add(map);
        	
    	}
    	return list;
    }
    
	/*
	 * public HashMap<String, Object> getStoryReplyByNo(int story_no) {
	 * HashMap<String, Object> map2 = new HashMap<String, Object>(); StoryVo storyVo
	 * =storySQLMapper.getStoryByNo(story_no); StoryReplyVo
	 * storyReplyVo=storySQLMapper.getStoryReplyByNo(storyVo.getNo());
	 * 
	 * map2.put("storyVo", storyVo); map2.put("storyReplyVo", storyReplyVo); return
	 * map2; }
	 */
      
      
    
    //스토리 & 댓글 한번에 지우기
    public void deleteStory(int story_no) {
    	
    	storySQLMapper.deleteStoryReplyWithStory(story_no);
    	storySQLMapper.deleteStoryByNo(story_no);
    }
    
    //댓글 지우기
    public void deleteStoryReply(int reply_no) {
    	storySQLMapper.deleteStoryReplyByNo(reply_no);
    }
    
    
    //스토리 수정
    public void updateStory(StoryVo vo) {
    	storySQLMapper.updateStoryByNo(vo);
    }
    
    
 
    //프로필 스토리 리스트
    public ArrayList<HashMap<String, Object>> getProfileStoryList(int memberNo){
    	ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
    	
    	ArrayList<StoryVo> profileStoryList = storySQLMapper.getProfileStoryListByNo(memberNo);
    	
    	for(StoryVo storyVo : profileStoryList) {
  			int member_no = storyVo.getMember_no();
  			int story_no = storyVo.getNo();
  			
  			MemberVo memberVo = memberSQLMapper.getMemberByNo(member_no);
  			String imagelink = storyVo.getImage_file_link();
  			int countStoryImage = storySQLMapper.countStoryImage(story_no);
  			
  			// story_reply List 넣기.
  			int storyNo = storyVo.getNo();
  			 
  			ArrayList<HashMap<String, Object>> storyReplyMemberList = new ArrayList<>();
  			ArrayList<StoryReplyVo> storyReplyList = storySQLMapper.getStoryReplyByNo(storyNo);
  			
  			for(StoryReplyVo storyReplyVo : storyReplyList ) {
  				
  				HashMap<String,Object> map = new HashMap<String, Object>();
  				
  				int memberNoReply =  storyReplyVo.getMember_no();
  				
  				MemberVo replyMemberVo = memberSQLMapper.getMemberByNo(memberNoReply);
  				
  				map.put("replyMemberVo", replyMemberVo);
  				map.put("storyReplyVo",storyReplyVo);
  				
  				storyReplyMemberList.add(map);
  				
  			}
  			
  			
  			HashMap<String, Object> map = new HashMap<String, Object>();
  			map.put("memberVo", memberVo);
  			map.put("storyVo", storyVo);
  			
  			map.put("imagelink", imagelink);
  			map.put("countStoryImage", countStoryImage);
  			map.put("storyReplyMemberList", storyReplyMemberList);
  			
  			
  			StoryLikeVo storyLikeVo = new StoryLikeVo();
  			storyLikeVo.setMember_no(memberNo);
  			storyLikeVo.setStory_no(storyNo);
  			
  			
  			int myCount = storySQLMapper.myStoryLikeCount(storyLikeVo);
  			int totalCount=storySQLMapper.totalStoryLikeCount(storyNo);
  			map.put("myStoryLikeCount", myCount);
  			map.put("totalStoryLikeCount",totalCount);
  			
  			list.add(map);
  			
  		}
  		
  		return list;
    }
    
    //프로필 위시 리스트
    public ArrayList<HashMap<String, Object>> getWishListInStory(int member_no, int user_no){
    	ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
    	
    	ArrayList<WishVo> wishListInStory =  storySQLMapper.getWishListInStoryByNo(member_no, user_no);
    	
    	for(WishVo wishVo : wishListInStory) {
    		int memberNo = wishVo.getMember_no();
    		
    		MemberVo memberVo = memberSQLMapper.getMemberByNo(memberNo);
    		
    		HashMap<String, Object> map = new HashMap<String, Object>();
    		map.put("memberVo", memberVo);
    		map.put("wishVo", wishVo);
    		
    		list.add(map);
    	}
    	
    	
    	
    	return list;
    }
    
    
    
    
    
      
      
}
