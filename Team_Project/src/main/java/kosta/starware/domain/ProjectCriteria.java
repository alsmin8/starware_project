package kosta.starware.domain;

import org.springframework.web.util.UriComponentsBuilder;

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
		this(1,6);
	}
	
	public ProjectCriteria(int pageNum, int amount){
		super();
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	public String[] getprojectSearchArr(){
		
		return projectSearchType == null? new String[] {}: projectSearchType.split("");
	}
	
	public String getListLink(){
		
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
				.queryParam("pageNum", this.getPageNum())
				.queryParam("amount", this.getAmount())
				.queryParam("ProjectSearchType", this.getProjectSearchType())
				.queryParam("ProjectSearchKey", this.getProjectSearchKey());
		
		return builder.toUriString();
	}
}
