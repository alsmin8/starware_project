package kosta.starware.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import kosta.starware.domain.AttendCriteria;
import kosta.starware.domain.AttendVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
//@WebAppConfiguration
@ContextConfiguration(
	"file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class AttendMapperTests {

	@Setter(onMethod_=@Autowired)
	private AttendMapper mapper;
	
	@Test
	public void testList(){
		
		AttendCriteria attcri=new AttendCriteria();
		
		attcri.setSearchName("홍길동");
		attcri.setFrom("2018-12-26");
		attcri.setTo("2019-02-15");
		
		
		List<AttendVO> list=mapper.totalRecordWithPaging(attcri);
		
		list.forEach(attend -> log.info(attend));
		
	}
	
}
