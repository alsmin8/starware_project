package kosta.starware.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import kosta.starware.domain.ChatDTO;
import kosta.starware.domain.EmpDTO;


public interface ChatMapper {

		int chatSubmit(ChatDTO chat);
		
		
		ArrayList<ChatDTO> getChatListbyID(@Param("from_ID") String from_ID,@Param("to_ID") String to_ID,@Param("m_contentNo") String listType);
		ArrayList<ChatDTO> getChatlistByRecent(@Param("from_ID") String from_ID,@Param("to_ID") String to_ID,@Param("m_contentNo") int m_Content);
		int unleadUpdate(@Param("from_ID") String from_ID,@Param("to_ID") String to_ID);

		
		
		int unleadAllChatlist(String userID);
		
		
		
		
		
		
		ArrayList<ChatDTO> getChatlist(String userID);
		
		ArrayList<ChatDTO> getChatlistUpdate(int chatNo);
		
		
		//임시불러오기
		EmpDTO getOneUser(@Param("emp_name")String userID);
		EmpDTO getOneUser2(@Param("emp_no")int userID);
		ArrayList<EmpDTO> getAllUser();
}
