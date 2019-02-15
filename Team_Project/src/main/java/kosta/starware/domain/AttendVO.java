package kosta.starware.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class AttendVO {

	private String attend_date;
	private int emp_no;
	private String attend_startTime;
	private String attend_endTime;
	private String attend_stateNo;
	
	private String emp_name;
	//¸®ÀýÆ®¸Ê
	//private List<EmpDTO> empList;
	
	
}
