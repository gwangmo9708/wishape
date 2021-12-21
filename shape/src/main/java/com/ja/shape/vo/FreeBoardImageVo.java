package com.ja.shape.vo;

import java.util.Date;

public class FreeBoardImageVo {

	private int no;
	private int free_board_no;
	private String file_name;
	private String file_link;
	private Date upload_date;
	
	public FreeBoardImageVo() {
		super();
	}
	
	public FreeBoardImageVo(int no, int free_board_no, String file_name, String file_link, Date upload_date) {
		super();
		this.no = no;
		this.free_board_no = free_board_no;
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
	public int getFree_board_no() {
		return free_board_no;
	}
	public void setFree_board_no(int free_board_no) {
		this.free_board_no = free_board_no;
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
