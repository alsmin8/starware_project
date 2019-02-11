<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%--  <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> --%>
 <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
	
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale = 1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>STARWARE(Groupware)</title>
<script src="jquery.js" type="text/javascript"></script>
<script src="js/bootstrap.js"></script>


</head>
<body>
<%
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
	%>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expended="false">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">STARWARE</a>
		</div>

		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="loginafter.jsp">메인</a></li>
				<li><a href="list.bit">전자결재</a></li>
				<li><a href="listActionProject.pro">협업지원</a></li>
				<li><a href="list.not">공지사항</a></li>
				<li><a href="resource_main.jsp">출퇴근관리</a></li>
				<li class="active"><a href="list.do">인사관리</a></li>
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
	
	<h1>사원 정보</h1>
	
	 <h3>사원정보</h3>
   <a href="insertForm.do">입력하기</a>
   <table class="type04">
  <!-- <table width="500" border="1" cellpadding="0" cellspacing="0"> -->
  <tr>
  <td>사번</td>
  <td>성명</td>
  <td>입사일</td>
  <td>부서번호</td>
  <td>직급번호</td>
  <td>재직상태</td>
  
  </tr>
  
<c:forEach var = "emp" items = "${listModel.list }">
    

  <tr>
  <td>${emp.emp_no }</td>
 <%--  <td>
					<c:if test="${emp.fname != null }">
						<c:set var="head" value="${fn:substring(emp.fname, 
												0, fn:length(emp.fname)-4) }"></c:set>
						<c:set var="pattern" value="${fn:substring(emp.fname, 
						fn:length(head) +1, fn:length(emp.fname)) }"></c:set>
					
						<c:choose>
							<c:when test="${pattern == 'jpg' || pattern == 'gif' }">
								<img src="upload/${head }_small.${pattern}">
							</c:when>
							<c:otherwise>
								<c:out value="NO IMAGE"></c:out>
							</c:otherwise>
						</c:choose>
					</c:if>
				</td> --%>
				<td><a href="detail.do?emp_no=${emp.emp_no }">${emp.emp_name }</a></td>
				      
				<td>${emp.emp_hiredate }</td> 
				<%--   <td>					
					<fmt:parseDate var="dateString" value="${emp.emp_hiredate }" pattern="yyyy-MM-dd"/>
					<fmt:formatDate value="${dateString }" pattern="yyyy-MM-dd"/>
				</td> --%> 
    <td>${emp.dept_no }</td> 
   <td>${emp.grade_no }</td>
	<td>${emp.emp_empstate }</td>
 
  <%-- <td>
  <fmt:parseDate var = "dateString" value="${emp.emp_hiredate}" pattern="yyyy-MM-dd"/>
  <fmt:formatDate value="${dateString }" pattern="yyyy-MM-dd"/>
  
  </td> --%>
 
  </tr>
  </c:forEach>

  
  </table>
  <br><br>
  <!-- 페이지 처리 영역 -->
  <!-- 이전 -->
  <c:if test="${listModel.startPage > 5 }">
  	<a href="list.do?pageNum=${listModel.startPage-5 }">[이전]</a>
  </c:if>
  
  <!-- 페이지 목록 -->
  <c:forEach var = "pageNo" begin="${listModel.startPage }"
  	end="${listModel.endPage }">
  	<c:if test="${listModel.requestPage == pageNo }"><b></c:if>
  	<a href="list.do?pageNum=${pageNo }">[${pageNo }]</a>
  	  	<c:if test="${listModel.requestPage == pageNo }"></b></c:if>
  	
   	</c:forEach>
   	
   	<!-- 이후 -->
  <c:if test="${listModel.endPage < listModel.totalPageCount }">
  	<a href="list.do?pageNum=${listModel.startPage+5 }">[이후]</a>
  </c:if> 
  
   
  <form action="list.do" method="post">
    <input type="checkbox" name="area" value="emp_name"> 성명
    <input type="checkbox" name="area" value="emp_no"> 사번
    <input type="checkbox" name="area" value="dept_no"> 부서번호 
    <input type="checkbox" name="area" value="grade_no"> 직급번호 
    <input type="checkbox" name="area" value="emp_empstate"> 재직상태 
    <input type="text" name="searchKey" size="10"></input>
    <input type="submit" value="검색">
  </form>

	
	
	
	
	</div>
	
	
</body>
</html>