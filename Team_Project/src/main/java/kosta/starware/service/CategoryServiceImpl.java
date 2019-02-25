package kosta.starware.service;

import java.util.ArrayList;
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
	
	@Override
	public EmpVO empInfo(int emp_no) {
		return mapper.empInfo(emp_no);
	}
	
	@Override
	public List<CategoryVO> getPowerList(@Param("category_no") int category_no) {
		List<EmpVO> list = mapper.getCgrByCno(category_no);
		List<CategoryVO> list2 = new ArrayList<>();

		for(int i = 0; i < list.size(); i++) {
			CategoryVO category = mapper.getCgr(category_no, list.get(i).getEmp_no());
			category.setEmp_name(list.get(i).getEmp_name());
			category.setDept_name(list.get(i).getDept_name());
			category.setGrade_name(list.get(i).getGrade_name());
			list2.add(category);
		}
		
		return list2;
	}


}
