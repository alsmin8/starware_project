package kosta.starware.service;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.event.TransactionalEventListener;

import kosta.starware.domain.Approval;
import kosta.starware.mapper.ApprovalMapper;
import kosta.starware.mapper.ApprovalMapperTest;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ApprovalServiceTest {
	@Setter(onMethod_ = @Autowired)
	private ApprovalService approvalservice;
	
	/*@Test
	public void testExist(){
		log.info(approvalservice);
		assertNotNull(approvalservice);
	}*/
	
	/*@Test
	public void testInsert(){
		Approval approval = new Approval();
		approval.setApp_title("새로작성하는service1");
		approval.setApp_kind("새로작성하는service1");
		
		approvalservice.appInsert(approval);
		log.info("생성된 게시물의 번호1:"+ approval.getApp_no());
		
	}*/
	/*@Test
	public void testappList(){
		approvalservice.appList().forEach(approval -> log.info(approval));
	}*/
	/*@Test
	public void testappDetail(){
		log.info(approvalservice.appDetail(3));
	}*/
	
	/*@Test
	public void testappDelete(){
		log.info("deleteresult::::"+approvalservice.appDelete(3));
	}*/
	
	/*@Test
	public void testappUpdate(){
		Approval approval = approvalservice.appDetail(4);
		if(approval==null){
			return ;
		}
		approval.setApp_title("제목수정됐다");
		log.info("updateresult"+approvalservice.appUpdate(approval));
	}*/
}
