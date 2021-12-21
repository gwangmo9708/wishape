package com.ja.shape.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class WishVo {

	private int no;
	private int member_no;
	private int small_category_no;
	private String title;
	private String content;
	private String access_option;
	private String plan_check;
	private int read_count;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date write_date;
	
	public WishVo() {
		super();
	}
	
	public WishVo(int no, int member_no, int small_category_no, String title, String content, String access_option,
			String plan_check, int read_count, Date write_date) {
		super();
		this.no = no;
		this.member_no = member_no;
		this.small_category_no = small_category_no;
		this.title = title;
		this.content = content;
		this.access_option = access_option;
		this.plan_check = plan_check;
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
	public int getSmall_category_no() {
		return small_category_no;
	}
	public void setSmall_category_no(int small_category_no) {
		this.small_category_no = small_category_no;
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
	public String getAccess_option() {
		return access_option;
	}
	public void setAccess_option(String access_option) {
		this.access_option = access_option;
	}
	public String getPlan_check() {
		return plan_check;
	}
	public void setPlan_check(String plan_check) {
		this.plan_check = plan_check;
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
