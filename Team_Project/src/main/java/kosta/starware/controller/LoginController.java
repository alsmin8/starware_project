package kosta.starware.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import kosta.starware.service.LoginService;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class LoginController {
	
	@Setter(onMethod_ = @Autowired)
	private LoginService service;
	
	@RequestMapping("/login")
	public void Login(){
		
	}
	
	@RequestMapping("/UserLogin")
	public String LoginAfter(HttpServletRequest request, HttpServletResponse response) throws Exception, IOException{
		try {
			request.setCharacterEncoding("utf-8");
			response.setContentType("text/html;charset=UTF-8");
			service.login(request, response);
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "loginafter";
	}
	
	@RequestMapping("/logoutaction")
	public String LogoutAction(HttpServletRequest request, HttpServletResponse response){
		request.getSession().invalidate();

		return "redirect:/login";
	}
}
