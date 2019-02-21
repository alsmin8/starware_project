package kosta.starware.service;

import static org.junit.Assert.assertNotNull;

import java.util.HashMap;
import java.util.List;

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
		approval.setApp_title("�����ۼ��ϴ�service1");
		approval.setApp_kind("�����ۼ��ϴ�service1");
		
		approvalservice.appInsert(approval);
		log.info("������ �Խù��� ��ȣ1:"+ approval.getApp_no());
		
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
		approval.setApp_title("��������ƴ�");
		log.info("updateresult"+approvalservice.appUpdate(approval));
	}*/
	
/*	@Test
	public void testResultapproval(){
		log.info("testApproval :");
		
		String userID = "12304";
		List<HashMap> list = approvalservice.resultApproval(userID);

		log.info("list :" +list);
	}*/
	
	@Test
	public void testResultDetail(){
		log.info("testApproval :");
		
		String app_no = "2";
		String app_kind = "기안서";
		String emp_no = "12301";
		HashMap list = approvalservice.resultDetail(app_no, app_kind, emp_no);

		log.info("list :" +list);
	}
}
