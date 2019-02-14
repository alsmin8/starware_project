package kosta.starware.service;

import java.util.ArrayList;
import java.util.Date;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import kosta.starware.domain.ChatDTO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ChatServiceTest {

	@Setter(onMethod_ = @Autowired)
	private ChatService chatService;
	
/*	@Test
	public void testExist(){
		log.info(chatService);
		assertNotNull(chatService);
	}*/
	
	@Test
	public void testdisplayTime(){
		log.info("testdisplayTime : ");
		Date today = new Date();
		
		Long gap = today.getTime() - 86400001;
		log.info("오늘 시간 확인" + gap);
		
		Date dateObj = new Date(gap);
		Long num = (long)(1000 * 60 * 60 * 24);
		log.info("비교시간 값 확인 : " + num);
		log.info("오늘 시간 확인2" + dateObj);
		
		String str = chatService.displayTime(gap);

		log.info("결과값 확인" + str);
	}

/*	@Test
	public void unleadChating(){
		log.info("unleadChating result 확인 : ");

		String userID = "박길동"; 
		
		//ArrayList<ChatDTO> chatDTO = chatService.unleadChating(userID);
		//log.info("chatDTO 의 값 : "+chatDTO);

	}*/
	
}
