package com.ja.shape.vo;

import java.util.Date;

public class FreeBoardReplyVo {

	private int no;
	private int free_board_no;
	private int member_no;
	private String content;
	private Date write_date;
	
	public FreeBoardReplyVo() {
		super();
	}
	
	public FreeBoardReplyVo(int no, int free_board_no, int member_no, String content, Date write_date) {
		super();
		this.no = no;
		this.free_board_no = free_board_no;
		this.member_no = member_no;
		this.content = content;
		this.write_date = write_date;
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
