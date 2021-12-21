package com.ja.shape.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class FriendsVo {

	private int no;
	private int friends_group_no;
	private int member_no;
	private String content;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date friends_date;
	
	public FriendsVo() {
		super();
	}
	
	public FriendsVo(int no, int friends_group_no, int member_no, String content, Date friends_date) {
		super();
		this.no = no;
		this.friends_group_no = friends_group_no;
		this.member_no = member_no;
		this.content = content;
		this.friends_date = friends_date;
	}
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public int getFriends_group_no() {
		return friends_group_no;
	}
	public void setFriends_group_no(int friends_group_no) {
		this.friends_group_no = friends_group_no;
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
	public Date getFriends_date() {
		return friends_date;
	}
	public void setFriends_date(Date friends_date) {
		this.friends_date = friends_date;
	}
	
	
}
