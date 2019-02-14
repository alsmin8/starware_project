package kosta.starware.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kosta.starware.domain.ProjectDTO;
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

	@Override
	public void register(ProjectDTO project) {
		
		log.info("������Ʈ ���......." + project);
		
		mapper.registerProject(project);
	}

	@Override
	public ProjectDTO read(int project_No) {
		
		log.info("������Ʈ �� ����........." + project_No);
		
		return mapper.readProject(project_No);
	}

	@Override
	public boolean modify(ProjectDTO project) {
		
		log.info("������Ʈ ����.........." + project);
		
		return mapper.modifyProject(project) == 1;
	}

	@Override
	public boolean remove(int project_No) {
		
		log.info("������Ʈ ����.........." + project_No);
		
		return mapper.removeProject(project_No) == 1;
	}

	@Override
	public List<ProjectDTO> getList() {
		
		log.info("������Ʈ ����Ʈ.........");
		
		return mapper.getListProject();
	}
	
}