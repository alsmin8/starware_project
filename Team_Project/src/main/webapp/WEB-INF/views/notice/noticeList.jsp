<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!CTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale = 1">
<link rel="stylesheet" href="/resources/css/bootstrap.css">
<link rel="stylesheet" href="/resources/css/custom.css">
<title>STARWARE(Groupware)</title>
<script src="/resources/jquery.js" type="text/javascript"></script>
<script src="/resources/js/bootstrap.js"></script>
</head>



<body>
<%-- <%
		String emp_no = null;
		if (session.getAttribute("emp_no") != null) {
			emp_no = (String) session.getAttribute("emp_no");
		}
		if (emp_no == null) {
			session.setAttribute("messageType", "오류메세지");
			session.setAttribute("messageContent", "현재 로그인이 되어있지 않습니다.");
			response.sendRedirect("login.jsp");
			return;
		}
	%> --%>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expended="false">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="login.jsp">STARWARE</a>
		</div>

		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="loginafter.jsp">메인</a></li>
				<li><a href="list.bit">전자결재</a></li>
				<li><a href="listActionProject.pro">협업지원</a></li>
				<li class="active"><a href="noticeList">공지사항</a></li>
				<li><a href="../attend/attendInsert">출퇴근관리</a></li>
				<li><a href="list.do">인사관리</a></li>
				<li><a href="calendar_main.jsp">일정관리</a></li>
				<li><a href="messengerFind.jsp">메세지함</a></li>
			</ul>

			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="buton" aria-haspopup="true"
					aria-expanded="false">회원관리<span class="caret"></span>
				</a>
					<ul class="dropdown-menu">
						<li><a href="logoutaction.jsp">로그아웃</a></li>
					</ul></li>
			</ul>

		</div>
	</nav>

	<div class="container">

	<h3>공지사항</h3>
	<a href="noticeInsertForm">글쓰기</a><br>

	<table class="type04">
		<tr>
			<td>글번호</td>
			<td>분류</td>
			<td>제목</td>
			<td>작성자</td>
			<td>작성일</td>
			<td>조회수</td>
		</tr>





		<c:forEach var="notice" items="${noticeList }">
			<tr>
				<td>${notice.notice_no}</td>
				<td>${notice.notice_subject }</td>
				
				<td><a href="noticeDetail?notice_no=${notice.notice_no}">${notice.notice_title }</a>		
				</td>
				
				<td>${notice.emp_no }</td>
				<td><fmt:parseDate var="dateString"
						value="${notice.notice_regdate}" pattern="yyyy-MM-dd" scope="page" /> <fmt:formatDate
						value="${dateString}" pattern="yyyy-MM-dd"/></td>
				<td>${notice.notice_hitCount}</td>
			</tr>
		
	
		</c:forEach>



	</table>
	<br>
	<br>

<%-- 	<!-- 페이지처리 영역 -->
	<!-- 이전 : 처음화면 아니면 무조건 이전 있어야되니까. 이전 누르면 5페이지 전으로 돌아가야 함 -->
	<c:if test="${listModel.startPage >5}">
		<a href="list.not?pageNum=${listModel.startPage-5 }">[이전]</a>
	</c:if>

	<!-- 페이지목록 -->
	<c:forEach var="pageNo" begin="${listModel.startPage }"
		end="${listModel.endPage }">
		<c:if test="${listModel.requestPage==pageNo }">
			<b>
		</c:if>
		<a href="list.not?pageNum=${pageNo }">[${pageNo }]</a>
		<c:if test="${listModel.requestPage==pageNo }">
			</b>
		</c:if>
	</c:forEach>

	<!-- 이후 -->
	<c:if test="${listModel.endPage <listModel.totalPageCount}">
		<a href="list.not?pageNum=${listModel.startPage+5 }">[이후]</a>
	</c:if> --%>



	<form action="list.not" method="post">
	
		<input type="checkbox" name="notice_subject" value="안 내">안내
		<input type="checkbox" name="notice_subject" value="인 사">인사
		<input type="checkbox" name="notice_subject" value="기 타">기타 
	<br>
		<input type="checkbox" name="area" value="notice_title">제목 
		<input type="checkbox" name="area" value="emp_no">작성자 
		<input type="text" name="searchKey" size="10"></input> 
		<input type="submit" value="검색">
	</form>

	</div>



</body>
</html>
