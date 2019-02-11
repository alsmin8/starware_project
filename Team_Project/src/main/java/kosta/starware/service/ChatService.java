package kosta.starware.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kosta.starware.domain.ChatDTO;
import kosta.starware.domain.EmpDTO;
import kosta.starware.mapper.ChatMapper;
import lombok.Setter;

@Service
public class ChatService {
	
	@Setter(onMethod_ = @Autowired)
	private ChatMapper chatMapper;
	
	public ArrayList<EmpDTO> getAllUser() {
		
		return chatMapper.getAllUser();
	}
	
	public EmpDTO getUser(String userID) {
		
		return chatMapper.getOneUser(userID);
	}
	
	
	
	
	
	public int insertChatSubmit(ChatDTO dto) {
		// TODO Auto-generated method stub
		return 0;
	}
	
	public void messengerChat(String fromID, String toID, String listType){
		
/*		if (fromID == null || fromID.equals("")||toID == null || toID.equals("")||listType == null || listType.equals("")) {
			System.out.println("빈칸");
			response.getWriter().write("");
		}else if (listType.equals("ten")) {
			System.out.println("ten");
			response.getWriter().write(getTen(fromID, toID));
		}else {
			try {
				System.out.println("getID");
				response.getWriter().write(getID(fromID, toID, listType));
			} catch (Exception e) {
				System.out.println("오류");
				response.getWriter().write("");
			}
		}
		return chatMapper.getChatListbyID(fromID, toID, 10);*/
	}
	
	public String Chatlist(String fromID, String toID, String listType) throws Exception {

		if (fromID == null || fromID.equals("")||toID == null || toID.equals("")||listType == null || listType.equals("")) {
			System.out.println("빈칸");
			return "";
		}else if (listType.equals("ten")) {
			System.out.println("ten");
			return getTen(fromID, toID);
		}else {
			try {
				System.out.println("getID");
				return getID(fromID, toID, listType);
			} catch (Exception e) {
				System.out.println("오류");
				return "";
			}
		}
	}
	public String getTen(String fromID, String toID) throws Exception{
		StringBuffer result = new StringBuffer("");

		ArrayList<ChatDTO> chatlist = chatMapper.getChatlistByRecent(fromID, toID, 40);

		if(chatlist.size() == 0){
			return "";
		}
		
		String timeType = "오전";
		
		result.append("{\"result\":[");
		for (int i = 0; i < chatlist.size(); i++) {
			result.append("[{\"value\": \"" + chatlist.get(i).getFrom_ID() + "\"},");
			result.append("{\"value\": \"" + chatlist.get(i).getTo_ID() + "\"},");
			result.append("{\"value\": \"" + chatlist.get(i).getM_Content().replaceAll(" ", "&nbsp;")
					.replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") + "\"},");
			int chatTime = Integer.parseInt(chatlist.get(i).getM_regdate().substring(11, 13));
			if (chatTime >= 12) {
				timeType = "오후";
				chatTime -= 12;
			}
			result.append("{\"value\": \"" + chatlist.get(i).getM_regdate().substring(0, 11) + " " + timeType + " "
					+ chatTime + ":" + chatlist.get(i).getM_regdate().substring(14, 16) + "\"}]");
			if (i != chatlist.size() - 1) {
				result.append(",");
			}
		}
		result.append("], \"last\" : \"" + chatlist.get(chatlist.size() - 1).getM_contentNo() + "\"}");
		
		System.out.println(result);
		
		return result.toString();
	}
	
	public String getID(String fromID, String toID, String listType) throws Exception{
		StringBuffer result = new StringBuffer("");

		ArrayList<ChatDTO> chatlist = chatMapper.getChatListbyID(fromID, toID, listType);
		//chatMapper.unleadChatUpdate(fromID, toID);
		
		if(chatlist.size() == 0){
			return "";
		}
		String timeType = "오전";

		result.append("{\"result\":[");
		for (int i = 0; i < chatlist.size(); i++) {
			result.append("[{\"value\": \"" + chatlist.get(i).getFrom_ID() + "\"},");
			result.append("{\"value\": \"" + chatlist.get(i).getTo_ID() + "\"},");
			result.append("{\"value\": \"" + chatlist.get(i).getM_Content().replaceAll(" ", "&nbsp;")
					.replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") + "\"},");
			int chatTime = Integer.parseInt(chatlist.get(i).getM_regdate().substring(11, 13));
			if (chatTime >= 12) {
				timeType = "오후";
				chatTime -= 12;
			}
			result.append("{\"value\": \"" + chatlist.get(i).getM_regdate().substring(0, 11) + " " + timeType + " "
					+ chatTime + ":" + chatlist.get(i).getM_regdate().substring(14, 16) + "\"}]");
			if (i != chatlist.size() - 1) {
				result.append(",");
			}
		}
		result.append("], \"last\" : \"" + chatlist.get(chatlist.size() - 1).getM_contentNo() + "\"}");
		
		System.out.println(result);
		
		return result.toString();
	}
	
}
