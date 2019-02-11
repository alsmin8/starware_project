package kosta.starware.mapper;

import java.util.List;

import kosta.starware.domain.NoticeVO;

public interface NoticeMapper {

	public int insertNotice(NoticeVO notice);
	
	//페이징 처리 안함
	public List<NoticeVO> noticeListWithPaging();
	
	public NoticeVO noticeDetail(int notice_no);
	
}
