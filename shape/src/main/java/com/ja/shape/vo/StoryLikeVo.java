package com.ja.shape.vo;

import java.util.Date;

public class StoryLikeVo {

	private int no;
	private int story_no;
	private int member_no;
	private Date click_date;
	public StoryLikeVo() {
		super();
	}
	public StoryLikeVo(int no, int story_no, int member_no, Date click_date) {
		super();
		this.no = no;
		this.story_no = story_no;
		this.member_no = member_no;
		this.click_date = click_date;
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
	public Date getClick_date() {
		return click_date;
	}
	public void setClick_date(Date click_date) {
		this.click_date = click_date;
	}
	
}
