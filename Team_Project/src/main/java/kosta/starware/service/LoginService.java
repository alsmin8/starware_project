package kosta.starware.service;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kosta.starware.domain.EmpDTO;
import kosta.starware.mapper.UserMapper;
import lombok.Setter;

@Service
public class LoginService {

	@Setter(onMethod_ = @Autowired)
	private UserMapper userMapper;

	public int login(HttpServletRequest request, HttpServletResponse response)throws Exception, IOException {
		// TODO Auto-generated method stub
		String emp_pass = request.getParameter("userPassword");
		//Emp emp = new Emp();
		//emp.setEmp_no(Integer.parseInt(request.getParameter("userID")));
		//emp.setEmp_pass(request.getParameter("userPassword1"));
		
		String userID = request.getParameter("userID");

		int re = -1;
		
		if (userID == null || userID.equals("") || emp_pass == null || emp_pass.equals("")) {
			request.getSession().setAttribute("messageType", "오류메세지");
			request.getSession().setAttribute("messageContent", "모든내용을 입력해주세요.");
			response.sendRedirect("/login");
			return re;
		}else if(userID.matches("(^[^0-9]*$)")){
			request.getSession().setAttribute("messageType", "오류메세지");
			request.getSession().setAttribute("messageContent", "아이디는 숫자만 입력해주세요.");
			response.sendRedirect("/login");
			return re;
		}else {
			int emp_no = Integer.parseInt(userID);
			re = userMapper.OneList(emp_no);
			System.out.println(re);

			if (re == -1) {
				request.getSession().setAttribute("messageType", "오류메세지");
				request.getSession().setAttribute("messageContent", "아이디가 존재하지않습니다.");
				response.sendRedirect("/login");
				return re;
			} else if (re == 0) {
				request.getSession().setAttribute("messageType", "오류메세지");
				request.getSession().setAttribute("messageContent", "비밀번호가 틀립니다.");
				response.sendRedirect("/login");
				return re;
			} else {
				EmpDTO emp = userMapper.getOneList(emp_no);
				request.getSession().setAttribute("emp_name", emp.getEmp_name());
				request.getSession().setAttribute("emp_no", userID);
				request.getSession().setAttribute("messageType", "성공메세지");
				request.getSession().setAttribute("messageContent", "로그인 되었습니다.");
				response.sendRedirect("/loginafter");
				//RequestDispatcher dispatcher=request.getRequestDispatcher("loginafter.jsp");
				//dispatcher.forward(request, response);
				return re;
			}
		}
	}
}
