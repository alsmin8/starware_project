package kosta.starware.service;

import java.util.List;

import kosta.starware.domain.CategoryVO;
import kosta.starware.domain.EmpVO;

public interface CategoryService {
	
	public int insertCgr(CategoryVO vo);

	public List<EmpVO> listEmp();
	
	public List<CategoryVO> listCgr();
}
