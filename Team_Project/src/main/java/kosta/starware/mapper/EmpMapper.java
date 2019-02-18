package kosta.starware.mapper;

import java.util.List;

import kosta.starware.domain.DeptVO;
import kosta.starware.domain.EmpCriteria;
import kosta.starware.domain.EmpVO;
import kosta.starware.domain.GradeVO;

public interface EmpMapper {

	//@Select("select * from emp where emp_no > 0")
	public List<EmpVO> empGetList();
	
	public List<EmpVO> empGetListWithPaging(EmpCriteria cri);
	
	/*public EmpVO empDept(int dept_no);*/
	
	public void empInsert(EmpVO emp);
	
	public void empInsertSelectKey(EmpVO emp);
	
	public EmpVO empRead(int emp_no);
	
	public int empUpdate (EmpVO emp);
	
	public int empGetTotalCount(EmpCriteria empcri);
	
	public GradeVO empGradeGet(int grade_no);
	
	public DeptVO empDeptGet(int dept_no);
	
	public DeptVO empDept(int dept_no);

}
//