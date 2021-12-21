package com.ja.shape.vo;

public class SmallCategoryVo {

	private int no;
	private int big_category_no;
	private String small_name;
	
	public SmallCategoryVo() {
		// TODO Auto-generated constructor stub
	}

	public SmallCategoryVo(int no, int big_category_no, String small_name) {
		super();
		this.no = no;
		this.big_category_no = big_category_no;
		this.small_name = small_name;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public int getBig_category_no() {
		return big_category_no;
	}

	public void setBig_category_no(int big_category_no) {
		this.big_category_no = big_category_no;
	}

	public String getSmall_name() {
		return small_name;
	}

	public void setSmall_name(String small_name) {
		this.small_name = small_name;
	}
	
	
	
}
