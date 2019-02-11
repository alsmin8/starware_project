package kosta.starware.mapper;

import java.util.ArrayList;

import kosta.starware.domain.EmpDTO;
import kosta.starware.domain.UserDTO;

public interface UserMapper {
	UserDTO getOneList(String userID);
	int register(UserDTO userDTO);
	ArrayList<UserDTO> listUserLoad();
	
	
	int OneList(int emp_no); //임시
	EmpDTO getOneList(int emp_no);	//임시
}
