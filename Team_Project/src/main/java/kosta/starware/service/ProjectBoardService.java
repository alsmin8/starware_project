package kosta.starware.service;

import java.util.List;

import kosta.starware.domain.ProjectBoardVO;

public interface ProjectBoardService {
	
	public int register(ProjectBoardVO vo);
	
	public List<ProjectBoardVO> getList(Integer project_No);
	
	public ProjectBoardVO get(int project_Board_No);
	
	public int remove(int project_Board_No);
	
	public int modify(ProjectBoardVO board);
	
	public int move(ProjectBoardVO board);

}
