<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<style>
	.input-group-text.otitle {
		width: 100px;
        text-align: center;
        display: flex;
        align-items: center;
        justify-content: center;
	}
</style>
<div>
	<h1>주문하기</h1>
	<div id="div_order"></div>
	<div id="div_order_total" class="alert alert-dark text-end"></div>
	<div class="row justify-content-center">
		<div class="col-10 col-md-8">
			<div class="card">
				<div class="card-header text-center">
					<h3 class="mt-3">배송지 정보</h3>
				</div>
				<div class="card-body">
					<form name="frm">
						<div class="input-group mb-2">
							<span class="input-group-text otitle">주문자명</span>
							<input class="form-control" name="rname" value="${user.uname}"/>
						</div>
						<div class="input-group mb-2">
							<span class="input-group-text otitle">전화번호</span>
							<input class="form-control" name="rphone" type="tel" value="${user.phone}"/>
						</div>
						<div class="input-group mb-2">
							<span class="input-group-text otitle">주소</span>
							<input class="form-control" name="raddress1" value="${user.address1}"/>
							<button class="btn btn-dark" type="button">검색</button>
						</div>
						<div>
							<input class="form-control" name="raddress2" value="${user.address2}" placeholder="상세주소"/>
						</div>
						<div>
							<input class="form-control" name="sum" type="hidden"/>
						</div>
						<div class="text-center my-3">
							<button class="btn btn-dark px-5">주문하기</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>

<script id="temp_order" type="x-handlebars-template">
	<table class="table table-hover">
		<colgroup>
			<col width="15%"/>
			<col width="10%"/>
			<col width="30%"/>
			<col width="15%"/>
			<col width="15%"/>
			<col width="15%"/>
			
		</colgroup>
		<tr class="table-dark text-center">
			<td>상품 번호</td>
			<td colspan=2>상품명</td>
			<td>상품가격</td>
			<td>수량</td>
			<td>총합</td>
		</tr>
		{{#each .}}
		<tr class="goods-row goods" gid="{{gid}}" price="{{price}}" qnt="{{qnt}}">
			<td class="text-center">{{gid}}</td>
			<td class="text-end"><img src="{{image}}" width="50px"></td>
			<td class="title"><div class="ellipsis">{{{title}}}</div></td>
			<td class="text-center">{{formatPrice price}}원</td>
			<td class="text-center">{{qnt}}개</td>
			<td class="text-center">{{sum price qnt}}</td>
		</tr>
		{{/each}}
	</table>
</script>

<script>
	$(frm).on("submit", function(e){
		e.preventDefault();
		const rname = $(frm.rname).val();
		const rphone = $(frm.rphone).val();
		const raddress1 = $(frm.raddress1).val();
		const raddress2 = $(frm.raddress2).val();
		const sum = $(frm.sum).val();
		// console.log(uid, rname, rphone, raddress1, raddress2, sum);
		const cnt=$("#div_order .goods").length;
		swal({
			  title: cnt + "개의 상품들을 주문하시겠습니까?",
			  text: "",
			  icon: "info",
			  buttons: true,
			  dangerMode: false,
			})
			.then((willPurchase) => {
			  if (willPurchase) {
				  $.ajax({
					 type:"post",
					 url:"/purchase/insert",
					 data:{uid, rname, rphone, raddress1, raddress2, sum},
					 success:function(pid){
						 // 주문상품 등록
						 let order_cnt = 0;
						 $("#div_order .goods").each(function(){
							const gid = $(this).attr("gid");
							const price = $(this).attr("price");
							const qnt = $(this).attr("qnt");
							// console.log(pid, gid, price, qnt);
							$.ajax({
								type:"post",
								url:"/order/insert",
								data:{pid, gid, price, qnt},
								success:function(){
									$.ajax({
										type:"post",
										url:"/cart/delete",
										data:{uid, gid},
										success:function(){											
											order_cnt++;
											if(cnt==order_cnt){
												swal({
													  title: cnt + "개의 주문상품 등록완료!",
													  icon: "success",
													  button: "확인",
													})
													.then((value) => {
														location.href="/";
													});
											}
										}
									});
								}
							});
						 });
					 }
				  });
			  } else {
				  swal({
					  title: "주문 실패!",
					  icon: "error",
					  button: "확인",
					});
				  return;
			  }
			});
	});
	function getOrder(data){
		const temp=Handlebars.compile($("#temp_order").html());
		$("#div_order").html(temp(data));
		let total = 0;
		$(data).each(function(){
			const price = this.price;
			const qnt = this.qnt;
			const sum = price*qnt;
			total += sum;
		});
		$("#div_order_total").html("합계 : " + total.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원");
		$(frm.sum).val(total);
	}

	Handlebars.registerHelper('formatPrice', function(price) {
	    // 가격을 1000 단위로 ,를 넣어서 형식화
	    return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	});
	
	Handlebars.registerHelper("sum", function(price, qnt){
		const sum = price * qnt;
		return sum.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
	});
</script>