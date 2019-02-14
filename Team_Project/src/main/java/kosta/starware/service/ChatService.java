package kosta.starware.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;

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
	public String getID(String fromID, String toID, String listType) throws Exception, IOException{
		StringBuffer result = new StringBuffer("");
		//log.info("getID 시작: " + fromID +" "+ toID);	
		ArrayList<ChatDTO> chatlist = chatMapper.getChatListbyID(fromID, toID, listType);
		//chatMapper.unleadChatUpdate(fromID, toID);
		
		if(chatlist.size() == 0){
			return "";
		}

		result.append("{\"result\":[");
		for (int i = 0; i < chatlist.size(); i++) {
			result.append("[{\"value\": \"" + chatlist.get(i).getFrom_ID() + "\"},");
			result.append("{\"value\": \"" + chatlist.get(i).getTo_ID() + "\"},");
			result.append("{\"value\": \"" + chatlist.get(i).getM_Content().replaceAll(" ", "&nbsp;")
					.replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") + "\"},");
			result.append("{\"value\": \"" + displayTime((chatlist.get(i).getM_regdate().getTime())) + "\"}]");
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
	
	
	
	
	

	//읽지 않은 최근메세지 불러오기
	public ArrayList<ChatDTO> unleadChating(String userID){
		StringBuffer result = new StringBuffer("");
		ArrayList<ChatDTO> chatlist = chatMapper.getChatlist(userID);
		System.out.println(chatlist);
		if(chatlist.size() == 0){
			return null;
		}
		for(int i =0 ; i< chatlist.size() ; i++){
			ChatDTO x = chatlist.get(i);
			for(int j=0; j<chatlist.size() ; i++){
				ChatDTO y = chatlist.get(j);
				if(x.getFrom_ID().equals(y.getTo_ID()) && x.getTo_ID().equals(y.getFrom_ID())){
					if(x.getM_contentNo() < y.getM_contentNo()){
						chatlist.remove(x);
						i--;
						break;
					}else{
						chatlist.remove(y);
						j--;
					}
				}
			}
		}
		System.out.println(chatlist);
		return chatlist;
	}
	//날짜 표시 기능(메소드)
	public String displayTime(Long timeValue) {
		Date today = new Date();
		
		Long gap = today.getTime() - timeValue;
		
		Date dateObj = new Date(timeValue);
		String str = "";
		
		if(gap < (1000 * 60 * 60 * 24)){
			
			int hh = dateObj.getHours();
			int mi = dateObj.getMinutes();
			int ss = dateObj.getSeconds();
			
			if(hh > 9){
				str += "" + hh + ":";
			}else{
				str += "0"+ hh + ":";
			}
			
			if(mi > 9){
				str += "" + mi + ":";
			}else{
				str += "0" + mi + ":";
			}
			
			if(ss > 9){
				str += "" + mi + "";
			}else{
				str += "0" + ss + "";
			}
			
			return str;
		}else{
			int yy = dateObj.getYear() -100;
			int mm = dateObj.getMonth() + 1;
			int dd = dateObj.getDate();
			
			str += yy + "/";
			
			if(mm > 9){
				str += "" + mm + "/\"";
			}else{
				str += "0" + mm + "/\"";
			}
			
			if(dd > 9){
				str += "" + dd + "";
			}else{
				str += "0" + dd + "";
			}
			
			return str;
		}
	}	
}
