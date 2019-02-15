package kosta.starware.domain;

import lombok.Data;

@Data
public class NoticeAttachFileDTO {
	private String fileName;
	private String uploadPath;
	private String uuid;
	private boolean image;
	
}
