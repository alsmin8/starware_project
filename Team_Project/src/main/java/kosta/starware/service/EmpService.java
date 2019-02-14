package kosta.starware.service;

import java.util.List;

import kosta.starware.domain.EmpCriteria;
import kosta.starware.domain.EmpVO;

public interface EmpService {
	
	public void empInsert(EmpVO emp);
	
	public EmpVO empGet(int emp_no);
	
	public boolean empUpdate (EmpVO emp);
	
	//public List<EmpVO> empGetList();
	/*List<EmpVO>*/
	public List<EmpVO> empGetList(EmpCriteria empcri);

}
