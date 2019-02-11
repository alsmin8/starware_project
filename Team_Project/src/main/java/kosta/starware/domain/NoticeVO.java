package kosta.starware.domain;

import lombok.Data;

@Data
public class NoticeVO {

	private int notice_no;
	private String notice_subject;
	private String notice_title;
	private String notice_contents;
	private int notice_hitCount;
	private String notice_regdate;
	private String notice_startDate;
	private String notice_endDate;
	private String notice_state;
	private int emp_no;
	
}
