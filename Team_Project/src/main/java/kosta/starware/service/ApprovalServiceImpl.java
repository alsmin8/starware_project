package kosta.starware.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kosta.starware.domain.AppCriteria;
import kosta.starware.domain.Approval;
import kosta.starware.domain.DisbursementDoc;
import kosta.starware.domain.DraftDoc;
import kosta.starware.domain.EmpDTO;
import kosta.starware.domain.PowerDTO;
import kosta.starware.domain.VacationDoc;
import kosta.starware.mapper.ApprovalMapper;
import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class ApprovalServiceImpl implements ApprovalService {
	@Setter(onMethod_ = @Autowired)
	private ApprovalMapper approvalmapper;
	
	//List
	@Override
	public List<Approval> appList(AppCriteria appcri) {
		log.info("get list......");
		return approvalmapper.appPaging(appcri);
	}
	
	//insert
	@Override
	public void appInsert(Approval approval) {
		log.info("insert::::::::::"+approval);
		approvalmapper.appInsertSelectKey(approval);
	}
	@Override
	public void appDdInsert(DisbursementDoc disbursementDoc) {
		int app_no = approvalmapper.getAppNo();
		disbursementDoc.setApp_no(app_no);
		approvalmapper.appDdInsert(disbursementDoc);
	}
	@Override
	public void appDraftInsert(DraftDoc draftDoc) {
		int app_no = approvalmapper.getAppNo();
		draftDoc.setApp_no(app_no);
		approvalmapper.appDraftInsert(draftDoc);
	}
	@Override
	public void appVacationInsert(VacationDoc vacationDoc) {
		int app_no = approvalmapper.getAppNo();
		vacationDoc.setApp_no(app_no);
		approvalmapper.appVacationInsert(vacationDoc);			
	}
	
	//detail
	@Override
	public Approval appDetail(int app_no) {
		log.info("get........"+app_no);
		return approvalmapper.appDetail(app_no);
	}
	@Override
	public VacationDoc appVacationDetail(int app_no) {
		log.info("get........"+app_no);
		return approvalmapper.appVacationDetail(app_no);
	}
	
	@Override
	public DisbursementDoc appDdDetail(int app_no) {
		return approvalmapper.appDdDetail(app_no);
	}

	@Override
	public DraftDoc appDraftDetail(int app_no) {
		log.info("get........"+app_no);
		return approvalmapper.appDraftDetail(app_no);
	}
	//delete
	@Override
	public boolean appDelete(int app_no) {
		log.info("delete..........."+app_no);
		return approvalmapper.appDelete(app_no)==1;
	}
	public boolean appDraftDelete(int app_no) {
		log.info("delete..........."+app_no);
		return approvalmapper.appDraftDelete(app_no)==1;
	}
	public boolean appDdDelete(int app_no) {
		log.info("delete..........."+app_no);
		return approvalmapper.appDdDelete(app_no)==1;
	}
	public boolean appVacationDelete(int app_no) {
		log.info("delete..........."+app_no);
		return approvalmapper.appVacationDelete(app_no)==1;
	}
	//update
	@Override
	public boolean appUpdate(Approval approval) {
		log.info("update.........."+approval);
		return approvalmapper.appUpdate(approval)==1;
	}
	
	@Override
	public boolean appDdUpdate(DisbursementDoc disbursementDoc) {
		return approvalmapper.appDdUpdate(disbursementDoc)==1;
	}

	@Override
	public boolean appDraftUpdate(DraftDoc draftDoc) {
		log.info("updatedraft:::......"+draftDoc);
		return approvalmapper.appDraftUpdate(draftDoc)==1;
	}

	@Override
	public boolean appVacationUpdate(VacationDoc vacationDoc) {
		// TODO Auto-generated method stub
		return approvalmapper.appVacationUpdate(vacationDoc)==1;
	}
	@Override
	public int getTotal(AppCriteria appcri) {
		
		return approvalmapper.getTotalCount(appcri);
	}

	
	
	
	
	
	
	@Override
	public List<HashMap> resultApproval(String userID) {
		log.info("resultapproval 시작 : ");
		List<HashMap> list = approvalmapper.resultApproval(userID);
		//log.info(list);
		return list;
	}
	
	@Override
	public HashMap resultDetail(String app_no, String app_kind) {
		System.out.println("resultDetail 시작 : ");
		HashMap detailinfo = null;
		
		if(app_kind.equals("지출결의서")){
			System.out.println("지출결의서");
			detailinfo = approvalmapper.resultDetail_D(app_no, app_kind);
			System.out.println(detailinfo);
			//Date date = (Date) detailinfo.get("STARTDATE");
			//log.info("날짜 데이터 " + date);
		}else if(app_kind.equals("기안서")){
			System.out.println("기안서");
			detailinfo = approvalmapper.resultDetail_DD(app_no, app_kind);
			System.out.println(detailinfo);
		}else if(app_kind.equals("연차신청서")){
			System.out.println("연차신청서");
			detailinfo = approvalmapper.resultDetail_VD(app_no, app_kind);
			System.out.println(detailinfo);
		}else{
		}
		
		log.info(detailinfo);
		return detailinfo;
	}

	@Override
	public int resultAccept(PowerDTO powerDTO) {
		int result = approvalmapper.accept(powerDTO);
		// TODO Auto-generated method stub
		return result;
	}

	@Override
	public int resultReject(PowerDTO powerDTO) {
		int result = approvalmapper.reject(powerDTO);
		// TODO Auto-generated method stub
		return result;
	}
	
	@Override
	public List<HashMap> listJsonEmp(String keyword){
		List<HashMap> list = approvalmapper.listJsonEmp();
		
		List keywordList = new ArrayList();
		
		if(keyword == null || keyword.equals("")){
			keywordList = null;
		}
		
		for(int i=0;i<list.size();i++){
			if(((String) list.get(i).get("EMP_NAME")).startsWith(keyword)){
				keywordList.add(list.get(i));
			}
		}
		return keywordList;
	}



}
