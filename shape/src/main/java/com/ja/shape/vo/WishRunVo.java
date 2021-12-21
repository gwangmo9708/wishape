package com.ja.shape.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class WishRunVo {

	private int no;
	private int member_no;
	private int wish_no;
	private String content;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date start_date;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date end_date;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date quit_date;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date write_date;
	
	public WishRunVo() {
		// TODO Auto-generated constructor stub
	}

	public WishRunVo(int no, int member_no, int wish_no, String content, Date start_date, Date end_date, Date quit_date,
			Date write_date) {
		super();
		this.no = no;
		this.member_no = member_no;
		this.wish_no = wish_no;
		this.content = content;
		this.start_date = start_date;
		this.end_date = end_date;
		this.quit_date = quit_date;
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

	public int getWish_no() {
		return wish_no;
	}

	public void setWish_no(int wish_no) {
		this.wish_no = wish_no;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getStart_date() {
		return start_date;
	}

	public void setStart_date(Date start_date) {
		this.start_date = start_date;
	}

	public Date getEnd_date() {
		return end_date;
	}

	public void setEnd_date(Date end_date) {
		this.end_date = end_date;
	}

	public Date getQuit_date() {
		return quit_date;
	}

	public void setQuit_date(Date quit_date) {
		this.quit_date = quit_date;
	}

	public Date getWrite_date() {
		return write_date;
	}

	public void setWrite_date(Date write_date) {
		this.write_date = write_date;
	}
	
	
	

}
