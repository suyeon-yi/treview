package com.treview.t_board_rep.vo;

public class T_board_repVO {

	private long rno, no;
	private String content, id, writeDate;
	public long getRno() {
		return rno;
	}
	public void setRno(long rno) {
		this.rno = rno;
	}
	public long getNo() {
		return no;
	}
	public void setNo(long no) {
		this.no = no;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getWriteDate() {
		return writeDate;
	}
	public void setWriteDate(String writeDate) {
		this.writeDate = writeDate;
	}
	@Override
	public String toString() {
		return "T_board_repVO [rno=" + rno + ", no=" + no + ", content=" + content + ", id=" + id + ", writeDate="
				+ writeDate + "]";
	}
	
}
