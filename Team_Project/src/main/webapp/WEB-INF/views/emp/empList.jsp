<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%--  <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> --%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale = 1">
<link rel="stylesheet" href="/resources/css/bootstrap.css">
<link rel="stylesheet" href="/resources/css/custom.css">
<title>STARWARE(Groupware)</title>
<script src="/resources/jquery.js" type="text/javascript"></script>
<script src="/resources/js/bootstrap.js"></script>
<style type="text/css">
.pagination ul {
	list-style: none;
	float: left;
	display: inline;
}

.pagination ul li {
	float: left;
}

.pagination ul li a {
	float: left;
	padding: 4px;
	margin-right: 3px;
	width: 30px;
	color: #000;
	font: bold 12px tahoma;
	border: 1px solid #eee;
	text-align: center;
	text-decoration: none;
}

.pagination ul li a:hover, ul li a:focus {
	color: #fff;
	border: 1px solid #4d86d1;
	background-color: #4d86d1;
}
</style>

</head>
<body>

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
				<li class="active"><a href="empList">인사관리</a></li>
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
		<a href="/emp/empInsertForm?emp_no=${emp.emp_no }">입력하기</a>
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

			<c:forEach var="emp" items="${empList}">


				<tr>
					<td>${emp.emp_no }</td>
					<%-- <td><a href="/emp/empDetail?emp_no=${emp.emp_no }">${emp.emp_name }</a></td>  --%>
					
					
					<%-- <td><a href = '/emp/empDetail?emp_no=<c:out value="${emp.emp_no }"/>'>
					<c:out value="${emp.emp_name }" /></a></td>  --%>
					
					  <td><a class='empMove' href='<c:out value="${emp.emp_no }"/>'>
							<c:out value="${emp.emp_name }" /> 
					</a></td>  
					
					
					<td>${emp.emp_hiredate }</td>
					<td>${emp.dept_no }</td>
					<td>${emp.grade_no }</td>
					<td>${emp.emp_empstate }</td>



				</tr>
			</c:forEach>


		</table>
		</div>
		<br> <br>
		<!-- 페이지 처리 영역 (newver.)-->
		<div class="pagination">
			<ul>
				<c:if test="${empPageMaker.prev}">
					<li class="paginate_button previous"><a
						href="${empPageMaker.empStartPage -1}">Previous</a></li>
				</c:if>

				<c:forEach var="num" begin="${empPageMaker.empStartPage}"
					end="${empPageMaker.empEndPage}">
					<li class="paginate_button  ${empPageMaker.empcri.pageNum == num ? "active":""} ">
						<a href="${num}">${num}</a>
					</li>
				</c:forEach>

				<c:if test="${empPageMaker.next}">
					<li class="paginate_button next"><a
						href="${empPageMaker.empEndPage +1 }">Next</a></li>
				</c:if>
			</ul>
		

		<form id='empActionForm' action='/emp/empList' method='get'>
			<input type='hidden' name='pageNum' value='${empPageMaker.empcri.pageNum }'> 
			<input type='hidden' name='amount' value='${empPageMaker.empcri.amount }'>
		</form>

		<script type="text/javascript">
		 /* var empActionForm =$('#empActionForm'); */
	 		$(document)
					.ready(
							function() {
								 var result = '<c:out value="${result}"/>';
								checkModal(result);

								history.replaceState({}, null, null);

								function checkModal(result) {

									if (result === '' || history.state) {
										return;
									}

									if (parseInt(result) > 0) {
										$(".modal-body").html(
												"게시글" + parseInt(result)
														+ " 등록되었습니다.");

									}
									$("#myModal").modal("show");
								}
								$("#regBtn").on("click", function() {

									self.location = "/emp/empInsertForm";
								}); 
								var empActionForm = $("#empActionForm"); 

								$(".paginate_button a").on(
										"click",
										function(e) {
											e.preventDefault();
											console.log('click');
											empActionForm.find(
													"input[name='pageNum']")
													.val($(this).attr("href"));
											empActionForm.submit();
										});
								//게시물 조회를 위한 이벤트 처리 추가
								$(".empMove")
										.on(
												"click",
												function(e) {

													e.preventDefault();
													empActionForm
															.append("<input type='hidden' name='emp_no' value='"
																	+ $(this)
																			.attr(
																					"href")
																	+ "'>");
													empActionForm.attr(
															"action",
															"/emp/empDetail");
													empActionForm.submit();

												});
							});
		</script>






		<form action="/empList" method="post">
			<input type="checkbox" name="area" value="emp_name"> 성명 <input
				type="checkbox" name="area" value="emp_no"> 사번 <input
				type="checkbox" name="area" value="dept_no"> 부서번호 <input
				type="checkbox" name="area" value="grade_no"> 직급번호 <input
				type="checkbox" name="area" value="emp_empstate"> 재직상태 <input
				type="text" name="searchKey" size="10"></input> <input type="submit"
				value="검색">
		</form>





	</div>


</body>
</html>