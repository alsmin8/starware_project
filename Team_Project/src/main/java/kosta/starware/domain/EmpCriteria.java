package kosta.starware.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class EmpCriteria {
	
	private int pageNum;
	private int amount;
	
	private String empSearchType;
	private String empSearchKeyword;
	
	public EmpCriteria() {
		this(1,5);
	}
	
	public EmpCriteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	public String[] getEmpSearchArr() {
		return empSearchType == null? new String[] {}:empSearchType.split("");
	}

}
//
