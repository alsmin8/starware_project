package kosta.starware.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kosta.starware.domain.EmpDTO;
import kosta.starware.domain.NoticeCriteria;
import kosta.starware.domain.UserVO;
import kosta.starware.service.NoticeService;
import kosta.starware.service.UserService;
import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor
public class UserController {

	@Setter(onMethod_ = @Autowired)
	private UserService service;
	
	@Setter(onMethod_ = @Autowired)
	private NoticeService noticeService;

	@GetMapping("/login")
	public String login(HttpSession session, Model model, NoticeCriteria ncri) {
		
		model.addAttribute("noticeList", noticeService.listNoticeService(ncri));
		
		if(session.getAttribute("emp_no") == null || session.getAttribute("emp_no").equals("")){
			return "/login";
		}else{

			return "/loginafter";
		}
	
	}

	@PostMapping("/login")
	public String loginafter(UserVO vo, HttpSession session, Model model, NoticeCriteria ncri) throws Exception {

		int num = service.loginCheck(vo);

		if (num == -1) {
			session.setAttribute("messageType", "오류메세지");
			session.setAttribute("messageContent", "모든내용을 입력해주세요.");
			return "/login";
		} else if (num == 0) {
			session.setAttribute("messageType", "오류메세지");
			session.setAttribute("messageContent", "아이디는 숫자만 입력하세요.");
			return "/login";
		} else {
			EmpDTO dto = service.loginService(vo);

			if (dto == null) {
				session.setAttribute("messageType", "오류메세지");
				session.setAttribute("messageContent", "아이디가 존재하지않습니다.");
				return "/login";
			} else if (!dto.getEmp_pass().equals(vo.getEmp_pass())) {
				session.setAttribute("messageType", "오류메세지");
				session.setAttribute("messageContent", "비밀번호가 틀립니다.");
				return "/login";
			} else {
				session.setAttribute("messageType", "성공메세지");
				session.setAttribute("messageContent", "로그인 되었습니다.");

				session.setAttribute("emp_no", String.valueOf(dto.getEmp_no()));
				session.setAttribute("emp_name", dto.getEmp_name());
				
				model.addAttribute("noticeList", noticeService.listNoticeService(ncri));
				
				return "/loginafter";
			}
		}
	}

	@RequestMapping("/loginafter")
	public void loginafter(Model model, NoticeCriteria ncri) {
		model.addAttribute("noticeList", noticeService.listNoticeService(ncri));
	}

	@RequestMapping("/logoutaction")
	public String logoutAction(HttpServletRequest request, HttpServletResponse response, HttpSession session)
			throws Exception {
		session.invalidate();

		return "redirect:/login";
	}
}
