package kosta.starware.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProjectBoardVO {
	
	private int project_Board_No;
	private String project_Board_Writer;
	private String project_Board_Contents;
	private String project_Board_Regdate;
	private int project_Board_Position;
	private Integer project_No;
	
}
