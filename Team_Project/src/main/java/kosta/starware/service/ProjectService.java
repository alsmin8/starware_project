package kosta.starware.service;

import java.util.List;

import kosta.starware.domain.ProjectAttachVO;
import kosta.starware.domain.ProjectCriteria;
import kosta.starware.domain.ProjectDTO;

public interface ProjectService {
	
	public void register(ProjectDTO project);
	
	public ProjectDTO read(int project_No);
	
	public boolean modify(ProjectDTO project);
	
	public boolean remove(int project_No);
	
	public List<ProjectDTO> getList(ProjectCriteria cri);
	
	public int getTotal(ProjectCriteria cri);
	
	public List<ProjectAttachVO> getAttachList(int project_No);
	
	

}