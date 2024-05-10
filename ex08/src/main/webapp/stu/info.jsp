<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div>
	<h1>수강신청목록</h1>
	<div class="input-group mb-2">	
		<div id="div_cou"></div>
		<button class="btn btn-dark" id="insert">수강신청</button>
	</div>
	<div id="div_enroll"></div>
</div>

<script id="temp_enroll" type="x-handlebars-template">
	<table class="table table-hover">
		<tr class="table-dark text-center">
			<th>강좌번호</th>
			<th>강좌이름</th>
			<th>강의시간</th>
			<th>강의실</th>
			<th>신청인원</th>
			<th>담당교수</th>
			<th>수강신청일</th>
			<th></th>
		</tr>
		{{#each .}}
		<tr class="text-center cou-row" data-lcode="{{lcode}}">
			<td>{{lcode}}</td>
			<td>{{lname}}</td>
			<td>{{hours}}</td>
			<td>{{room}}</td>
			<td>{{persons}}/{{capacity}}명</td>
			<td>{{pname}}({{pcode}})</td>
			<td>{{edate}}</td>
			<td><button class="btn btn-dark btn-sm delete" lcode="{{lcode}}">취소</button></td>
		</tr>
		{{/each}}
	</table>
</script>

<script id="temp_cou" type="x-handlebars-template">
	<select class="form-select" id="lcode">
		{{#each .}}
		<option value="{{lcode}}">{{lname}}:{{pname}}&nbsp;&nbsp;&nbsp;{{persons}}/{{capacity}}</option>
		{{/each}}
	</select>
</script>

<script>
	// 수강신청 버튼 누를 경우
	$("#insert").on("click", function(){
		const lcode = $("#div_cou #lcode").val();
		if(confirm("수강신청하시겠습니까?")){
			$.ajax({
				type:"post",
				url:"/enroll/insert",
				data:{scode, lcode},
				success:function(data){
					if(data == "true"){
						alert("수강신청 완료");
						getData();
						getCou();
					}else {
						alert("이미 수강신청한 강좌입니다.");
						return;
					}
				}
			});
		}
		
	});
	
	// 취소 버튼을 누른 경우
	$("#div_enroll").on("click", ".delete", function(){
		const lcode = $(this).attr("lcode");
		if(confirm(lcode + "번 수강을 취소하시겠습니까?"))
		$.ajax({
			type:"post",
			url:"/enroll/delete",
			data:{scode,lcode},
			success:function(data){
				if(data == "true"){
					alert("수강취소 완료");
					getData();
					getCou();
				}else {
					alert("수강취소 실패");
					return;
				}
			}
		});
	});
	
	let scode = "${stu.scode}";
	getData();
	
	function getData(){
		$.ajax({
			type:"get",
			url:"/enroll/list.json",
			data:{scode},
			dataType:"json",
			success:function(data){
				const temp = Handlebars.compile($("#temp_enroll").html());
				$("#div_enroll").html(temp(data));
			}
		});
	}
	
	getCou();
	function getCou(){
		$.ajax({
			type:"get",
			url:"/cou/list.json",
			data:{page:1, size:100, key:'lcode', word:''},
			dataType:"json",
			success:function(data){
				const temp = Handlebars.compile($("#temp_cou").html());
				$("#div_cou").html(temp(data));
			}
		});
	}
</script>