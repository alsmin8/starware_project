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
<style type="text/css">
.pagination ul {
	list-style:none;
	float:left;
	display:inline;
}
.pagination ul li {
	float:left;
}
.pagination ul li a {
	float:left;
	padding:4px;
	margin-right:3px;
	width:30px;
	color:#000;
	font:bold 12px tahoma;
	border:1px solid #eee;
	text-align:center;
	text-decoration:none;
}
.pagination ul li a:hover, ul li a:focus {
	color:#fff;
	border:1px solid #4d86d1;
	background-color:#4d86d1;
}
</style>

</head>



<body>
<%
		session.setAttribute("emp_no", "12301");
		String emp_no = null;
		if (session.getAttribute("emp_no") != null) {
			emp_no = (String) session.getAttribute("emp_no");
		}
		if (emp_no == null) {
			session.setAttribute("messageType", "오류메세지");
			session.setAttribute("messageContent", "현재 로그인이 되어있지 않습니다.");
			/* response.sendRedirect("login.jsp");
			return; */
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
			<a class="navbar-brand" href="login.jsp">STARWARE</a>
		</div>

		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="loginafter.jsp">메인</a></li>
				<li><a href="list.bit">전자결재</a></li>
				<li><a href="listActionProject.pro">협업지원</a></li>
				<li class="active"><a href="/notice/noticeList">공지사항</a></li>
				<li><a href="/attend/attendInsert">출퇴근관리</a></li>
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
		<br><br><br>
		<div>
		<a href="/notice/noticeList"><h3 style="display: inline">공지사항</h3></a>
		
			<button data-oper='insert' class="btn btn-primary pull-right">글쓰기</button>
		</div>
	
		<form id="insertFormAction" action="notice/noticeInsertForm" method="get">
		</form>

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

					<td><a class='noticeMove' href='<c:out value="${notice.notice_no }"/>'>
					<c:out value="${notice.notice_title }"/></a>
					</td>

					<td>${notice.emp_no }</td>
					<td><fmt:parseDate var="dateString"
							value="${notice.notice_regdate}" pattern="yyyy-MM-dd"
							scope="page" /> <fmt:formatDate value="${dateString}"
							pattern="yyyy-MM-dd" /></td>
					<td>${notice.notice_hitCount}</td>
				</tr>
			</c:forEach>
		</table>
		
		<!-- 페이징처리 -->
		<div class="pagination">
			<ul>
				<c:if test="${noticeModel.prev}">
					<li class="paginate_button previous"><a
						href="${noticeModel.startPage -1}"><</a></li>
				</c:if>

				<c:forEach var="num" begin="${noticeModel.startPage}"
					end="${noticeModel.endPage}">
					<li class="paginate_button  ${noticeModel.ncri.pageNum == num ? "active":""} ">
						<a href="${num}">${num}</a>
					</li>
				</c:forEach>

				<c:if test="${noticeModel.next}">
					<li class="paginate_button next"><a
						href="${noticeModel.endPage +1 }">></a></li>
				</c:if>
			</ul>
		</div>
		
		<form id='noticeAction' action="/notice/noticeList" method='get'>
				<input type='hidden' name='pageNum' value='${noticeModel.ncri.pageNum}'>
				<input type='hidden' name='amount' value='${noticeModel.ncri.amount}'>
				<input type='hidden' name='noticeSearchType' value='<c:out value="${ noticeModel.ncri.noticeSearchType }"/>'>
				<input type='hidden' name='noticeSearchKey' value='<c:out value="${ noticeModel.ncri.noticeSearchKey }"/>'>
		</form> 


		<form action="noticeList" method="get" id="searchNotice">
			<select name=noticeSearchType>
				<option value=""
					<c:out value="${noticeModel.ncri.noticeSearchType == null?'selected':''}"/>>--</option>
				<option value="T"
					<c:out value="${noticeModel.ncri.noticeSearchType eq 'T'?'selected':''}"/>>제목</option>
				<option value="C"
					<c:out value="${noticeModel.ncri.noticeSearchType eq 'C'?'selected':''}"/>>내용</option>
				<option value="W"
					<c:out value="${noticeModel.ncri.noticeSearchType eq 'W'?'selected':''}"/>>작성자</option>
				<option value="TWC"
					<c:out value="${noticeModel.ncri.noticeSearchType eq 'TWC'?'selected':''}"/>>전체</option>
			</select>
			<input type='text' name='noticeSearchKey'
								value='<c:out value="${noticeModel.ncri.noticeSearchKey}"/>' /> <input
								type='hidden' name='pageNum'
								value='<c:out value="${noticeModel.ncri.pageNum}"/>' /> <input
								type='hidden' name='amount'
								value='<c:out value="${noticeModel.ncri.amount}"/>' />
			<button class='btn btn-default'>검색</button>
		</form>

	</div>

<script type="text/javascript">

$(document).ready(
		function(){
			
			var noticeAction=$("#noticeAction");
			var searchNotice=$("#searchNotice");
			var insertFormAction=$("#insertFormAction");
			
			$(".paginate_button a").on(
					"click",
					function(e) {
						e.preventDefault();

						console.log('click');

						noticeAction.find("input[name='pageNum']")
								.val($(this).attr("href"));
						noticeAction.submit();
					});
			
			$(".noticeMove").on("click", function(e){
				e.preventDefault();
				noticeAction.append("<input type='hidden' name='notice_no' value='"
						+ $(this).attr("href")+ "'>");
				noticeAction.attr("action",	"/notice/noticeDetail");
				noticeAction.submit();
			});
			
			$("button[data-oper='insert']").on("click", function(e) {
				insertFormAction.attr("action", "/notice/noticeInsertForm").submit();
			}); 
			
			
			$("#searchNotice button").on("click", function(e){
				
				if(!searchNotice.find("option:selected").val()){
					alert("검색 종류를 선택하세요.");
					return false;
				}
				
				if(!searchNotice.find("input[name='noticeSearchKey']").val()){
					alert("키워드를 입력하세요.");
					return false;
				}
				
				searchNotice.find("input[name='pageNum']").val("1");
				e.preventDefault();
				
				searchNotice.submit();
				
			});
			
			
		});



</script>

</body>
</html>
