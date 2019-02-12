package kosta.starware.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kosta.starware.domain.Approval;
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
	
	@PostMapping("/appinsertddform")
	public String appInsert(Approval approval, RedirectAttributes rttr){
		log.info("appInsert::"+approval);
		approvalservice.appInsert(approval);
		rttr.addFlashAttribute("result", approval.getApp_no());
		return "redirect:/approval/applist_alllist";
	}
	
	@GetMapping("/appdetaildd")
	public void appDetail(@RequestParam("app_no") int app_no, Model model){
		log.info("/appdetaildd");
		model.addAttribute("approval", approvalservice.appDetail(app_no));
	}
	
	@PostMapping("/appupdateddform")
	public String appUpdate(Approval approval, RedirectAttributes rttr){
		log.info("update........"+approval);
		
		if(approvalservice.appUpdate(approval)){
			rttr.addFlashAttribute("result","success");
		}
		return "redirect:/approval/applist_alllist";
		}
	@PostMapping("/delete")//????????????????????????????
	public String appDelete(@RequestParam("app_no") int app_no, RedirectAttributes rttr){
		log.info("delete////////"+app_no);
		if(approvalservice.appDelete(app_no)){
			rttr.addFlashAttribute("result","success");
		}
		return "redirect:/approval/applist_alllist";
	}
}

