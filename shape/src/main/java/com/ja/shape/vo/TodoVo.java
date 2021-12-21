package com.ja.shape.vo;

public class TodoVo {

	private int no;
	private int wish_no;
	private String title;
	private String content;
	
	public TodoVo() {
		// TODO Auto-generated constructor stub
	}

	public TodoVo(int no, int wish_no, String title, String content) {
		super();
		this.no = no;
		this.wish_no = wish_no;
		this.title = title;
		this.content = content;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public int getWish_no() {
		return wish_no;
	}

	public void setWish_no(int wish_no) {
		this.wish_no = wish_no;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	

	
}
