package kosta.starware.mapper;

import java.util.List;

import kosta.starware.domain.ProjectBoardVO;

public interface ProjectBoardMapper {
	
	public int insert(ProjectBoardVO vo);
	
	public List<ProjectBoardVO> list(int project_No);
	
	public ProjectBoardVO read(int project_Board_No);
	
	public int delete(int project_Board_No);
	
	public int update(ProjectBoardVO board);
	
	public int move(ProjectBoardVO board);

}