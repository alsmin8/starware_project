package kosta.starware.mapper;

import java.util.List;

import kosta.starware.domain.CategoryVO;
import kosta.starware.domain.EmpVO;

public interface CategoryMapper {
	
	public int insertCgr(CategoryVO vo);
	
	public List<EmpVO> listEmp();
	
	public List<CategoryVO> listCgr();

}
