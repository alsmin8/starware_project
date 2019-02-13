package kosta.starware.domain;

import lombok.Data;

@Data
public class DisbursementDoc {
	private int app_no;
	private int d_no;
	private String d_idx;
	private String d_contents;
	private String d_usingdate;
	private int d_amount;
	
}
