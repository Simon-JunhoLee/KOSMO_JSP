<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- Modal -->
<div class="modal fade" id="modalReview" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">리뷰 작성</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      	<input id="rid" type="hidden"/>
        <textarea rows="10" cols="" class="form-control" id="content" placeholder="내용을 입력하세요."></textarea>
      </div>
	  <div class="text-center mb-3">
	    <button type="button" class="btn btn-dark btn-sm px-5" id="btn-insert">등록</button>
	    <button type="button" class="btn btn-dark btn-sm px-5" id="btn-update">수정</button>
	    <button type="button" class="btn btn-secondary btn-sm px-5" data-bs-dismiss="modal">Close</button>
	  </div>
    </div>
  </div>
</div>

<script>
	$("#btn-insert").on("click", function(){
		const content = $("#content").val();
		if(content == ""){
			swal("리뷰내용을 작성하세요!", "", "warning")
			.then((value) => {
				$("#content").focus();
			});
		}else{
			// swal("", gid + "\n" + uid + "\n" + content, "success");
			$.ajax({
				type:"post",
				url:"/review/insert",
				data:{uid, gid, content},
				success:function(){
					swal("리뷰 등록 완료!", "", "success")
					.then((value) => {
						$("#content").val("");
						$("#modalReview").modal("hide");
						getTotal();
					});
				}
			});
		}
	});
	
	$("#btn-update").on("click", function(){
		const content = $("#content").val();
		const rid = $("#rid").val();
		if(content == ""){
			swal("리뷰내용을 작성하세요!", "", "warning")
			.then((value) => {
				$("#content").focus();
			});
		}else{
			swal({
		      	  title: "리뷰 수정",
		      	  text: rid + "번의 리뷰를 수정하시겠습니까?",
		      	  icon: "warning",
		      	  buttons: true,
		      	})
		      	.then((willUpdate) => {
		      	  if (willUpdate) {
		      		// 수정하기
		      		$.ajax({
		      			type:"post",
		      			url:"/review/update",
		      			data:{rid, content},
		      			success:function(data){
	      					$("#modalReview").modal("hide");
		      				swal("리뷰 수정 완료!", "", "success")
		      				.then((value) => {
		      					getTotal();
		      				});
		      			}
		      		});
		      	  } else {
		      	      return;
		      	    }
	      	  });
		}
	})
</script>