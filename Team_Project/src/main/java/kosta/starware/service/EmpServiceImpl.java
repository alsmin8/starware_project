package kosta.starware.service;

import java.util.List;

import org.springframework.stereotype.Service;

import kosta.starware.domain.DeptVO;
import kosta.starware.domain.EmpCriteria;
import kosta.starware.domain.EmpVO;
import kosta.starware.domain.GradeVO;
import kosta.starware.mapper.EmpMapper;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class EmpServiceImpl implements EmpService {

	private EmpMapper mapper;

	@Override
	public void empInsert(EmpVO emp) {
		log.info("empInsert......" + emp);

		mapper.empInsertSelectKey(emp);
	}

	@Override
	public EmpVO empGet(int emp_no) {
		log.info("empGet......" + emp_no);

		return mapper.empRead(emp_no);

	}
	 @Override
	   public GradeVO empGradeGet(int grade_no){
	      log.info("empDept.........." + grade_no);
	      
	      return mapper.empGradeGet(grade_no);
	   }
	
	
	@Override
	public boolean empUpdate(EmpVO emp) {
		log.info("empUpdate......" + emp);

		return mapper.empUpdate(emp) == 1;

	}

	/*@Override
	public List<EmpVO> empGetList() {
		log.info("empGetList.......");
		return mapper.empGetList();
	}*/
	
	@Override
	public List<EmpVO> empGetList(EmpCriteria empcri) {
		
		log.info("get List with empcritria" + empcri);
		
		return mapper.empGetListWithPaging(empcri);
	}
	
	@Override
	public int empGetTotal(EmpCriteria empcri) {
		log.info("get total count");
		return mapper.empGetTotalCount(empcri);
	}

	@Override
	public DeptVO empDept(int dept_no) {
		log.info("empDept.........." + dept_no);
	      
	      return mapper.empDept(dept_no);
	}

	@Override
	public GradeVO empGrade(int grade_no) {
		log.info("empGrade.........." + grade_no);
	      
	      return mapper.empGradeGet(grade_no);
	
	}

	@Override
	public DeptVO empDeptGet(int dept_no) {
		// TODO Auto-generated method stub
		 return mapper.empDeptGet(dept_no);
	}
	
	@Override
	   public List<EmpVO> empListService() {
	      
	      log.info("empListService............");
	      
	      return mapper.empList();
	   }


	
	

}
//