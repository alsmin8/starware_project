package kosta.starware.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class EmpPageDTO {
	
	private int empStartPage;
	private int empEndPage;
	private boolean prev, next;
	
	private int empTotal;
	private EmpCriteria empcri;
	
	public EmpPageDTO(EmpCriteria empcri, int empTotal) {
		
		this.empcri = empcri;
		this.empTotal = empTotal;
		
		this.empEndPage = (int) (Math.ceil(empcri.getPageNum() / 10.0)) * 10;
		this.empStartPage = this.empEndPage - 9;
		
		int empRealEnd = (int) (Math.ceil((empTotal * 1.0) / empcri.getAmount()));
		
		if(empRealEnd < this.empEndPage) {
			this.empEndPage = empRealEnd;
		}
		
		this.prev = this.empStartPage > 1;
		
		this.next = this.empEndPage < empRealEnd;
	}

	

}
