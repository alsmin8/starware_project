package kosta.starware.controller;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.imageio.ImageIO;

import org.apache.commons.codec.binary.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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
	public ResponseEntity<HashMap> getDatail(@RequestParam String app_no,@RequestParam String app_kind, @RequestParam String emp_no){
		log.info("getDatail : 가져온 번호 => " + app_no + " 가져온 문서종류 => " + app_kind + "가져온 emp_no => " + emp_no);	
		HashMap detail = approvalservice.resultDetail(app_no, app_kind, emp_no);
		log.info(detail);
		return detail != null ? new ResponseEntity<>(detail ,HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@RequestMapping("/getAccept")
	public ResponseEntity<String> getAccept(PowerDTO powerDTO,@RequestParam String DataURL){
		log.info("getAccept" + powerDTO);
		String upload = MakeUploadFile(powerDTO, DataURL);
		powerDTO.setUpload(upload);
		//log.info(upload);
		int accept = approvalservice.resultAccept(powerDTO);
		return accept==1 ? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		//return new ResponseEntity<>("success", HttpStatus.OK);
	}
	
	@RequestMapping("/getReject")
	public ResponseEntity<String> getReject(PowerDTO powerDTO, @RequestParam String DataURL){
		log.info("getReject" + powerDTO);
		String upload = MakeUploadFile(powerDTO, DataURL);
		powerDTO.setUpload(upload);
		//log.info(upload);
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
			//log.info(list);
			return new ResponseEntity<>(list ,HttpStatus.OK);
		}
	}
	
	//파일 업로드 메소드
	private String MakeUploadFile(PowerDTO powerDTO, String upload){
		/**
		 * upload (imgbase64data:image/png;base64,iVBORw0KGgoAA 로 시작)
		 * saveFilePath (저장경로)
		 * saveName (파일이름)
		 */ 
		String saveFilePath = "C:\\upload";
		String saveName = powerDTO.getApp_no() +"_" + powerDTO.getEmp_no() + "_Sign";
		String uploadFolderPath=getFolder();
		
		File uploadPath = new File(saveFilePath, uploadFolderPath);
		if(uploadPath.exists()==false){
			uploadPath.mkdirs();
		}
		
		try {
		BufferedImage image = null;
		
		String[] base64Arr = upload.split(","); // image/png;base64, 이 부분 버리기 위한 작업
		byte[] imageByte = Base64.decodeBase64(base64Arr[1]); // base64 to byte array로 변경
		
		ByteArrayInputStream bis = new ByteArrayInputStream(imageByte);
		image = ImageIO.read(bis);
		bis.close();

		File outputfile = new File(uploadPath +"\\"+ saveName + ".png");
		log.info("save -> " + uploadPath +"\\"+ saveName + ".png");
		ImageIO.write(image, "png", outputfile); // 파일생성
		}catch (Exception e) {
			e.printStackTrace();
		}
		return uploadPath +"\\"+ saveName + ".png";
	}
	
	
	private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);
		return str.replace("-", File.separator);
	}
	
	
	//파일디테일 로드 메소드
	@RequestMapping("/display")
	public ResponseEntity<byte[]> getFile(String fileName){
		log.info(fileName);
		
		File file=new File(fileName);
		
		ResponseEntity<byte[]> result = null;

		try {
			//HttpHeaders header = new HttpHeaders();
			//header.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), HttpStatus.OK);
		} catch (IOException e) {
		
			e.printStackTrace();
		}
		return result;
	}
}
