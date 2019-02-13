package kosta.starware.domain;

import org.springframework.stereotype.Repository;

import lombok.Data;

@Data
@Repository
public class EmpVO {
	
	private int emp_no;
	private String emp_name;
	private String dept_name;

}
