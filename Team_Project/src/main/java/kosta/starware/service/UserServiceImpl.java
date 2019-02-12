package kosta.starware.service;

import org.springframework.stereotype.Service;

import kosta.starware.domain.EmpDTO;
import kosta.starware.domain.UserVO;
import kosta.starware.mapper.UserMapper;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@AllArgsConstructor
public class UserServiceImpl implements UserService {

	private UserMapper mapper;

	@Override
	public EmpDTO loginService(UserVO vo) throws Exception {
		int emp_no = Integer.parseInt(vo.getEmp_no());

		return mapper.login(emp_no);
	}

	@Override
	public int loginCheck(UserVO vo) {

		String emp_no = vo.getEmp_no();
		String emp_pass = vo.getEmp_pass();

		//System.out.println(emp_no);
		//System.out.println(emp_pass);

		int re = -1;

		if (emp_no == null || emp_no.equals("") || emp_pass == null || emp_pass.equals("")) {
			return re;
		} else if (emp_no.matches("(^[^0-9]*$)")) {
			re = 0;
			return re;
		} else {
			return 1;

		}
	}

}