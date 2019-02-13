$(function() {
	$('#tab2').click(function() {
		location.href = "listActionSchedule.sche"
	});
	$('#tab3').click(function() {
		location.href = "insertFormSchedule2.jsp"
	});
});

$(document).ready(
		function() {
			$(function() {
				$.ajax({
					url : 'listJsonBySchno.sche',
					dataType : 'json',
					success : function(data) {
						$.each(data, function(index, item) {
							var start = item.schedule_starttime
							var end = item.schedule_endtime
							var startime = start.substring(11);
							var endtime = end.substring(11);
							// 0000-00-00
							if (start.substring(5, 7) == $('#mth').attr('name')
									|| start.substring(6, 7) == $('#mth').attr(
											'name')) {
								if (start.substring(8, 9) == '0'
										|| end.substring(8, 9) == '0') {
									start = start.substring(9, 10);
									end = end.substring(9, 10);
								} else {
									start = start.substring(8, 10);
									end = end.substring(8, 10);
								}
								for (var i = start; i <= end; i++) {
									$("td[id='" + i + "']").append(
											"<div class='new' value = '일정' onclick = 'winOpen("
													+ item.schedule_no + ","
													+ item.emp_no + ")'>"
													+ item.schedule_title
													+ " (" + item.empCount
													+ ") </div>");
								}
							}
						});
					}
				});

			});
		})

function winOpen(schedule_no, emp_no) {
	var url = 'detailActionSchedule.sche?schedule_no=' + schedule_no
			+ '&emp_no=' + emp_no;
	window.open(url, '일정', 'width = 500, height = 500');
}

function startSuggest() {
	var keyword = $('#temp').val();
	var params = "keyword=" + encodeURIComponent(keyword);

	$.ajax({
		url : 'listJsonEmp.sche',
		type : 'POST',
		data : params,
		dataType : 'json',
		success : function(data) {
			var html = "";
			$.each(data, function(index, item) {
				var str = item.schedule_title;
				console.log(typeof (str));
				html += "<a href=javascript:select('" + str + "')>" + str
						+ "</a><br>";
			});
			console.log('성공');
			var suggestList = document.getElementById("suggestList");
			suggestList.innerHTML = html;
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
	hide('suggest');
	$('.attendees-group')
			.append(
					'<input type="checkbox" class="form-control" name="attendees" id="person" value="'
							+ selectKeyword
							+ '">'
							+ selectKeyword
							+ '</input>&nbsp&nbsp');
}

function hide(elementId) {
	var element = document.getElementById(elementId);
	if (element) {
		element.style.display = "none";
	}
}
