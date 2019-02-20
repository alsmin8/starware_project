package kosta.starware.mapper;

import java.util.List;

import kosta.starware.domain.ProjectAttachVO;

public interface ProjectAttachMapper {
	
	public void insert(ProjectAttachVO vo);
	
	public void delete(String uuid);
	
	public List<ProjectAttachVO> findByProjectNo(int project_No);
	
	public void deleteAll(int project_No);

}
