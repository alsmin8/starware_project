package kosta.starware.service;

import java.util.List;

import kosta.starware.domain.DeptVO;
import kosta.starware.domain.EmpCriteria;
import kosta.starware.domain.EmpVO;
import kosta.starware.domain.GradeVO;

public interface EmpService {
	
	public void empInsert(EmpVO emp);
	
	public EmpVO empGet(int emp_no);
	
	/*public EmpVO empDept(int dept_no);*/
	
	public boolean empUpdate (EmpVO emp);
	
	//public List<EmpVO> empGetList();
	/*List<EmpVO>*/
	public List<EmpVO> empGetList(EmpCriteria empcri);
	
	public int empGetTotal(EmpCriteria empcri);
	
	public GradeVO empGradeGet(int grade_no);
	
	public DeptVO empDept(int dept_no);
	
	public GradeVO empGrade(int grade_no);
	
	public DeptVO empDeptGet(int dept_no);
	
	public List<EmpVO> empListService();

}
//