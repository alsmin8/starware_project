package kosta.starware.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class AttendPageDTO {

	private int startPage;
	private int endPage;
	private boolean prev, next;
	
	private int total;
	private AttendCriteria attcri;
	
	public AttendPageDTO(AttendCriteria attcri, int total){
		this.total=total;
		this.attcri=attcri;
		
		this.endPage=(int)(Math.ceil(attcri.getPageNum()/10.0))*10;
		this.startPage=this.endPage-9;
		
		int realEnd=(int)(Math.ceil((total*1.0)/attcri.getAmount()));
		
		if(realEnd<this.endPage){
			this.endPage=realEnd;
		}
		
		this.prev = this.startPage>1;
		this.next = this.endPage<realEnd;
	}
	
	
	
}