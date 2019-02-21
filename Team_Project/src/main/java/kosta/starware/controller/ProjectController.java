package kosta.starware.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kosta.starware.domain.ProjectAttachFileDTO;
import kosta.starware.domain.ProjectAttachVO;
import kosta.starware.domain.ProjectCriteria;
import kosta.starware.domain.ProjectDTO;
import kosta.starware.domain.ProjectPageDTO;
import kosta.starware.service.ProjectService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Log4j
@RequestMapping("/project/*")
@AllArgsConstructor
public class ProjectController {

	private ProjectService service;

	@GetMapping("/projectList")
	public void projectList(ProjectCriteria cri, Model model) {

		log.info("list + cri");
		model.addAttribute("listProjectForm", service.getList(cri));

		int total = service.getTotal(cri);
		log.info("total:" + total);

		model.addAttribute("pageMaker", new ProjectPageDTO(cri, total));
	}

	@GetMapping(value = "/getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<ProjectAttachVO>> getAttachList(int project_No) {

		log.info("getAttachList" + project_No);

		return new ResponseEntity<>(service.getAttachList(project_No), HttpStatus.OK);
	}

	@PostMapping("/projectInsert")
	public String projectInsert(RedirectAttributes rttr, ProjectDTO project) {

		if (project.getAttachList() != null) {
			project.getAttachList().forEach(attach -> log.info(attach));
		}

		service.register(project);
		log.info("/insertProject" + project);

		rttr.addFlashAttribute("result", project.getProject_No());

		return "redirect:/project/projectList";
	}

	@GetMapping("/projectInsert")
	public void projectInsert() {

	}

	@RequestMapping("/projectDetail")
	public void projectDetail(@RequestParam("project_No") int project_No, Model model,
			@ModelAttribute("cri") ProjectCriteria cri) {
		log.info("detail....");
		model.addAttribute("project", service.read(project_No));
	}

	@RequestMapping("/projectUpdate")
	public void projectUpdate(@RequestParam("project_No") int project_No, Model model,
			@ModelAttribute("cri") ProjectCriteria cri) {
		model.addAttribute("project", service.read(project_No));
		log.info(cri);
	}

	@PostMapping("/projectUpdate")
	public String projectUpdate(ProjectDTO project, @ModelAttribute("cri") ProjectCriteria cri, @RequestParam("project_No") int project_No,
			RedirectAttributes rttr) {

		log.info("update:" + project);
		
		List<ProjectAttachVO> attachList = service.getAttachList(project_No);

		if (service.modify(project)) {
			
			deleteFiles(attachList);
			rttr.addFlashAttribute("result", "success");
		}

		return "redirect:/project/projectList" + cri.getListLink();
	}

	@RequestMapping("/projectDelete")
	public String projectDelete(@RequestParam("project_No") int project_No, RedirectAttributes rttr,
			@ModelAttribute("cri") ProjectCriteria cri) {

		log.info("remove....................." + project_No);

		service.remove(project_No);

		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("ProjectSearchType", cri.getProjectSearchType());
		rttr.addAttribute("ProjectSearchKey", cri.getProjectSearchKey());
		
		rttr.addFlashAttribute("result", "success");

		return "redirect:/project/projectList";
	}

	@GetMapping("/projectDelete")
	public void projectDelete(@RequestParam("project_No") int project_No, Model model,
			@ModelAttribute("cri") ProjectCriteria cri) {

		model.addAttribute("project", service.read(project_No));

		log.info("project_No" + project_No);

	}

	@GetMapping("/uploadForm")
	public void uploadForm() {

		log.info("uploadForm");
	}

	@PostMapping("/uploadFormAction")
	public void uploadFormPost(MultipartFile[] uploadFile, Model model) {

		String uploadFolder = "C:\\upload";

		for (MultipartFile multipartFile : uploadFile) {

			log.info("---------------------------------");
			log.info("upload File Name:" + multipartFile.getOriginalFilename());
			log.info("upload Size:" + multipartFile.getSize());

			File saveFile = new File(uploadFolder, multipartFile.getOriginalFilename());

			try {
				multipartFile.transferTo(saveFile);
			} catch (Exception e) {
				log.error(e.getMessage());
			}
		}
	}

	@GetMapping("/uploadAjax")
	public void uploadAjax() {

		log.info("upload ajax");
	}

