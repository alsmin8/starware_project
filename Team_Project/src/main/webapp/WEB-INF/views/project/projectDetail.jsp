<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale = 1">
<link rel="stylesheet" href="/resources/css/bootstrap.css">
<link rel="stylesheet" href="/resources/css/custom.css">
<link rel="stylesheet" href="/resources/css/detailProject.css">
<title>STARWARE(Groupware)</title>
<script src="/resources/jquery.js" type="text/javascript"></script>
<script src="/resources/js/bootstrap.js"></script>
<style>
.uploadResult {
  width:100%;
  background-color: gray;
}
.uploadResult ul{
  display:flex;
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
.uploadResult ul li img{
  width: 100px;
}
.uploadResult ul li span {
  color:white;
}
.bigPictureWrapper {
  position: static;
  display: none;
  justify-content: center;
  align-items: center;
  top:0%;
  width:100%;
  height:100%;
  background-color: gray; 
  z-index: 100;
  background:rgba(255,255,255,0.5);
}
.bigPicture {
  position: relative;
  display:flex;
  justify-content: center;
  align-items: center;
}

.bigPicture img {
  width:600px;
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
            <li><a href="/approval/applist_alllist">전자결재</a></li>
           	<li class="active"><a href="/project/projectList">협업지원</a></li>
            <li><a href="/notice/noticeList">공지사항</a></li>
            <li><a href="/attend/attendInsert">출퇴근관리</a></li>
            <li><a href="/emp/empList">인사관리</a></li>
            <li><a href="/schedule/scheduleMain">일정관리</a></li>
            <li><a href="/chat/messengerFind">메세지함<span id="unread" class="label label-info"></span></a></li>
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
						<li><a href="/logoutaction">로그아웃</a></li>
					</ul></li>
			</ul>

			<%
				}
			%>
		</div>
	</nav>
	
	<div class="container">
	
	<h3 align="center">프로젝트 상세보기</h3>
	<table class="detail">
		<tr>
			<th>번호</th>
			<td>${project.project_No }</td>
		</tr>
		<tr>
			<th>작성일</th>
			<td>${project.project_Regdate }</td>
		</tr>
		<tr>
			<th>프로젝트 제목</th>
			<td>${project.project_Title }</td>
		</tr>
		<tr>
			<th>작성자</th>
			<td>${project.project_Writer }</td>
		</tr>
		<tr>
			<th>담당자</th>
			<td>${project.project_Manager }</td>
		</tr>
		<tr>
			<th>기간</th>
			<td>${project.project_Term }</td>
		</tr>
		<tr>
			<th>계획시작일</th>
			<td><fmt:parseDate var="project_Start_Date"	value="${project.project_Start_Date}" pattern="yyyy-MM-dd"/> <fmt:formatDate value="${project_Start_Date}"
							pattern="yyyy-MM-dd" /></td>
		</tr>
		<tr>
			<th>계획종료일</th>
			<td><fmt:parseDate var="project_End_Date"	value="${project.project_End_Date}" pattern="yyyy-MM-dd" scope="page" /> <fmt:formatDate value="${project_End_Date}"
							pattern="yyyy-MM-dd" /></td>
		</tr>
		<tr>
			<th>프로젝트 종류</th>
			<td>${project.project_Kind }</td>
		</tr>
		<tr>
			<th>진행상태</th>
			<td>${project.project_Situation }</td>
		</tr>
		<tr>
			<th>내용</th>
			<td>${project.project_Contents }</td>
		</tr>
	</table>
	
			<div class='bigPictureWrapper'>
  <div class='bigPicture'>
  </div>
</div>

<div class="row">
  <div class="col-lg-12">
    <div class="panel panel-default">

      <div class="panel-heading">Files</div>
      <!-- /.panel-heading -->
      <div class="panel-body">
        
        <div class='uploadResult'> 
          <ul>
          </ul>
        </div>
      </div>
      <!--  end panel-body -->
    </div>
    <!--  end panel-body -->
  </div>
  <!-- end panel -->
</div>
<!-- /.row -->
	
	
	<button data-oper="update" class="btn btn-primary pull" style="text-align: right">수정하기</button>
	<button data-oper="delete" class="btn btn-primary pull" style="text-align: right">삭제하기</button>
	<button data-oper="list" class="btn btn-primary pull" style="text-align: right">목록</button>
	<span style="float: right;"><input class="btn btn-primary pull" type="button" value="게시판" onclick="location.href='/project/projectBoard?project_No=${project.project_No}&project_Writer=${project.project_Writer }&pageNum=${cri.pageNum}&amount=${cri.amount}';"></span>

	
	<form id='listAction' action="project/projectList" method="get">
	<input type='hidden' name='project_No' id='project_No' value='<c:out value="${project.project_No}"/>'>
	<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum}"/>'>
	<input type='hidden' name='amount' value='<c:out value="${cri.amount}"/>'>
	<input type='hidden' name='projectSearchType' value='<c:out value="${cri.projectSearchType}"/>'>
    <input type='hidden' name='projectSearchKey' value='<c:out value="${cri.projectSearchKey}"/>'>
	</form>
	
	<form id='deleteFormAction' action="project/projectDelete" method="get">
	<input type='hidden' name='project_No' id='project_No' value='<c:out value="${project.project_No}"/>'>
	<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum}"/>'>
	<input type='hidden' name='amount' value='<c:out value="${cri.amount}"/>'>
	<input type='hidden' name='projectSearchType' value='<c:out value="${cri.projectSearchType}"/>'>
    <input type='hidden' name='projectSearchKey' value='<c:out value="${cri.projectSearchKey}"/>'>
	</form>
	
	<form id='updateFormAction' action="project/projectUpdate" method="get">
	<input type='hidden' name='project_No' id='project_No' value='<c:out value="${project.project_No}"/>'>
	<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum}"/>'>
	<input type='hidden' name='amount' value='<c:out value="${cri.amount}"/>'>
	<input type='hidden' name='projectSearchType' value='<c:out value="${cri.projectSearchType}"/>'>
    <input type='hidden' name='projectSearchKey' value='<c:out value="${cri.projectSearchKey}"/>'>
	</form>
	
