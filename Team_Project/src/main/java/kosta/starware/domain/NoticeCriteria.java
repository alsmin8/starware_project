package kosta.starware.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class NoticeCriteria {

	private int pageNum;
	private int amount;
	
	private String noticeSearchType;
	private String noticeSearchKey;
	
	public NoticeCriteria(){
		this(1, 5);
	}
	
	public NoticeCriteria(int pageNum, int amount) {
		super();
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	public String[] getNoticeSearchArr(){
		return noticeSearchType==null? new String[] {}:noticeSearchType.split("");
	}
	
	

	public String getListLink(){
		
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
				.queryParam("pageNum", this.getPageNum())
				.queryParam("amount", this.getAmount())
				.queryParam("NoticeSearchType", this.getNoticeSearchType())
				.queryParam("NoticeSearchKey", this.getNoticeSearchKey());
		
		return builder.toUriString();
	}
	
	
	
	
	
}
