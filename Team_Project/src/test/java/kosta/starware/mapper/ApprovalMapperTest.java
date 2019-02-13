package kosta.starware.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.event.TransactionalEventListener;

import kosta.starware.domain.Approval;
import kosta.starware.domain.DisbursementDoc;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ApprovalMapperTest {
	@Setter(onMethod_ = @Autowired)
	private ApprovalMapper approvalmapper;
	
	/*@Test
	public void testapplist(){
		approvalmapper.appList().forEach(Approval -> log.info(Approval));
	}*/
	
	/*@Test
	public void testappInsert(){
		Approval approval = new Approval();
		approval.setApp_title("�����ۼ��ϴ� test");
		approval.setApp_kind("�����ۼ��ϴ� test");
		
		approvalmapper.appInsert(approval);
		log.info(approval);
	}*/
	
	/*@Test
	public void testappInsertSelectKey(){
		Approval approval = new Approval();
		approval.setApp_title("�����ۼ��ϴ� selectkey");
		approval.setApp_kind("�����ۼ��ϴ� selectkey");
		
		approvalmapper.appInsertSelectKey(approval);
		log.info(approval);
	}*/
	
	/*@Test
	public void testappDetail(){
		Approval approval = approvalmapper.appDetail(41);
		log.info(approval);
	}*/
	
	/*@Test
	public void testappDelete(){
		log.info("DELETECOUNT::"+approvalmapper.appDelete(41));
	}*/
	
	/*@Test
	public void testappUpdate(){
		Approval approval = new Approval();
		DisbursementDoc disbursementDoc =  new DisbursementDoc();
		approval.setApp_no(101);
		approval.setApp_title("수정test");
		disbursementDoc.setD_amount(10000000);
		
		int count = approvalmapper.appUpdate(approval);
		log.info("UPDATECOUNT::::::::" +count);
		int amount = approvalmapper.appDdUpdate(disbursementDoc);
		log.info("UPDATEAMOUNT"+amount);
	}*/
	/*@Test
	public void testgetappno(){
		
		log.info("appno::::::::" +approvalmapper.getAppNo());
	}*/
	
}
