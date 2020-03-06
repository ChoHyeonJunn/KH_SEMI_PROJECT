package com.devca.model.dto.profile;

import java.sql.Date;

public class ANSWER_BOARD {
	
	private int ANSWER_BOARD_SEQ;
	private int ANSWER_BOARDNO;
	private int ANSWER_GROUPNO;
	private int ANSWER_GROUPSEQ;
	private int ANSWER_TITLETAB;
	private String ANSWER_TITLE;
	private String ANSWER_CONTENT;
	private String ANSWER_WRITER;
	private Date REGDATE;
	public ANSWER_BOARD() {
		super();
		// TODO Auto-generated constructor stub
	}
	public ANSWER_BOARD(int aNSWER_BOARD_SEQ, int aNSWER_BOARDNO, int aNSWER_GROUPNO, int aNSWER_GROUPSEQ,
			int aNSWER_TITLETAB, String aNSWER_TITLE, String aNSWER_CONTENT, String aNSWER_WRITER, Date rEGDATE) {
		super();
		ANSWER_BOARD_SEQ = aNSWER_BOARD_SEQ;
		ANSWER_BOARDNO = aNSWER_BOARDNO;
		ANSWER_GROUPNO = aNSWER_GROUPNO;
		ANSWER_GROUPSEQ = aNSWER_GROUPSEQ;
		ANSWER_TITLETAB = aNSWER_TITLETAB;
		ANSWER_TITLE = aNSWER_TITLE;
		ANSWER_CONTENT = aNSWER_CONTENT;
		ANSWER_WRITER = aNSWER_WRITER;
		REGDATE = rEGDATE;
	}
	public int getANSWER_BOARD_SEQ() {
		return ANSWER_BOARD_SEQ;
	}
	public void setANSWER_BOARD_SEQ(int aNSWER_BOARD_SEQ) {
		ANSWER_BOARD_SEQ = aNSWER_BOARD_SEQ;
	}
	public int getANSWER_BOARDNO() {
		return ANSWER_BOARDNO;
	}
	public void setANSWER_BOARDNO(int aNSWER_BOARDNO) {
		ANSWER_BOARDNO = aNSWER_BOARDNO;
	}
	public int getANSWER_GROUPNO() {
		return ANSWER_GROUPNO;
	}
	public void setANSWER_GROUPNO(int aNSWER_GROUPNO) {
		ANSWER_GROUPNO = aNSWER_GROUPNO;
	}
	public int getANSWER_GROUPSEQ() {
		return ANSWER_GROUPSEQ;
	}
	public void setANSWER_GROUPSEQ(int aNSWER_GROUPSEQ) {
		ANSWER_GROUPSEQ = aNSWER_GROUPSEQ;
	}
	public int getANSWER_TITLETAB() {
		return ANSWER_TITLETAB;
	}
	public void setANSWER_TITLETAB(int aNSWER_TITLETAB) {
		ANSWER_TITLETAB = aNSWER_TITLETAB;
	}
	public String getANSWER_TITLE() {
		return ANSWER_TITLE;
	}
	public void setANSWER_TITLE(String aNSWER_TITLE) {
		ANSWER_TITLE = aNSWER_TITLE;
	}
	public String getANSWER_CONTENT() {
		return ANSWER_CONTENT;
	}
	public void setANSWER_CONTENT(String aNSWER_CONTENT) {
		ANSWER_CONTENT = aNSWER_CONTENT;
	}
	public String getANSWER_WRITER() {
		return ANSWER_WRITER;
	}
	public void setANSWER_WRITER(String aNSWER_WRITER) {
		ANSWER_WRITER = aNSWER_WRITER;
	}
	public Date getREGDATE() {
		return REGDATE;
	}
	public void setREGDATE(Date rEGDATE) {
		REGDATE = rEGDATE;
	}
	@Override
	public String toString() {
		return "ANSWER_BOARD [ANSWER_BOARD_SEQ=" + ANSWER_BOARD_SEQ + ", ANSWER_BOARDNO=" + ANSWER_BOARDNO
				+ ", ANSWER_GROUPNO=" + ANSWER_GROUPNO + ", ANSWER_GROUPSEQ=" + ANSWER_GROUPSEQ + ", ANSWER_TITLETAB="
				+ ANSWER_TITLETAB + ", ANSWER_TITLE=" + ANSWER_TITLE + ", ANSWER_CONTENT=" + ANSWER_CONTENT
				+ ", ANSWER_WRITER=" + ANSWER_WRITER + ", REGDATE=" + REGDATE + "]";
	}
	
	
	
	
}
