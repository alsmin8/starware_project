package kosta.starware.service;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
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
	public List<AttendVO> empRecordService(int emp_no, String year, String month) {
		
		return attendMapper.empRecordWithPaging(emp_no, year, month);
	}

	@Override
	public List<AttendVO> totalRecordService(AttendCriteria attcri) {
		
		//이름만 검색시
		if(attcri.getSearchName()!=null&&!attcri.getFrom().contains("2")&&!attcri.getTo().contains("2")){
			
			if(attcri.getSearchName().length()==0){
				attcri.setSearchName(null);
			}
			
			attcri.setFrom(null);
			attcri.setTo(null);
			return attendMapper.totalRecordWithPaging(attcri);
		}
		
		//날짜만 검색시
		if (attcri.getFrom()!=null&&attcri.getTo()!=null&&attcri.getSearchName().length()==0) {
			attcri.setSearchName(null);
			return attendMapper.totalRecordWithPaging(attcri);
		}
		
		//이름+날짜 함께 검색시
		if (attcri.getFrom()!=null&&attcri.getTo()!=null&&attcri.getSearchName()!=null) {
			return attendMapper.totalRecordWithPaging(attcri);
		}
		
		//초기
		if(attcri.getFrom()==null&&attcri.getTo()==null&&attcri.getSearchName()==null){
			attcri.setFrom(null);
			attcri.setTo(null);
			attcri.setSearchName(null);	
		}
		return attendMapper.totalRecordWithPaging(attcri);

		
		
	}

	@Override
	public int getAttendTotalService(AttendCriteria attcri) {
		
		return attendMapper.getAttendTotal(attcri);
	}

	@Override
	public int insertAttendService(AttendVO attend) {
	
		
			Date date= new Date();
			
			// now= String 형태로 변환
			SimpleDateFormat now = new SimpleDateFormat("HHmmss");
			String nowpattern = now.format(date);
			int nowTime = Integer.parseInt(nowpattern);
			
			if (nowTime > 90000) {
				attend.setAttend_stateNo("지각");
			} else {
				attend.setAttend_stateNo("출근");
			}
			log.info("attend"+attend);
			
			
			// 당일 출근 기록이 이미 있는 경우, 인서트X
			int emp_no=attend.getEmp_no();
			
			String dbData=null;
			dbData=attendMapper.getOneRecord(emp_no);
			
			if(dbData!=null){ //뽑아낸 데이터가 있는 경우
				return 0;
			}else{
				return attendMapper.insertAttend(attend);
			}
			
		
		
	}

	@Override
	public int insertLeaveService(AttendVO attend) {
		
		Date date = new Date();
		
		//attend_date 설정
		SimpleDateFormat today = new SimpleDateFormat("YYYY-MM-DD");
		String todaypattern = today.format(date);
		attend.setAttend_date(todaypattern);
		
		//attend_endTime 설정
		SimpleDateFormat today2=new SimpleDateFormat("HH:mm:ss");
		String timepattern=today2.format(date);	
		attend.setAttend_endTime(timepattern);
		log.info(timepattern);
		
		// now= String 형태로 변환
		SimpleDateFormat now = new SimpleDateFormat("HHmmss");
		String nowpattern = now.format(date);
		
		int nowTime = Integer.parseInt(nowpattern);
				
				if (nowTime < 180000) {
					attend.setAttend_stateNo("조퇴");
				} else {
					attend.setAttend_stateNo("퇴근");
				}
		
		//당일 퇴근 기록 이미 있는 경우
		int emp_no=attend.getEmp_no();
		String dbData=attendMapper.getEndTime(emp_no);
		if(dbData!=null){
			return 0;
		}else{
			return attendMapper.insertLeave(attend);
		}
				

	
	}

	
	
	

}
