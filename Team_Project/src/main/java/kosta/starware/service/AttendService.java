package kosta.starware.service;

import java.util.List;

import kosta.starware.domain.AttendCriteria;
import kosta.starware.domain.AttendVO;

public interface AttendService {

	public List<AttendVO> totalRecordService(AttendCriteria attcri);
	
	public List<AttendVO> empRecordService(int emp_no, String year, String month);
	
	public int getAttendTotalService(AttendCriteria attcri);
	
	public int insertAttendService(AttendVO attend);
	
	public int insertLeaveService(AttendVO attend);
	

	
}
