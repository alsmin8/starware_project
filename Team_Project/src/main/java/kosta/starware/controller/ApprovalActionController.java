package kosta.starware.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import kosta.starware.service.ApprovalService;
import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RestController
@Log4j
@AllArgsConstructor
@RequestMapping("/approval2/*")
public class ApprovalActionController {

	@Setter(onMethod_ = { @Autowired })
	private ApprovalService approvalservice;
	
	@RequestMapping("/getDatail.json")
	public ResponseEntity<String> allUserCheck(){
		log.info("allUserCheck");	
		//ArrayList<EmpDTO> emplist = service.getAllUser();
		//log.info(emplist);
		//service.getAllUser()
		return new ResponseEntity<>("success" ,HttpStatus.OK);
	}
}
