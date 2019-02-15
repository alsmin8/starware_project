package kosta.starware.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class AttendCriteria {

	private int pageNum;
	private int amount; //한 페이지에 몇 개 보여줄지
	
	public AttendCriteria(){
		this(1, 10);
	}
	
	public AttendCriteria(int pageNum, int amount){
		super();
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	
}
