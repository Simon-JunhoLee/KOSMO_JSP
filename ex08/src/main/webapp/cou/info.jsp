<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div>
	<h1>수강신청한 학생 목록</h1>
	<div id="div_stu"></div>
</div>

<script id="temp_stu" type="x-handlebars-template">
	<table class="table table-hover">
		<colgroup>
            <col width="1/6"/>
            <col width="1/6"/>
            <col width="1/6"/>
            <col width="1/6"/>
            <col width="1/6"/>
            <col width="1/6"/>
        </colgroup>
		<tr class="table-dark text-center">
			<td>학생번호</td>
			<td>학생이름</td>
			<td>학생학과</td>
			<td>학생학년</td>
			<td>수강신청일</td>
			<td>점수</td>
		</tr>
		{{#each .}}
		<tr class="text-center stu-row" data-scode="{{scode}}">
			<td>{{scode}}</td>
			<td>{{sname}}</td>
			<td>{{sdept}}</td>
			<td>{{year}}학년</td>
			<td>{{edate}}</td>
			<td><input class="form-control" value="{{grade}}"></td>
		</tr>
		{{/each}}
	</table>
</script>

<script>
let lcode = "${cou.lcode}";
getData();

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