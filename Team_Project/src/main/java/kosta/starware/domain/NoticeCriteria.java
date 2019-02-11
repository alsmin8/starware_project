package kosta.starware.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class NoticeCriteria {

	private int pageNum;
	private int amount;
	
	public NoticeCriteria(){
		this(1, 5);
	}
	
	public NoticeCriteria(int pageNum, int amount) {
		super();
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	
	
}
