package kosta.starware.mapper;

import java.util.List;

import kosta.starware.domain.NoticeAttachVO;

public interface NoticeAttachMapper {

	public void insert(NoticeAttachVO navo);
	public void delete(String notice_uuid);
	public List<NoticeAttachVO> findByNoticeNo(int notice_no);
	public void deleteAll(int notice_no);
	
}
