<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>
	table .title {
		color: white;
		text-align: center;
	}
</style>
<div class="row">
	<div class="col">
		<div><h1>강좌정보</h1></div>
		<div class="text-end mb-2">
			<button class="btn btn-dark" id="update">강좌수정</button>
			<button class="btn btn-secondary" id="delete">강좌삭제</button>
		</div>
		<table class="table table-bordered">
			<tr>
				<td class="title table-dark">강좌번호</td>
				<td>${cou.lcode}</td>
				<td class="title table-dark">강좌이름</td>
				<td>${cou.lname}</td>
				<td class="title table-dark">담당교수</td>
				<td>${cou.pname}(${cou.instructor})</td>
			</tr>
			<tr>
				<td class="title table-dark">강의실</td>
				<td>${cou.room}</td>
				<td class="title table-dark">강의시수</td>
				<td>${cou.hours}</td>
				<td class="title table-dark">신청인원</td>
				<td>${cou.persons}/${cou.capacity}</td>
			</tr>
		</table>
	</div>
</div>
<jsp:include page="info.jsp"/>
<script>
	//수정버튼을 클릭한경우
	$("#update").on("click", function(){
		const lcode="${cou.lcode}";
		location.href="/cou/update?lcode=" + lcode;
	});
	
	//삭제버튼을 클릭한경우
	$("#delete").on("click", function(){
		const lcode="${cou.lcode}";
		if(confirm(lcode + "번 강좌를 삭제하시겠습니까?")){
			//학생삭제
			$.ajax({
				type:"post",
				url:"/cou/delete",
				data:{lcode},
				success:function(data){
					if(data=="true"){
						alert("삭제완료!");
						location.href="/cou/list";
					}else{
						alert("학생이 신청한 수강데이터가 존재합니다!");
					}
				}
			});
		}
	});
</script>