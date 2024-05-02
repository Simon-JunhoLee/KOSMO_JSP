<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="row justify-content-center">
	<div class="col-10">
		<h1>글쓰기</h1>
		<form class="px-5" name="frm" method="post" action="/bbs/update">
		    <input type="hidden" name="writer" value="${user.uid}">
		    <input type="hidden" name="bid" value="${bbs.bid}">
		    <input type="text"  class="form-control mb-2" name="title" value="${bbs.title}" placeholder="제목을 입력하세요.">
		    <textarea rows="10" class="form-control" name="contents" placeholder="내용을 입력하세요." style="white-space: pre-line;">${bbs.contents}</textarea>
		    <div class="text-center mt-3 mb-4">
		        <button class="btn btn-dark px-5" type="submit">수정</button>
		        <button class="btn btn-secondary px-5" type="reset">취소</button>
		    </div>
		</form>
	</div>
</div>
<script>
	$(frm).on("submit", function(e){
	    e.preventDefault();
	    const title = $(frm.title).val();
	    const contents = $(frm.contents).val();
	    if(title == ""){
	        alert('제목을 입력하세요.');
	        $(frm.title).focus();
	    }else if(contents == ""){
	        alert('내용을 입력하세요.');
	        $(frm.contents).focus();
	    }else {
	    	if(!confirm("수정하시겠습니까?"))	return;
	        frm.submit();
	    }
	});
</script>