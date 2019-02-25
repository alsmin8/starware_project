package kosta.starware.domain;

import java.util.List;

import org.springframework.stereotype.Repository;
import lombok.Data;

@Data
@Repository
public class CategoryVO {
	
	private int category_no;
	private int emp_no;
	private String category_type;
	private String category_name;
	private String category_color;
	private int category_ordinal;
	private int cgr_power;
	
	private List<String> power_group;
	private List<Integer> attendees;
	private String emp_name;
	private String dept_name;
	private String grade_name;

}
