<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
    .table-bordered {
        width: 100%;
        border-collapse: collapse;
    }

    .table-bordered td {
        border: 1px solid #ddd;
        padding: 8px;
        text-align: center;
        width: 16.66%; /* 각 열의 너비를 1/6로 설정하여 동일하게 조절 */
    }

    table .title {
		color:white;
		text-align:center;
    }
</style>
<div class="row">
	<div class="col">
		<div><h1>교수정보</h1></div>
		<div class="text-end mb-2">
			<button class="btn btn-dark" id="update">교수수정</button>
			<button class="btn btn-secondary" id="delete">교수삭제</button>
		</div>
		<table class="table table-bordered mb-5">
			<tr>
				<td class="title table-dark">교수번호</td>
				<td>${pro.pcode}</td>
				<td class="title table-dark">교수이름</td>
				<td>${pro.pname}</td>
				<td class="title table-dark">교수학과</td>
				<td>${pro.dept}</td>
			</tr>
			<tr>
				<td class="title table-dark">임용일자</td>
				<td>${pro.hiredate}</td>
				<td class="title table-dark">교수직급</td>
				<td>${pro.title}</td>
				<td class="title table-dark">교수급여</td>
				<td>${pro.salary}</td>
			</tr>
		</table>
	</div>
</div>
<jsp:include page="info.jsp"/>
<script>

	//수정버튼을 클릭한경우
	$("#update").on("click", function(){
		const pcode="${pro.pcode}";
		location.href="/pro/update?pcode=" + pcode;
	});

	$("#delete").on("click", function(){
		const pcode = "${pro.pcode}";
		if(confirm(pcode + "번 교수를 삭제하시겠습니까?")){
			// 교수삭제
			$.ajax({
				type:"post",
				url:"/pro/delete",
				data:{pcode},
				success:function(data){
					if(data == 1){						
						alert("삭제 완료되었습니다.");
						location.href="/pro/list";
					} else{
						alert("지도학생 혹은 담당과목이 존재합니다.");
					}
				}
			});
		}
	});
</script>