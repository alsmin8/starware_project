package kosta.starware.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import kosta.starware.domain.ScheduleSearchDTO;
import kosta.starware.domain.ScheduleVO;

public interface ScheduleMapper {
	
	public int insertSch(ScheduleVO schedule);
	
	public int addAttendeeSch(ScheduleVO schedule);
	
	public List<ScheduleVO> listSch(HashMap<String, Object> map);
	
	public List<ScheduleVO> listEmpBySno(int schedule_no);
	
	public ScheduleVO getSch(@Param("schedule_no") int schedule_no, @Param("emp_no") int emp_no);
	
	public int updateSch(ScheduleVO schedule);
	
	public int deleteSch(@Param("schedule_no") int schedule_no, @Param("emp_no") int emp_no);
	
	public int updateAttCount(@Param("schedule_no")int schedule_no);
	
	public int updateSchJson(ScheduleVO schedule);
	
}
