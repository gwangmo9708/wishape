package com.ja.shape.vo;

import java.util.Date;

public class FreeBoardLikeVo {
   
	private int no;
	private int free_board_no;
	private int member_no;
	private Date click_date;
	
	public FreeBoardLikeVo() {
		super();
	}
	
	public FreeBoardLikeVo(int no, int free_board_no, int member_no, Date click_date) {
		super();
		this.no = no;
		this.free_board_no = free_board_no;
		this.member_no = member_no;
		this.click_date = click_date;
	}
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public int getFree_board_no() {
		return free_board_no;
	}
	public void setFree_board_no(int free_board_no) {
		this.free_board_no = free_board_no;
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
