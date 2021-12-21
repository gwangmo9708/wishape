package com.ja.shape.vo;

import java.util.Date;

public class WishRunEpiloguePlaceVo {

	private int no;
	private int wish_run_epilogue_no;
	private String address;
	private Date write_date; 
	
	public WishRunEpiloguePlaceVo() {
		// TODO Auto-generated constructor stub
	}

	public WishRunEpiloguePlaceVo(int no, int wish_run_epilogue_no, String address, Date write_date) {
		super();
		this.no = no;
		this.wish_run_epilogue_no = wish_run_epilogue_no;
		this.address = address;
		this.write_date = write_date;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public int getWish_run_epilogue_no() {
		return wish_run_epilogue_no;
	}

	public void setWish_run_epilogue_no(int wish_run_epilogue_no) {
		this.wish_run_epilogue_no = wish_run_epilogue_no;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public Date getWrite_date() {
		return write_date;
	}

	public void setWrite_date(Date write_date) {
		this.write_date = write_date;
	}
	
	
	
}
