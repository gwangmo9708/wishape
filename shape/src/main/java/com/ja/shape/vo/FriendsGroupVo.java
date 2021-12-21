package com.ja.shape.vo;

public class FriendsGroupVo {

	private int no;
	private int member_no;
	private String name;
	private String content;
	
	public FriendsGroupVo() {
		super();
	}
	
	public FriendsGroupVo(int no, int member_no, String name, String content) {
		super();
		this.no = no;
		this.member_no = member_no;
		this.name = name;
		this.content = content;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public int getMember_no() {
		return member_no;
	}

	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	
	
	
	
}
