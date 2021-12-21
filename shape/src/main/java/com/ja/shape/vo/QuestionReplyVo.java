package com.ja.shape.vo;

import java.sql.Date;

public class QuestionReplyVo {
	private int no;
	private int question_no;	//외래키 
	private String content;
	private Date write_date;
	
	public QuestionReplyVo() {
		super();
	}

	public QuestionReplyVo(int no, int question_no, String content, Date write_date) {
		super();
		this.no = no;
		this.question_no = question_no;
		this.content = content;
		this.write_date = write_date;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public int getQuestion_no() {
		return question_no;
	}

	public void setQuestion_no(int question_no) {
		this.question_no = question_no;
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
