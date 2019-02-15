package kosta.starware.domain;

import lombok.Data;

@Data
public class NoticeAttachFileDTO {
	private String na_fileName;
	private String na_uploadPath;
	private String na_uuid;
	private boolean na_image;
	
}
