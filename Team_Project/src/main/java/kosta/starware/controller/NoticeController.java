package kosta.starware.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kosta.starware.domain.NoticeCriteria;
import kosta.starware.domain.NoticePageDTO;
import kosta.starware.domain.NoticeVO;
import kosta.starware.service.NoticeService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;


@Controller
@Log4j
@RequestMapping("/notice/*")
@AllArgsConstructor
public class NoticeController {

	private NoticeService service;
	
	
	/*@GetMapping("/noticeList")
	public void noticeList(Model model){
		model.addAttribute("noticeList", service.listNoticeService());		
	}*/
	
	@GetMapping("/noticeList")
	public void list(NoticeCriteria ncri, Model model){
		model.addAttribute("noticeList", service.listNoticeService(ncri));		
		int total=service.getNoticeTotalService(ncri);
		model.addAttribute("noticeModel", new NoticePageDTO(ncri, total));
	}
	
	
	@GetMapping("/noticeInsertForm")
	public void noticeInsertForm(){
		
	}
	
	@PostMapping("/noticeInsert")
	public String noticeInsert(@RequestParam(value="notice_title", required=true) String notice_title,
		@RequestParam(value="notice_contents", required=true) String notice_contents,
		@RequestParam(value="notice_subject", required=true) String notice_subject,
		@RequestParam(value="notice_startDate", required=false) String notice_startDate,
		@RequestParam(value="notice_endDate", required=false) String notice_endDate,
		@RequestParam(value="notice_state", required=false) String notice_state, RedirectAttributes rttr){
		
		NoticeVO notice=new NoticeVO();
		
		notice.setNotice_title(notice_title);
		notice.setNotice_contents(notice_contents);
		notice.setNotice_subject(notice_subject);
		notice.setNotice_startDate(notice_startDate);
		notice.setNotice_endDate(notice_endDate);
		notice.setNotice_state(notice_state);
		
		
		service.insertNoticeService(notice);
		
		log.info("notice Insert:"+notice);
		
		rttr.addFlashAttribute("result", notice.getNotice_no());
		return "redirect:/notice/noticeList";
		
	}
	
	
	
	@GetMapping("/noticeUpdateForm")
	public void noticeUpdateForm(@RequestParam("notice_no") int notice_no, 
			@ModelAttribute("ncri") NoticeCriteria ncri,
			Model model){
		model.addAttribute("notice", service.detailNoticeService(notice_no));
		log.info(ncri);
		//log.info(model);
	}
	
	@PostMapping("/noticeUpdate")
	public String noticeUpdate(
		@RequestParam(value="notice_no", required=true) int notice_no,	
		@RequestParam(value="notice_title", required=true) String notice_title,
		@RequestParam(value="notice_contents", required=true) String notice_contents,
		@RequestParam(value="notice_subject", required=true) String notice_subject,
		@RequestParam(value="notice_startDate", required=false) String notice_startDate,
		@RequestParam(value="notice_endDate", required=false) String notice_endDate,
		@RequestParam(value="notice_state", required=false) String notice_state,
		@ModelAttribute("ncri") NoticeCriteria ncri,
		RedirectAttributes rttr){
		
		NoticeVO notice=service.detailNoticeService(notice_no);
		//log.info("detail:"+notice);
		//log.info(ncri);
		
		
		notice.setNotice_title(notice_title);
		notice.setNotice_contents(notice_contents);
		notice.setNotice_subject(notice_subject);
		notice.setNotice_startDate(notice_startDate);
		notice.setNotice_endDate(notice_endDate);
		notice.setNotice_state(notice_state);
		
		
		service.updateNoticeService(notice);
		
		//log.info("notice Update:"+notice);
		
		//rttr.addFlashAttribute("result", notice.getNotice_no());
		
		rttr.addAttribute("pageNum", ncri.getPageNum());
		rttr.addAttribute("amount", ncri.getAmount());
		
		return "redirect:/notice/noticeList";
		
	}
	
	@RequestMapping("/noticeDetail")
	public void noticeDetail(@RequestParam("notice_no") int notice_no, 
			@ModelAttribute("ncri") NoticeCriteria ncri, Model model){
		model.addAttribute("notice", service.detailNoticeService(notice_no));
		//log.info(model);
	}
	
	
	@GetMapping("/noticeDeleteForm")
	public void noticeDeleteForm(@RequestParam("notice_no") int notice_no,
			@ModelAttribute("ncri") NoticeCriteria ncri,Model model){
		model.addAttribute("notice", service.detailNoticeService(notice_no));
		//log.info(model);
	}
	
	@RequestMapping("/noticeDelete")
	public String noticeDelete(@RequestParam("notice_no") int notice_no
			, @ModelAttribute("ncri") NoticeCriteria ncri,
			RedirectAttributes rttr){
		service.deleteNoticeService(notice_no);
		
		rttr.addAttribute("pageNum", ncri.getPageNum());
		rttr.addAttribute("amount", ncri.getAmount());
		
		return "redirect:/notice/noticeList";
	}
	
	
	
	
}
