package kosta.starware.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kosta.starware.domain.ScheduleVO;
import kosta.starware.mapper.ScheduleMapper;
import lombok.Setter;

@Service
public class ScheduleServiceImpl implements ScheduleService {

	@Setter(onMethod_=@Autowired)
	ScheduleMapper mapper;
	
	@Override
	public int insertSch(ScheduleVO schedule) {
		return mapper.insertSch(schedule);
	}
	
	@Override
	public int addAttendeeSch(ScheduleVO schedule) {
		return mapper.addAttendeeSch(schedule);
	}
	
	@Override
	public List<ScheduleVO> listSch(int emp_no) {
		
		List<ScheduleVO> list = mapper.listSch(emp_no);
		System.out.println("list........"+list);
		return mapper.listSch(emp_no);
	}
	
	@Override
	public ScheduleVO getSch(int schedule_no, int emp_no) {
		return mapper.getSch(schedule_no, emp_no);
	}
	
	@Override
	public List<ScheduleVO> listEmpBySno(int schedule_no) {
		return mapper.listEmpBySno(schedule_no);
	}
	
}
