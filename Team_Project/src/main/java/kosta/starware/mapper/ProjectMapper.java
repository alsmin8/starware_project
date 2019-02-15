package kosta.starware.mapper;

import java.util.List;

import kosta.starware.domain.ProjectCriteria;
import kosta.starware.domain.ProjectDTO;

public interface ProjectMapper {
	
	public List<ProjectDTO> getListProject();
	
	public List<ProjectDTO> getListPagingProject(ProjectCriteria cri);
	
	public void registerProject(ProjectDTO project);
	
	public ProjectDTO readProject(int project_No);
	
	public int removeProject(int project_No);////////////////
	
	public int modifyProject(ProjectDTO project);
	
	public int getTotalCountProject(ProjectCriteria cri);
	

	
}
