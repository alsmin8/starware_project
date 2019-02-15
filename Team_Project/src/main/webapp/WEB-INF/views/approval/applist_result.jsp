<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	
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
<style>

td{
text-align: center;
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

		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="/loginafter">메인</a></li>
				<li class="active"><a href="/approval/applist_alllist">전자결재</a></li>
				<li><a href="/project/projectList">협업지원</a></li>
				<li><a href="/notice/noticeList">공지사항</a></li>
				<li><a href="/attend/attendInsert">출퇴근관리</a></li>
				<li><a href="/emp/empList">인사관리</a></li>
				<li><a href="/schedule/scheduleMain">일정관리</a></li>
				<li><a href="/chat/messengerFind">메세지함<span id="unread" class="label label-info"></span></a></li>
			</ul>

			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="buton" aria-haspopup="true"
					aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="/logoutaction">로그아웃</a></li>
					</ul>
				</li>
			</ul>

		</div>
	</nav>
	
	<script type="text/javascript">
		$(function() {
			$('#tab1').click(function() {
				location.href="/approval/applist_alllist"
			});
			$('#tab2').click(function() {
				location.href="/approval/applist_myself"
			});
		});
	
	</script>  
	
	<div class="container">
		<ul class="nav nav-tabs" role="tablist">
			<li><a id="tab1" role="tab" data-toggle="tab" style="font-size: 11pt; font-weight: bold">전자결재목록</a></li>
			<li><a id="tab2" role="tab" data-toggle="tab" font-weight="bold" style="font-size: 11pt; font-weight: bold">내가 올린 결재목록</a></li>
			<li class="active"><a id="tab3" href="#applist" role="tab" data-toggle="tab" font-weight="bold" style="font-size: 11pt; font-weight: bold">내가 진행할 결재목록</a></li>
		</ul>
	</div>
	<div class="container" id="applist">
		<h2>내가 진행할 결재목록</h2><br>
	<table class="type04">
		<thead>
			<tr>
				<td>글번호</td>
				<td>문서종류</td>
				<td>제      목</td>
				<td>기안일자</td>
				<td>상신일자</td>
				<td>본인승인결과</td>
				<td>기안자</td>
			</tr>
		</thead>
		<tbody id="result_detail">
		<c:forEach var="Approval" items="${applist_result}">
			<tr data-app_no="${Approval.APP_NO}">
				<td>${Approval.APP_NO}</td>
				<td>${Approval.APP_KIND}</td>
				<td>${Approval.APP_TITLE}</td>
				<%-- <a href="detail.bit?seq=${Approval.APP_NO}&app_kind=${Approval.APP_KIND}"></a> --%>
				<td>
					 <fmt:parseDate var="dateString" value="${Approval.APP_STARTDATE}" pattern="yyyy-MM-dd"/>
					 <fmt:formatDate value="${dateString}" pattern="yyyy-MM-dd"/>
				</td>
				<td>
					 <fmt:parseDate var="dateString" value="${Approval.POWER_REGDATE}" pattern="yyyy-MM-dd"/>
					 <fmt:formatDate value="${dateString}" pattern="yyyy-MM-dd"/>
				</td>
				<td>${Approval.POWER_DEFULT}</td>
				<td>${Approval.EMP_NO}</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<br><br>
	
	
	<!-- <form action="list.bit" method="post" >
	<input type ="checkbox" name = "check" value = "연차신청서">연차신청서
	<input type ="checkbox" name = "check" value = "지출결의서">지출결의서
	<input type ="checkbox" name = "check" value = "기안서">기안서
	<br>
	<input type ="checkbox" name = "time" value = "approval_time">기간
	<input type ="date" name = "time" value = "app_startdate">~
	<input type ="date" name = "time" value = "app_enddate">
	<br>
	<input type="radio" name="app_situation" value="결재요청">결재요청
	<input type="radio" name="app_situation" value="결재중">결재중
	<input type="radio" name="app_situation" value="반려">반려
	<input type="radio" name="app_situation" value="승인">승인
	
	<input type ="checkbox" name = "vd_title" value = "vd_title">제목
	<input type ="text" name = "searchKey" size = "10"></input>
	
	<input type ="text" name = "searchKey" size = "10"></input>
	<br><input type = "submit" value = "검색">
	
	</form> -->
	
	</div>




<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">결재 승인 내용 및 창</h4>
			</div>
			<div class="modal-body">
				<div class="form-group">
					<label>문서종류</label> 
					<input class="form-control" name='kind' value='kind!!!!' readonly="readonly">
				</div>      
				<div class="form-group">
					<label>제목</label> 
					<input class="form-control" name='title' value='New Title!!!!' readonly="readonly">
				</div>
				<div class="form-group">
					<label>작성내용</label> 
					<input class="form-control" name='content' value='content' readonly="readonly">
				</div>
				<div class="form-group">
					<label>기안일자</label> 
					<input class="form-control" name='startDate' value='2018-01-01 13:13' readonly="readonly">
				</div>
				<div class="form-group">
					<label>완료일자</label> 
					<input class="form-control" name='endDate' value='2018-01-01 13:13' readonly="readonly">
				</div>
				<div class="form-group">
					<label>기안자</label> 
					<input class="form-control" name='writer' value='writer' readonly="readonly">
				</div>
			</div>
			<div class="modal-footer">
				<button id='modalAcceptBtn' type="button" class="btn btn-primary">accept</button>
				<button id='modalRejectBtn' type="button" class="btn btn-danger">reject</button>
				<button id='modalCloseBtn' type="button" class="btn btn-default">Close</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
<!-- /.modal -->
	
	
	
<script type="text/javascript">
	var modal = $(".modal");
	var modalInputKind = modal.find("input[name='kind']");
	var modalInputTitle = modal.find("input[name='title']");
	var modalInputContent = modal.find("input[name='content']");
	var modalInputStartDate = modal.find("input[name='startDate']");
	var modalInputEndDate = modal.find("input[name='endDate']");
	var modalInputWriter = modal.find("input[name='writer']");
	
	var modalAcceptBtn = $("#modalAcceptBtn");
	var modalRejectBtn = $("#modalRejectBtn");

	//상세 조회 클릭 이벤트 처리 
    $(".result_detail").on("click", "tr", function(e){
    // tr를 왜 두번째에 넣어줬냐 동적으로 하기위해 - 있는 tr이 아닙니다.
	    var detailNum = $(this).data("app_no"); //app_no를 뽑아냄
	
	  	function getDetail(detailNum) {
			$.ajax({
				type: 'POST',
				url : '/approval2/getDetail.json',
				data : {
					app_no : detailNum
				},
				success : function(result){
					console.log(result);
					modalInputKind.val(result.kind);
					modalInputTitle.val(result.title);
					modalInputContent.val(result.content);
					modalInputStartDate.val(result.startDate);
					modalInputEndDate.val(result.endDate);
					modalInputWriter.val(result.writer);
					
			        modal.data("app_no", result.app_no);
			        
			        modal.find("button[id !='modalCloseBtn']").hide();
			        modalAcceptBtn.show();
			        modalRejectBtn.show();
			        
			        $(".modal").modal("show");
				}
			})
	    }	//getDetail 메소드 종료
    });	//result_detail 클릭버튼 이벤트 종료
    modalAcceptBtn.on("click", function(e){
        function getAccept(){
			$.ajax({
				type: 'POST',
				url : '',
				data : {
					app_no: modal.data("app_no"), 
					power_defult: '승인'
				},
				success : function(result){
					console.log(result);
					alret(result);
					$(".modal").modal('hide');
					location.href="/approval/applist_result";
				}
			})
	    }	//getAccept 메소드 종료
        
    });	//modalAcceptBtn 이벤트 종료

    modalRejectBtn.on("click", function (e){

        function getReject(){
			$.ajax({
				type: 'POST',
				url : '',
				data : {
	        		app_no: modal.data("app_no"), 
	        		power_defult: '거절'
				},
				success : function(result){
					console.log(result);
					alret(result);
					$(".modal").modal('hide');
					location.href="/approval/applist_result";
				}
			})
	    }	//getReject 메소드 종료
  	}); //modalRejectBtn 이벤트 종료
    
</script>

</body>
</html>