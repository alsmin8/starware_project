package kosta.starware.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Required;
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
import kosta.starware.domain.ScheduleSearchDTO;
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
	
	@Setter(onMethod_=@Autowired)
	HttpServletRequest request;
	
	
	@PostMapping("/insertCgr")
	public String insertCgr(CategoryVO category) {
		
		HttpSession session = request.getSession();
		String emp_temp = (String) session.getAttribute("emp_no");
		int emp_no = Integer.parseInt(emp_temp);
		System.out.println("emp.........."+emp_no);
		
		category.setEmp_no(emp_no);
		service.insertCgr(category);
		System.out.println("category..num......"+category);
		
		if(category.getPower_group()!=null) {
		for(int i = 0; i < category.getPower_group().size(); i++) {
				String temp = category.getPower_group().get(i);
				int emp_no2 = Integer.parseInt(temp.substring(0,5));
				int cgr_power = Integer.parseInt(temp.substring(5));
				category.setEmp_no(emp_no2);
				category.setCgr_power(cgr_power);
				service.addAttendee(category);

			}
		}
		
		return "success";
	}
	
	

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
	
	
	
	@GetMapping("/listCgr")
	public List<CategoryVO> listCgr() {
		
		HttpSession session = request.getSession();
		String emp_temp = (String) session.getAttribute("emp_no");
		int emp_no = Integer.parseInt(emp_temp);
		System.out.println("emp.........."+emp_no);
		
		List<CategoryVO> list = service.listCgr(emp_no);
		System.out.println("list.........."+list);
		return list;
		
	}
	
	@GetMapping("/getCgr")
	public CategoryVO updateCgr(@RequestParam("category_no") int category_no) {
		
		HttpSession session = request.getSession();
		String emp_temp = (String) session.getAttribute("emp_no");
		int emp_no = Integer.parseInt(emp_temp);
		System.out.println("emp.........."+emp_no);
		
		CategoryVO category = service.getCgr(category_no, emp_no);
	
		System.out.println("category.........."+category);
		return category;
		
	}
	

	@PostMapping("/updateCgr")
	public String updateCgr(CategoryVO category) {
		HttpSession session = request.getSession();
		String emp_temp = (String) session.getAttribute("emp_no");
		int emp_no = Integer.parseInt(emp_temp);
		System.out.println("emp.........."+emp_no);
		
		category.setEmp_no(emp_no);
		
		if(category.getAttendees()!=null) {
			for(int i = 0; i < category.getAttendees().size(); i++) {
				/*category.setEmp_no(category.getAttendees().get(i));*/
				
				service.addAttendee(category);
			}
		}
		
		service.updateCgr(category);
		
		if(category.getCategory_color()!=null) {
	
		service.updateColorCgr(category);
		}
		return "success";
	}
	
	@PostMapping("/deleteCgr")
	public String deleteCgr(CategoryVO category) {
		System.out.println(category);
		
		HttpSession session = request.getSession();
		String emp_temp = (String) session.getAttribute("emp_no");
		int emp_no = Integer.parseInt(emp_temp);
		System.out.println("emp.........."+emp_no);
		
		service.deleteCgr(category.getCategory_no(), emp_no);
		return "success";
	}
	
	@GetMapping("/getEmpJson")
	public EmpVO getEmpJson(@RequestParam("emp_no") int emp_no) {

			EmpVO emp = service.empInfo(emp_no);
			return emp;
		}
	
	@GetMapping("/getPowerList")
	public List<CategoryVO> getPowerList(@RequestParam("category_no") int category_no) {
	
		List<CategoryVO> list = service.getPowerList(category_no);
		return list;
	}
	
	@PostMapping("/insertSch")
	public String insertSch(ScheduleVO schedule) {

		HttpSession session = request.getSession();
		String emp_temp = (String) session.getAttribute("emp_no");
		int emp_no = Integer.parseInt(emp_temp);
		
		schedule.setEmp_no(emp_no);
		serviceSch.insertSch(schedule);
		
		System.out.println("sche"+schedule.getSchedule_no());
		
		if(schedule.getAttendees()!=null) {
		for(int i = 0; i < schedule.getAttendees().size(); i++) {
			if(schedule.getAttendees().get(i)!=emp_no) {
			schedule.setEmp_no(schedule.getAttendees().get(i));
			serviceSch.addAttendeeSch(schedule);
			}
			}
		}
		
		return "success";
	}
	
	@GetMapping("/listSchJson")
	public List<ScheduleVO> listSchJson(ScheduleSearchDTO search) {
/*		ScheduleSearchDTO search = new ScheduleSearchDTO();*/
		
		/*while (cgr_no.remove(null));*/
		if(search.getCgr_no()!=null) {
			search.getCgr_no().removeAll(Collections.singleton(null));
		}
		System.out.println("cgr_no"+search.getCgr_no());
		System.out.println("search"+search);
		HttpSession session = request.getSession();
		String emp_temp = (String) session.getAttribute("emp_no");
		int emp_no = Integer.parseInt(emp_temp);
		
		List<ScheduleVO> list = serviceSch.listSch(search, emp_no);
		System.out.println("list..........캘린더조회"+list);
		return list;
	}
	
	@PostMapping("/updateSchJson")
	public String updateSchJson(ScheduleVO schedule) {
		serviceSch.updateSchJson(schedule);
		System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!json!!!!!!!!!!!!1업데이트");
		return "success";
	}
	
	@GetMapping("/getSchJson")
	public ScheduleVO getSchJson(int schedule_no) {
		
		HttpSession session = request.getSession();
		String emp_temp = (String) session.getAttribute("emp_no");
		int emp_no = Integer.parseInt(emp_temp);
		
		ScheduleVO schedule = serviceSch.getSch(schedule_no, emp_no);
		List<ScheduleVO> list = serviceSch.listEmpBySno(schedule_no);
		
		int[] no = new int[list.size()];
		System.out.println("no"+list);
		System.out.println("no"+list.size());
		
		String[] name = new String[list.size()];
		String[] dept = new String[list.size()];
		
		for(int i = 0; i < list.size(); i++) {

			System.out.println("d"+no);
			no[i] = list.get(i).getEmp_no();
			name[i] = list.get(i).getEmp_name();
			dept[i] = list.get(i).getDept_name();
		}
		
		System.out.println("no"+no);
		
/*		schedule.setAttendees(no);*/
		schedule.setEmp_name2(name);
		schedule.setDept_name2(dept);
		
		return schedule;
	}

}
