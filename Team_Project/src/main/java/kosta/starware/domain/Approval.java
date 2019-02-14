package kosta.starware.domain;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class Approval {
	private int app_no;
	private String app_kind;
	private String app_title;
	private String app_startdate;
	private String app_enddate;
	private String app_situation;
	private int emp_no;
	
	private String grade_name;
	private String dept_name;
	
}
