package kosta.starware.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kosta.starware.domain.ScheduleVO;

public interface ScheduleService {
	
	public int insertSch(ScheduleVO schedule);
	
	public int addAttendeeSch(ScheduleVO schedule);
	
	public List<ScheduleVO> listSch(int emp_no);
	
	public ScheduleVO getSch(int schedule_no, int emp_no);
	
	public List<ScheduleVO> listEmpBySno(int schedule_no);
	
}
