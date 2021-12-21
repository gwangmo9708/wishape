package com.ja.shape.vo;

import java.util.Date;

public class QuestionVo {
	
	private int no;
	private int member_no; //외래키 - member테이블 참조
	private String content;
	private String private_check = "n";
	private Date write_date;
	
	public QuestionVo() {
		super();
	}

	public QuestionVo(int no, int member_no, String content, String private_check, Date write_date) {
		super();
		this.no = no;
		this.member_no = member_no;
		this.content = content;
		this.private_check = private_check;
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

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getPrivate_check() {
		return private_check;
	}

	public void setPrivate_check(String private_check) {
		this.private_check = private_check;
	}

	public Date getWrite_date() {
		return write_date;
	}

	public void setWrite_date(Date write_date) {
		this.write_date = write_date;
	}

	
}
