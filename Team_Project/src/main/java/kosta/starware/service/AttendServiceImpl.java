package kosta.starware.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kosta.starware.domain.AttendCriteria;
import kosta.starware.domain.AttendVO;
import kosta.starware.mapper.AttendMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class AttendServiceImpl implements AttendService {

	@Setter(onMethod_=@Autowired)
	private AttendMapper attendMapper;
	

	@Override
	public List<AttendVO> empRecordService() {
		
		return attendMapper.empRecordWithPaging();
	}

	@Override
	public List<AttendVO> totalRecordService(AttendCriteria attcri) {
		
		return attendMapper.totalRecordWithPaging(attcri);
	}

	@Override
	public int getAttendTotalService(AttendCriteria attcri) {
		
		return attendMapper.getAttendTotal(attcri);
	}

}
