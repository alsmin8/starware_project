package kosta.starware.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kosta.starware.domain.CategoryVO;
import kosta.starware.domain.EmpVO;
import kosta.starware.service.CategoryService;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/schedule/*")
public class ScheduleController {
	
	@Setter(onMethod_=@Autowired)
	CategoryService service;
	
	// ��� (post)
	@PostMapping("/insertCgr")
	public String insertCgr(CategoryVO category) {
		System.out.println("vo............"+category);
		service.insertCgr(category);
		
		if(category.getAttendees()!=null) {
			for(int i = 0; i < category.getAttendees().size(); i++) {
				category.setEmp_no(category.getAttendees().get(i));
				service.insertCgr(category);
				System.out.println("����......................"+i);
			}
		}
		
		System.out.println("����......................");
		return "redirect:/schedule/scheduleMain";
	}
	
	
	@GetMapping("/scheduleMain")
	public String toMain() {
		System.out.println("����......................");
		
		return "/schedule/scheduleMain";
	}
	
	
	// ��� ��� ��ȸ (get)
	@ResponseBody
	@GetMapping("/listEmp")
	public List<EmpVO> listEmp(@RequestParam String keyword) {
		List<EmpVO> list = service.listEmp();
		System.out.println("params........"+keyword);
		System.out.println("list......controller........"+list);

		List keywordList = new ArrayList();
		
		if(keyword == null || keyword.equals("")){
			keywordList = null;
		}
		
		for(int i=0;i<list.size();i++){
			if(list.get(i).getEmp_name().startsWith(keyword)){
				keywordList.add(list.get(i));
			}
		}
		return keywordList;
	}
	
	
	// ��� ��ȸ (get)
	@ResponseBody
	@GetMapping("/listCgr")
	public List<CategoryVO> listCgr(@RequestParam("emp_no") int emp_no) {
		
		List<CategoryVO> list = service.listCgr(emp_no);
		System.out.println("list.........."+list);
		return list;
		
	}
	
	@ResponseBody
	@GetMapping("/getCgr")
	public CategoryVO updateCgr(@RequestParam("category_no") int category_no, @RequestParam("emp_no") int emp_no) {
		
		CategoryVO category = service.getCgr(category_no, emp_no);
		System.out.println("category.........."+category);
		return category;
		
	}
	
	// ���� (put)
	@PostMapping("/updateCgr")
	public String updateCgr(CategoryVO category) {
		System.out.println(category);
		System.out.println(category.getAttendees());
		if(category.getAttendees()!=null) {
			for(int i = 0; i < category.getAttendees().size(); i++) {
				category.setEmp_no(category.getAttendees().get(i));
				service.addAttendee(category);
			}
		}
		service.updateCgr(category);
		return "redirect:/schedule/scheduleMain";
	}
	
	@PostMapping("/deleteCgr")
	public String deleteCgr(CategoryVO category) {
		System.out.println(category);
		service.deleteCgr(category.getCategory_no(), category.getEmp_no());
		return "redirect:/schedule/scheduleMain";
	}

}
