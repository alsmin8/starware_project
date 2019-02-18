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
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kosta.starware.domain.CategoryVO;
import kosta.starware.domain.EmpVO;
import kosta.starware.domain.ScheduleVO;
import kosta.starware.service.CategoryService;
import kosta.starware.service.ScheduleService;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RestController
@Log4j
@RequestMapping("/schedule/")
public class ScheduleController {
	
	@Setter(onMethod_=@Autowired)
	CategoryService service;
	
	@Setter(onMethod_=@Autowired)
	ScheduleService serviceSch;
	
	// 등록 (post)
	@PostMapping("/insertCgr")
	public String insertCgr(CategoryVO category) {

		service.insertCgr(category);
		System.out.println("category..num......"+category.getCategory_no());
		
		if(category.getAttendees()!=null) {
		for(int i = 0; i < category.getAttendees().size(); i++) {
				category.setEmp_no(category.getAttendees().get(i));
				service.addAttendee(category);
			System.out.println("성공......................"+i);
			}
		}
		
		System.out.println("성공......................");
		return "success";
	}
	
	
	// 사원 목록 조회 (get)
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
	
	
	// 목록 조회 (get)
	@GetMapping("/listCgr")
	public List<CategoryVO> listCgr(@RequestParam("emp_no") int emp_no) {
		
		List<CategoryVO> list = service.listCgr(emp_no);
		System.out.println("list.........."+list);
		return list;
		
	}
	
	@GetMapping("/getCgr")
	public CategoryVO updateCgr(@RequestParam("category_no") int category_no, @RequestParam("emp_no") int emp_no) {
		
		CategoryVO category = service.getCgr(category_no, emp_no);
		System.out.println("category.........."+category);
		return category;
		
	}
	
	// 수정 (put)
	@PostMapping("/updateCgr")
	public String updateCgr(CategoryVO category) {
		System.out.println(category);
		System.out.println(category.getAttendees());
		
		if(category.getAttendees()!=null) {
			for(int i = 0; i < category.getAttendees().size(); i++) {
				category.setEmp_no(category.getAttendees().get(i));
				// modifyadd sql 만들어야함
				service.addAttendee(category);
			}
		}
		
		// 해당 카테고리 내용 일괄 수정됨
		service.updateCgr(category);
		
		if(category.getCategory_color()!=null) {
		// 본인 카테고리 컬러만 수정됨
		service.updateColorCgr(category);
		}
		return "success";
	}
	
	@PostMapping("/deleteCgr")
	public String deleteCgr(CategoryVO category) {
		System.out.println(category);
		service.deleteCgr(category.getCategory_no(), category.getEmp_no());
		return "success";
	}
	
	@PostMapping("/insertSch")
	public String insertSch(ScheduleVO schedule) {
		System.out.println("schedule..num......"+schedule);
		int count = serviceSch.insertSch(schedule);
		
		if(schedule.getAttendees()!=null) {
		for(int i = 0; i < schedule.getAttendees().size(); i++) {
			schedule.setEmp_no(schedule.getAttendees().get(i));
			serviceSch.addAttendeeSch(schedule);
			System.out.println("성공......................"+i);
			}
		}
		
		System.out.println("성공......................");
		return "success";
	}

}
