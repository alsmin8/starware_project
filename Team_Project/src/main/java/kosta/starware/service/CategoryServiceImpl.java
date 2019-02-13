package kosta.starware.service;

import java.util.List;

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
	public int insertCgr(CategoryVO vo) {

		return mapper.insertCgr(vo);
	}
	
	@Override
	public List<EmpVO> listEmp() {
		
		return mapper.listEmp();
	}
	
	@Override
	public List<CategoryVO> listCgr() {
		
		return mapper.listCgr();
	}

}
