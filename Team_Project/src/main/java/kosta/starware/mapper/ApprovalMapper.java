package kosta.starware.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import kosta.starware.domain.Approval;

public interface ApprovalMapper {
	
	@Select("select * from approval where bno >0 ")
	public List<Approval> applist();
	
}
