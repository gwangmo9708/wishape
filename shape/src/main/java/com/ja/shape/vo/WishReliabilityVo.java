package com.ja.shape.vo;

import java.util.Date;

public class WishReliabilityVo {

	private int no;
	private int member_no;
	private int wish_run_no;
	private String good_bad;
	private Date click_date;
	
	public WishReliabilityVo() {
		// TODO Auto-generated constructor stub
	}

	public WishReliabilityVo(int no, int member_no, int wish_run_no, String good_bad, Date click_date) {
		super();
		this.no = no;
		this.member_no = member_no;
		this.wish_run_no = wish_run_no;
		this.good_bad = good_bad;
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

	public int getWish_run_no() {
		return wish_run_no;
	}

	public void setWish_run_no(int wish_run_no) {
		this.wish_run_no = wish_run_no;
	}

	public String getGood_bad() {
		return good_bad;
	}

	public void setGood_bad(String good_bad) {
		this.good_bad = good_bad;
	}

	public Date getClick_date() {
		return click_date;
	}

	public void setClick_date(Date click_date) {
		this.click_date = click_date;
	}

	
}


