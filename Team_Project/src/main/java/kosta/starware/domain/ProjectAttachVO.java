package kosta.starware.domain;

import lombok.Data;

@Data
public class ProjectAttachVO {

	private String project_uuid;
	private String project_uploadPath;
	private String project_fileName;
	
	private int project_No;
}
