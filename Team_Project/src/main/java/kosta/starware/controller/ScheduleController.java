package kosta.starware.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
	
	@PostMapping("/insertCgr")
	public String insertCgr(CategoryVO category) {
		System.out.println("vo............"+category);
		category.setEmp_no(12305);
		service.insertCgr(category);
		
		if(category.getAttendees()!=null) {
			for(int i = 0; i < category.getAttendees().size(); i++) {
				category.setEmp_no(category.getAttendees().get(i));
				service.insertCgr(category);
				System.out.println("성공......................"+i);
			}
		}
		
		System.out.println("성공......................");
		return "redirect:/schedule/scheduleMain";
	}
	
	@GetMapping("/scheduleMain")
	public String toMain() {
		System.out.println("성공......................");
		
		return "/schedule/scheduleMain";
	}
	
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
	
	@ResponseBody
	@GetMapping("/listCgr")
	public List<CategoryVO> listCgr() {
		
		List<CategoryVO> list = service.listCgr();
		
		return list;
		
	}

}
