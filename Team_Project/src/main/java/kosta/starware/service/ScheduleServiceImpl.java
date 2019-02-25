package kosta.starware.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kosta.starware.domain.ScheduleSearchDTO;
import kosta.starware.domain.ScheduleVO;
import kosta.starware.mapper.ScheduleMapper;
import lombok.Setter;

@Service
public class ScheduleServiceImpl implements ScheduleService {

	@Setter(onMethod_=@Autowired)
	ScheduleMapper mapper;
	
	@Transactional
	@Override
	public int insertSch(ScheduleVO schedule) {
		mapper.insertSch(schedule);
		System.out.println("service-sche"+schedule.getSchedule_no());
		
		return mapper.updateAttCount(schedule.getSchedule_no());
	}
	
	@Transactional
	@Override
	public int addAttendeeSch(ScheduleVO schedule) {
		mapper.addAttendeeSch(schedule);
		return mapper.updateAttCount(schedule.getSchedule_no());
	}
	
	@Override
	public List<ScheduleVO> listSch(ScheduleSearchDTO search, int emp_no) {
		
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("area", search.getArea());
		map.put("searchKey", search.getSearchKey());
		map.put("schedule_starttime", search.getSchedule_starttime());
		map.put("schedule_endtime", search.getSchedule_endtime());
		map.put("emp_no", emp_no);
		map.put("cgr_no", search.getCgr_no());
		List<ScheduleVO> list = mapper.listSch(map);
		
/*		try {
			byte[] bytes = (search.getSchedule_starttime()).getBytes("US-ASCII");
		} catch (Exception e) {
			e.printStackTrace();
		} */
		
		if(search.getEname()!=null) {
			List<ScheduleVO> list3 = new ArrayList<ScheduleVO>();
		for(int i = 0; i < list.size(); i++) {
			// 사용자와 같은 일정을 가진 참여자 리스트 출력
			List<ScheduleVO> list2 = mapper.listEmpBySno(list.get(i).getSchedule_no());
			System.out.println("empname....."+list2);
			for(int j = 0; j < list2.size(); j++) {
				if((list2.get(j).getEmp_name()).equals(search.getSearchKey())) {
					list3.add(mapper.getSch(list.get(i).getSchedule_no(), list2.get(j).getEmp_no()));
				}
			}
		}
		list = list3;
		}
		System.out.println("list........"+list);
	
		return list;
	}
	
	@Override
	public ScheduleVO getSch(int schedule_no, int emp_no) {
		return mapper.getSch(schedule_no, emp_no);
	}
	
	@Override
	public List<ScheduleVO> listEmpBySno(int schedule_no) {
		return mapper.listEmpBySno(schedule_no);
	}
	
	@Override
	public int updateSch(ScheduleVO schedule) {
		return mapper.updateSch(schedule);
	}
	
	@Override
	public int deleteSch(@Param("schedule_no") int schedule_no, @Param("emp_no") int emp_no) {
		return mapper.deleteSch(schedule_no, emp_no);
	}
	
	@Override
	public int updateSchJson(ScheduleVO schedule) {
		return mapper.updateSchJson(schedule);
	}
	
}
