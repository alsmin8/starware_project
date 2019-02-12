package kosta.starware.service;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kosta.starware.domain.ChatDTO;
import kosta.starware.domain.EmpDTO;
import kosta.starware.mapper.ChatMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class ChatService {
	
	@Setter(onMethod_ = @Autowired)
	private ChatMapper chatMapper;
	
	//messengerFind이동시 session 체크 여부
	public int userCheck(HttpSession session) {
		String emp_no = (String) session.getAttribute("emp_no");
		String emp_name = (String) session.getAttribute("emp_name");
		
		if (emp_no == null || emp_name == null) {
			session.setAttribute("messageType", "오류메세지");
			session.setAttribute("messageContent", "현재 로그인이 되어있지 않습니다.");
			return 0;
		}
		return 1;
	}
	//전체 emp유저 불러오기
	public ArrayList<EmpDTO> getAllUser() {	
		
		return chatMapper.getAllUser();
	}
	//사용자 검색 (이름)
	public EmpDTO getUser(String userID) {	
		
		return chatMapper.getOneUser(userID);
	}	
	//사용자 검색(사번)
	public EmpDTO getUser2(int userID) {	
		// TODO Auto-generated method stub
		return chatMapper.getOneUser2(userID);
	}
	//메신저 사용자 체크
	public String chatUserCheck(HttpSession session, String toID) {
		log.info(session.getAttribute("emp_no"));
		log.info(session.getAttribute("emp_name"));
		log.info(toID);
		String emp_no = (String) session.getAttribute("emp_no");
		String emp_name = (String) session.getAttribute("emp_name");
		
		if (emp_no == null || emp_name ==null) {
			session.setAttribute("messageType", "오류메세지");
			session.setAttribute("messageContent", "현재 로그인이 되어있지 않습니다.");
			return "-1";
		}
		if (toID == null|| toID.equals("")){
			session.setAttribute("messageType", "오류메세지");
			session.setAttribute("messageContent", "대화상대가  지정되지 않았습니다.");
			return "0";
		}
		return "1";
	}
	//메세지 DB저장
	public int insertChatSubmit(ChatDTO dto) {
		return chatMapper.chatSubmit(dto);
	}
	//사용자간 메세지 불러오기
	public String messengerChat(String fromID, String toID, String listType) throws Exception, IOException{
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
		//return chatMapper.getChatListbyID(fromID, toID, listType);
	}
	public String getTen(String fromID, String toID) throws Exception{
		StringBuffer result = new StringBuffer("");
		//log.info("getTen 시작: " + fromID +" "+ toID);		
		ArrayList<ChatDTO> chatlist = chatMapper.getChatlistByRecent(fromID, toID, 10);
		
		//log.info("chatlist : " + chatlist);	
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
		
		//System.out.println(result);
		readChat(fromID, toID);
		return result.toString();
	}
	public String getID(String fromID, String toID, String listType) throws Exception{
		StringBuffer result = new StringBuffer("");
		//log.info("getID 시작: " + fromID +" "+ toID);	
		ArrayList<ChatDTO> chatlist = chatMapper.getChatListbyID(fromID, toID, listType);
		//log.info("chatlist : " + chatlist);
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
		
		//System.out.println(result);
		readChat(fromID, toID);
		return result.toString();
	}
	//안읽은 메세지 업데이트
	public int readChat(String fromID, String toID){
		return chatMapper.unleadUpdate(fromID, toID);
	}
	
	//안 읽은 전체 메세지 갯수 
	public int unleadAllChatlist(String userID){
		return chatMapper.unleadAllChatlist(userID);
	}


}
