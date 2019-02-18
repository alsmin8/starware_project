package kosta.starware.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import kosta.starware.domain.PowerDTO;
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
	public ResponseEntity<HashMap> getDatail(@RequestParam String app_no,@RequestParam String app_kind){
		log.info("getDatail : 가져온 번호 => " + app_no + " 가져온 문서종류 => " + app_kind);	
		HashMap detail = approvalservice.resultDetail(app_no, app_kind);
		log.info(detail);
		return detail != null ? new ResponseEntity<>(detail ,HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@RequestMapping("/getAccept")
	public ResponseEntity<String> getAccept(PowerDTO powerDTO){
		log.info("getAccept" + powerDTO);	
		int accept = approvalservice.resultAccept(powerDTO);
		return accept==1 ? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		//return new ResponseEntity<>("success", HttpStatus.OK);
	}
	
	@RequestMapping("/getReject")
	public ResponseEntity<String> getReject(PowerDTO powerDTO){
		log.info("getReject" + powerDTO);
		int reject = approvalservice.resultReject(powerDTO);
		return reject==1 ? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		//return new ResponseEntity<>("success", HttpStatus.OK);
	}
	@RequestMapping(value ="/listJsonEmp", produces = "application/json")
	public ResponseEntity<List<HashMap>> listJsonEmp(@RequestParam String keyword){
		log.info("listJsonEmp");
		if(keyword == null || keyword == ""){
			return null;
		}else{
			List<HashMap> list = approvalservice.listJsonEmp(keyword);
			log.info(list);
			return new ResponseEntity<>(list ,HttpStatus.OK);
		}
	}
}
