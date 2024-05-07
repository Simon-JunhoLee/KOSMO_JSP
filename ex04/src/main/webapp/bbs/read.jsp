<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div>
	<h1>게시글 정보</h1>
	<div class="card">
		<div class="card-body">
			<div>${bbs.title}</div>
			<hr>
			<div>${bbs.contents}</div>
		</div>
		<div class="card-footer text-muted">
			<span>${bbs.bdate}</span> &nbsp;
			<span>${bbs.uname} (${bbs.writer})</span>
		</div>
	</div>
	<div class="text-center mt-3 mb-4" id="div_update">
        <a href="/bbs/update?bid=${bbs.bid}" class="btn btn-dark px-5 update">수정</a>
        <button class="btn btn-secondary px-5 delete">삭제</button>
    </div>
</div>

<jsp:include page="comments.jsp"/>

<script>
	const writer = "${bbs.writer}";
	if(uid == writer){
		$("#div_update").show();
	}else{
		$("#div_update").hide();
	}
	
	$("#div_update").on("click", ".delete", function(){
		const bid = "${bbs.bid}";
		if(confirm(bid + "번 게시글을 삭제하시겠습니까?")){
			// 게시글 삭제
			$.ajax({
				type: "post",
				url: "/bbs/delete",
				data: {bid},
				success: function(data){
					location.href="/bbs/list";
				}
			});
		}
	});
</script>