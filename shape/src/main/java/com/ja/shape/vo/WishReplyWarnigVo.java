package com.ja.shape.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class WishReplyWarnigVo {
	
	private int no;
	private int member_no;
	private int wish_reply_no;
	private String content;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date write_date;
	
	public WishReplyWarnigVo() {
		super();
	}

	public WishReplyWarnigVo(int no, int member_no, int wish_reply_no, String content, Date write_date) {
		super();
		this.no = no;
		this.member_no = member_no;
		this.wish_reply_no = wish_reply_no;
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

	public int getWish_reply_no() {
		return wish_reply_no;
	}

	public void setWish_reply_no(int wish_reply_no) {
		this.wish_reply_no = wish_reply_no;
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
