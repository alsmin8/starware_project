<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
	x font: bold 12px tahoma;
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
	<%
		String emp_no = null;
		if (session.getAttribute("emp_no") != null) {
			emp_no = (String) session.getAttribute("emp_no");
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
				<li><a href="/loginafter">메인</a></li>
				<li><a href="/approval/applist_alllist">전자결재</a></li>
				<li><a href="/project/listProjectForm">협업지원</a></li>
				<li><a href="/notice/noticeList">공지사항</a></li>
				<li><a href="/attend/attendInsert">출퇴근관리</a></li>
				<li><a href="/emp/empList">인사관리</a></li>
				<li><a href="/schedule/scheduleMain">일정관리</a></li>
				<li class="active"><a href="/chat/messengerFind">메세지함<span
						id="unread" class="label label-info"></span></a></li>
			</ul>
			<%
				if (emp_no == null) {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="buton" aria-haspopup="true"
					aria-expanded="false">접속하기<span class="caret"></span>
				</a>
					<ul class="dropdown-menu">
						<li><a href="main.jsp">로그인</a></li>
					</ul></li>
			</ul>
			<%
				} else {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="buton" aria-haspopup="true"
					aria-expanded="false">회원관리<span class="caret"></span>
				</a>
					<ul class="dropdown-menu">
						<li><a href="logoutaction.jsp">로그아웃</a></li>
					</ul></li>
			</ul>

			<%
				}
			%>
		</div>
	</nav>

	<div class="container">
		<h3 align="center">
			프로젝트 목록 보기</a>
		</h3>
		
				<form action="insertProjectForm" style="text-align: right">
			<a href="insertProjectForm" class="btn btn-primary pull"
				type="submit">프로젝트 생성하기</a>
			<form id="insertFormAction" action="project/insertProjectForm"
				method="get"></form></form>

		<table class="type04">
			<tr>
				<td>No</td>
				<td>제목</td>
				<td>작성자</td>
				<td>담당자</td>
				<td>기간</td>
				<td>계획 시작일</td>
				<td>계획 종료일</td>
				<td>작성일</td>
			</tr>

			<c:forEach var="project" items="${listProjectForm }">
				<tr>
					<td>${project.project_No}</td>
					<td><a class='projectMove'
						href='<c:out value="${project.project_No}"/>'> <c:out
								value="${project.project_Title}" /></a></td>
					<td>${project.project_Writer}</td>
					<td>${project.project_Manager}</td>
					<td>${project.project_Term }</td>
					<td><fmt:parseDate var="project_Start_Date"	value="${project.project_Start_Date}" pattern="yyyy-MM-dd"/> <fmt:formatDate value="${project_Start_Date}"
							pattern="yyyy-MM-dd" /></td>
					<td><fmt:parseDate var="project_End_Date"	value="${project.project_End_Date}" pattern="yyyy-MM-dd"
							scope="page" /> <fmt:formatDate value="${project_End_Date}"
							pattern="yyyy-MM-dd" /></td>
					<td>${project.project_Regdate}</td>
				</tr>
			</c:forEach>
		</table>

			<div class="pagination">
				<c:if test="${pageMaker.prev}">
					<li class="paginate_button previous"><a
						href="${pageMaker.startPage -1}">Previous</a></li>
				</c:if>

				<c:forEach var="num" begin="${pageMaker.startPage}"
					end="${pageMaker.endPage}">
					<li class="paginate_button  ${pageMaker.cri.pageNum == num ? "active":""} ">
						<a href="${num}">${num}</a>
					</li>
				</c:forEach>

				<c:if test="${pageMaker.next}">
					<li class="paginate_button next"><a
						href="${pageMaker.endPage +1 }">Next</a></li>
				</c:if>
			</div>

			<!-- 검색 -->
			<form action="listProjectForm" method="get" id="searchProject">
				<select name=projectSearchType style="text-align: center"
					class="btn btn-primary pull">
					<option value=""
						<c:out value="${pageMaker.cri.projectSearchType == null?'selected':''}"/>>--</option>
					<option value="T"
						<c:out value="${pageMaker.cri.projectSearchType eq 'T'?'selected':''}"/>>제목</option>
					<option value="C"
						<c:out value="${pageMaker.cri.projectSearchType eq 'C'?'selected':''}"/>>내용</option>
					<option value="W"
						<c:out value="${pageMaker.cri.projectSearchType eq 'W'?'selected':''}"/>>작성자</option>
					<option value="TC"
						<c:out value="${pageMaker.cri.projectSearchType eq 'TC'?'selected':''}"/>>제목
						+ 내용</option>
					<option value="TW"
						<c:out value="${pageMaker.cri.projectSearchType eq 'TW'?'selected':''}"/>>제목
						+ 작성자</option>
					<option value="TWC"
						<c:out value="${pageMaker.cri.projectSearchType eq 'TWC'?'selected':''}"/>>제목
						+ 내용 + 작성자</option>
				</select> <input type='text' name='projectSearchKey'
					class="btn btn-primary pull"
					value='<c:out value="${pageMaker.cri.projectSearchKey}"/>' /> <input
					type='hidden' name='pageNum'
					value='<c:out value="${pageMaker.cri.pageNum}"/>' /> <input
					type='hidden' name='amount'
					value='<c:out value="${pageMaker.cri.amount}"/>' />
				<button class='btn btn-primary pull'>검색</button>
				<input type="button" class="btn btn-primary pull"
					value="검색 전 목록으로 돌아가기" onclick="location.href='listProjectForm'">
			</form>


			<form id='projectAction' action="/project/listProjectForm"
				method='get'>
				<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'>
				<input type='hidden' name='amount' value='${pageMaker.cri.amount}'>
				<input type='hidden' name='projectSearchType'
					value='<c:out value="${pageMaker.cri.projectSearchType}"/>'>
				<input type='hidden' name='projectSearchKey'
					value='<c:out value="${pageMaker.cri.projectSearchKey }"/>'>
			</form>

			<form id='listAction' action="project/listProjectForm" method="get">
				<input type='hidden' name='project_No' id='project_No'
					value='<c:out value="${project.project_No}"/>'> <input
					type='hidden' name='pageNum'
					value='<c:out value="${cri.pageNum}"/>'> <input
					type='hidden' name='amount' value='<c:out value="${cri.amount}"/>'>
				<input type='hidden' name='projectSearchType'
					value='<c:out value="${pageMaker.cri.projectSearchType}"/>'>
				<input type='hidden' name='projectSearchKey'
					value='<c:out value="${pageMaker.cri.projectSearchKey }"/>'>
			</form>
			<!-- Modal  추가 -->
			<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal"
								aria-hidden="true">&times;</button>
							<h4 class="modal-title" id="myModalLabel">starware</h4>
						</div>
						<div class="modal-body">처리가 완료되었습니다.</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-primary"
								data-dismiss="modal">Close</button>
						</div>
					</div>
					<!-- /.modal-content -->
				</div>
				<!-- /.modal-dialog -->
			</div>
			<!-- /.modal -->
	</div>

	<script type="text/javascript">
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
											"게시글 " + parseInt(result)
													+ " 번이 등록되었습니다.");
								}

								$("#myModal").modal("show");
							}

							var projectAction = $("#projectAction");
							var searchProject = $("#searchProject");
							var insertFormAction = $("#insertFormAction");

							$(".paginate_button a").on(
									"click",
									function(e) {
										e.preventDefault();

										console.log('click');

										projectAction.find(
												"input[name='pageNum']").val(
												$(this).attr("href"));
										projectAction.submit();
									});

							$(".projectMove")
									.on(
											"click",
											function(e) {
												e.preventDefault();
												projectAction
														.append("<input type='hidden' name='project_No' value='"
																+ $(this).attr(
																		"href")
																+ "'>");
												projectAction
														.attr("action",
																"/project/detailProjectForm");
												projectAction.submit();
											});

							$("button[data-oper='insert']").on(
									"click",
									function(e) {
										insertFormAction.attr("action",
												"/project/insertProjectForm")
												.submit();
									});

							$("#searchProject button")
									.on(
											"click",
											function(e) {

												if (!searchProject.find(
														"option:selected")
														.val()) {
													alert("검색 종류를 선택하세요.");
													return false;
												}

												if (!searchProject
														.find(
																"input[name='projectSearchKey']")
														.val()) {
													alert("키워드를 입력하세요.");
													return false;
												}

												searchProject
														.find(
																"input[name='pageNum']")
														.val("1");
												e.preventDefault();

												searchProject.submit();

											});

						});
	</script>

</body>
</html>