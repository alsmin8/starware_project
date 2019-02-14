package kosta.starware.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import kosta.starware.domain.EmpCriteria;
import kosta.starware.domain.EmpVO;

public interface EmpMapper {

	//@Select("select * from emp where emp_no > 0")
	public List<EmpVO> empGetList();
	
	public List<EmpVO> empGetListWithPaging(EmpCriteria cri);
	
	public void empInsert(EmpVO emp);
	
	public void empInsertSelectKey(EmpVO emp);
	
	public EmpVO empRead(int emp_no);
	
	public int empUpdate (EmpVO emp);

}
