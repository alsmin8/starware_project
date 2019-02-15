package kosta.starware.mapper;

import java.util.List;

import kosta.starware.domain.AttendCriteria;
import kosta.starware.domain.AttendVO;

public interface AttendMapper {

	public List<AttendVO> totalRecordWithPaging(AttendCriteria attcri);
	
	public List<AttendVO> empRecordWithPaging();
	
	public int getAttendTotal(AttendCriteria attcri);
	
	
	
	
}
