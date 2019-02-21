package kosta.starware.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import kosta.starware.domain.NoticeCriteria;
import kosta.starware.domain.NoticeVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
//@WebAppConfiguration
@ContextConfiguration(
	"file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class NoticeMapperTests {

	@Setter(onMethod_=@Autowired)
	private NoticeMapper mapper;
	
	
	@Test
	public void testList(){
		
		NoticeCriteria ncri=new NoticeCriteria();
		ncri.setNoticeSearchKey("dd");
		ncri.setNoticeSearchType("C");
		
		List<NoticeVO> list=mapper.noticeListWithPaging(ncri);
		
		list.forEach(attend -> log.info(attend));
		
	}
	
}
