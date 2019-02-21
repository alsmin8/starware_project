package kosta.starware.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kosta.starware.domain.ProjectAttachVO;
import kosta.starware.domain.ProjectCriteria;
import kosta.starware.domain.ProjectDTO;
import kosta.starware.mapper.ProjectAttachMapper;
import kosta.starware.mapper.ProjectMapper;
import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class ProjectServiceImpl implements ProjectService{
	
	@Setter(onMethod_=@Autowired)
	private ProjectMapper mapper;
	
	@Setter(onMethod_=@Autowired)
	private ProjectAttachMapper attachMapper;

	@Transactional
	@Override
	public void register(ProjectDTO project) {
		
		log.info("글 등록" + project);
		
		mapper.registerProject(project);
		
		if(project.getAttachList() == null || project.getAttachList().size() <= 0 ){
			return;
		}
		
		project.getAttachList().forEach(attach -> {
			attach.setProject_No(project.getProject_No());
			attachMapper.insert(attach);
		});
	}

	@Override
	public ProjectDTO read(int project_No) {
		
		log.info("리스트조회" + project_No);
		
		return mapper.readProject(project_No);
	}

	@Transactional
	@Override
	public boolean modify(ProjectDTO project) {
		
		log.info("글 수정" + project);
		
		attachMapper.deleteAll(project.getProject_No());
		
		boolean modifyResult = mapper.modifyProject(project) == 1;
		
		if(modifyResult && project.getAttachList().size()>0){
			project.getAttachList().forEach(attach -> {
				attach.setProject_No(project.getProject_No());
				attachMapper.insert(attach);
			});
		}
		
		return modifyResult;
	}

	@Transactional
	@Override
	public boolean remove(int project_No) {
		
		log.info("글 삭제" + project_No);
		
		attachMapper.deleteAll(project_No);
		
		return mapper.removeProject(project_No) == 1;
	}

	@Override
	public List<ProjectDTO> getList(ProjectCriteria cri) {
		
		log.info("getlist....... + cri:" + cri);
		
		return mapper.getListPagingProject(cri);
	}

	@Override
	public int getTotal(ProjectCriteria cri) {
		
		log.info("get total count");

		return mapper.getTotalCountProject(cri);
	}

	@Override
	public List<ProjectAttachVO> getAttachList(int project_No) {
		
		log.info("get Attach list by project_No" + project_No);
		
		return attachMapper.findByProjectNo(project_No);
	}
	
}
