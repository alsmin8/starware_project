package kosta.starware.domain;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class ChatDTO{
		private int m_contentNo;
		private String from_ID;
		private String to_ID;
		private String m_Content;
		private String m_regdate;
		private int chatLead;
}
