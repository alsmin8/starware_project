package kosta.starware.domain;

import lombok.Data;

@Data
public class ProjectDTO {

	private int project_No;
	private String project_Title;
	private String project_Contents;
	private String project_Kind;
	private String project_Writer;
	private String project_Manager;
	private String project_Members;
	private int project_Term;
	private String project_Start_Date;
	private String project_End_Date;
	private String project_Regdate;
	private String project_Situation;
	private int emp_No;

}
