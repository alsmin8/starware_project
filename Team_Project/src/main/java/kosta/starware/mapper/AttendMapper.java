package kosta.starware.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kosta.starware.domain.AttendCriteria;
import kosta.starware.domain.AttendVO;

public interface AttendMapper {

	public List<AttendVO> totalRecordWithPaging(AttendCriteria attcri);
	
	public List<AttendVO> empRecordWithPaging(@Param("emp_no")int emp_no, @Param("year") String year, @Param("month") String month);
	
	public int getAttendTotal(AttendCriteria attcri);
	
	public int insertAttend(AttendVO attend);
	
	public int insertLeave(AttendVO attend);
	
	public String getOneRecord(int emp_no);
	
	public String getEndTime(int emp_no);
	
	
	
	
	
}
