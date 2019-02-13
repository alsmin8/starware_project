package kosta.starware.service;

import java.util.List;

import kosta.starware.domain.Approval;
import kosta.starware.domain.DisbursementDoc;
import kosta.starware.domain.DraftDoc;
import kosta.starware.domain.VacationDoc;

public interface ApprovalService {
	public void appInsert(Approval approval);
	public void appDdInsert(DisbursementDoc disbursementDoc);
	public void appDraftInsert(DraftDoc draftDoc);
	public void appVacationInsert(VacationDoc vacationDoc);
	
	public Approval appDetail(int app_no);
	public DisbursementDoc appDdDetail(int app_no);
	public DraftDoc appDraftDetail(int app_no);
	public VacationDoc appVacationDetail(int app_no);
	
//	public int getAppNo(int app_no);
	
	public boolean appUpdate(Approval approval);
	public boolean appDelete(int app_no);
	public List<Approval> appList();
}
