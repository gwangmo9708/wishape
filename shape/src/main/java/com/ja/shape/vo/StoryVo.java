package com.ja.shape.vo;

import java.util.Date;

public class StoryVo {
	private int no;
	private int member_no;
	private String content;
	private String image_file_name;
	private String image_file_link;
	private Date write_date;
	public StoryVo() {
		super();
	}
	public StoryVo(int no, int member_no, String content, String image_file_name, String image_file_link,
			Date write_date) {
		super();
		this.no = no;
		this.member_no = member_no;
		this.content = content;
		this.image_file_name = image_file_name;
		this.image_file_link = image_file_link;
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
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getImage_file_name() {
		return image_file_name;
	}
	public void setImage_file_name(String image_file_name) {
		this.image_file_name = image_file_name;
	}
	public String getImage_file_link() {
		return image_file_link;
	}
	public void setImage_file_link(String image_file_link) {
		this.image_file_link = image_file_link;
	}
	public Date getWrite_date() {
		return write_date;
	}
	public void setWrite_date(Date write_date) {
		this.write_date = write_date;
	}
	
	
}
