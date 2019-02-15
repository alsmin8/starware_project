package kosta.starware.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kosta.starware.domain.NoticeCriteria;
import kosta.starware.domain.NoticeVO;
import kosta.starware.mapper.NoticeMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class NoticeServiceImpl implements NoticeService {

	@Setter(onMethod_=@Autowired)
	private NoticeMapper noticeMapper;
	
	@Override
	public int insertNoticeService(NoticeVO notice) {
		log.info("게시글 등록..."+notice);
		
		return noticeMapper.insertNotice(notice);
	}

	@Override
	public List<NoticeVO> listNoticeService(NoticeCriteria ncri) {
		log.info("listNotice..");
		return noticeMapper.noticeListWithPaging(ncri);
	}

	@Override
	public NoticeVO detailNoticeService(int notice_no) {
		NoticeVO notice=noticeMapper.noticeDetail(notice_no);
		noticeMapper.updateHitCount(notice);
		return notice;
	}

	@Override
	public int updateNoticeService(NoticeVO notice) {
		return noticeMapper.noticeUpdate(notice);
	}

	@Override
	public int deleteNoticeService(int notice_no) {
	
		return noticeMapper.noticeDelete(notice_no);
	}

	@Override
	public int getNoticeTotalService(NoticeCriteria ncri) {
		
		return noticeMapper.getNoticeTotal(ncri);
	}

	
	
	

}
