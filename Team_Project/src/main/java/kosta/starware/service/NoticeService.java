package kosta.starware.service;

import java.util.List;

import kosta.starware.domain.NoticeVO;

public interface NoticeService {

	public int insertNoticeService(NoticeVO notice);
	
	public List<NoticeVO> listNoticeService();
	
	public NoticeVO detailNoticeService(int notice_no);
	
	
}
