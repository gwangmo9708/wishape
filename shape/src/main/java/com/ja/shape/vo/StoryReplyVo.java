package com.ja.shape.vo;

import java.util.Date;

public class StoryReplyVo {

	private int no;
	private int story_no;
	private int member_no;
	private String content;
	private Date write_date;
	
	public StoryReplyVo() {
		super();
	}
	
	public StoryReplyVo(int no, int story_no, int member_no, String content, Date write_date) {
		super();
		this.no = no;
		this.story_no = story_no;
		this.member_no = member_no;
		this.content = content;
		this.write_date = write_date;
	}
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public int getStory_no() {
		return story_no;
	}
	public void setStory_no(int story_no) {
		this.story_no = story_no;
	}
	public int getMember_no() {
		return member_no;
	}
	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getWrite_date() {
		return write_date;
	}
	public void setWrite_date(Date write_date) {
		this.write_date = write_date;
	}
	
	
	
	
}
