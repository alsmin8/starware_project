package kosta.starware.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kosta.starware.domain.AttendCriteria;
import kosta.starware.domain.AttendPageDTO;
import kosta.starware.service.AttendService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/attend/*")
@Log4j
@AllArgsConstructor
public class AttendController {
	
	private AttendService service;
	
	@GetMapping("/attendInsert")
	public void attendInsert(){
		
	}
	
	@GetMapping("/attendEmpRecord")
	public void attendEmpRecord(Model model){
		model.addAttribute("list", service.empRecordService());
	}
	
	@GetMapping("/attendResult")
	public void attendResult(){
		
	}
	
	@GetMapping("/attendTotalRecord")
	public void attendTotalRecord(AttendCriteria attcri,Model model){
		model.addAttribute("total", service.totalRecordService(attcri));
		//log.info("getAmount:"+attcri.getAmount());
		//log.info("페이지넘버:"+attcri.getPageNum());
		log.info(model);
		
		int total=service.getAttendTotalService(attcri);
		model.addAttribute("attendModel", new AttendPageDTO(attcri, total));
		
		log.info(total);
	}

}
