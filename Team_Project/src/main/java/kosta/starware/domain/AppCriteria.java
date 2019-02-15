package kosta.starware.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString

public class AppCriteria {
	
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
