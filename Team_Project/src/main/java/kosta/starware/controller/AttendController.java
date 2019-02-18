package kosta.starware.controller;

import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kosta.starware.domain.AttendCriteria;
import kosta.starware.domain.AttendPageDTO;
import kosta.starware.domain.AttendVO;
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
	public void attendInsert(AttendVO attend){
		//log.info("attend insert..."+attend);
		//service.insertAttendService(attend);
	}
	
	@ResponseBody
	@RequestMapping(value="/attendAction", produces="application/text; charset=utf8")
	public String attendAction(AttendVO attend){
		
		int insertCount=service.insertAttendService(attend);
		log.info("count:"+insertCount);
		
		return "출근 기록 완료";
	}
	
	@ResponseBody
	@RequestMapping(value="/leaveAction", produces="application/text; charset=utf8")
	public String leaveAction(AttendVO attend){
		log.info("Leave..."+attend);
		int leaveCount=service.insertLeaveService(attend);
		log.info("count:"+leaveCount);
		
		return "퇴근 기록 완료";
		
	}
	
	
	
	@GetMapping("/attendEmpRecord")
	public void attendEmpRecord(Model model){
		//model.addAttribute("list", service.empRecordService());
	}
	
	//에이작스로?
	@GetMapping("/listEmpRecord")
	public void listEmpRecord(Model model){
		
	}
	
	@GetMapping("/attendResult")
	public void attendResult(){
		
	}
	
	
	@RequestMapping("/attendTotalRecord")
	public void attendTotalRecord(AttendCriteria attcri,Model model){
		model.addAttribute("total", service.totalRecordService(attcri));
		
		log.info(model);
		log.info("searchName:"+attcri.getSearchName());
		log.info("from:"+attcri.getFrom());
		log.info("to:"+attcri.getTo());
		
		
		int total=service.getAttendTotalService(attcri);
		model.addAttribute("attendModel", new AttendPageDTO(attcri, total));
		
		//log.info("total:"+total);
	}

}
