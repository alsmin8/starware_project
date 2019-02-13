package kosta.starware.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
	public void list(Model model){
		log.info("empList");
		
		model.addAttribute("empList", service.empGetList());
	}
	
	//사원정보입력
	@PostMapping("/empInsertForm")
	public String empInsert(EmpVO emp, RedirectAttributes rttr) {
		log.info("empInsert: " + emp);
		
		service.empInsert(emp);
		
		rttr.addFlashAttribute("result", emp.getEmp_no());
		
		return "redirect:/emp/empList";
	}
	//사원정보입력 화면처리 메소드(추가)
	@GetMapping("/empInsertForm")
	public void empInsert() {
		
	}
	
	//사원목록조회 처리
	@GetMapping({"/empDetail","/empUpdateForm"})
	public void empGet(@RequestParam("emp_no") int emp_no, Model model) {
		
		log.info("/empDetail or /empUpdateForm");
		model.addAttribute("emp", service.empGet(emp_no));
	}
	//사원정보수정
	@PostMapping("/empUpdateForm")
	public String empUpdate(EmpVO emp, RedirectAttributes rttr) {
		log.info("empUpdate: " + emp);
		
		if (service.empUpdate(emp)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/emp/empList";
		}
	//사원정보수정 화면처리 메소드(추가)

	}

