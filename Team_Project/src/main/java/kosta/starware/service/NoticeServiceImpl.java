package kosta.starware.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kosta.starware.domain.NoticeAttachVO;
import kosta.starware.domain.NoticeCriteria;
import kosta.starware.domain.NoticeVO;
import kosta.starware.mapper.NoticeAttachMapper;
import kosta.starware.mapper.NoticeMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class NoticeServiceImpl implements NoticeService {

	@Setter(onMethod_=@Autowired)
	private NoticeMapper noticeMapper;
	
	@Setter(onMethod_=@Autowired)
	private NoticeAttachMapper attachMapper;
	
	@Transactional
	@Override
	public void insertNoticeService(NoticeVO notice) {
		log.info("게시글 등록..."+notice);
		
		noticeMapper.insertNotice(notice);
		
		if(notice.getAttachList()==null||notice.getAttachList().size()<=0){
			return;
		}
		
		notice.getAttachList().forEach(attach ->{
			attach.setNotice_no(notice.getNotice_no());
			attachMapper.insert(attach);
		});
		
		
	
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
	public boolean deleteNoticeService(int notice_no) {
	
		attachMapper.deleteAll(notice_no);
		return noticeMapper.noticeDelete(notice_no)==1;
	}

	@Override
	public int getNoticeTotalService(NoticeCriteria ncri) {
		
		return noticeMapper.getNoticeTotal(ncri);
	}


	@Override
	public List<NoticeAttachVO> getAttachList(int notice_no) {
		log.info("get AttachList:"+notice_no);
		return attachMapper.findByNoticeNo(notice_no);
	}

	
	
	

}
