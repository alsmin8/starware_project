package kosta.starware.mapper;

import java.util.List;

import kosta.starware.domain.NoticeVO;

public interface NoticeMapper {

	public int insertNotice(NoticeVO notice);
	
	//����¡ ó�� ����
	public List<NoticeVO> noticeListWithPaging();
	
	public NoticeVO noticeDetail(int notice_no);
	
}
