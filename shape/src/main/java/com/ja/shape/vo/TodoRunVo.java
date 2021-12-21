package com.ja.shape.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class TodoRunVo {

	private int no;
	private int todo_no;
	private int wish_run_no;
	private String check = "n";
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date todo_day;
	
	public TodoRunVo() {
		// TODO Auto-generated constructor stub
	}

	public TodoRunVo(int no, int todo_no, int wish_run_no, String check, Date todo_day) {
		super();
		this.no = no;
		this.todo_no = todo_no;
		this.wish_run_no = wish_run_no;
		this.check = check;
		this.todo_day = todo_day;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public int getTodo_no() {
		return todo_no;
	}

	public void setTodo_no(int todo_no) {
		this.todo_no = todo_no;
	}

	public int getWish_run_no() {
		return wish_run_no;
	}

	public void setWish_run_no(int wish_run_no) {
		this.wish_run_no = wish_run_no;
	}

	public String getCheck() {
		return check;
	}

	public void setCheck(String check) {
		this.check = check;
	}

	public Date getTodo_day() {
		return todo_day;
	}

	public void setTodo_day(Date todo_day) {
		this.todo_day = todo_day;
	}
	
	
	
}
