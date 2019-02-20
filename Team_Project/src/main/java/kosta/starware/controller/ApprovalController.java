package kosta.starware.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kosta.starware.domain.AppCriteria;
import kosta.starware.domain.AppPageDTO;
import kosta.starware.domain.Approval;
import kosta.starware.domain.DisbursementDoc;
import kosta.starware.domain.DraftDoc;
import kosta.starware.domain.EmpVO;
import kosta.starware.domain.VacationDoc;
import kosta.starware.service.ApprovalService;
import kosta.starware.service.EmpService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/approval/*")
@AllArgsConstructor
public class ApprovalController {
	private ApprovalService approvalservice;
	private EmpService empService;
	
	// 리스트
	@GetMapping("/applist_alllist")
	public void appList(Model model, AppCriteria appcri) {
		log.info("list.........................." + approvalservice.appList(appcri));
		model.addAttribute("list", approvalservice.appList(appcri));
		model.addAttribute("appPageMaker", new AppPageDTO(appcri, 13));
	}

	// 문서종류선택
	@GetMapping("/appselectform")
	public void appselectform() {
	}

	// 인서트폼 보내기
	@PostMapping("/appselectform")
	public String appselectform(@RequestParam("app_kind") String app_kind) {
		if (app_kind == "기안서") {
			return "/appinsertdraftform";
		} else if (app_kind == "지출결의서") {
			return "/appinsertddform";
		} else {
			return "/appinsertvacationform";
		}
	}

	@GetMapping("/appinsertddform")
	public void appinsertddform() {
	}

	@GetMapping("/appinsertdraftform")
	public void appinsertdraftform() {
	}

	@GetMapping("/appinsertvacationform")
	public void appinsertvacationform() {
	}

	@Transactional
	@PostMapping("/appinsertddform")
	public String appDdInsert(Approval approval, DisbursementDoc disbursementdoc,@RequestParam("attendees") List<Integer> attendees) {
		log.info("appInsert::" + approval + "appInsert::" + disbursementdoc + " attendees::" + attendees);
		if(attendees.size() == 0 || attendees == null){
			return "redirect:/approval/applist_alllist";
		}else{
			approvalservice.appInsert(approval);
			approvalservice.appDdInsert(disbursementdoc);

			//rttr.addFlashAttribute("result", approval.getApp_no());
			return "redirect:/approval/applist_alllist";
		}
	}
	
	@Transactional
	@PostMapping("/appinsertdraftform")
	public String appDraftInsert(Approval approval, DraftDoc draftDoc,@RequestParam("attendees") List<Integer> attendees) {
		log.info("appInsert::" + approval + "appInsert::" + draftDoc + " attendees::" + attendees);
		if(attendees.size() == 0 || attendees == null){
			return "redirect:/approval/applist_alllist";
		}else{
			approvalservice.appInsert(approval, attendees);
			approvalservice.appDraftInsert(draftDoc);
			
			return "redirect:/approval/applist_alllist";
		}
	}
	
	@Transactional
	@PostMapping("/appinsertvacationform")
	public String appVacationInsert(Approval approval, VacationDoc vacationDoc,@RequestParam("attendees") List<Integer> attendees) {
		log.info("appInsert::" + approval + "appInsert::" + vacationDoc + " attendees::" + attendees);
		if(attendees.size() == 0 || attendees == null){
			return "redirect:/approval/applist_alllist";
		}else{
			approvalservice.appInsert(approval);
			approvalservice.appVacationInsert(vacationDoc);
			//rttr.addFlashAttribute("result", approval.getApp_no());
			return "redirect:/approval/applist_alllist";
		}
	}

	@GetMapping("/whichappdetail") //어떤 디테일 폼으로 갈건지
	public String applist( @RequestParam("app_kind") String app_kind,
			@RequestParam("app_no") int app_no , Model model) {

		if (app_kind.equals("기안서")) {
			Approval appr = approvalservice.appDetail(app_no);
			int empNo = appr.getEmp_no();
			EmpVO emp = empService.empGet(empNo);
			model.addAttribute("approval",approvalservice.appDetail(app_no));
			model.addAttribute("draftdoc",approvalservice.appDraftDetail(app_no));
			model.addAttribute("emp",emp);
			
			return "approval/appdetaildraft";
			
		} else if (app_kind.equals("지출결의서")) {
			model.addAttribute("approval", approvalservice.appDetail(app_no));
			model.addAttribute("disbursementdoc", approvalservice.appDdDetail(app_no));
			model.addAttribute("emp", empService.empGet(approvalservice.appDetail(app_no).getEmp_no()));
			return "/approval/appdetaildd";
		} else {
			model.addAttribute("approval", approvalservice.appDetail(app_no));
			model.addAttribute("vacationdoc", approvalservice.appVacationDetail(app_no));
			model.addAttribute("emp", empService.empGet(approvalservice.appDetail(app_no).getEmp_no()));
			return "/approval/appdetailvacation";
		}
	}

	/*
	 * @GetMapping("/appdetaildd") public void appDetail(@RequestParam("app_no")
	 * int app_no, @RequestParam("app_kind") String app_kind, Model model) {
	 * 
	 * model.addAttribute("approval", approvalservice.appDetail(app_no));
	 * model.addAttribute("disbursementdoc",
	 * approvalservice.appDdDetail(app_no)); }
	 */

	@GetMapping("/appdetaildraft")
	public void appDraftDetail(@RequestParam("app_no") int app_no, @RequestParam("app_kind") String app_kind,
			 Model model, RedirectAttributes rttr) {
		
		Approval appr = approvalservice.appDetail(app_no); 
		int empId = appr.getEmp_no();
		model.addAttribute("emp", empService.empGet(empId));
		model.addAttribute("approval", approvalservice.appDetail(app_no));
		model.addAttribute("draftdoc", approvalservice.appDraftDetail(app_no));
		rttr.addAttribute("app_no", app_no);
		rttr.addAttribute("app_kind", app_kind);
		log.info("go!!!!!!!!!!!!!!!!");
	}

	@GetMapping("/appdetailvacation")
	public void appVacationDetail(@RequestParam("app_no") int app_no, @RequestParam("app_kind") String app_kind,
			Model model) {

		model.addAttribute("approval", approvalservice.appDetail(app_no));
		model.addAttribute("vacationdoc", approvalservice.appVacationDetail(app_no));
	}

	@GetMapping("/appdetaildd")
	public void appDdDetail(@RequestParam("app_no") int app_no, Model model, @RequestParam("app_kind") String app_kind,
			RedirectAttributes rttr) {
		log.info("/appdetaildd");
		//model.addAttribute("emp", EmpService.empGet(approvalservice.appDetail(app_no).getEmp_no()));
		model.addAttribute("approval", approvalservice.appDetail(app_no));
		model.addAttribute("disbursementdoc", approvalservice.appDdDetail(app_no));
		rttr.addAttribute("app_no", app_no);
		rttr.addAttribute("app_kind", app_kind);
	
		
	}
	//-----------------------------------------update
	@GetMapping("/appupdateddform")
	public void appUpdate(@RequestParam("app_no") int app_no, @RequestParam("app_kind") String app_kind, Model model,
			RedirectAttributes rttr, Approval approval, DisbursementDoc disbursementDoc){
		model.addAttribute("approval", approvalservice.appDetail(app_no));
		model.addAttribute("disbursementdoc", approvalservice.appDdDetail(app_no));
		rttr.addAttribute("app_no", app_no);
		rttr.addAttribute("app_kind", app_kind);
		log.info("bbb;;;;;;;;;;"+app_kind);
	}
	
	@PostMapping("/appupdateddform")
	public String appDdUpdate(Approval approval, DisbursementDoc disbursementDoc, RedirectAttributes rttr,@RequestParam("app_no") int app_no
			,@RequestParam("app_kind") String app_kind) {
		
		approvalservice.appUpdate(approval);
		approvalservice.appDdUpdate(disbursementDoc);
		rttr.addAttribute("app_no", app_no);
		rttr.addAttribute("app_kind", app_kind);
		log.info("aaadd;;;;;;;;;;"+app_no);
		
		return "redirect:/approval/appdetaildd";
	}
	@GetMapping("/appupdatedraftform")
	public void appUpdate(@RequestParam("app_no") int app_no, @RequestParam("app_kind") String app_kind, Model model,
			RedirectAttributes rttr, Approval approval, DraftDoc draftDoc){
		model.addAttribute("approval", approvalservice.appDetail(app_no));
		model.addAttribute("draftdoc", approvalservice.appDraftDetail(app_no));
		rttr.addAttribute("app_no", app_no);
		rttr.addAttribute("app_kind", app_kind);
		log.info("bbb;;;;;;;;;;"+app_kind);
	}
	@PostMapping("/appupdatedraftform")
	public String appDraftUpdate(Approval approval, DraftDoc draftDoc, RedirectAttributes rttr, @RequestParam("app_no") int app_no, 
			@RequestParam("app_kind") String app_kind){
		log.info("update........!!!" + draftDoc);
		approvalservice.appUpdate(approval);
		approvalservice.appDraftUpdate(draftDoc);
		rttr.addAttribute("app_no", app_no);
		rttr.addAttribute("app_kind", app_kind);
		log.info("aaadraft;;;;;;;;;;"+app_no);
		return "redirect:/approval/appdetaildraft";
	}
	@GetMapping("/appupdatevacationform")
	public void appUpdate(@RequestParam("app_no") int app_no, @RequestParam("app_kind") String app_kind, Model model,
			RedirectAttributes rttr, Approval approval,VacationDoc vacationDoc){
		model.addAttribute("approval", approvalservice.appDetail(app_no));
		model.addAttribute("vacationdoc", approvalservice.appVacationDetail(app_no));
		rttr.addAttribute("app_no", app_no);
		rttr.addAttribute("app_kind", app_kind);
		
	}
	@PostMapping("/appupdatevacationform")
	public String appDraftUpdate(Approval approval, VacationDoc vacationDoc, RedirectAttributes rttr, @RequestParam("app_no") int app_no, 
			@RequestParam("app_kind") String app_kind){
		log.info("update........!!!" + vacationDoc);
		approvalservice.appUpdate(approval);
		approvalservice.appVacationUpdate(vacationDoc);
		rttr.addAttribute("app_no", app_no);
		rttr.addAttribute("app_kind", app_kind);
		
		return "redirect:/approval/appdetailvacation";
	}
	
	
	/*@GetMapping("/appupdatedraftform")
	public void appDraftUpdate(@RequestParam("app_no") int app_no, @RequestParam("app_kind") String app_kind, Model model,
			RedirectAttributes rttr, Approval approval, DraftDoc draftDoc){
		model.addAttribute("approval", approvalservice.appDraftUpdate(draftDoc))
	}*/
	/*
	 * @GetMapping("/appdelete") // ???????????????????????????? public String
	 * appDelete(@RequestParam("app_no") int app_no, RedirectAttributes rttr) {
	 * log.info("delete////////" + app_no); if
	 * (approvalservice.appDelete(app_no)) { rttr.addFlashAttribute("result",
	 * "success"); }
	 * 
	 * return "redirect:/approval/applist_alllist"; }
	 */
	@GetMapping({ "/appdeletedraft" })
	public String appDraftDelete(@RequestParam("app_no") int app_no, RedirectAttributes rttr) {
		approvalservice.appDraftDelete(app_no);
		approvalservice.appDelete(app_no);

		return "redirect:/approval/applist_alllist";
	}

	@GetMapping({ "/appdeletedd" })
	public String appDdDelete(@RequestParam("app_no") int app_no, RedirectAttributes rttr) {
		approvalservice.appDdDelete(app_no);
		approvalservice.appDelete(app_no);

		return "redirect:/approval/applist_alllist";
	}

	@GetMapping({ "/appdeletevacation" })
	public String appVacationDelete(@RequestParam("app_no") int app_no, RedirectAttributes rttr) {
		approvalservice.appVacationDelete(app_no);
		approvalservice.appDelete(app_no);

		return "redirect:/approval/applist_alllist";
	}

	@GetMapping("/applist_myself")
	public void mySelf() {

	}

	@RequestMapping("/applist_result")
	public String result(HttpSession session, Model model) {
		log.info("applist_result 시작 : ");
		String userID = (String) session.getAttribute("emp_no");
		String userName = (String) session.getAttribute("emp_name");
		
		if (userID == null || userName == null) {
			session.setAttribute("messageType", "오류메세지");
			session.setAttribute("messageContent", "현재 로그인이 되어있지 않습니다.");
			return "redirect:/login";
		}else{
			List<HashMap> applist_result = approvalservice.resultApproval(userID);
			//log.info(applist_result);
			model.addAttribute("applist_result", applist_result);
			return "/approval/applist_result";
		}


	}

}
