package com.ja.shape.vo;

public class MemberCategoryVo {

	private int no;
	private int member_no;
	private int small_category_no;
	
	public MemberCategoryVo() {
		super();
	}

	public MemberCategoryVo(int no, int member_no, int small_category_no) {
		super();
		this.no = no;
		this.member_no = member_no;
		this.small_category_no = small_category_no;
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
	
	
}
