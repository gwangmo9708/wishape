package com.ja.shape.vo;

import java.util.Date;

public class WishRunReplyVo {

	private int no;
	private int member_no;
	private int wish_run_no;
	private String content;
	private Date write_date;
	
	public WishRunReplyVo() {
		// TODO Auto-generated constructor stub
	}

	public WishRunReplyVo(int no, int member_no, int wish_run_no, String content, Date write_date) {
		super();
		this.no = no;
		this.member_no = member_no;
		this.wish_run_no = wish_run_no;
		this.content = content;
		this.write_date = write_date;
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

	public int getWish_run_no() {
		return wish_run_no;
	}

	public void setWish_run_no(int wish_run_no) {
		this.wish_run_no = wish_run_no;
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
