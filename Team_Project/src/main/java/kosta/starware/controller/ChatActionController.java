package kosta.starware.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import kosta.starware.service.ChatService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RestController
@Log4j
@AllArgsConstructor
public class ChatActionController {
	
	private ChatService service;
	
	@RequestMapping("/UserRegisterCheck")
	public void UserRegisterCheck(){
		
	}
	private String babo;
	
	
}
