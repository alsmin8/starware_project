package kosta.starware.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
	public PowerDTO appPowerGet(int app_no, int emp_no) {
		// TODO Auto-generated method stub
		return approvalmapper.appPowerGet(app_no, emp_no);
	}

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

	
	
	
	//내가 올린 결재 목록
	@Override
	public List<HashMap> myselfApproval(String userID) {
		List<HashMap> list = approvalmapper.myselfApproval(userID);
		//log.info(list);
		return list;
	}
	
	//list<hashmap>으로 jsp에 출력하고자 하는 column 값 반환
	@Override
	public List<HashMap> resultApproval(String userID) {
		log.info("resultapproval 시작 : ");
		List<HashMap> list = approvalmapper.resultApproval(userID);
		//log.info(list);
		return list;
	}
	
	
	//리스트에서 누른 상세정보를 hashmap으로 반환(위와 출력하고자 하는 정보가 다름)
	@Override
	public HashMap resultDetail(String app_no, String app_kind, String emp_no) {
		System.out.println("resultDetail 시작 : ");
		HashMap detailinfo = null;
		
		if(app_kind.equals("지출결의서")){
			System.out.println("지출결의서");
			detailinfo = approvalmapper.resultDetail_D(app_no, app_kind,emp_no);
			System.out.println(detailinfo);
			//Date date = (Date) detailinfo.get("STARTDATE");
			//log.info("날짜 데이터 " + date);
		}else if(app_kind.equals("기안서")){
			System.out.println("기안서");
			detailinfo = approvalmapper.resultDetail_DD(app_no, app_kind, emp_no);
			System.out.println(detailinfo);
		}else if(app_kind.equals("연차신청서")){
			System.out.println("연차신청서");
			detailinfo = approvalmapper.resultDetail_VD(app_no, app_kind, emp_no);
			System.out.println(detailinfo);
		}else{
		}
		log.info(detailinfo);
		return detailinfo;
	}
	
	//승인에 대한 처리서비스
	@Override
	@Transactional
	public int resultAccept(PowerDTO powerDTO) {
		System.out.println(powerDTO.getUpload());
		int result = approvalmapper.accept(powerDTO);
		
		String app_no = powerDTO.getApp_no();
		List<PowerDTO> list = approvalmapper.powerCount(app_no);
		for(int i = 0; i<list.size(); i++){
			if(list.size() == 1 && list.get(i).getPower_defult().equals("승인")){
				System.out.println("승인");
				approvalmapper.approvalAcceptUpdate(app_no);
			}else if(list.get(i).getPower_defult().equals("거절")){
				System.out.println("거절");
				approvalmapper.approvalRejectUpdate(app_no);
			}else{
				System.out.println("else");
			}
		}
		return result;
	}
	
	//거절에 대한 처리서비스
	@Override
	@Transactional
	public int resultReject(PowerDTO powerDTO) {
		System.out.println(powerDTO.getUpload());
		int result = approvalmapper.reject(powerDTO);
		
		String app_no = powerDTO.getApp_no();
		List<PowerDTO> list = approvalmapper.powerCount(app_no);
		for(int i = 0; i<list.size(); i++){
			if(list.size() == 1 && list.get(i).getPower_defult().equals("승인")){
				System.out.println("승인");
				approvalmapper.approvalAcceptUpdate(app_no);
			}else if(list.get(i).getPower_defult().equals("거절")){
				System.out.println("거절");
				approvalmapper.approvalRejectUpdate(app_no);
			}else{
				System.out.println("else");
			}
		}
		return result;
	}
	
	//각 전자결재에 대해 insert시 결재권자 검색서비스
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
	
	//검색한 결재권자를 db에 저장서비스
	@Override
	public void appInsert(Approval approval, List<Integer> attendees) {
		approvalmapper.appInsertSelectKey(approval);
		int app_no = approval.getApp_no();
		
		System.out.println("attendees 정보 : " + attendees);
		System.out.println("app_no : " + app_no);
		
		for(int i=0; i<attendees.size(); i++){
			int emp_no = attendees.get(i);
			approvalmapper.powerInsert(app_no, emp_no);
		}
	}

}
