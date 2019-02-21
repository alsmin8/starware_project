package kosta.starware.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kosta.starware.domain.NoticeAttachFileDTO;
import kosta.starware.domain.NoticeAttachVO;
import kosta.starware.domain.NoticeCriteria;
import kosta.starware.domain.NoticePageDTO;
import kosta.starware.domain.NoticeVO;
import kosta.starware.service.NoticeService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;


@Controller
@Log4j
@RequestMapping("/notice/*")
@AllArgsConstructor
public class NoticeController {

	private NoticeService service;
	
	@GetMapping("/noticeList")
	public void list(NoticeCriteria ncri, Model model){
		model.addAttribute("noticeList", service.listNoticeService(ncri));		
		int total=service.getNoticeTotalService(ncri);
		model.addAttribute("noticeModel", new NoticePageDTO(ncri, total));
	}	
	
	@GetMapping("/noticeInsertForm")
	public void noticeInsertForm(){
		
	}
	
	@PostMapping("/noticeInsert")
	public String noticeInsert(NoticeVO notice, RedirectAttributes rttr){
		
		log.info("notice Insert:"+notice);
		
	/*	if(notice.getAttachList()!=null){
			notice.getAttachList().forEach(attach ->log.info(attach));
		}*/
		service.insertNoticeService(notice);
		
		rttr.addFlashAttribute("result", notice.getNotice_no());
		return "redirect:/notice/noticeList";
		
	}
	
	
	@GetMapping("/noticeUpdateForm")
	public void noticeUpdateForm(@RequestParam("notice_no") int notice_no, 
			@ModelAttribute("ncri") NoticeCriteria ncri,
			Model model){
		model.addAttribute("notice", service.detailNoticeService(notice_no));
	}
	
	@RequestMapping("/noticeUpdate")
	public String noticeUpdate(NoticeVO notice, @ModelAttribute("ncri") NoticeCriteria ncri, RedirectAttributes rttr){
		log.info("notice update:"+notice);
		service.updateNoticeService(notice);
		 
		rttr.addAttribute("pageNum", ncri.getPageNum());
		rttr.addAttribute("amount", ncri.getAmount());
		//rttr.addFlashAttribute("result", notice.getNotice_no());
		
		return "redirect:/notice/noticeList";
	}
	
	
	@RequestMapping("/noticeDetail")
	public void noticeDetail(@RequestParam("notice_no") int notice_no, 
			@ModelAttribute("ncri") NoticeCriteria ncri, Model model){
		model.addAttribute("notice", service.detailNoticeService(notice_no));
		//log.info(model);
	}
	
	
	@GetMapping("/noticeDeleteForm")
	public void noticeDeleteForm(@RequestParam("notice_no") int notice_no,
			@ModelAttribute("ncri") NoticeCriteria ncri,Model model){
		model.addAttribute("notice", service.detailNoticeService(notice_no));
		//log.info(model);
	}
	
