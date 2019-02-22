package kosta.starware.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kosta.starware.domain.ScheduleSearchDTO;
import kosta.starware.domain.ScheduleVO;

public interface ScheduleService {
	
	public int insertSch(ScheduleVO schedule);
	
	public int addAttendeeSch(ScheduleVO schedule);
	
	public List<ScheduleVO> listSch(ScheduleSearchDTO search, @Param("emp_no") int emp_no);
	
	public ScheduleVO getSch(int schedule_no, int emp_no);
	
	public List<ScheduleVO> listEmpBySno(int schedule_no);
	
	public int updateSch(ScheduleVO schedule);
	
	public int deleteSch(@Param("schedule_no") int schedule_no, @Param("emp_no") int emp_no);
	
	public int updateSchJson(ScheduleVO schedule);
	
}
