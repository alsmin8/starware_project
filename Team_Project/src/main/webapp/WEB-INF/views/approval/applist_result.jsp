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
.modal-content>.modal-footer{
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
			<tr data-app_no="${Approval.APP_NO}", data-app_kind="${Approval.APP_KIND}", data-power_defult="${Approval.POWER_DEFULT}">
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
				<td>${Approval.EMP_NAME}(${Approval.EMP_NO})</td>
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
					<input class="form-control" name='startDate' value='startDate' readonly="readonly">
				</div>
				<div class="form-group">
					<label>완료일자</label>
					<input class="form-control" name='endDate' value='endDate' readonly="readonly">
				</div>
				<div class="form-group">
					<label>기안자</label> 
					<input class="form-control" name='writer' value='writer' readonly="readonly">
				</div>
			</div>
			<div id="container">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      			<canvas id="drawCanvas" width="200" height="150" style=" position: relative; border: 1px solid #000;"></canvas>
      			<div class="uploadResult"></div>
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
    //window가 load 될때 Event Listener를 등록 하여 준다.
    if(window.addEventListener){
        window.addEventListener('load', InitEvent, false);
    }
    var canvas, context, tool;
    function InitEvent ()
    {
        // Canvas 객체를 탐색 한다.
        canvas = document.getElementById('drawCanvas');
        if (!canvas) {
          alert('캔버스 객체를 찾을 수 없음');
          return;
        }
        if (!canvas.getContext){
          alert('Drawing Contextf를 찾을 수 없음');
          return;
        }
        // 2D canvas context를 가져 온다.
        context = canvas.getContext('2d');
        if (!context){
          alert('getContext() 함수를 호출 할 수 없음');
          return;
        }
        // tool_pencil 함수의 인스턴스를 생성 한다.
        tool = new tool_pencil();
        // Canvas에 mousedown, mousemove, mouseup 이벤트 리스너를 추가한다.
        canvas.addEventListener('mousedown', ev_canvas, false);
        canvas.addEventListener('mousemove', ev_canvas, false);
        canvas.addEventListener('mouseup',   ev_canvas, false);
    }//InitEvent end
    // 마우스 이동을 추적 하여 그리기 작업을 수행 한다.

    function tool_pencil (){
        var tool = this;
        this.started = false;
        // 마우스를 누를때 그리기 작업을 시작 한다.
        this.mousedown = function (ev){
            context.beginPath();
            context.moveTo(ev._x, ev._y);
            tool.started = true;
        };
        // 마우스가 이동 할때(mousemove) 마다 호출 된다.
        this.mousemove = function (ev){
            if (tool.started){
                context.lineTo(ev._x, ev._y);
                context.stroke();
            }
        };
        // 마우스 좌측 버튼을 놓았을때(mouseup) 호출 된다. 
        this.mouseup = function (ev){
          if (tool.started){
                tool.mousemove(ev);
                tool.started = false;
          }
        };
    }// tool_pencil end

    // Canvas요소 내의 좌표를 결정 한다.
    function ev_canvas (ev)
    {
        if (ev.layerX || ev.layerX == 0){ // Firefox 브라우저
          ev._x = ev.layerX;
          ev._y = ev.layerY;
        }else if (ev.offsetX || ev.offsetX == 0){ // Opera 브라우저
          ev._x = ev.offsetX;
          ev._y = ev.offsetY;
        }
        // tool의 이벤트 핸들러를 호출한다.
        var func = tool[ev.type];
        if (func){
            func(ev);
        }
    }//ev_canvas end
</script>
	
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
    var emp_no = <%=emp_no%>;
	
	//상세 조회 클릭 이벤트 처리 
    $("#result_detail").on("click", "tr", function(e){
    // tr를 왜 두번째에 넣어줬냐 동적으로 하기위해 - 있는 tr이 아닙니다.
	    var detailNum = $(this).data("app_no"); //app_no를 뽑아냄
	    var detailKind = $(this).data("app_kind"); //app_kind를 뽑아냄
		var detailDefult = $(this).data("power_defult");

	    console.log(emp_no);
		console.log(detailNum);
		console.log(detailKind);
		//console.log(modalInputCanvas);
		$.ajax({
			type: 'POST',
			url : '/approval2/getDatail.json',
			data : {
				app_no : detailNum,
				app_kind : detailKind,
				emp_no : emp_no
			},
			success : function(result){
				console.log(result);
				modalInputKind.val(result.KIND);
				modalInputTitle.val(result.TITLE);
				modalInputContent.val(result.CONTENT);
				modalInputStartDate.val(displayTime(result.STARTDATE));
				modalInputEndDate.val(displayTime(result.ENDDATE));
				modalInputWriter.val(result.WRITER);
				

				if(result.UPLOAD == null || result.UPLOAD =={} || result.UPLOAD == ""){

				}else{
					var fileCallPath = encodeURIComponent(result.UPLOAD);
					var canvas=document.getElementById("drawCanvas");
					var context=canvas.getContext('2d');
					var image=new Image();
					image.onload=function(){
					context.drawImage(image,0,0,canvas.width,canvas.height);
					};
					image.src= "/approval2/display?fileName="+ fileCallPath;
				}
				 
		        modal.data("app_no", result.APP_NO);
		         
		        if(detailDefult == '승인' || detailDefult == '거절'){
		        	modal.find("button[id !='modalCloseBtn']").hide();
		        }else{
		        	modal.find("button[id !='modalCloseBtn']").hide();
			        modalAcceptBtn.show();
			        modalRejectBtn.show();
		        }
		        $(".modal").modal("show");
			}
		})//getDetail 메소드 종료
    });	//result_detail 클릭버튼 이벤트 종료 
    modalAcceptBtn.on("click", function(e){
    	var Image = document.getElementById('drawCanvas').toDataURL();
		$.ajax({
			type: 'POST',
			url : '/approval2/getAccept',
			data : {
				app_no: modal.data("app_no"), 
				emp_no: emp_no,
				power_defult: '승인',
				DataURL : Image
			},
			success : function(result){
				alert(result);
				$(".modal").modal('hide');
				location.href="/approval/applist_result";
			}
		})//getAccept 메소드 종료
        
    });	//modalAcceptBtn 이벤트 종료

    modalRejectBtn.on("click", function (e){
    	var Image = document.getElementById('drawCanvas').toDataURL();
		$.ajax({
			type: 'POST',
			url : '/approval2/getReject',
			data : {
        		app_no: modal.data("app_no"), 
				emp_no: emp_no,
        		power_defult: '거절',
				DataURL : Image
			},
			success : function(result){
				alert(result);
				$(".modal").modal('hide');
				location.href="/approval/applist_result";
			}
		})//getReject 메소드 종료
  	}); //modalRejectBtn 이벤트 종료 
    $("#modalCloseBtn").on("click", function(e){
    	modal.modal('hide');
    	$(".uploadResult").html('');
    	context.clearRect(0, 0, canvas.width, canvas.height);
    });
    function displayTime(timeValue) {
    	var today = new Date();
    	var gap = today.getTime() - timeValue;
    	var dateObj = new Date(timeValue);
    		
    	var hh = dateObj.getHours();
    	var mi = dateObj.getMinutes();
    	var ss = dateObj.getSeconds();
    	var yy = dateObj.getFullYear();
    	var mm = dateObj.getMonth() + 1;
    	var dd = dateObj.getDate();
    	
    	return [yy, '/',(mm > 9 ? '' : '0') + mm, '/',(dd > 9 ? '' : '0') + dd, ' - ' , (hh > 9 ? '' : '0') + hh, ':', (mi > 9 ? '' : '0') + mi, ':',(ss > 9 ? '' : '0') + ss].join('');
    };
</script>
</body>
</html>