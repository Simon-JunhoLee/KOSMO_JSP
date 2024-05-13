<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	input[type="checkbox"] {
	    width: 20px;
	    height: 20px;
	}
	input[type="checkbox"]:checked {
        background-color: black; /* Change to desired color */
        border : none;
    }
</style>
<div>
	<h1>수강신청한 학생 목록</h1>
	<div id="div_stu"></div>
</div>

<script id="temp_stu" type="x-handlebars-template">
	<button class="btn btn-dark px-3 mb-2" id="update">선택 저장</button>
	<table class="table table-hover">
		<colgroup>
			<col width="4%"/>
            <col width="16%"/>
            <col width="16%"/>
            <col width="16%"/>
            <col width="16%"/>
            <col width="16%"/>
            <col width="16%"/>                        
        </colgroup>
		<tr class="table-dark text-center">
			<td><input class="form-check-input" id="all" type="checkbox"></td>
			<td>학생번호</td>
			<td>학생이름</td>
			<td>학생학과</td>
			<td>학생학년</td>
			<td>수강신청일</td>
			<td>점수</td>
		</tr>
		{{#each .}}
		<tr class="text-center stu-row" scode="{{scode}}">
			<td><input class="form-check-input chk" type="checkbox"></td>
			<td>{{scode}}</td>
			<td>{{sname}}</td>
			<td>{{sdept}}</td>
			<td>{{year}}학년</td>
			<td>{{edate}}</td>
			<td scode="{{scode}}">
				<input class="text-center px-2 grade" size=3 value="{{grade}}">
				<button class="btn btn-dark btn-sm update">수정</button>
			</td>
		</tr>
		{{/each}}
	</table>
</script>

<script>
let lcode = "${cou.lcode}";
getData();

$("#div_stu").on("click", ".stu-row .update", function(){
	let scode = $(this).parent().attr("scode");
	let td = $(this).parent();
	let grade = td.find(".grade").val();
	// alert(lcode + ":" + scode + ":" + grade);
	$.ajax({
		type:"post",
		url:"/enroll/update",
		data:{lcode, scode, grade},
		success:function(){
			// alert("점수 수정 완료")
			getData();
		}
	});
});

// 전체선택 체크박스를 클릭한 경우
$("#div_stu").on("click", "#all", function(){
	if($(this).is(":checked")){
		$("#div_stu .chk").each(function(){
			$(this).prop("checked", true);
		});
	}else{
		$("#div_stu .chk").each(function(){
			$(this).prop("checked", false);
		});
	}
});

// 각행의 체크박스를 클릭한 경우
$("#div_stu").on("click", ".chk", function(){
	let all = $("#div_stu .chk").length;
	let chk = $("#div_stu .chk:checked").length;
	if(all == chk){
		$("#div_stu #all").prop("checked", true);
	}else{
		$("#div_stu #all").prop("checked", false);
	}
});

// 선택 저장 버튼을 클릭한 경우
$("#div_stu").on("click", "#update", function(){
	let chk = $("#div_stu .chk:checked").length;
	if(chk == 0){
		alert("수정할 학생들을 선택하세요.");
		return;
	}
	if(!confirm(chk + "개 성적을 수정하시겠습니까?")) return;
	// 성적 수정
	let cnt = 0;
	$("#div_stu .chk:checked").each(function(){
		let tr = $(this).parent().parent();
		let scode = tr.attr("scode");
		let grade = tr.find(".grade").val();
		// alert(lcode + "/" + scode + "/" + grade);
		$.ajax({
			type:"post",
			url:"/enroll/update",
			data:{lcode, scode, grade},
			success:function(){
				cnt++;
				if(chk == cnt){					
					alert("점수 수정 완료");
					getData();
				}
			}
		});
	});
});

function getData(){
	$.ajax({
		type:"get",
		url:"/enroll/slist.json",
		dataType:"json",
		data:{lcode},
		success:function(data){
			console.log(data);
			const temp=Handlebars.compile($("#temp_stu").html());
			$("#div_stu").html(temp(data));
		}
	});
}
</script>