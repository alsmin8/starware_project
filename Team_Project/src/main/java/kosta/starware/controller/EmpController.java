package kosta.starware.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kosta.starware.domain.EmpCriteria;
import kosta.starware.domain.EmpPageDTO;
import kosta.starware.domain.EmpVO;
import kosta.starware.service.EmpService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/emp/*")
@AllArgsConstructor
public class EmpController {
	
	private EmpService service;
	
	//목록 출력
	@GetMapping("/empList")
	public void list(EmpCriteria empcri, Model model){
		
		log.info("empList: " + empcri);
		model.addAttribute("empList", service.empGetList(empcri));
		/*int total=service.empGetList(empcri);*/
		//model.addAttribute("empPageMaker", new EmpPageDTO(empcri, 100));
		int empTotal = service.empGetTotal(empcri);
		log.info("total: " + empTotal);
		model.addAttribute("empPageMaker", new EmpPageDTO(empcri, empTotal));
		
	}
	
	//사원정보입력
	@PostMapping("/empInsertForm")
	public String empInsert(EmpVO emp, RedirectAttributes rttr) {
		//log.info("empInsert: " + emp);
		
		service.empInsert(emp);
		
		rttr.addFlashAttribute("result", emp.getEmp_no());
		
		return "redirect:/emp/empList";
	}
	//사원정보입력 화면처리 메소드(추가)
	@GetMapping("/empInsertForm")
	public void empInsert() {
		
	}
	
	//사원상세정보 처리 (교재에 있는 코드)
	/*@RequestMapping({"/empDetail","/empUpdateForm"})
	public void empGet(@RequestParam("emp_no") int emp_no, 
			@ModelAttribute("empcri") EmpCriteria empcri, Model model) {
		
		log.info("/empDetail or empUpdateForm");
		
		model.addAttribute("emp", service.empGet(emp_no));
		
	}*/
	//사원상세정보 처리
	@RequestMapping("/empDetail")
	public void empDetail(@RequestParam("emp_no") int emp_no, 
			@ModelAttribute("empcri") EmpCriteria empcri, Model model){
		model.addAttribute("emp", service.empGet(emp_no));
		//log.info(model);
	}
		
	//사원정보수정
	@RequestMapping("/empUpdateForm")
	public void empUpdateForm(@RequestParam("emp_no") int emp_no, 
			@ModelAttribute("empcri") EmpCriteria empcri,
			Model model){
		model.addAttribute("emp", service.empGet(emp_no));
		log.info(model);
	}
	
	@PostMapping("/empUpdate")
	public String empUpdate(EmpVO emp, @ModelAttribute("empcri") EmpCriteria empcri, RedirectAttributes rttr) {
		log.info("### empUpdate: ");
		
		service.empUpdate(emp);
		 
		rttr.addAttribute("pageNum", empcri.getPageNum());
		rttr.addAttribute("amount", empcri.getAmount());
		//rttr.addFlashAttribute("result", notice.getNotice_no());
		
		return "redirect:/emp/empList";
		
	}
		
		
		/*if (service.empUpdate(emp)) {
			rttr.addFlashAttribute("result", "success");
		}
		rttr.addAttribute("pageNum", empcri.getPageNum());
		rttr.addAttribute("amount", empcri.getAmount());
		
		return "redirect:/emp/empList";
	}*/
	

	// 테스트
	/*@PostMapping("/empUpdate")
	public String empUpdate(){
		log.info("### empUpdate: ");
		
		return "";
	}*/
	
	
		
	//사원정보수정 화면처리 메소드(추가)

}