	@RequestMapping("/noticeDelete")
	public String noticeDelete(@RequestParam("notice_no") int notice_no
			, @ModelAttribute("ncri") NoticeCriteria ncri,
			RedirectAttributes rttr){
		
		List<NoticeAttachVO> attachList=service.getAttachList(notice_no);				
		
		if(service.deleteNoticeService(notice_no)){
			deleteFiles(attachList);
			log.info("deleted....");
		}
	
		//service.deleteNoticeService(notice_no);
		
		rttr.addAttribute("pageNum", ncri.getPageNum());
		rttr.addAttribute("amount", ncri.getAmount());
		
		return "redirect:/notice/noticeList"+ncri.getListLink();
	}
	
	
	private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);
		return str.replace("-", File.separator);

	}
	
	//check Image
	private boolean checkImageType(File file) {

		try {
			String contentType = Files.probeContentType(file.toPath());
			//log.info("컨텐트타입??"+contentType);

			return contentType.startsWith("image");

		} catch (IOException e) {

			e.printStackTrace();
		}
		return false;
	}
	

	
	@RequestMapping(value="/uploadAjaxAction", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<NoticeAttachFileDTO>> uploadAjaxAction(MultipartFile[] uploadFile){
		
		List<NoticeAttachFileDTO> list=new ArrayList<>();
		String uploadFolder = "C:\\upload";
		
		String uploadFolderPath=getFolder();
		
		//make folder
		//File uploadPath=new File(uploadFolder, getFolder());
		File uploadPath = new File(uploadFolder, uploadFolderPath);

		
		if(uploadPath.exists()==false){
			uploadPath.mkdirs();
		}
		//make yyyy/MM/dd folder
		
		for(MultipartFile multipartFile : uploadFile){
		
		NoticeAttachFileDTO nafDTO=new NoticeAttachFileDTO();
		
			
		log.info("============================================");
		log.info("upload file name:"+multipartFile.getOriginalFilename());
		log.info("upload file size:"+multipartFile.getSize());
		
		String uploadFileName = multipartFile.getOriginalFilename();

		// IE has file path
		uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
		
		
		nafDTO.setFileName(uploadFileName);
		
		UUID uuid=UUID.randomUUID();
		uploadFileName=uuid.toString()+"_"+uploadFileName;
		
	
		try {
			File saveFile=new File(uploadPath, uploadFileName);
			multipartFile.transferTo(saveFile);
			
		
			nafDTO.setUuid(uuid.toString());
			nafDTO.setUploadPath(uploadFolderPath);
			
			log.info(nafDTO);
			
			//check image type, 썸네일 생성
			if(checkImageType(saveFile)){
				nafDTO.setImage(true);
				log.info(nafDTO);
				
				
				FileOutputStream thumbnail=new FileOutputStream(new File(uploadPath, "s_"+uploadFileName));
				Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 100, 100);
				thumbnail.close();
			}
			
			list.add(nafDTO);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
			
		}//end for
		
		return new ResponseEntity<>(list, HttpStatus.OK);
		
		
	}
	
	
	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName){
		log.info("fileName:"+fileName);
		
		File file=new File("C:\\upload"+fileName);
		
		ResponseEntity<byte[]> result = null;

		try {
			HttpHeaders header = new HttpHeaders();

			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		} catch (IOException e) {
		
			e.printStackTrace();
		}
		return result;
	}


	@GetMapping(value="/download", produces=MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public ResponseEntity<Resource> downloadFile(String fileName){
		Resource resource=new FileSystemResource("C:\\upload\\"+fileName);
		
		String resourceName=resource.getFilename();
		
		//remove UUID
		String resourceOriginalName=resourceName.substring(resourceName.indexOf("_")+1);
		
		HttpHeaders headers=new HttpHeaders();
		
		try {
			//String downloadName=null;
			//downloadName=new String(resourceOriginalName.getBytes("UTF-8"), "ISO-8859-1");
			
			headers.add("Content-Disposition", "attachment; filename=" + new String(resourceName.getBytes("UTF-8"), "ISO-8859-1"));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
	}
	
	@PostMapping("/deleteFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String fileName, String type){
		File file;
		
		try {
			file=new File("c:\\upload\\"+URLDecoder.decode(fileName, "UTF-8"));
			file.delete();
			
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		return new ResponseEntity<String>("deleted", HttpStatus.OK);
	}
	
	
	@RequestMapping(value="/getAttachList", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<NoticeAttachVO>> getAttachList(int notice_no){
		return new ResponseEntity<>(service.getAttachList(notice_no), HttpStatus.OK);
	}
	
	
	public void deleteFiles(List<NoticeAttachVO> attachList){
		if(attachList==null||attachList.size()==0){
			return;
		}
		
		attachList.forEach(attach -> {
		
			try {

				Path file=Paths.get("C:\\upload\\"+attach.getNotice_uploadPath()+"\\"+attach.getNotice_uuid()+"_"+attach.getNotice_fileName());
				Files.deleteIfExists(file);
				
				if(Files.probeContentType(file).startsWith("image")){
						Path thumbNail=Paths.get("C:\\upload\\"+attach.getNotice_uploadPath()+"\\s_"+attach.getNotice_uuid()+"_"+attach.getNotice_fileName());
						
						Files.delete(thumbNail);
				}
				
			} catch (Exception e) {
				log.error("delete file error:"+e.getMessage());
			}
		
		}); //end foreach
		
	}
	
}
	
	
	



