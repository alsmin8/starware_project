package kosta.starware.mapper;

import org.apache.ibatis.annotations.Param;

import kosta.starware.domain.EmpDTO;

public interface UserMapper {

	public EmpDTO login(@Param("emp_no") int emp_no);

}
