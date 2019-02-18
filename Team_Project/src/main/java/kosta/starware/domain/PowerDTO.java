package kosta.starware.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PowerDTO {
	private String app_no;
	private String emp_no;
	private String power_defult;
}
