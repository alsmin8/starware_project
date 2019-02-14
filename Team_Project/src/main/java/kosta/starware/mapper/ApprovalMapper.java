package kosta.starware.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import kosta.starware.domain.AppCriteria;
import kosta.starware.domain.Approval;
import kosta.starware.domain.DisbursementDoc;
import kosta.starware.domain.DraftDoc;
import kosta.starware.domain.VacationDoc;

public interface ApprovalMapper {
	
	//@Select("select * from approval")
	public List<Approval> appList();
	public List<Approval> appPaging(AppCriteria cri);
 	//insert
	public void appInsert(Approval approval);
	public void appInsertSelectKey(Approval approval);
	public int getAppNo();
	public void appDdInsert(DisbursementDoc disbursementDoc);
	public void appDraftInsert(DraftDoc draftDoc);
	public void appVacationInsert(VacationDoc vacationDoc);
	//detail
	public Approval appDetail(int app_no);
	public DisbursementDoc appDdDetail(int app_no);
	public DraftDoc appDraftDetail(int app_no);
	public VacationDoc appVacationDetail(int app_no);
	//delete	
	public int appDelete(int app_no);
	public int appDdDelete(int app_no);
	public int appDraftDelete(int app_no);
	public int appVacationDelete(int app_no);
	//update
	public int appUpdate(Approval approval);
	public int appDdUpdate(DisbursementDoc disbursementDoc);
	public int appDraftUpdate(DraftDoc draftDoc);
	public int appVacationUpdate(VacationDoc vacationDoc);

}
