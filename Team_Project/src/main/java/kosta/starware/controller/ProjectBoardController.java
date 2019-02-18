package kosta.starware.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import kosta.starware.domain.ProjectBoardVO;
import kosta.starware.service.ProjectBoardService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/projectboard/")
@Log4j
@AllArgsConstructor
public class ProjectBoardController {

	private ProjectBoardService service;
	
	@PostMapping(value = "/register", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> create(@RequestBody ProjectBoardVO vo){
		
		log.info("ProjectBoardVO : " + vo);
		
		int insertCount = service.register(vo);
		
		log.info("Board Insert Count : " + insertCount);
		
		return insertCount == 1 ? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping(value = "/pages/{project_No}", produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<List<ProjectBoardVO>> getList(@PathVariable("project_No") int project_No){
		
		log.info("getList............." + project_No);
		
		return new ResponseEntity<>(service.getList(project_No), HttpStatus.OK);
	}
	
	@GetMapping(value = "/{project_Board_No}", produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<ProjectBoardVO> get(@PathVariable("project_Board_No") int project_Board_No){
		
		log.info("get............" + project_Board_No);
		
		return new ResponseEntity<>(service.get(project_Board_No),HttpStatus.OK);
		
	}
	
	@DeleteMapping(value = "/{project_Board_No}", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> remove(@PathVariable("project_Board_No") int project_Board_No){
		log.info("remove : " + project_Board_No);
		
		return service.remove(project_Board_No) == 1 ? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@RequestMapping(method = {RequestMethod.PUT, RequestMethod.PATCH}, value = "/{project_Board_No}", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> modify(@RequestBody ProjectBoardVO board,@PathVariable("project_Board_No") int project_Board_No){
		
		
		board.setProject_Board_No(project_Board_No);
		
		log.info("project_Board_No : " + project_Board_No);
		
		log.info("modify : " + board);
		
		return service.modify(board) == 1 ? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		
	}
	
	@RequestMapping(method = {RequestMethod.PUT, RequestMethod.PATCH}, value = "/move/{project_Board_No}", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> move(@RequestBody ProjectBoardVO board, @PathVariable("project_Board_No") int project_Board_No){
		
		board.setProject_Board_No(project_Board_No);
		
		log.info("project_Board_No : " + project_Board_No);
		
		log.info("modify : " + board);
		
		return service.move(board) == 1 ? new ResponseEntity<>("success",HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
}
