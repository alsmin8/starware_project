package kosta.starware.domain;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@ToString
@NoArgsConstructor
public class EmpDTO implements Serializable{
	private int emp_no;
	private String emp_name;
	private String emp_pass;
	private String emp_gender;
	private String emp_socialNo;
	private int dept_no;
	private int grade_no;
	private String emp_cellphone;
	private String emp_extension;
	private String emp_hiredate;
	private String emp_retiredate;
	private String emp_empstate;
	private int emp_totalvdays;
	private int emp_vleftdays;
	//private String dept_name;
}
