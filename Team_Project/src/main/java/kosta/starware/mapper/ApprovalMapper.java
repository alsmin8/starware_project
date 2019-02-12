package kosta.starware.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import kosta.starware.domain.Approval;

public interface ApprovalMapper {
	
	//@Select("select * from approval")
	public List<Approval> appList();
	public void appInsert(Approval approval);
	public void appInsertSelectKey(Approval approval);
	public Approval appDetail(int app_no);
	public int appDelete(int app_no);
	public int appUpdate(Approval approval);
}
