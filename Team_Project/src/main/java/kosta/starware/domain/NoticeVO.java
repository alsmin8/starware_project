package kosta.starware.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
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
	
	private List<NoticeAttachVO> attachList;
	
	private String emp_name;
	
}
