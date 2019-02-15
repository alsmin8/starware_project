package kosta.starware.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
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
		service.deleteNoticeService(notice_no);
		
		rttr.addAttribute("pageNum", ncri.getPageNum());
		rttr.addAttribute("amount", ncri.getAmount());
		
		return "redirect:/notice/noticeList";
	}
	
	
	private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);
		return str.replace("-", File.separator);

	}
	
	//check Image
	private boolean checkImageType(File file) {
		log.info("file??"+file);

		try {
			String contentType = Files.probeContentType(file.toPath());
			log.info("컨텐트타입??"+contentType);

			return contentType.startsWith("image");

		} catch (IOException e) {
			// TODO Auto-generated catch block
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
		
		
		nafDTO.setNa_fileName(uploadFileName);
		
		UUID uuid=UUID.randomUUID();
		uploadFileName=uuid.toString()+"_"+uploadFileName;
		
	
		try {
			File saveFile=new File(uploadPath, uploadFileName);
			multipartFile.transferTo(saveFile);
			
		
			nafDTO.setNa_uuid(uuid.toString());
			nafDTO.setNa_uploadPath(uploadFolderPath);
			
			log.info(nafDTO);
			
			//check image type, 썸네일 생성
			if(checkImageType(saveFile)){
				nafDTO.setNa_image(true);
				FileOutputStream thumbnail=new FileOutputStream(new File(uploadPath, "s_"+uploadFileName));
				Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 100, 100);
				thumbnail.close();
			}
			
			list.add(nafDTO);
			log.info("리스트:"+list);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
			
		}//end for
		
		return new ResponseEntity<>(list, HttpStatus.OK);
		
		
	}
	
	


		
	
	
}
