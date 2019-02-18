package kosta.starware.service;

import java.util.List;

import org.springframework.stereotype.Service;

import kosta.starware.domain.ProjectBoardVO;
import kosta.starware.mapper.ProjectBoardMapper;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@AllArgsConstructor
public class ProjectBoardServiceImpl implements ProjectBoardService {

	private ProjectBoardMapper mapper;
	
	@Override
	public int register(ProjectBoardVO vo) {
		
		log.info("register.........." + vo);
		
		return mapper.insert(vo);
	}

	@Override
	public List<ProjectBoardVO> getList(int project_No) {
		
		log.info("getList............" + project_No);
		
		return mapper.list(project_No);
		
	}

	@Override
	public ProjectBoardVO get(int project_Board_No) {
		
		log.info("get................" + project_Board_No);
		
		return mapper.read(project_Board_No);
	}

	@Override
	public int remove(int project_Board_No) {
		
		log.info("remove............." + project_Board_No);
		
		return mapper.delete(project_Board_No);
	}

	@Override
	public int modify(ProjectBoardVO board) {
		
		log.info("modify..........." + board);
		
		return mapper.update(board);
	}

	@Override
	public int move(ProjectBoardVO board) {
		
		log.info("move......" + board);
		
		return mapper.move(board);
	}
	
	

}
