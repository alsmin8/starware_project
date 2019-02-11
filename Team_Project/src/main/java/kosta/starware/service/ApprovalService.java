package kosta.starware.service;

import java.util.List;

import kosta.starware.domain.Approval;

public interface ApprovalService {
	public void appInsert(Approval approval);
	public Approval appDetail(int app_no);
	public boolean appUpdate(Approval approval);
	public boolean appDelete(int app_no);
	public List<Approval> appList();
}
