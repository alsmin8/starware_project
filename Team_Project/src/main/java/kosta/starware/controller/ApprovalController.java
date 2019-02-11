package kosta.starware.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kosta.starware.service.ApprovalService;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/approval/*")
public class ApprovalController {
	@Setter(onMethod_ = {@Autowired})
	private ApprovalService approvalservice;
	
	@GetMapping("/applist_alllist")
	public void appList(Model model){
		log.info("list.........................."+ approvalservice.appList());
		model.addAttribute("list", approvalservice.appList());
	}

}
