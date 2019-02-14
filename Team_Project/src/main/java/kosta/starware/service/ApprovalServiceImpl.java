package kosta.starware.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kosta.starware.domain.Approval;
import kosta.starware.domain.DisbursementDoc;
import kosta.starware.domain.DraftDoc;
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
	public List<Approval> appList() {
		log.info("get list......");
		return approvalmapper.appList();
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

	

}
