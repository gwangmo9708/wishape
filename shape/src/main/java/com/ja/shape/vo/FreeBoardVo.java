package com.ja.shape.vo;

import java.util.Date;

public class FreeBoardVo {

	private int no;
	private int member_no;
	private String title;
	private String content;
	private int read_count;
	private Date write_date;
	
	public FreeBoardVo() {
		super();
	}
	
	public FreeBoardVo(int no, int member_no, String title, String content, int read_count, Date write_date) {
		super();
		this.no = no;
		this.member_no = member_no;
		this.title = title;
		this.content = content;
		this.read_count = read_count;
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
	public int getRead_count() {
		return read_count;
	}
	public void setRead_count(int read_count) {
		this.read_count = read_count;
	}
	public Date getWrite_date() {
		return write_date;
	}
	public void setWrite_date(Date write_date) {
		this.write_date = write_date;
	}
	
	
}
