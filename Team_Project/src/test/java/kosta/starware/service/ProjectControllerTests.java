package kosta.starware.service;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.patch;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration({
	"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@Log4j
public class ProjectControllerTests {
	
	@Setter(onMethod_ = {@Autowired})
	private WebApplicationContext ctx;
	private MockMvc mockMvc;
	
	@Before
	public void setup(){
		this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
	}
	
/*	@Test
	public void testList() throws Exception{ 
		
		log.info(
			mockMvc.perform(MockMvcRequestBuilders.get("/project/listProjectForm"))
			.andReturn()
			.getModelAndView()
			.getModelMap());
	}*/

/*	@Test
	public void testRegister()throws Exception{
		
		String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/project/listProjectForm")
				.param("project_Title", "�׽�Ʈ ���� ����")
				.param("project_Contents", "�׽�Ʈ ���� ����")
				.param("project_Kind", "���� ����")
				.param("project_Writer", "user00")
				.param("project_Manager", "�����")
				.param("project_Members", "����")
				.param("project_Term", "20")
				.param("project_Situation", "����")
				).andReturn().getModelAndView().getViewName();
		
		log.info(resultPage);
	}*/

	
/*	@Test
	public void tetget() throws Exception{
		
		log.info(mockMvc.perform(MockMvcRequestBuilders
				.get("/project/detailProjectForm")
				.param("Project_No", "1"))
				.andReturn()
				.getModelAndView().getModelMap());
	}
	
	@Test
	public void testModify() throws Exception{
		String resultPage = mockMvc
				.perform(MockMvcRequestBuilders.post("/project/updateProjectForm")
						.param("Project_No", "1")
						.param("project_Title", "�׽�Ʈ ���� ����")
						.param("project_Contents", "�׽�Ʈ ���� ����")
						.param("project_Kind", "���� ����")
						.param("project_Writer", "user00")
						.param("project_Manager", "�����")
						.param("project_Members", "����")
						.param("project_Term", "20")
						.param("project_Situation", "����"))
				.andReturn().getModelAndView().getViewName();
		
		log.info(resultPage);
	}*/
	
/*	@Test
	public void testRemove()throws Exception{
		String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/board/remove")
				.param("bno", "13")
				).andReturn().getModelAndView().getViewName();
		log.info(resultPage);
	}*/
	
/*	@Test
	public void testPaging()throws Exception{
		log.info(mockMvc.perform(
				MockMvcRequestBuilders.get("/board/list")
				.param("pageNum","2")
				.param("amount", "50"))
				.andReturn().getModelAndView().getModelMap());
	}*/

	@Test
	public void testpaging()throws Exception{
		
		log.info(mockMvc.perform(
				MockMvcRequestBuilders.get("/project/listProjectForm")
				.param("pageNumProject", "2")
				.param("amountProject", "30"))
				.andReturn().getModelAndView().getModelMap());
	}

}
