package kosta.starware.domain;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class UserDTO{
	private String userID;
	private String userPassword;
	private String userName;
	private int userAge;
	
}
