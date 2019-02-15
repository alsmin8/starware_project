package kosta.starware.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class AppPageDTO {

  private int startPage;
  private int endPage;
  private boolean prev, next;

  private int total;
  private AppCriteria appcri;

  public AppPageDTO(AppCriteria appcri, int total) {

    this.appcri = appcri;
    this.total = total;

    this.endPage = (int) (Math.ceil(appcri.getPageNum() / 10.0)) * 10;

    this.startPage = this.endPage - 9;

    int realEnd = (int) (Math.ceil((total * 1.0) / appcri.getAmount()));

    if (realEnd <= this.endPage) {
      this.endPage = realEnd;
    }

    this.prev = this.startPage > 1;

    this.next = this.endPage < realEnd;
  }
  
}

