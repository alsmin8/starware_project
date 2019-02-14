package kosta.starware.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kosta.starware.domain.NoticeVO;
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
	public void listProjectForm(Model model) {

		log.info("/listProjectForm");

		model.addAttribute("listProjectForm", service.getList());
	}

	/*
	 * @PostMapping("/insertProjectForm") public String
	 * insertProjectForm(ProjectDTO project, RedirectAttributes rttr) {
	 * 
	 * log.info("insertProjectForm:" + project);
	 * 
	 * service.register(project);
	 * 
	 * rttr.addFlashAttribute("result", project.getProject_No());
	 * 
	 * return "redirect:/project/listProjectForm"; }
	 */

	@PostMapping("/insertProjectForm")
	public String insertProjectForm(
			@RequestParam(value = "project_Title", required = true) String project_Title,
			@RequestParam(value = "project_Contents", required = true) String project_Contents,
			@RequestParam(value = "project_Kind", required = true) String project_Kind,
			@RequestParam(value = "project_Writer", required = false) String project_Writer,
			@RequestParam(value = "project_Manager", required = false) String project_Manager,
			@RequestParam(value = "project_Members", required = false) String project_Members,
			@RequestParam(value = "project_Term", required = false) int project_Term,
			@RequestParam(value = "project_Start_Date", required = false) String project_Start_Date,
			@RequestParam(value = "project_End_Date", required = false) String project_End_Date,
			@RequestParam(value = "project_Regdate", required = false) String project_Regdate,
			@RequestParam(value = "project_Situation", required = false) String project_Situation,
			RedirectAttributes rttr) {

		ProjectDTO project = new ProjectDTO();

		project.setProject_Title(project_Title);
		project.setProject_Contents(project_Contents);
		project.setProject_Kind(project_Kind);
		project.setProject_Writer(project_Writer);
		project.setProject_Manager(project_Manager);
		project.setProject_Members(project_Members);
		project.setProject_Term(project_Term);
		project.setProject_Start_Date(project_Start_Date);
		project.setProject_End_Date(project_End_Date);
		project.setProject_Regdate(project_Regdate);
		project.setProject_Situation(project_Situation);

		service.register(project);

		log.info("/insertProjectForm" + project);

		rttr.addFlashAttribute("result", project.getProject_No());
		return "redirect:/project/listProjectForm";
	}

	@GetMapping("/insertProjectForm")
	public void insertProjectForm() {

	}

	@GetMapping("/detailProjectForm")
	public void detailProjectForm(@RequestParam("project_No") int project_No, Model model) {

		log.info("/detailProjectForm");
		model.addAttribute("project", service.read(project_No));
	}

	@GetMapping("/updateProjectForm")
	public void updateProjectForm(@RequestParam("project_No") int project_No, Model model) {
		model.addAttribute("project", service.read(project_No));
		log.info(model);
	}

	@PostMapping("/updateProject")
	public String updateProject(ProjectDTO project, RedirectAttributes rttr) {

		log.info("updateProjectForm:" + project);

		if (service.modify(project)) {

			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/project/listProjectForm";
	}

	@RequestMapping("/deleteProject")
	public String deleteProject(@RequestParam("project_No") int project_No, RedirectAttributes rttr) {

		log.info("remove...." + project_No);

		if (service.remove(project_No)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/project/listProjectForm";
	}

	@GetMapping("/deleteProjectForm")
	public void deleteProjectForm(@RequestParam("project_No") int project_No, Model model) {

		model.addAttribute("project_No");

		// log.info("project_No" + project_No);

	}

}
