
var categoryService = (function() {
	
	function add(category, callback, error) {
		console.log('add reply..................');

		$.ajax({
			type : 'post',
			url : '/schedule/insertCgr',
			data : category,
			success : function() {
				if(callback) {
					callback('success');
				}
			}
			
		})
		
	}
	
	function getList(params, callback, error) {
	
		$.ajax({
			type : 'get',
			url : '/schedule/listCgr',
			data : params,
			dataType : 'json',
			success : function(data) {
				if(callback) {
					callback(data);
				}
			},
			error : function(xhr, status, er) {
				if(error) {
					error();
				}
			}
		});
	
	}
	
	function remove(params, callback, error) {
		
		$.ajax({
			type : 'post',
			url : '/schedule/deleteCgr',
			data : params,
			success : function() {
				if(callback) {
					callback('success');
				}
			},
			error : function(xhr, status, er) {
				if (error) {
					error(er);
				}
			}
			
		});
	}
	
	function update(category, callback, error) {
		
		$.ajax({
			type : 'post',
			url : '/schedule/updateCgr',
			data : category,
			success : function() {
				if(callback) {
					callback('success');
				}
			},
			error : function(xhr, status, er) {
				if(error) {
					error();
				}
			}
		});
	}
	
	function get(params, callback, error) {
		
		$.ajax({
			type : 'get', 
			url : '/schedule/getCgr',
			data : params,
			dataType : 'json',
			success : function(data, status, xhr) {
				if(callback) {
					callback(data);
				}
			},
			error : function(xhr, status, er) {
				if(error) {
					error();
				}
			}
		})
	}
	
	// replyservice 의 리턴값
	return {add : add, getList : getList, remove : remove, update : update, get : get};
	
	// replyservice 호출 동시에 함수를 실행하자.
})();


function wrapWindowByMask(str){
    //화면의 높이와 너비를 구한다.
    var maskHeight = $(document).height();  
    var maskWidth = $(window).width();  

    //마스크의 높이와 너비를 화면 것으로 만들어 전체 화면을 채운다.
    $('#mask').css({'width':maskWidth,'height':maskHeight});  

    //애니메이션 효과 - 일단 1초동안 까맣게 됐다가 80% 불투명도로 간다. 
    $('#mask').fadeTo("fast",0.6);    

    //윈도우 같은 거 띄운다.
    $('#'+str+'Modal').show();
}

$(document).ready(function(){
    //검은 막 띄우기
    $('.register').click(function(e){
        e.preventDefault();
        $('div[class=attendees-group]').empty();
        $('.color-selector .color').css('border', '');
    	$('input[type=radio][name=category_color]').attr('checked', '');
        wrapWindowByMask('register');
        $('#insertCgrBtn').show();
        $('#updateCgrBtn').hide();
        $('#deleteCgrBtn').hide();
        $('#listCgrBtn').hide();
    });
    
   /* $('.listedit').click(function(e){
        e.preventDefault();
        wrapWindowByMask('listedit');
    });*/

    //닫기 버튼을 눌렀을 때
    $('.modal .close').click(function (e) {  
        //링크 기본동작은 작동하지 않도록 한다.
        e.preventDefault();  
        $('#mask, .modal, #calendar-sub-info').hide();  
    });       

    //검은 막을 눌렀을 때
    $('#mask').click(function () {  
        $(this).hide();  
        $('.modal').hide();  
    });      
    
    $('.title').on('click', function() {
    	$('#calendar-sub-info').show();
    })
    
    $('.color-selector .color').on('click', function() {
    	
    	$('.color-selector .color').css('border', '');
    	$('input[type=radio][name=category_color]').attr('checked', '');
 		$(this).next('input[type=radio][name=category_color]').attr('checked', 'checked');
 		$(this).css('border','3.5px #BDBDBD solid');
 		
    	var colorValue = $('input[type=radio][name=category_color]').length;
 	    console.log('len'+colorValue);
    	var colorData = new Array(colorValue);
 	    for(var i=0; i<colorValue; i++){                          
 	    	colorData[i] = $('input[type=radio][name=category_color]')[i].checked;
 	    	console.log('-----'+colorData[i]);
 	    }
 	    
 	});
    
	$('.attendees-group').on('click', 'button', function(e) {
		e.preventDefault();
		$(this).parent().remove();
	})    

});



function startSuggest() {
		var keyword = $('#temp').val();
		console.log('keyword.........'+keyword);
		
		var keywordData = { "keyword": keyword };
		
		$.ajax({
			url : '/schedule/listEmp',
			type : 'get',
			data : keywordData,
			dataType : 'json',
			success : function(data) {
				$('#suggest tbody').html('');
				var html = "";
				$.each(data, function(index, item) {
					var str = item.emp_no + ":"+item.emp_name+":"+item.dept_name;
					console.log('str..........'+str);
					html += "<tr><td><a href=javascript:select('" + str + "')>" + item.emp_name + "</a></td><td>" 
									+ item.dept_name + "</td><td>" + item.emp_no + "</td></tr>";
				});
				console.log('성공');
				$('#suggestList tbody').append(html);
				show('suggest');
			}
		});
	}

	function show(elementId) {
		var element = document.getElementById(elementId);
		console.log(element);
		if (element) {
			element.style.display = "";
		}
	}

	function select(selectKeyword) {
/*              		hide('suggest');  */
		var emp_no = selectKeyword.substring(0, selectKeyword.indexOf(':'));
		var emp_name = selectKeyword.substring(selectKeyword.indexOf(':')+1, selectKeyword.lastIndexOf(':'));
		var dept_name = selectKeyword.substring(selectKeyword.lastIndexOf(':')+1);
	$('.attendees-group').append('<span><input type="checkbox" name="attendees" value="'+ emp_no + '" checked="checked" style="display:none">'
								+ emp_name +'-'+dept_name+' ['+emp_no+']</input><button id="delete-btn">X</button></span>');
	}

	/* function hide(elementId) {
		var element = document.getElementById(elementId);
		if (element) {
			
			element.style.display = "none";
		}
	} */
	
