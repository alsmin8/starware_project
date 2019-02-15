package kosta.starware.domain;

import lombok.Data;

@Data
public class NoticeAttachVO {

	private String notice_uuid;
	private String notice_uploadPath;
	private String notice_fileName;
	private int notice_no;
}
