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
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="/resources/jquery.js" type="text/javascript"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="/resources/js/bootstrap.js"></script>
<style>
.uploadResult {
	width: 100%;
	background-color: gray;
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
	color: white;
}

.bigPictureWrapper {
	position: absolute;
	display: none;
	justify-content: center;
	align-items: center;
	top: 0%;
	width: 100%;
	height: 100%;
	background-color: gray;
	z-index: 100;
	background: rgba(255, 255, 255, 0.5);
}

.bigPicture {
	position: relative;
	display: flex;
	justify-content: center;
	align-items: center;
}

.bigPicture img {
	width: 600px;
}
</style>
<script>
	function getSelectValue(frm) {
		frm.project_Situation.value = frm.situation.options[frm.situation.selectedIndex].text;
		frm.project_Kind.value = frm.Kind.options[frm.Kind.selectedIndex].text;
	};
</script>

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
				<li><a href="/chat/messengerFind">메세지함<span
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
						<li><a href="/logoutaction">로그아웃</a></li>
					</ul></li>
			</ul>

			<%
				}
			%>
		</div>
	</nav>

<form role="form" id="form" name="form" action="projectUpdate" method="post">
	<div class="container">
			<input type="hidden" name="project_No" value="${project.project_No}">
			<input type="hidden" name="emp_no" value="${emp_no}"> <input
				type='hidden' name='pageNum' value='<c:out value="${cri.pageNum}"/>'>
			<input type='hidden' name='amount'
				value='<c:out value="${cri.amount}"/>'> <input type='hidden'
				name='projectSearchType'
				value='<c:out value="${pageMaker.cri.projectSearchType}"/>'>
			<input type='hidden' name='projectSearchKey'
				value='<c:out value="${pageMaker.cri.projectSearchKey }"/>'>

			<table class="table table-bordered table-hover"
				style="text-align: center; border: 1px solid #dddddd;">
				<thead>
					<tr>
						<th colspan="5"><h4>프로젝트 수정</h4></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 110px;"><h5>작성자</h5></td>
						<td colspan="2"><input class="form-control" type="text"
							id="project_Writer" name="project_Writer" maxlength="20"
							value="${project.project_Writer }"></td>

						<td><h5>프로젝트 종류</h5></td>
						<td colspan="2"><select name="project_Kind"
							onChange="getSelectValue(this.form);" class="form-control">
								<option value="${project.project_Kind }">품질개선</option>
								<option value="${project.project_Kind }">검증</option>
								<option value="${project.project_Kind }">유지보수</option>
								<option value="${project.project_Kind }">개발</option>
						</select></td>
					</tr>

					<tr>
						<td style="width: 110px;"><h5>담당자</h5></td>
						<td colspan="2"><input class="form-control" type="text"
							id="project_Manager" name="project_Manager" maxlength="20"
							value="${project.project_Manager }"></td>

						<td style="width: 110px;"><h5>진행상태</h5></td>
						<td colspan="2"><select name="project_Situation"
							onChange="getSelectValue(this.form);" class="form-control">
								<option value="${project.project_Situation }">예정</option>
								<option value="${project.project_Situation }">완료</option>
								<option value="${project.project_Situation }">보류</option>
								<option value="${project.project_Situation }">폐기</option>
						</select>
					</tr>

					<tr>
						<td style="width: 110px;"><h5>팀원</h5></td>
						<td colspan="2"><input class="form-control" type="text"
							id="project_Members" name="project_Members" maxlength="20"
							value="${project.project_Members }"></td>

												<td style="width: 110px;"><h5>기간</h5></td>
						<td colspan="2"><input class="form-control" type="number"
							id="project_Term" name="project_Term" maxlength="20"></td>
					</tr>

					<tr>
						<td style="width: 110px;"><h5>제목</h5></td>
						<td colspan="2"><input class="form-control" type="text"
							id="project_Title" name="project_Title" maxlength="20"
							value="${project.project_Title }"></td>
						<td style="width: 110px;"><h5>계획시작일</h5></td>
						<td colspan="2"><input class="form-control"  type="date"
							id="project_Start_Date" name="project_Start_Date" maxlength="20"
							value="${project.project_Start_Date }"></td>

					</tr>
					<tr>
						<td style="width: 110px;"><h5>내용</h5></td>
						<td colspan="2"><textarea class="form-control" rows="8"
								cols="100" name="project_Contents">${project.project_Contents }</textarea></td>
						<td style="width: 110px;"><h5>계획종료일</h5></td>
						<td colspan="2"><input class="form-control" type="date"
							id="project_End_Date" name="project_End_Date" maxlength="20"
							value="${project.project_End_Date }"></td>
					</tr>

				</tbody>
			</table>
			<div class='bigPictureWrapper'>
				<div class='bigPicture'></div>
			</div>

			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-heading">Files</div>
						<!-- /.panel-heading -->
						<div class="panel-body">
						<input type="file" name="uploadFile" multiple="multiple">
					</div>
					<div class="uploadResult">
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
		</form>
			<button type="submit" data-oper='list' class="btn btn-primary pull"	style="margin-left: 485px">프로젝트 수정 취소</button>
			<button type="submit" data-oper='update' class="btn btn-primary pull" style="text-align: center;">프로젝트 수정</button>

	<script type="text/javascript">
		$(document).ready(
				function() {
					var updateProjectForm = $("form");
					var Title = document.form.project_Title;
					var Contents = document.form.project_Contents;

					$('button').on(
							"click",
							function(e) {
								e.preventDefault();
								var projectoper = $(this).data("oper");
								console.log(projectoper);

								if (projectoper === 'update') {

									if (Title.value == ''
											|| Contents.value == '') {
										window.alert("제목과 내용을 입력해야 합니다.")
										document.form.project_Title.focus();
										document.form.project_Contents.focus();
										return false;
									}

									updateProjectForm.attr("action",
											"/project/projectUpdate");

								} else if (projectoper === 'list') {
									updateProjectForm.attr("action",
											"/project/projectList").attr(
											"method", "get");

									var pageNumTag = $("input[name='pageNum']")
											.clone();
									var amountTag = $("input[name='amount']")
											.clone();
									var keywordTag = $(
											"input[name='ProjectSearchKey']")
											.clone();
									var typeTag = $(
											"input[name='ProjectSearchType']")
											.clone();

									updateProjectForm.empty();
									updateProjectForm.append(pageNumTag);
									updateProjectForm.append(amountTag);
									updateProjectForm.append(keywordTag);
									updateProjectForm.append(typeTag);
								}
								updateProjectForm.submit();
							});
				});
	</script>
	
	<script type="text/javascript">
	$(document).ready(function() {
		  (function(){
		    
		    var project_No = '<c:out value="${project.project_No}"/>';
		    
		    $.getJSON("/project/getAttachList", {project_No:project_No}, function(arr){
		    
		      console.log(arr);
		      
		      var str = "";


		      $(arr).each(function(i, attach){
		    	  
		            var fileCallPath =  encodeURIComponent( attach.project_uploadPath+ "/s_"+attach.project_uuid +"_"+attach.project_fileName);

		            str += "<li data-path='"+attach.project_uploadPath+"' data-uuid='"+attach.project_uuid+"' "
		            str += "data-filename='"+attach.project_fileName+"'><div>";
		            str += "<span> "+ attach.project_fileName+"</span><br/>";
		            str += "<button type='button' data-file=\'"+fileCallPath+""
		            str += " class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
		            str += "<img src='/resources/images/attach.png'></a>";
		            str += "</div>";
		            str +"</li>";
		       });
		      
		      $(".uploadResult ul").html(str);
		      
		    });//end getjson
		  })();//end function
	});
	
	  $(".uploadResult").on("click", "button", function(e){
		    
		    console.log("delete file");
		      
		    if(confirm("Remove this file? ")){
		    
		      var targetLi = $(this).closest("li");
		      targetLi.remove();
		    }
		  });  
		
	  var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	  var maxSize = 5242880; //5MB
	  
	  function checkExtension(fileName, fileSize){
	    
	    if(fileSize >= maxSize){
	      alert("파일 사이즈 초과");
	      return false;
	    }
	    
	    if(regex.test(fileName)){
	      alert("해당 종류의 파일은 업로드할 수 없습니다.");
	      return false;
	    }
	    return true;
	  }
	  
	  $("input[type='file']").change(function(e){

		    var formData = new FormData();
		    
		    var inputFile = $("input[name='uploadFile']");
		    
		    var files = inputFile[0].files;
		    
		    for(var i = 0; i < files.length; i++){

		      if(!checkExtension(files[i].name, files[i].size) ){
		        return false;
		      }
		      formData.append("uploadFile", files[i]);
		      
		    }
		    
		    $.ajax({
		      url: '/project/uploadAjaxAction',
		      processData: false, 
		      contentType: false,data: 
		      formData,type: 'POST',
		      dataType:'json',
		        success: function(result){
		          console.log(result); 
				  showUploadResult(result); //업로드 결과 처리 함수 

		      }
		    }); //$.ajax
		    
	  });
		    function showUploadResult(uploadResultArr){
			    
		        if(!uploadResultArr || uploadResultArr.length == 0){ return; }
		        
		        var uploadUL = $(".uploadResult ul");
		        
		        var str ="";
		        
		        $(uploadResultArr).each(function(i, obj){
		    			var fileCallPath =  encodeURIComponent( obj.project_uploadPath+"/"+ obj.project_uuid +"_"+obj.project_fileName);			      
		    		    var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
		    		      
		    			str += "<li "
		    			str += "data-path='"+obj.project_uploadPath+"' data-uuid='"+obj.project_uuid+"' data-filename='"+obj.project_fileName+"' ><div>";
		    			str += "<span> "+ obj.project_fileName+"</span>";
		    			str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' " 
		    			str += "class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
		    			str += "<img src='/resources/images/attach.png'></a>";
		    			str += "</div>";
		    			str +"</li>";
		        });
		        
		        uploadUL.append(str);
		      }
