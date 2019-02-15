package kosta.starware.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import kosta.starware.domain.ProjectCriteria;
import kosta.starware.domain.ProjectDTO;
import kosta.starware.mapper.ProjectMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
//@WebAppConfiguration
@ContextConfiguration(
	"file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class projectMapperTests {
	
	@Setter(onMethod_=@Autowired)
	private ProjectMapper mapper;
	
/*	@Test
	public void testGetlist(){
		mapper.getListProject().forEach(project -> log.info(project));
	}*/

/*	@Test
	public void testregister(){
		
		ProjectDTO project = new ProjectDTO();
		project.setProject_Title("�� �߰�....");
		project.setProject_Contents("�� ���� �߰�..");
		project.setProject_Kind("������Ʈ ���� �߰�");
		project.setProject_Writer("�ۼ��� �߰�");
		project.setProject_Manager("����� �߰�");
		project.setProject_Members("��� �߰�");
		project.setProject_Term(10);
		project.setProject_Situation("���� ���� �߰�");
		
		mapper.registerProject(project);
		
		log.info(project);
	}*/
	
/*	@Test
	public void testRead(){
		
		ProjectDTO project = mapper.readProject(3);
		
		log.info(project);
	}*/
	
/*	@Test
	public void testdelete(){
		
		log.info("����  ����: " + mapper.removeProject(20));
	}*/
	
/*	@Test
	public void testupdate(){
		
		ProjectDTO project = new ProjectDTO();
		
		project.setProject_No(1);
		project.setProject_Title("�λ� �ý���1");
		project.setProject_Contents("�λ�ý��ۺ���1");
		project.setProject_Kind("����1");
		project.setProject_Writer("������1");
		project.setProject_Manager("��α�1");
		project.setProject_Members("����1");
		project.setProject_Term(50);
		project.setProject_Situation("������1");
		
		int count = mapper.modifyProject(project);
		log.info("���� :" + count);
	}*/
	
	@Test
	public void testPaging(){
		ProjectCriteria projectCirteria = new ProjectCriteria();
		
		projectCirteria.setPageNum(2);
		projectCirteria.setAmount(10);
		
		List<ProjectDTO> list = mapper.getListPagingProject(projectCirteria);
		
		list.forEach(project -> log.info(project.getProject_No()));
	}
}
