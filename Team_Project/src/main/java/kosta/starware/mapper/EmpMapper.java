package kosta.starware.mapper;

import java.util.List;

import kosta.starware.domain.EmpCriteria;
import kosta.starware.domain.EmpVO;

public interface EmpMapper {

	//@Select("select * from emp where emp_no > 0")
	public List<EmpVO> empGetList();
	
	public List<EmpVO> empGetListWithPaging(EmpCriteria cri);
	
	public EmpVO empDept(int dept_no);
	
	public void empInsert(EmpVO emp);
	
	public void empInsertSelectKey(EmpVO emp);
	
	public EmpVO empRead(int emp_no);
	
	public EmpVO empDeptGet(int emp_no);
	
	public int empUpdate (EmpVO emp);

}
