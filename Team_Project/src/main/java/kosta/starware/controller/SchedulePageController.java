package kosta.starware.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/*import org.apache.catalina.connector.Request;*/
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kosta.starware.domain.ScheduleSearchDTO;
import kosta.starware.domain.ScheduleVO;
import kosta.starware.service.ScheduleService;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/schedulePage/*")
public class SchedulePageController {
	
	@Setter(onMethod_=@Autowired)
	ScheduleService service;
	
	@Setter(onMethod_=@Autowired)
	HttpServletRequest request;
	
	@GetMapping("/")
	public String toMain() {
		
		return "/schedule/scheduleMain";
	}
	
	@GetMapping("/listSch")
	public String listSch(ScheduleSearchDTO search, Model model) {
		
		HttpSession session = request.getSession();
		String emp_temp = (String) session.getAttribute("emp_no");
		int emp_no = Integer.parseInt(emp_temp);
		
		System.out.println("search......list....."+search+"emp_no......"+emp_no);
		
		List<ScheduleVO> list =  service.listSch(search, emp_no);
		
		model.addAttribute("search", search);
		model.addAttribute("list", list);
		
		return "/schedule/scheduleList2";
	}
	
	@GetMapping("/getSch")
	public String getSch(@RequestParam("schedule_no") int schedule_no, ScheduleSearchDTO search, Model model) {
		
		HttpSession session = request.getSession();
		String emp_temp = (String) session.getAttribute("emp_no");
		int emp_no = Integer.parseInt(emp_temp);
	
		
		ScheduleVO schedule = service.getSch(schedule_no, emp_no);

		model.addAttribute("schedule", schedule);
		model.addAttribute("search", search);
		model.addAttribute("empList", service.listEmpBySno(schedule_no));
		
		System.out.println("search.....get....."+search);
		
		System.out.println("sch"+schedule);
		System.out.println("sch2"+service.listEmpBySno(schedule_no));
		
		return "/schedule/scheduleDetail2";
	}
	
	@PostMapping("/updateSch")
	public String updateSch(ScheduleVO schedule, ScheduleSearchDTO search, RedirectAttributes rttr) {
		
		System.out.println("search......"+search);
		
		if(schedule.getAttendees()!=null) {
			for(int i = 0; i < schedule.getAttendees().size(); i++) {
				schedule.setEmp_no(schedule.getAttendees().get(i));
					service.addAttendeeSch(schedule);
				}
			}
		
		System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1�뾽�뜲�씠�듃");
		
		service.updateSch(schedule);
		
		String str = "redirect:/schedulePage/listSch";
	
		if(search != null) {
			str +="?";
			if(search.getArea()!=null) {
			for (int i = 0; i < search.getArea().length; i++) {
				str += "area=" + search.getArea()[i]+"&";
			}
			}
			if(search.getEname()!=null) {
			for (int i = 0; i < search.getEname().length; i++) {
				str += "ename=" + search.getEname()[i];
			}
			}
			if(search.getSearchKey()!=null) {
				str += "&searchKey=" + search.getSearchKey();
			}
		}
		
		return "redirect:/schedulePage/listSch";
	}
	
	@PostMapping("/deleteSch")
	public String deleteSch(@RequestParam("schedule_no") int schedule_no) {
		
		HttpSession session = request.getSession();
		String emp_temp = (String) session.getAttribute("emp_no");
		int emp_no = Integer.parseInt(emp_temp);
		
		service.deleteSch(schedule_no, emp_no);
		
		return "redirect:/schedulePage/listSch";
	}
	
	@GetMapping("/test")
	public String test() {
		return "/schedule/index";
	}
}
