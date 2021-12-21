package com.ja.shape.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class WishLikeVo {

	private int no;
	private int member_no;
	private int wish_no;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date click_date;
	
	public WishLikeVo() {
		super();
	}

	public WishLikeVo(int no, int member_no, int wish_no, Date click_date) {
		super();
		this.no = no;
		this.member_no = member_no;
		this.wish_no = wish_no;
		this.click_date = click_date;
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

	public int getWish_no() {
		return wish_no;
	}

	public void setWish_no(int wish_no) {
		this.wish_no = wish_no;
	}

	public Date getClick_date() {
		return click_date;
	}

	public void setClick_date(Date click_date) {
		this.click_date = click_date;
	}
	
	
}
