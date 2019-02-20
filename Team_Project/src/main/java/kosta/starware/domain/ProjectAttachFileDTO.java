package kosta.starware.domain;

import lombok.Data;

@Data
public class ProjectAttachFileDTO {

	private String project_fileName;
	private String project_uploadPath;
	private String project_uuid;
}
