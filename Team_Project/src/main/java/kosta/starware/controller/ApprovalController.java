package kosta.starware.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kosta.starware.domain.Approval;
import kosta.starware.domain.DisbursementDoc;
import kosta.starware.domain.DraftDoc;
import kosta.starware.domain.VacationDoc;
import kosta.starware.service.ApprovalService;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/approval/*")
public class ApprovalController {
	@Setter(onMethod_ = { @Autowired })
	private ApprovalService approvalservice;

	// 전체결재목록
	@GetMapping("/applist_alllist")
	public void appList(Model model) {
		log.info("list.........................." + approvalservice.appList());
		model.addAttribute("list", approvalservice.appList());
	}

	// 문서 종류 선택
	@GetMapping("/appselectform")
	public void appselectform() {
	}

	// 종류 선택 시 해당 입력 폼 이동
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

	@PostMapping("/appinsertddform")
	public String appDdInsert(Approval approval, DisbursementDoc disbursementdoc, RedirectAttributes rttr) {
		log.info("appInsert::" + approval + "appInsert::" + disbursementdoc);
		approvalservice.appInsert(approval);
		approvalservice.appDdInsert(disbursementdoc);

		rttr.addFlashAttribute("result", approval.getApp_no());
		return "redirect:/approval/applist_alllist";
	}

	@PostMapping("/appinsertdraftform")
	public String appDraftInsert(Approval approval, DraftDoc draftDoc, RedirectAttributes rttr) {
		approvalservice.appInsert(approval);
		approvalservice.appDraftInsert(draftDoc);
		rttr.addFlashAttribute("result", approval.getApp_no());
		return "redirect:/approval/applist_alllist";
	}

	@PostMapping("/appinsertvacationform")
	public String appDraftInsert(Approval approval, VacationDoc vacationDoc, RedirectAttributes rttr) {
		approvalservice.appInsert(approval);
		approvalservice.appVacationInsert(vacationDoc);
		rttr.addFlashAttribute("result", approval.getApp_no());
		return "redirect:/approval/applist_alllist";
	}

	@GetMapping("/a")
	public String applist(RedirectAttributes rttr, @RequestParam("app_kind") String app_kind, @RequestParam("app_no") int app_no) {

		if (app_kind.equals("기안서")) {
			rttr.addAttribute("app_no", app_no); // addFlashAttribute("app_no",
			rttr.addAttribute("app_kind", app_kind);
			return "redirect:/approval/appdetaildraft";
		} else if (app_kind.equals("지출결의서")) {
			rttr.addAttribute("app_no", app_no);
			rttr.addAttribute("app_kind", app_kind);
			return "redirect:/approval/appdetaildd";
		} else {
			rttr.addAttribute("app_no", app_no);
			rttr.addAttribute("app_kind", app_kind);
			return "redirect:/approval/appdetailvacation";
		}
	}

	@GetMapping("/appdetaildd")
	public void appDetail(@RequestParam("app_no") int app_no, @RequestParam("app_kind") String app_kind, Model model) {

		model.addAttribute("approval", approvalservice.appDetail(app_no));
		model.addAttribute("disbursementdoc", approvalservice.appDdDetail(app_no));
	}

	@GetMapping("/appdetaildraft")
	public void appDraftDetail(@RequestParam("app_no") int app_no, @RequestParam("app_kind") String app_kind,
			Model model) {

		model.addAttribute("approval", approvalservice.appDetail(app_no));
		model.addAttribute("draftdoc", approvalservice.appDraftDetail(app_no));
	}

	@GetMapping("/appdetailvacation")
	public void appVacationDetail(@RequestParam("app_no") int app_no, @RequestParam("app_kind") String app_kind,
			Model model) {

		model.addAttribute("approval", approvalservice.appDetail(app_no));
		model.addAttribute("vacationdoc", approvalservice.appVacationDetail(app_no));
	}

	/*
	 * @GetMapping({ "/appdetaildd", "/appupdateddform" }) public void
	 * get(@RequestParam("app_no") int app_no, Model
	 * model,@RequestParam("app_kind") String app_kind) {
	 * log.info("/appdetaildd or appupdateddform");
	 * model.addAttribute("approval", approvalservice.appDetail(app_no)); }
	 */

	@PostMapping("/appupdateddform")
	public String appUpdate(Approval approval, RedirectAttributes rttr) {
		log.info("update........" + approval);

		if (approvalservice.appUpdate(approval)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/approval/applist_alllist";
	}

	@PostMapping("/delete") // ????????????????????????????
	public String appDelete(@RequestParam("app_no") int app_no, RedirectAttributes rttr) {
		log.info("delete////////" + app_no);
		if (approvalservice.appDelete(app_no)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/approval/applist_alllist";
	}

	@GetMapping("/applist_myself")
	public void mySelf() {

	}

	@GetMapping("/applist_result")
	public void result() {

	}

}
