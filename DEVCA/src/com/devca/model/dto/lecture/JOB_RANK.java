package com.devca.model.dto.lecture;

public class JOB_RANK {
	private String JOB_RANK_DIVISION;
	private String JOB_RANK_STACK;
	private int JOB_RANK_NUM;

	public JOB_RANK() {
		super();
		// TODO Auto-generated constructor stub
	}

	public JOB_RANK(String jOB_RANK_DIVISION, String jOB_RANK_STACK, int jOB_RANK_NUM) {
		super();
		JOB_RANK_DIVISION = jOB_RANK_DIVISION;
		JOB_RANK_STACK = jOB_RANK_STACK;
		JOB_RANK_NUM = jOB_RANK_NUM;
	}

	public String getJOB_RANK_DIVISION() {
		return JOB_RANK_DIVISION;
	}

	public void setJOB_RANK_DIVISION(String jOB_RANK_DIVISION) {
		JOB_RANK_DIVISION = jOB_RANK_DIVISION;
	}

	public String getJOB_RANK_STACK() {
		return JOB_RANK_STACK;
	}

	public void setJOB_RANK_STACK(String jOB_RANK_STACK) {
		JOB_RANK_STACK = jOB_RANK_STACK;
	}

	public int getJOB_RANK_NUM() {
		return JOB_RANK_NUM;
	}

	public void setJOB_RANK_NUM(int jOB_RANK_NUM) {
		JOB_RANK_NUM = jOB_RANK_NUM;
	}

	@Override
	public String toString() {
		return "JOB_RANK [JOB_RANK_DIVISION=" + JOB_RANK_DIVISION + ", JOB_RANK_STACK=" + JOB_RANK_STACK
				+ ", JOB_RANK_NUM=" + JOB_RANK_NUM + "]";
	}

}
