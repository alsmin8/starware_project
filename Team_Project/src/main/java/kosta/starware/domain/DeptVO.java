package kosta.starware.domain;

import lombok.Data;

@Data
public class DeptVO {
   private int dept_no;
   private String dept_name;
   private int DEPT_SUPERIOR;
   
}