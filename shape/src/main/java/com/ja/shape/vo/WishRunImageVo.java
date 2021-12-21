package com.ja.shape.vo;

import java.util.Date;

public class WishRunImageVo {

	private int no;
	private int wish_run_no;
	private String file_name;
	private String file_link;
	private Date upload_date;
	
	public WishRunImageVo() {
		// TODO Auto-generated constructor stub
	}

	public WishRunImageVo(int no, int wish_run_no, String file_name, String file_link, Date upload_date) {
		super();
		this.no = no;
		this.wish_run_no = wish_run_no;
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

	public int getWish_run_no() {
		return wish_run_no;
	}

	public void setWish_run_no(int wish_run_no) {
		this.wish_run_no = wish_run_no;
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
