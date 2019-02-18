package kosta.starware.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kosta.starware.domain.CategoryVO;
import kosta.starware.domain.EmpVO;

public interface CategoryService {
	
	public int insertCgr(CategoryVO vo);

	public List<EmpVO> listEmp();
	
	public List<CategoryVO> listCgr(int emp_no);
	
	public int updateCgr(CategoryVO category);
	
	public CategoryVO getCgr(@Param("category_no") int category_no, @Param("emp_no") int emp_no);
	
	public int addAttendee(CategoryVO category);
	
	public int deleteCgr(@Param("category_no") int category_no, @Param("emp_no") int emp_no);

	public int updateColorCgr(CategoryVO category);
}
