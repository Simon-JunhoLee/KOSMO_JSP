<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
.bi-chat-heart{
	color : hotpink;
}
.bi-chat-heart-fill{
	color : hotpink;
}
</style>
<div>
	<div class="row my-5">
		<div class="col-md-6">
			<img src="${goods.image}" width="90%">
		</div>
		<div class="col">
			<h3>${goods.title}</h3><hr>
			<div class="mb-3"><h5>가격 : <fmt:formatNumber value="${goods.price}" pattern=""/></h5></div>
			<div class="mb-3"><h5>브랜드 : ${goods.brand}</h5></div>
			<div class="mb-3"><h5>등록일 : ${goods.regDate}</h5></div>
			<div class="mb-3"><h5>배송정보 : CJ택배</h5></div>
			<div class="mb-3"><h5>카드할인 : 카드사별 무이자할부 / 최대 5개월</h5></div>
			<div class="my-3 text-center">
				<button class="btn btn-dark px-5" id="buy">바로구매</button>
				<button class="btn btn-secondary px-5" id="cart">장바구니</button>
				<button class="btn btn-lg">
					<span class="bi {{heart ucnt}}" id="heart" gid="${goods.gid}">
						<span id="fcnt" style="font-size:20px;"></span>
					</span>
				</button>
			</div>			
		</div>
	</div>
</div>

<script>
	const gid="${goods.gid}";
	const ucnt = "${goods.ucnt}";
	const fcnt = "${goods.fcnt}";
	
	
	$("#cart").on("click", function(){
		if(uid){
			// 장바구니 넣기
			$.ajax({
				type:"post",
				url:"/cart/insert",
				data:{uid, gid},
				success:function(data){
					if(data == "true"){
						swal("장바구니에 담았습니다.", "", "success")
						.then((value) => {
							swal({
						      	  title: "장바구니 이동",
						      	  text: "장바구니 페이지로 이동하시겠습니까?",
						      	  icon: "info",
						      	  buttons: true,
						      	  successMode: true,
						      	})
						      	.then((willMove) => {
						      	  if (willMove) {
						      		// 삭제하기
						      	    location.href="/cart/list";
						      	  } else {
						      	    return;
						      	  }
						      	});
						});
					}else{
						swal("장바구니에 존재하는 상품입니다.", "", "info")
						.then((value) => {
							swal({
						      	  title: "장바구니 이동",
						      	  text: "장바구니 페이지로 이동하시겠습니까?",
						      	  icon: "info",
						      	  buttons: true,
						      	  successMode: true,
						      	})
						      	.then((willMove) => {
						      	  if (willMove) {
						      		// 삭제하기
						      	    location.href="/cart/list";
						      	  } else {
						      	    return;
						      	  }
						      	});
						});
					}
				}
			});
		}else{
			// 세션에 페이지 저장 => 로그인 후 해당 페이지로 이동
			sessionStorage.setItem("target", "/goods/read?gid=" + gid);
			
			swal("로그인이 필요한 페이지입니다.", "", "warning")
			.then((value) => {
				location.href="/user/login";				
			});
		}
	});
	
	$("#buy").on("click", function(){
		if(uid){
			// 구매하기
			
		}else{
			// 세션에 페이지 저장 => 로그인 후 해당 페이지로 이동
			sessionStorage.setItem("target", "/goods/read?gid=" + gid);
			
			swal("로그인이 필요한 페이지입니다.", "", "warning")
			.then((value) => {
				location.href="/user/login";				
			});
		}
	});
	
	Handlebars.registerHelper('heart', function(value) {
		if(value == 0) return "bi-chat-heart";
		else return "bi-chat-heart-fill";
	});
	
	$("#fcnt").html(fcnt);
	if(ucnt == 0){
		$("#heart").removeClass("bi-chat-heart-fill");
		$("#heart").addClass("bi-chat-heart");
	}else{
		$("#heart").removeClass("bi-chat-heart");
		$("#heart").addClass("bi-chat-heart-fill");
	}
	
	$(".bi-chat-heart").on("click", function(e){
		e.preventDefault();
		const gid=$(this).attr("gid");
		if(uid){
			$.ajax({
				type:"post",
				url:"/favorite/insert",
				data:{uid, gid},
				success:function(){
					location.reload(true);
				}
			});
			
		}else{
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
	
	$(".bi-chat-heart-fill").on("click", function(e){
		e.preventDefault();
		const gid=$(this).attr("gid");
		$.ajax({
			type:"post",
			url:"/favorite/delete",
			data:{uid, gid},
			success:function(){
				location.reload(true);
			}
		});
	});
</script>