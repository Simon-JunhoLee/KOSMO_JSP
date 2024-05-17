<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	.page-link {
	  color: #000; 
	  background-color: #fff;
	  border: 1px solid #fff;
	  border-radius : 15%; 
	}
	
	.page-item.active .page-link {
	 z-index: 1;
	 color: #4A6BD6;
	 font-weight:bold;
	 background-color: #f1f1f1;
	 border-color: #ccc;
	 
	}
	
	.page-link:focus, .page-link:hover {
	  color: #000;
	  background-color: #fafafa; 
	  border-color: #ccc;
	}
</style>
<div class="my-3">
	<div class="text-end">
		<button class="btn btn-sm btn-outline-dark px-5 mb-3" id="insertReview">리뷰 쓰기</button>
	</div>
	<div id="div_review"></div>
</div>
<jsp:include page="modal_review.jsp"/>
<div id="pagination" class="pagination justify-content-center mt-5"></div>

<script id="temp_review" type="x-handlebars-template">
	{{#each .}}
		<div class="review-item">
			<div class="row px-3 mb-1">
				<div class="col">
					<span><b>{{uid}}</b></span> | 
					<span style="color:gray; font-size:13px;">{{revDate}}</span>
				</div>
				<div class="col text-end" style="{{display uid}}" rid="{{rid}}">
					<button class="btn btn-outline-dark btn-sm update" content="{{content}}">수정</button>
					<button class="btn btn-outline-secondary btn-sm delete">삭제</button>
				</div>
			</div>
			<div class="ellipsis px-3 content mt-2" style="font-size:15px;">
				{{breaklines content}}
			</div> <hr>
		</div>
	{{/each}}
</script>

<script>
	$("#insertReview").on("click", function(){
		if(uid){
			$("#modalReview #content").val("");
			$("#btn-insert").show();
			$("#btn-update").hide();
			$("#modalReview").modal("show");
		}
		else{
			// 세션에 페이지 저장 => 로그인 후 해당 페이지로 이동
			const target = window.location.href
			// sessionStorage.setItem("target", "/goods/read?gid=" + gid);
			sessionStorage.setItem("target", target);
			swal("로그인이 필요한 페이지입니다.", "", "warning")
			.then((value) => {
				location.href="/user/login";
			});
		}
	});
	
	let page = 1;
	let size = 5;
	let gid1 = "${param.gid}";
	
	// getData();
	function getData(){
		$.ajax({
			type:"get",
			url:"/review/list.json",
			data:{page, size, gid:gid1},
			dataType:"json",
			success:function(data){
				const temp = Handlebars.compile($("#temp_review").html());
				$("#div_review").html(temp(data));
			}
		});
	}
	
	getTotal();
	function getTotal(){
		$.ajax({
			type:"get",
			url:"/review/total",
			data:{gid: gid1},
			success:function(data){
				const total = parseInt(data);
				let totalPage = Math.ceil(total/size);
				if(total == 0){
					getData();
					$("#pagination").hide();
					return;
				}
				$("#pagination").twbsPagination("changeTotalPages", totalPage, page);
				if(total > size){
					$("#pagination").show();
				}else{
					$("#pagination").hide();
				}
			}
		});
	}
	
	// 리뷰 클릭 시 toggle 기능
	$("#div_review").on("click", ".content", function(){
		const content = $(this);
		const isEllipsis = content.hasClass("ellipsis");

		// 모든 리뷰를 접기
		$("#div_review .content").addClass("ellipsis");

		// 클릭한 리뷰의 상태에 따라 toggle
		if (isEllipsis) {
			content.removeClass("ellipsis");
		}
	});
	
	// 삭제버튼을 클릭한 경우
	$("#div_review").on("click", ".delete", function(){
		const rid = $(this).parent().attr("rid");
		swal({
	      	  title: "리뷰 삭제",
	      	  text: rid + "번의 리뷰를 삭제하시겠습니까?",
	      	  icon: "warning",
	      	  buttons: true,
	      	  dangerMode: true,
	      	})
	      	.then((willDelete) => {
	      	  if (willDelete) {
	      		// 삭제하기
	      		$.ajax({
	      			type:"post",
	      			url:"/review/delete",
	      			data:{rid},
	      			success:function(data){
	      				swal("리뷰 삭제 완료!", "", "success")
	      				.then((value) => {
	      					getTotal();
	      				});
	      			}
	      		});
	      	  } else {
	      	      return;
	      	    }
	      	  });
	});
	
	// 수정버튼을 클릭한 경우
	$("#div_review").on("click", ".update", function(){
		const rid = $(this).parent().attr("rid");
		const content = $(this).attr("content");
		$("#modalReview").modal("show");
		$("#modalReview #content").val(content);
		$("#btn-insert").hide();
		$("#btn-update").show();
		$("#rid").val(rid);
	});
	
		
	Handlebars.registerHelper('breaklines', function(text) {
	  text = Handlebars.Utils.escapeExpression(text);
	  text = text.replace(/(\r\n|\n|\r)/gm, '<br>');
	  return new Handlebars.SafeString(text);
	});
	
	Handlebars.registerHelper('display', function(writer){
		if(uid != writer) return "display:none";
	});
	
	$('#pagination').twbsPagination({
		totalPages:10, 
		visiblePages: 5, 
		startPage : 1,
		initiateStartPageClick: false, 
		first:'<i class="bi bi-chevron-double-left"></i>', 
		prev :'<i class="bi bi-chevron-left"></i>',
		next :'<i class="bi bi-chevron-right"></i>',
		last :'<i class="bi bi-chevron-double-right"></i>',
		onPageClick: function (event, clickPage) {
			 page=clickPage; 
			 getData();
		}
	});
</script>