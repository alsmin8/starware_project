package kosta.starware.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
		log.info("게시글 등록!"+notice);
		
		return noticeMapper.insertNotice(notice);
	}

	@Override
	public List<NoticeVO> listNoticeService() {
		log.info("listNotice..");
		return noticeMapper.noticeListWithPaging();
	}

	@Override
	public NoticeVO detailNoticeService(int notice_no) {
		
		return noticeMapper.noticeDetail(notice_no);
	}

}
