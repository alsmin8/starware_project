package kosta.starware.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kosta.starware.domain.ScheduleVO;

public interface ScheduleMapper {
	
	public int insertSch(ScheduleVO schedule);
	
	public int addAttendeeSch(ScheduleVO schedule);
	
	public List<ScheduleVO> listSch(int emp_no);
	
	public List<ScheduleVO> listEmpBySno(int schedule_no);
	
	public ScheduleVO getSch(@Param("schedule_no") int schedule_no, @Param("emp_no") int emp_no);
	
}
