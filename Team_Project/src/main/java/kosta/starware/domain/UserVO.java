package kosta.starware.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class UserVO {

	private String emp_no;
	private String emp_pass;
	private String emp_name;

}
