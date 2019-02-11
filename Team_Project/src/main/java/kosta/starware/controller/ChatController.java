package kosta.starware.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

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
	public void MessengerFind(){
		
	}

	@RequestMapping("/messengerChat")
	public void MessengerChat(Model model){
		log.info("messengerChat");
		//model.addAttribute("board", service.messengerChat(fromID, toID, listType));
	}


	
}
