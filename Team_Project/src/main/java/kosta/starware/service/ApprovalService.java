package kosta.starware.service;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import kosta.starware.domain.AppCriteria;
import kosta.starware.domain.Approval;
import kosta.starware.domain.DisbursementDoc;
import kosta.starware.domain.DraftDoc;
import kosta.starware.domain.EmpDTO;
import kosta.starware.domain.PowerDTO;
import kosta.starware.domain.VacationDoc;

public interface ApprovalService {
	
	public List<Approval> appList(AppCriteria appcri);
	public int getTotal(AppCriteria appcri);
	//insert
	public void appInsert(Approval approval);
	public void appDdInsert(DisbursementDoc disbursementDoc);
	public void appDraftInsert(DraftDoc draftDoc);
	public void appVacationInsert(VacationDoc vacationDoc);
	//detail
	public Approval appDetail(int app_no);
	public DisbursementDoc appDdDetail(int app_no);
	public DraftDoc appDraftDetail(int app_no);
	public VacationDoc appVacationDetail(int app_no);
	//update
	public boolean appUpdate(Approval approval);
	public boolean appDdUpdate(DisbursementDoc disbursementDoc);
	public boolean appDraftUpdate(DraftDoc draftDoc);
	public boolean appVacationUpdate(VacationDoc vacationDoc);
	//delete
	public boolean appDelete(int app_no);
	public boolean appDraftDelete(int app_no);
	public boolean appDdDelete(int app_no);
	public boolean appVacationDelete(int app_no);
	
	//내가 결재할 목록
	public List<HashMap> resultApproval(String userID);
	public HashMap resultDetail(String app_no, String app_kind, String emp_no);
	public int resultAccept(PowerDTO powerDTO);
	public int resultReject(PowerDTO powerDTO);
	public List<HashMap> listJsonEmp(String keyword);
		
	//보류 결재권자 인설트
	public void appInsert(Approval approval, List<Integer> attendees);
	
	//내가 올린 결재 목록
	public List<HashMap> myselfApproval(String userID);
}