</script>
		    
<script type="text/javascript">
		    $(document).ready(function() {


		  	  var formObj = $("form");

		  	  $('button').on("click", function(e){
		  	    
		  	    e.preventDefault(); 
		  	    
		  	    var operation = $(this).data("oper");
		  	    
		  	    console.log(operation);
		  	    
		  	    if(operation === 'remove'){
		  	      formObj.attr("action", "/project/remove");
		  	      
		  	    }else if(operation === 'list'){
		  	      //move to list
		  	      formObj.attr("action", "/project/projectList").attr("method","get");
		  	      
		  	      var pageNumTag = $("input[name='pageNum']").clone();
		  	      var amountTag = $("input[name='amount']").clone();
		  	      var keywordTag = $("input[name='projectSearchKey']").clone();
		  	      var typeTag = $("input[name='projectSearchType']").clone();      
		  	      
		  	      formObj.empty();
		  	      
		  	      formObj.append(pageNumTag);
		  	      formObj.append(amountTag);
		  	      formObj.append(keywordTag);
		  	      formObj.append(typeTag);	  
		  	      
		  	    }else if(operation === 'update'){
		  	        
		  	        console.log("submit clicked");
		  	        
		  	        var str = "";
		  	        
		  	        $(".uploadResult ul li").each(function(i, obj){
		  	          
		  	          var jobj = $(obj);
		  	          
		  	          console.dir(jobj);
		  	          
		  	          str += "<input type='hidden' name='attachList["+i+"].project_fileName' value='"+jobj.data("filename")+"'>";
		  	          str += "<input type='hidden' name='attachList["+i+"].project_uuid' value='"+jobj.data("uuid")+"'>";
		  	          str += "<input type='hidden' name='attachList["+i+"].project_uploadPath' value='"+jobj.data("path")+"'>";
		  	          
		  	        });
		  	        formObj.append(str).submit();
		          }
		      
		  	    formObj.submit();
		  	  });
		    });
	</script>


</body>
</html>