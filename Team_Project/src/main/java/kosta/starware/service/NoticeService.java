package kosta.starware.service;

import java.util.List;

import kosta.starware.domain.NoticeAttachVO;
import kosta.starware.domain.NoticeCriteria;
import kosta.starware.domain.NoticeVO;

public interface NoticeService {

	public void insertNoticeService(NoticeVO notice);
	
	public List<NoticeVO> listNoticeService(NoticeCriteria ncri);
	
	public NoticeVO detailNoticeService(int notice_no);
	
	public boolean updateNoticeService(NoticeVO notice);

	public boolean deleteNoticeService(int notice_no);
	
	public int getNoticeTotalService(NoticeCriteria ncri);
	
	public List<NoticeAttachVO> getAttachList(int notice_no); 
	
}
