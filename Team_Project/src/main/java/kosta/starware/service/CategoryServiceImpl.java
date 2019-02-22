package kosta.starware.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kosta.starware.domain.CategoryVO;
import kosta.starware.domain.EmpVO;
import kosta.starware.mapper.CategoryMapper;
import lombok.Setter;

@Service
public class CategoryServiceImpl implements CategoryService {
	
	@Setter(onMethod_=@Autowired)
	CategoryMapper mapper;

	@Override
	public int insertCgr(CategoryVO category) {

		return mapper.insertCgr(category);
	}
	
	@Override
	public List<EmpVO> listEmp() {
		
		return mapper.listEmp();
	}
	
	@Override
	public List<CategoryVO> listCgr(int emp_no) {
		
		return mapper.listCgr(emp_no);
	}
	
	@Override
	public int updateCgr(CategoryVO category) {
		return mapper.updateCgr(category);
	}
	
	@Override
	public CategoryVO getCgr(int category_no, int emp_no) {
		
		CategoryVO category = mapper.getCgr(category_no, emp_no);
		
		category.setAttendees(mapper.getCgrByCno(category_no));
		
		if(category.getAttendees()!=null) {
			
			String[] emp_name = new String[category.getAttendees().size()];
			String[] dept_name = new String[category.getAttendees().size()];
			
			for(int i = 0; i < category.getAttendees().size();i++) {
				EmpVO emp = mapper.empInfo(category.getAttendees().get(i));
				
				emp_name[i] = emp.getEmp_name();
				dept_name[i] = emp.getDept_name();
			
			}
			category.setEmp_name(emp_name);
			category.setDept_name(dept_name);
		}

		System.out.println("category.........."+category);
		return category;
	}
	
	@Override
	public int addAttendee(CategoryVO category) {
		return mapper.addAttendee(category);
	}
	
	@Override
	public int deleteCgr(int category_no, int emp_no) {
		return mapper.deleteCgr(category_no, emp_no);
	}
	
	@Override
	public int updateColorCgr(CategoryVO category) {
		return mapper.updateColorCgr(category);
	}


}
