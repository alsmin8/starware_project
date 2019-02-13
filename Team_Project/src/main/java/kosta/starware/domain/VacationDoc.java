package kosta.starware.domain;

import lombok.Data;

@Data
public class VacationDoc {
	private int app_no;
	private int vd_no;
	private String vd_startdate;
	private String vd_enddate;
	private int vd_day;
	private String vd_contents;
}
