package com.ja.shape.vo;

import java.util.Date;

public class MessageVo {

	private int no;
	private int from_member_no;
	private int to_member_no;
	private String content;
	private String read_check ="n";
	private String delete_check="n";
	private Date write_date;
	
	public MessageVo() {
		// TODO Auto-generated constructor stub
	}

	public MessageVo(int no, int from_member_no, int to_member_no, String content, String read_check,
			String delete_check, Date write_date) {
		super();
		this.no = no;
		this.from_member_no = from_member_no;
		this.to_member_no = to_member_no;
		this.content = content;
		this.read_check = read_check;
		this.delete_check = delete_check;
		this.write_date = write_date;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public int getFrom_member_no() {
		return from_member_no;
	}

	public void setFrom_member_no(int from_member_no) {
		this.from_member_no = from_member_no;
	}

	public int getTo_member_no() {
		return to_member_no;
	}

	public void setTo_member_no(int to_member_no) {
		this.to_member_no = to_member_no;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getRead_check() {
		return read_check;
	}

	public void setRead_check(String read_check) {
		this.read_check = read_check;
	}

	public String getDelete_check() {
		return delete_check;
	}

	public void setDelete_check(String delete_check) {
		this.delete_check = delete_check;
	}

	public Date getWrite_date() {
		return write_date;
	}

	public void setWrite_date(Date write_date) {
		this.write_date = write_date;
	}
	
}