	@PostMapping("/deleteFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String fileName, String type) {
		log.info("deleteFile : " + fileName);

		File file;

		try {
			file = new File("E:\\upload\\" + URLDecoder.decode(fileName, "UTF-8"));

			file.delete();

			if (type.equals("image")) {

				String largeFileName = file.getAbsolutePath().replace("s_", "");

				log.info("largeFileName : " + largeFileName);

				file = new File(largeFileName);

				file.delete();

			}

		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}

		return new ResponseEntity<String>("deleted", HttpStatus.OK);
	}
	
	@PostMapping(value = "/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<ProjectAttachFileDTO>> uploadAjaxPost(MultipartFile[] uploadFile) {

		List<ProjectAttachFileDTO> list = new ArrayList<>();
		String uploadFolder = "C:\\upload";

		String uploadFolderPath = getFolder();

		File uploadPath = new File(uploadFolder, uploadFolderPath);

		log.info("upload path:" + uploadPath);

		if (uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}

		for (MultipartFile multipartFile : uploadFile) {

			ProjectAttachFileDTO attachDTO = new ProjectAttachFileDTO();

			String uploadFileName = multipartFile.getOriginalFilename();

			log.info("---------------------------------");
			log.info("upload File Name:" + multipartFile.getOriginalFilename());
			log.info("upload Size:" + multipartFile.getSize());

			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
			log.info("file name:" + uploadFileName);

			attachDTO.setProject_fileName(uploadFileName);

			UUID uuid = UUID.randomUUID();

			uploadFileName = uuid.toString() + "_" + uploadFileName;

			try {
				File saveFile = new File(uploadPath, uploadFileName);
				multipartFile.transferTo(saveFile);

				attachDTO.setProject_uuid(uuid.toString());
				attachDTO.setProject_uploadPath(uploadFolderPath);

				list.add(attachDTO);

			} catch (Exception e) {
				log.error(e.getMessage());
			}
		}

		return new ResponseEntity<>(list, HttpStatus.OK);
	}

	private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		Date date = new Date();

		String str = sdf.format(date);

		return str.replace("-", File.separator);

	}

	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName) {
		log.info("fileName : " + fileName);

		File file = new File("c:\\upload\\" + fileName);

		log.info("file : " + file);

		ResponseEntity<byte[]> result = null;

		try {

			HttpHeaders header = new HttpHeaders();

			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	@GetMapping(value = "/download", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public ResponseEntity<Resource> downloadFile(@RequestHeader("User-Agent") String userAgent, String fileName) {

		log.info("download file : " + fileName);

		Resource resource = new FileSystemResource("c:\\upload\\" + fileName);

		if (resource.exists() == false) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}

		log.info("resource : " + resource);

		String resourceName = resource.getFilename();
		String resourceOriginalName = resourceName.substring(resourceName.indexOf("_") + 1);

		HttpHeaders headers = new HttpHeaders();

		try {

			String downloadName = null;

			if (userAgent.contains("Trident")) {
				log.info("IE browser");
				downloadName = URLEncoder.encode(resourceOriginalName, "UTF-8").replaceAll("\\+", " ");
			} else if (userAgent.contains("Edge")) {
				log.info("Edge browser");
				downloadName = URLEncoder.encode(resourceOriginalName, "UTF-8");
			} else {
				log.info("Chrome browser");
				downloadName = new String(resourceOriginalName.getBytes("UTF-8"), "ISO-8859-1");
			}

			log.info("downloadName : " + downloadName);

			// headers.add("Content-Disposition", "attachment; filename=" + new
			// String(resourceName.getBytes("UTF-8"),"ISO-8859-1"));
			headers.add("Content-Disposition", "attachment; filename=" + downloadName);

		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
	}

	private void deleteFiles(List<ProjectAttachVO> attachList){
		
		if(attachList == null || attachList.size() == 0){
			return;
		}
		
		log.info("delete attach files.........");
		log.info(attachList);
		
		attachList.forEach(attach -> {
			try{
				Path file = Paths.get("c:\\upload\\"+attach.getProject_uploadPath()+"\\"+attach.getProject_uuid()+"_"+attach.getProject_fileName());
				
				Files.deleteIfExists(file);
				
				if(Files.probeContentType(file).startsWith("image")){
					
					Path thumbNail = Paths.get("c:\\upload\\"+attach.getProject_uploadPath()+"\\s"+attach.getProject_uuid()+"_"+attach.getProject_fileName());
					
					Files.delete(thumbNail);
				}
				}catch(Exception e){
					log.error("delete file error" + e.getMessage());
				}
		});
	}
	
	@GetMapping("/projectBoard")
	   public void board(@RequestParam("project_No") int project_No,Model model){
	      
	      model.addAttribute("project", service.read(project_No));
	      
	   }
}
