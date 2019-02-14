package kosta.starware.service;

import java.util.HashMap;
import java.util.List;

import kosta.starware.domain.Approval;
import kosta.starware.domain.DisbursementDoc;
import kosta.starware.domain.DraftDoc;
import kosta.starware.domain.VacationDoc;

public interface ApprovalService {
	
	public List<Approval> appList();
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
	
}
