package kosta.starware.service;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import kosta.starware.domain.ProjectCriteria;
import kosta.starware.domain.ProjectDTO;
import kosta.starware.mapper.projectMapperTests;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ProjectServiecTests {

	@Setter(onMethod_ = { @Autowired })
	private ProjectService service;


@Test 
public void test(){

log.info(service); assertNotNull(service); }


	/*
	 * @Test public void testregister(){ ProjectDTO project = new ProjectDTO();
	 * 
	 * project.setProject_Title("�� �߰�....");
	 * project.setProject_Contents("�� ���� �߰�..");
	 * project.setProject_Kind("������Ʈ ���� �߰�");
	 * project.setProject_Writer("�ۼ��� �߰�");
	 * project.setProject_Manager("����� �߰�");
	 * project.setProject_Members("��� �߰�"); project.setProject_Term(10);
	 * project.setProject_Situation("���� ���� �߰�");
	 * 
	 * service.register(project);
	 * 
	 * log.info("������ ������Ʈ ��ȣ:" + project.getProject_No()); }
	 */

/*	@Test
	public void testGetList() {

		service.getList(new ProjectCriteria(2,10)).forEach(project -> log.info(project));
	}*/

	/*
	 * @Test public void testRead(){
	 * 
	 * log.info(service.read(2)); }
	 */

	/*
	 * @Test public void testdelte() {
	 * 
	 * log.info("���� ���:...." + service.remove(2)); }
	 */

	/*
	 * @Test public void testupdate() {
	 * 
	 * ProjectDTO project = service.read(3);
	 * 
	 * if (project == null) { return; }
	 * 
	 * project.setProject_Title("���� �����մϴ�"); log.info("���� ���:....." +
	 * service.modify(project)); }
	 */

}
