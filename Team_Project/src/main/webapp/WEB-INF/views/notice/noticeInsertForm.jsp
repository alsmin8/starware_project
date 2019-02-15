<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<meta name="viewport" content="width=device-width, initial-scale = 1">
<link rel="stylesheet" href="/resources/css/bootstrap.css">
<link rel="stylesheet" href="/resources/css/custom.css">
<title>STARWARE(Groupware)</title>
<script src="/resources/jquery.js" type="text/javascript"></script>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

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

	<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
		<ul class="nav navbar-nav">
		 	<li><a href="loginafter.jsp">메인</a></li>
     <li><a href="/approval/applist_alllist">전자결재</a></li>
            <li><a href="/project/projectList">협업지원</a></li>
            <li class="active"><a href="/notice/noticeList">공지사항</a></li>
            <li><a href="/attend/attendInsert">출퇴근관리</a></li>
            <li><a href="/emp/empList">인사관리</a></li>
            <li><a href="/schedule/scheduleMain">일정관리</a></li>
            <li><a href="/chat/messengerFind">메세지함<span id="unread" class="label label-info"></span></a></li>
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
		<form role="form" name="form" action="noticeInsert" method="post"
			onsubmit="return checkForm();">
			<input type="hidden" name="emp_no" value="12301"><br>
			<table class="table table-bordered table-hover"
				style="text-align: center; border: 1px solid #dddddd;">
				<thead>
					<tr>
						<th colspan="4"><h4>공지사항 글쓰기</h4></th>
					</tr>
				</thead>

				<tbody>
					<tr>
						<td style="width: 110px;"><h5>카테고리</h5></td>
						<td colspan="3" style="text-align: left"><select
							name="notice_subject">
								<option label="안 내">안 내</option>
								<option label="인 사">인 사</option>
								<option label="기 타">기 타</option>
						</select></td>
					</tr>

					<tr>
						<td style="width: 110px;"><h5>제목</h5></td>
						<td colspan="3"><input class="form-control" type="text"
							name="notice_title"></td>
					</tr>

					<tr>
						<td style="width: 110px;"><h5>내용</h5></td>
						<td colspan="3"><textarea rows="10" cols="100"
								name="notice_contents"></textarea>
					</tr>

					<tr>
						<td style="width: 110px;"><h5>시작일</h5></td>
						<td style="width: 40%"><input class="form-control"
							type="text" id="start" name="notice_startDate"></td>
						<td style="width: 110px;" colspan="2">
							<!-- <h5>파일</h5> -->
						</td>
					</tr>
					<tr>
						<td style="width: 110px;"><h5>종료일</h5></td>
						<td style="width: 40%"><input class="form-control"
							type="text" id="end" name="notice_endDate"></td>
						<td style="width: 110px;"><h5>진행상태</h5></td>
						<td style="text-align: left"><select name="notice_state">
								<option label="진행중">진행중</option>
								<option label="완료">완료</option>
						</select></td>
					</tr>
					<tr>
						<td style="text-align: left" colspan="4">
							<div align="right">
								<button type="submit" data-oper='insert' class="btn btn-default">등록</button>
								<!-- <input class="btn btn-default" type="submit" value="등록"/> &nbsp; -->
								<input class="btn btn-default" type="button"
									onclick="location.href='noticeList';" value="취소" />
							</div>
						</td>
					</tr>

				</tbody>
			</table>
		</form>

		<div>
			<table class="table table-bordered table-hover"
				style="text-align: left; border: 1px solid #dddddd;">
				<thead></thead>
				<tbody>
					<tr>
						<td style="width: 110px;"><h5>&nbsp; &nbsp; 파일첨부</h5></td>
						<td>
						<div class='uploadDiv'>
						<input type="file" name="uploadFile" multiple>
						</div>
						<div class='uploadResult'>
						<ul>
						
						</ul>
						</div>
						
						</td>
					</tr>
				</tbody>
			</table>

		</div>


	</div>
	<script>
		
	/* 첨부파일 처리 */
		
	 	$(document).ready(function(e) {
			var formObj = $("form[role='form']");
			var cloneObj=$(".uploadDiv").clone();

			$("button[type='submit']").on("click", function(e) {

				e.preventDefault();

				console.log("submit clicked");

				var str = "";
			})

			var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
			var maxSize = 5242880; //5MB

			function checkExtension(fileName, fileSize) {

				if (fileSize >= maxSize) {
					alert("파일 사이즈 초과");
					return false;
				}

				if (regex.test(fileName)) {
					alert("해당 종류의 파일은 업로드할 수 없습니다.");
					return false;
				}
				return true;
			}

			$("input[type='file']").change(function(e) {

				var formData = new FormData();

				var inputFile = $("input[name='uploadFile']");

				var files = inputFile[0].files;
				
				//console.log(files);

				for (var i = 0; i < files.length; i++) {

					if (!checkExtension(files[i].name, files[i].size)) {
						return false;
					}
					formData.append("uploadFile", files[i]);

				}

				$.ajax({
					url : '/notice/uploadAjaxAction',
					processData : false,
					contentType : false,
					data : formData,
					type : 'POST',
					dataType : 'json',
					success : function(result) {
						console.log(result);
						showUploadedFile(result); //업로드 결과 처리 함수
						$(".uploadDiv").html(cloneObj.html());
					}
				});
			})
			
			var uploadResult=$(".uploadResult ul");
			
			$(".uploadResult").on("click", "span", function(e){
				console.log("delete file...");
				
				var targetFile=$(this).data("file");
				var type=$(this).data("type");
				
				var targetLi=$(this).closest("li");
				
				
				$.ajax({
					url : '/notice/deleteFile',
					data : {fileName : targetFile, type: type},
					dataType : 'text',
					type: 'POST',
					success : function(result){
						alert(result);
						targetLi.remove();
					}
				})
				
				
			})
			
			
			function showUploadedFile(uploadResultArr){
				
				var str = "";
			
				 $(uploadResultArr).each(function(i, obj) {
	
					if(!obj.image){
						var fileCallPath =  encodeURIComponent("/"+ obj.uploadPath+ "/s_"+obj.uuid+"_"+obj.fileName);
						
						str +="<li>"+obj.fileName+"  <a href='/notice/download?fileName="+fileCallPath+"'>"+"<img src='/resources/images/notice_attach.jpg' style='width: 30px; height: 30px;'>"
							+"</a><span data-file=\'"+fileCallPath+"\' data-type='file'> 【  X 】 </span></li>";						
					}else{
						
						 var fileCallPath =  encodeURIComponent("/"+ obj.uploadPath+ "/s_"+obj.uuid+"_"+obj.fileName);
						/*  str+="<li data-path='"+obj.uploadPath+"'";
						 str+=" data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'><div>";
						 str+="<span> "+obj.fileName"</span>";
						 str+="  <img src='/notice/display?fileName="+fileCallPath+"' style='width: 30px; height: 30px;'>"+
						  */
						 
						 
						 str+="<li>"+obj.fileName+"  <img src='/notice/display?fileName="+fileCallPath+"' style='width: 30px; height: 30px;'>"+
						 "<span data-file=\'"+fileCallPath+"\' data-type='file'> 【  X 】</span></li>";						
					}
				});
				uploadResult.append(str);
			}
			
			
		})
		
	</script>


	<script>
		//데이트 피커 날짜 제한

		$(function() {

			$("#today").text(new Date().toLocaleDateString());

			$("#start").datepicker({
				dateFormat : 'yy/mm/dd',
				onClose : function(selectedDate) {
					// 시작일(fromDate) datepicker가 닫힐때
					// 종료일(toDate)의 선택할수있는 최소 날짜(minDate)를 선택한 시작일로 지정
					$("#start").datepicker("option", "minDate", selectedDate);
				}
			});

			$("#end").datepicker({
				dateFormat : 'yy/mm/dd',
				onClose : function(selectedDate) {
					$("#start").datepicker("option", "maxDate", selectedDate);
				}
			});
		});
	</script>

	<script>
		function checkForm() {
			var title = document.form.notice_title;
			var contents = document.form.notice_contents;
			var start = document.form.notice_startDate;
			var end = document.form.notice_endDate;

			if (title.value == '' || contents.value == '') {
				window.alert("제목과 내용을 입력해야 합니다.")
				document.form.notice_title.focus();
				document.form.notice_contents.focus();
				return false;
			}

			if (end.value != '' && start.value == '') {
				window.alert('시작일을 입력해야 합니다.')
				document.form.notice_startDate.focus();
				return false;

			}
		}
	</script>



</body>
</html>