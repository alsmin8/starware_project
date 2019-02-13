package kosta.starware.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kosta.starware.domain.ProjectDTO;
import kosta.starware.service.ProjectService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/project/*")
@AllArgsConstructor
public class ProjectController {
	
	private ProjectService service;
	
	@GetMapping("/listProjectForm")
	public void listProjectForm(Model model){
		
		log.info("listProjectForm");
		
		model.addAttribute("listProjectForm",service.getList());
	}
	
	@PostMapping("/insertProjectForm")
	public String insertProjectForm(ProjectDTO project, RedirectAttributes rttr){
		
		log.info("insertProjectForm:" + project);
		
		service.register(project);
		
		rttr.addFlashAttribute("result", project.getProject_No());
		
		return "redirect:/project/listProjectForm";
		
	}
	
	@GetMapping("/detailProjectForm")
	public void detailProjectForm(@RequestParam("Project_No") int Project_No, Model model){
		
		log.info("detailProjectForm");
		model.addAttribute("project", service.read(Project_No));
	}
	
	@PostMapping("/updateProjectForm")
	public String updateProjectForm(ProjectDTO project, RedirectAttributes rttr){
		
		log.info("updateProjectForm:" + project);
		
		if(service.modify(project)){
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/project/listProjectForm";
	}

}
