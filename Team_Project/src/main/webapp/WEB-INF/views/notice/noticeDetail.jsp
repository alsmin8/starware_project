<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale = 1">
<link rel="stylesheet" href="/resources/css/bootstrap.css">
<link rel="stylesheet" href="/resources/css/custom.css">
<title>STARWARE(Groupware)</title>
<script src="/resources/jquery.js" type="text/javascript"></script>
<script src="/resources/js/bootstrap.js"></script>
<link rel="stylesheet" href="/resources/css/detailProject.css">
<style>
.uploadResult {
	width: 1000px;
	background-color: white;
}

.uploadResult ul {
	display: flex;
	flex-flow: row;
	justify-content: center;
	align-items: center;
}

.uploadResult ul li {
	list-style: none;
	padding: 10px;
	align-content: center;
	text-align: center;
}

.uploadResult ul li img {
	width: 100px;
}

.uploadResult ul li span {
	color: black;
}
</style>


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
			response.sendRedirect("/login");
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
		<a class="navbar-brand" href="/login">STARWARE</a>
	</div>

	<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
		<ul class="nav navbar-nav">
			<li><a href="/loginafter">메인</a></li>
			<li><a href="/approval/applist_alllist">전자결재</a></li>
			<li><a href="/project/projectList">협업지원</a></li>
			<li class="active"><a href="/notice/noticeList">공지사항</a></li>
			<li><a href="/attend/attendInsert">출퇴근관리</a></li>
			<li><a href="/emp/empList">인사관리</a></li>
			<li><a href="/schedulePage/">일정관리</a></li>
			<li><a href="/chat/messengerFind">메세지함<span id="unread"
					class="label label-info"></span></a></li>
		</ul>

		<ul class="nav navbar-nav navbar-right">
			<li class="dropdown"><a href="#" class="dropdown-toggle"
				data-toggle="dropdown" role="buton" aria-haspopup="true"
				aria-expanded="false">회원관리<span class="caret"></span>
			</a>
				<ul class="dropdown-menu">
					<li><a href="/logoutaction">로그아웃</a></li>
				</ul></li>
		</ul>

	</div>
	</nav>

	<div class="container">

		<h3>공지사항</h3>

		<table class="detail" width="1000" border="1" cellpadding="0"
			cellspacing="0" style="margin-left: auto; margin-right: auto;">
			<tr>
				<td>글번호: ${notice.notice_no}</td>
				<td>조회수: ${notice.notice_hitCount}</td>
			</tr>
			<tr>
				<td>작성자: ${notice.emp_name}</td>
				<td>작성일: ${notice.notice_regdate}</td>
			</tr>
			<tr>
				<td colspan="2">분류: ${notice.notice_subject }</td>
			</tr>
			<tr>
				<td colspan="2">제목: ${notice.notice_title}</td>
			</tr>
			<tr>
				<td colspan=2 width=700 height=100>${notice.notice_contents}</td>
			</tr>
			<tr>
				<td>시작일: ${notice.notice_startDate }</td>
				<td>종료일: ${notice.notice_endDate }</td>
			</tr>
		</table>

		<div class='uploadResult'>
			<ul>

			</ul>
		</div>

		<br>

		<div align="center">
			<button data-oper='list' class="btn btn-default">글목록</button>
			<c:if test="${notice.emp_no==emp_no }">
			<button data-oper='update' class="btn btn-default">글수정</button>
			</c:if>
			<c:if test="${notice.emp_no==emp_no }">
			<button data-oper='delete' class="btn btn-default">글삭제</button>
			</c:if>
		</div>

		<form id="listAction" action="notice/noticeList" method="get">
			<input type='hidden' name='notice_no' id='notice_no'
				value='<c:out value="${notice.notice_no }"/>'> <input
				type='hidden' name='pageNum'
				value='<c:out value="${ncri.pageNum }"/>'> <input
				type='hidden' name='amount' value='<c:out value="${ncri.amount }"/>'>
		</form>

		<form id="updateFormAction" action="notice/noticeUpdateForm"
			method="get">
			<input type='hidden' name='notice_no' id='notice_no'
				value='<c:out value="${notice.notice_no }"/>'> <input
				type='hidden' name='pageNum'
				value='<c:out value="${ncri.pageNum }"/>'> <input
				type='hidden' name='amount' value='<c:out value="${ncri.amount }"/>'>
		</form>

		<form id="deleteFormAction" method="get">
			<input type='hidden' name='notice_no' id='notice_no'
				value='<c:out value="${notice.notice_no }"/>'> <input
				type='hidden' name='pageNum'
				value='<c:out value="${ncri.pageNum }"/>'> <input
				type='hidden' name='amount' value='<c:out value="${ncri.amount }"/>'>
		</form>

	</div>


	<script>
		//파일 첨부 파일 가지고 오기
		$(document)
				.ready(
						function() {

							(function() {

								var notice_no = '<c:out value="${notice.notice_no}"/>';

								$
										.getJSON(
												"/notice/getAttachList",
												{
													notice_no : notice_no
												},
												function(arr) {
													console.log(arr);

													var str = "";

													$(arr)
															.each(
																	function(i,
																			attach) {

																		//여기 조건 이상..ㅠ
																		if (attach.type) {
																			/* var fileCallPath =  encodeURIComponent( attach.notice_uploadPath+ "/s_"+attach.notice_uuid +"_"+attach.notice_fileName);
																					             
																			 str += "<li data-path='"+attach.notice_uploadPath+"' data-uuid='"+attach.notice_uuid+"' data-filename='"+attach.notice_fileName+"'><div>";
																			str += "<img src='/notice/display?fileName="+fileCallPath+"'>";
																			str += "</div>";
																			str +"</li>"; */
																		} else {

																			str += "<li data-path='"+attach.notice_uploadPath+"' data-uuid='"+attach.notice_uuid+"' data-filename='"+attach.notice_fileName+"'><div>";
																			str += "<span> "
																					+ "- "
																					+ attach.notice_fileName
																					+ "</span>";
																			str += "<img src='/resources/images/notice_attach.jpg' style='width: 30px; height: 30px;'></a>";
																			str += "</div>";
																			str
																					+ "</li>";
																		}
																	});

													$(".uploadResult ul").html(
															str);

												}); //end getJSON	
							})(); //end function

							$(".uploadResult").on("click","li",function(e) {

												var liObj = $(this);

												var path = encodeURIComponent(liObj.data("path")+ "/"
														+ liObj.data("uuid")+ "_"+ liObj.data("filename"));
												if (liObj.data("uuid") == null) {
													//showImage(path.replace(new RegExp(/\\/g),"/"));
												} else {
													//download 
													self.location = "/notice/download?fileName="+ path
												}
											});
						});
					</script>


	<script type="text/javascript">
		$(document).ready(
				function() {
					var listAction = $("#listAction");
					var updateFormAction = $("#updateFormAction");
					var deleteFormAction = $("#deleteFormAction");

					$("button[data-oper='update']").on(
							"click",
							function(e) {
								updateFormAction.attr("action",
										"/notice/noticeUpdateForm").submit();
							});

					$("button[data-oper='list']").on("click", function(e) {
						listAction.find("#notice_no").remove();
						listAction.attr("action", "/notice/noticeList")
						listAction.submit();
					});

					/* $("button[data-oper='delete']").on(
							"click",
							function(e) {
								deleteFormAction.attr("action",
										"/notice/noticeDeleteForm").submit();
							}); */

				});
	</script>


<!-- Modal  추가 -->
	<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog"
		aria-labelledby="deleteModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="deleteModalLabel">확인 메시지</h4>
				</div>
				<div class="modal-body">글을 삭제하시겠습니까?</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" name="modalDeleteAct">삭제</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->

<script type="text/javascript">
		$(document).ready(function(){
			$("button[data-oper='delete']").on("click",function(e){
				var deleteFormAction = $("#deleteFormAction");
				
				$('#deleteModal').modal();
				
				$("button[name='modalDeleteAct']").click(function(){
					deleteFormAction.attr("action", "/notice/noticeDelete").submit();
					alert("삭제 완료");
				})
			})
		})
	</script>


</body>
</html>