package kosta.starware.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class ProjectCriteria {

	private int pageNum;
	private int amount;
	
	private String projectSearchType;
	private String projectSearchKey;
	
	public ProjectCriteria(){
		this(1,10);
	}
	
	public ProjectCriteria(int pageNum, int amount){
		super();
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	public String[] getprojectSearchArr(){
		
		return projectSearchType == null? new String[] {}: projectSearchType.split("");
	}
}
