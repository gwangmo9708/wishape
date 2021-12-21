package com.ja.shape.vo;

import java.util.Date;

public class QuestionImageVo {
	private int no;
	private int question_no;
	private String file_name;
	private String file_link;
	private Date upload_date;
	
	public QuestionImageVo() {
		super();
	}

	public QuestionImageVo(int no, int question_no, String file_name, String file_link, Date upload_date) {
		super();
		this.no = no;
		this.question_no = question_no;
		this.file_name = file_name;
		this.file_link = file_link;
		this.upload_date = upload_date;
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

	public String getFile_name() {
		return file_name;
	}

	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}

	public String getFile_link() {
		return file_link;
	}

	public void setFile_link(String file_link) {
		this.file_link = file_link;
	}

	public Date getUpload_date() {
		return upload_date;
	}

	public void setUpload_date(Date upload_date) {
		this.upload_date = upload_date;
	}
	
	
	
}
