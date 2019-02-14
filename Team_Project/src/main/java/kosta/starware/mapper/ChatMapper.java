package kosta.starware.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import kosta.starware.domain.ChatDTO;
import kosta.starware.domain.EmpDTO;


public interface ChatMapper {

		int chatSubmit(ChatDTO chat);
		
		ArrayList<ChatDTO> getChatListbyID(@Param("from_ID") String from_ID,@Param("to_ID") String to_ID,@Param("m_contentNo") String listType);
		
		int unleadUpdate(@Param("from_ID") String from_ID,@Param("to_ID") String to_ID);
		int unleadAllChatlist(String userID);
		
		int unleadUserChatlist(@Param("userID")String userID,@Param("toID") String toID);
		
		
		ArrayList<ChatDTO> getChatlist(String userID);
		
		
		
		
		
		
		ArrayList<ChatDTO> getChatlistUpdate(int chatNo);
		
		
		//임시불러오기
		EmpDTO getOneUser(@Param("emp_name")String userID);
		EmpDTO getOneUser2(@Param("emp_no")int userID);
		ArrayList<EmpDTO> getAllUser();

		
}
