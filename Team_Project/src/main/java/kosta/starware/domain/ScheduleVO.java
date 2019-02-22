package kosta.starware.domain;

import java.util.List;

import org.springframework.stereotype.Repository;

import lombok.Data;

@Data
@Repository
public class ScheduleVO {
	
	private int schedule_no;
	private int emp_no;
	private int category_no;
	private String schedule_title;
	private String schedule_contents;
	private String schedule_regdate;
	private String schedule_starttime;
	private String schedule_endtime;
	private List<Integer> attendees;
	private int attcount;
	private String category_name;
	private String category_color;
	private String emp_name;
	private String dept_name;
	private String[] emp_name2;
	private String[] dept_name2;

}
