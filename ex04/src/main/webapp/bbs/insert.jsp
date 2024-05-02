<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="row justify-content-center">
	<div class="col-10">
		<h1>글쓰기</h1>
		<form class="px-5" name="frm" method="post" action="/bbs/insert">
		    <input type="hidden" name="writer" value="${user.uid}">
		    <input type="text"  class="form-control mb-2" name="title" placeholder="제목을 입력하세요.">
		    <textarea rows="10" class="form-control" name="contents" placeholder="내용을 입력하세요." style="white-space: pre;"></textarea>
		    <div class="text-center mt-3 mb-4">
		        <button class="btn btn-dark px-5" type="submit">등록</button>
		        <button class="btn btn-secondary px-5" type="reset">취소</button>
		    </div>
		</form>
	</div>
</div>
<script>
	$(frm.uid).val(uid);
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
	    	if(!confirm("등록하시겠습니까?"))	return;
	        frm.submit();
	    }
	});
</script>