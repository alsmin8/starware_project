package kosta.starware.domain;

import java.io.Serializable;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ChatDTO implements Serializable{
		private int m_contentNo;
		private String from_ID;
		private String to_ID;
		private String m_Content;
		private Date m_regdate;
		private int chatLead;
}
