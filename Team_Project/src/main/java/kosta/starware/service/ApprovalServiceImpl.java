package kosta.starware.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kosta.starware.domain.Approval;
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
	@Override
	public void appInsert(Approval approval) {
		log.info("insert::::::::::"+approval);
		approvalmapper.appInsertSelectKey(approval);

	}

	@Override
	public Approval appDetail(int app_no) {
		log.info("get........"+app_no);
		return approvalmapper.appDetail(app_no);
	}

	@Override
	public boolean appUpdate(Approval approval) {
		log.info("update.........."+approval);
		return approvalmapper.appUpdate(approval)==1;
	}

	@Override
	public boolean appDelete(int app_no) {
		log.info("delete..........."+app_no);
		return approvalmapper.appDelete(app_no)==1;
	}

	@Override
	public List<Approval> appList() {
		log.info("get list......");
		return approvalmapper.appList();
	}

}
