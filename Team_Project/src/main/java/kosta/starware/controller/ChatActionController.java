package kosta.starware.controller;

import java.io.IOException;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import kosta.starware.domain.ChatDTO;
import kosta.starware.domain.EmpDTO;
import kosta.starware.service.ChatService;
import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RestController
@Log4j
@AllArgsConstructor
@RequestMapping("/chat2/*")
public class ChatActionController {
	
	@Setter(onMethod_ = @Autowired)
	private ChatService service;
	
	@RequestMapping("/allUserCheck.json")
	public ResponseEntity<ArrayList<EmpDTO>> allUserCheck(){
		log.info("allUserCheck");	
		//ArrayList<EmpDTO> emplist = service.getAllUser();
		//log.info(emplist);
		return new ResponseEntity<>(service.getAllUser() ,HttpStatus.OK);
	}
	
	@RequestMapping(value = "/userRegisterCheck", produces = "application/json")
	public EmpDTO userCheck(@RequestParam String userID){
		log.info("userRegisterCheck.json");	
		//log.info("userID :" +userID);
		EmpDTO dto = null;
		
		if(isStringDouble(userID)){
			dto = service.getUser2(Integer.parseInt(userID));
		}else{
			dto = service.getUser(userID);
		}
		return dto;
	}
	public static boolean isStringDouble(String s) {
	    try {
	        Double.parseDouble(s);
	        return true;
	    } catch (NumberFormatException e) {
	        return false;
	    }
	  }
	
	@RequestMapping(value = "/insertChatSubmit", consumes="application/json", produces={MediaType.TEXT_PLAIN_VALUE})
	public String insertChatSubmit(@RequestBody ChatDTO chatDTO){
		log.info("insertChatSubmit");
		//log.info(chatDTO);
		int result = service.insertChatSubmit(chatDTO);

		if(result == 1){
			return "1";
		}else if(result == 0){
			return "0";
		}else{
			return "-1";
		}
	}

	@RequestMapping(value="/listChatLoad", produces = "application/text; charset=utf8")
	public String listChatLoad(@RequestParam String fromID, @RequestParam String toID, @RequestParam String listType) throws Exception, IOException, Exception{
		log.info("listChatLoad");
		return service.messengerChat(fromID, toID, listType);	
	}

	@RequestMapping("/unleadAllChatlist")
	public String unleadAllChatlist(@RequestParam String userID){
		log.info("unleadAllChatlist");		
		String count = String.valueOf(service.unleadAllChatlist(userID));
		
		return count;
	}
	
	@RequestMapping(value ="/unreadChatMessaging", produces = "application/json")
	public ResponseEntity<ArrayList<ChatDTO>> unleadChating(@RequestParam String userID){
		log.info("unleadChating");		
		
		return new ResponseEntity<>(service.unreadChating(userID),HttpStatus.OK);
	}
}
