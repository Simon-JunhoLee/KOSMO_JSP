<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	.brand{
		font-size:12px;
	}
	#div_shop img{
		border-radius:10%;
		box-shadow:0px 5px 5px 0px gray;
		cursor: pointer;
		height: auto;
		aspect-ratio:1/1;
	}
	.btn{
		border : solid 1px gray;
	}
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
	.bi-chat-heart{
		color : hotpink;
	}
	.bi-chat-heart-fill{
		color : hotpink;
	}
</style>

<div class="row my-5">
	<div class="col-8"></div>
	<form class="col-4 mb-4 d-flex justify-content-end" name="frm">
		<div class="input-group">
			<input placeholder="검색어" class="form-control" name="word" value="">
			<button class="btn btn-dark">검색</button>
		</div>
	</form>
	<div class="row" id="div_shop"></div>
	<ul id="pagination" class="pagination pagination-sm justify-content-center mt-3"></ul>
</div>

<script id="temp_shop" type="x-handlebars-template">
	{{#each .}}
		<div class="col-6 col-md-4 col-lg-2 mb-5">
			<div class="mb-2"><a href="/goods/read?gid={{gid}}"><img src="{{image}}" width="90%"></a></div>
			{{#if brand}}
				<div class="brand px-1">{{brand}}</div>
			{{else}}
				<div class="brand px-1">KOSMO</div>
			{{/if}}
			<div class="ellipsis px-1 me-3">{{{title}}}</div>
			<div class="d-flex justify-content-between align-items-center px-1 me-3">
				<span>{{formatPrice price}}원</span>
				<span class="bi bi-chat-dots">
					<span>{{rcnt}}</span>
				</span>
				<span class="bi {{heart ucnt}}" gid={{gid}}>
					<span style="font-size:15px;">{{fcnt}}</span>
				</span>
			</div>
		</div>
	{{/each}}
</script>

<script>
	let size = 12;
	let page = 1;
	let word = "";
	// getData();
	function getData(){
		$.ajax({
			type:"get",
			url:"/goods/list.json",
			data:{page, size, word, uid},
			dataType:"json",
			success:function(data){
				const temp = Handlebars.compile($("#temp_shop").html());
				$("#div_shop").html(temp(data));
			}
		});
	}
	
	$(frm).on("submit", function(e){
		e.preventDefault();
		word=$(frm.word).val();
		page = 1;
		// getData();
		getTotal();
	});
	
	getTotal();
	function getTotal(){
		$.ajax({
			type:"get",
			url:"/goods/total",
			data:{word},
			success:function(data){
				const total = parseInt(data);
				if(total == 0){
					swal({
						  title: "검색한 상품이 없습니다!",
						  icon: "error",
						  button: "확인",
					});
					return;
				}
				const totalPage = Math.ceil(total/size);
				$("#pagination").twbsPagination("changeTotalPages", totalPage, page);
				if(total > size){
					$("#pagination").show();
				}else{
					$("#pagination").hide();
				}
				$("#total").html("검색 수 : " + total);
			}
		});
	}
	
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
	
	Handlebars.registerHelper('formatPrice', function(price) {
        // 가격을 1000 단위로 ,를 넣어서 형식화
        return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    });
	Handlebars.registerHelper('heart', function(value) {
		if(value == 0) return "bi-chat-heart";
		else return "bi-chat-heart-fill";
	});
	
	// 좋아요 추가
	$("#div_shop").on("click", ".bi-chat-heart", function(){
		const gid=$(this).attr("gid");
		if(!uid){
			swal("로그인이 필요한 페이지입니다.", "", "warning")
			.then((value) => {
				location.href="/user/login";				
			});
		}else{			
			// alert(uid + ":" + gid);
			$.ajax({
				type:"post",
				url:"/favorite/insert",
				data:{uid, gid},
				success:function(){
					getData();
				}
			});
		}
	});
	
	// 좋아요 취소
	$("#div_shop").on("click", ".bi-chat-heart-fill", function(){
		const gid=$(this).attr("gid");		
			// alert(uid + ":" + gid);
			$.ajax({
				type:"post",
				url:"/favorite/delete",
				data:{uid, gid},
				success:function(){
					getData();
				}
			});
	});
	
</script>