<script type="text/javascript">
$(document).ready(function () {
	 
		(function(){
			
	  var project_No = '<c:out value="${project.project_No}"/>';
	  
	  $.getJSON("/project/getAttachList", {project_No: project_No}, function(arr){
		
		  console.log(arr);
		  
		  var str="";
		  
		  $(arr).each(function(i, attach){
		         if(attach.project_fileName){
		        	 
		             str += "<li data-path='"+attach.project_uploadPath+"' data-uuid='"+attach.project_uuid+"' data-filename='"+attach.project_fileName+"'><div>";
		             str += "<span> "+ attach.project_fileName+"</span><br/>";
		             str += "<img src='/resources/images/attach.png'></a>";
		             str += "</div>";
		             str +"</li>";
		          } 
		         });
		         
		         $(".uploadResult ul").html(str);
		         
		         
		       });//end getjson

		      
		    })();//end function

$(".uploadResult").on("click","li", function(e){
    
    var liObj = $(this);
    
    var path = encodeURIComponent(liObj.data("path")+"/" + liObj.data("uuid")+"_" + liObj.data("filename"));
    
    if(liObj.data("uuid") == null){
    	showImage(path.replace(new RegExp(/\\/g),"/"));
    }else {
      //download 
      self.location ="/project/download?fileName="+path
    }
    
});
  });
  
</script>
<script type="text/javascript">

	$(document).ready(function() {
		var listAction = $("#listAction");
		var updateFormAction = $("#updateFormAction");
		var deleteFormAction = $("#deleteFormAction");

		$("button[data-oper='update']").on("click", function(e) {
			updateFormAction.attr("action", "/project/projectUpdate").submit();
	}); 

		$("button[data-oper='list']").on("click", function(e) {
			listAction.find("#project_No").remove();
			listAction.attr("action", "/project/projectList")
			listAction.submit();
	});
	
		$("button[data-oper='delete']").on("click", function(e) {
			deleteFormAction.attr("action", "/project/projectDelete").submit();
	}); 
	
	});
</script>
	
	</div>
	
	
</body>
</html>