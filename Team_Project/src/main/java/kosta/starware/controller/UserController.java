package kosta.starware.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kosta.starware.domain.EmpDTO;
import kosta.starware.domain.UserVO;
import kosta.starware.service.UserService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor
public class UserController {

	private UserService service;

	@GetMapping("/login")
	public void login(@ModelAttribute("vo") UserVO vo) {

		// log.info("login start...................");
	}

	@PostMapping("/login")
	public String loginafter(UserVO vo, HttpSession session) throws Exception {

		// log.info("vo : " + vo);

		int num = service.loginCheck(vo);

		if (num == -1) 
		{
			session.setAttribute("messageType", "�����޼���");
			session.setAttribute("messageContent", "��系���� �Է����ּ���.");
			return "/login";
		} 
		else if (num == 0) 
		{
			session.setAttribute("messageType", "�����޼���");
			session.setAttribute("messageContent", "���̵�� ���ڸ� �Է��ϼ���.");
			return "/login";
		} 
		else 
		{
			EmpDTO dto = service.loginService(vo);

			if (dto == null) 
			{
				session.setAttribute("messageType", "�����޼���");
				session.setAttribute("messageContent", "���̵� ���������ʽ��ϴ�.");
				return "/login";
			} 
			else if (!dto.getEmp_pass().equals(vo.getEmp_pass())) 
			{
				session.setAttribute("messageType", "�����޼���");
				session.setAttribute("messageContent", "��й�ȣ�� Ʋ���ϴ�.");
				return "/login";
			} 
			else 
			{
				session.setAttribute("messageType", "�����޼���");
				session.setAttribute("messageContent", "�α��� �Ǿ����ϴ�.");

				session.setAttribute("emp_no", String.valueOf(dto.getEmp_no()));
				session.setAttribute("emp_name", dto.getEmp_name());
				return "/loginafter";
			}

		}

	}

	@RequestMapping("/loginafter")
	public void loginafter() {

	}

	@RequestMapping("/logoutaction")
	public String logoutAction(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		session.invalidate();

		return "redirect:/login";
	}
}
