package kosta.starware.mapper;

import java.util.List;

import kosta.starware.domain.NoticeCriteria;
import kosta.starware.domain.NoticeVO;

public interface NoticeMapper {

	public int insertNotice(NoticeVO notice);
	
	//페이징 처리 안함
	//public List<NoticeVO> getListWithPaging();
	
	public List<NoticeVO> noticeListWithPaging(NoticeCriteria ncri);
	
	public NoticeVO noticeDetail(int notice_no);
	
	public int noticeUpdate(NoticeVO notice);
	
	public int noticeDelete(int notice_no);
	
	public int updateHitCount(NoticeVO notice);
	
	public int getNoticeTotal(NoticeCriteria ncri);
}
