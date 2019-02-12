package kosta.starware.service;

import kosta.starware.domain.EmpDTO;
import kosta.starware.domain.UserVO;

public interface UserService {

	public EmpDTO loginService(UserVO vo) throws Exception;

	public int loginCheck(UserVO vo);

}
