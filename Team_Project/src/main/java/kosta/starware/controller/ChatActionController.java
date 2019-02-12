package kosta.starware.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

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
		
		ArrayList<EmpDTO> emplist = service.getAllUser();
		log.info(emplist);
		
		return new ResponseEntity<>(service.getAllUser() ,HttpStatus.OK);
	}
	
	@RequestMapping("/userRegisterCheck.json")
	public EmpDTO userCheck(@RequestParam String userID){
		log.info("userID :" +userID);
	
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
	

	@RequestMapping(value = "/insertChatSubmit")
	public ResponseEntity<String> insertChatSubmit(){
		log.info("insertChatSubmit");
		
		return new ResponseEntity<>("success", HttpStatus.OK);
	}
	
	@RequestMapping("/listChatLoad")
	public void listChatLoad(){
		log.info("listChatLoad");
		
	}
	
	@RequestMapping("/unleadChat")
	public void unleadChat(){
		log.info("unleadChat");
		
	}
	

	
}
