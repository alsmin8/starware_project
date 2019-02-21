package kosta.starware.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString

public class AppCriteria {
	private String[] check;
	private String app_kind;
	private String time;
	private String app_startdate;
	private String app_enddate;
	private String app_situation;
	private String app_title;
	private String searchKey;
	
	private int pageNum;
	private int amount;
	
	public AppCriteria(){
		this(1,5);
	}
	
	public AppCriteria(int pageNum, int amount){
		this.pageNum = pageNum;
		this.amount = amount;
	}
}
