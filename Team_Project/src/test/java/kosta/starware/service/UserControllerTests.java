package kosta.starware.service;

import static org.junit.Assert.*;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpSession;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
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
public class UserControllerTests {

	@Setter(onMethod_ = {@Autowired})
	private WebApplicationContext ctx;
	
	@Setter(onMethod_ = {@Autowired})
	private MockMvc mockMvc;
	
	@Setter(onMethod_ = @Autowired)
	private UserService service;
	
	@Setter(onMethod_ = @Autowired)
	private NoticeService noticeService;
	
	@Before
	public void setup(){
		this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
	}
	
	@Test
	public void testLogin() throws Exception {
		MockHttpSession session = new MockHttpSession();
		String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/login/").sessionAttr("emp_no", session.getAttribute("emp_no"))).andReturn().getModelAndView().getViewName();
		log.info(resultPage);
	}

}
