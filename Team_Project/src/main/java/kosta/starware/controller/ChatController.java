package kosta.starware.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kosta.starware.service.ChatService;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/chat/*")
public class ChatController {

	@Setter(onMethod_ = @Autowired)
	private ChatService service;
	
	@RequestMapping("messengerFind")
	public String MessengerFind(HttpSession session){
		//log.info("messengerFind");
		int result = service.userCheck(session);
		
		if (result == 0) {
			return "redirect:/login";
			//return "/chat/messengerFind";
		}else{
			return "/chat/messengerFind";
		}
	}
	
	@RequestMapping("/messengerChat")
	public String MessengerChat(HttpSession session, @RequestParam("toID") String toID, Model model){
		
		String result = service.chatUserCheck(session, toID);
		//model.addAttribute("board", service.messengerChat(fromID, toID, listType));
		if (result == "-1") {
			return "redirect:/login";
		}else if(result == "0"){
			return "/chat/messengerFind";
		}else{
			model.addAttribute("toID", toID);
			return "/chat/messengerChat";
		}
	}
}
