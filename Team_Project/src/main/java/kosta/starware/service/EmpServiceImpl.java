package kosta.starware.service;

import java.util.List;

import org.springframework.stereotype.Service;

import kosta.starware.domain.EmpCriteria;
import kosta.starware.domain.EmpVO;
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
	public EmpVO empDept(int dept_no){
		log.info("empDept.........." + dept_no);
		
		return mapper.empDept(dept_no);
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
	
	

}
