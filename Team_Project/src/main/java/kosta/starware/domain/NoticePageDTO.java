package kosta.starware.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class NoticePageDTO {

	private int startPage;
	private int endPage;
	private boolean prev, next;
	
	private int total;
	private NoticeCriteria ncri;
	
	public NoticePageDTO(NoticeCriteria ncri, int total){
		this.total=total;
		this.ncri=ncri;
		
		this.endPage=(int)(Math.ceil(ncri.getPageNum()/5.0))*5;
		this.startPage=this.endPage-4;
		
		int realEnd=(int)(Math.ceil((total*1.0)/ncri.getAmount()));
		
		if(realEnd<this.endPage){
			this.endPage=realEnd;
		}
		
		this.prev = this.startPage>1;
		this.next = this.endPage<realEnd;
	}
	
	
	
}
