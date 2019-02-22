package kosta.starware.domain;

import java.util.List;

import org.springframework.stereotype.Repository;

import lombok.Data;

@Repository
@Data
public class ScheduleSearchDTO {
	
	private String[] area;
	private String[] ename;
	private String searchKey;
	private String schedule_starttime;
	private String schedule_endtime;
	private List<Integer> cgr_no;

}
