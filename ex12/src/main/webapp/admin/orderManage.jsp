<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div>
	<h1>주문 관리</h1>
	<div id="div_order_manage"></div>
	<jsp:include page="/user/modal_orders.jsp"/>
</div>

<script id="temp_order_manage" type="x-handlebars-template">
	<table class="table table-hover">
		<colgroup>
			<col width="10%"/>
			<col width="10%"/>
			<col width="13%"/>
			<col width="20%"/>
			<col width="11%"/>
			<col width="10%"/>
			<col width="13%"/>
			<col width="10%"/>			
		</colgroup>
		<tr class="table-dark text-center">
			<td>주문번호</td>
			<td>주문자</td>
			<td>전화번호</td>
			<td>배송지</td>
			<td>주문일자</td>
			<td>주문금액</td>
			<td>상태</td>
			<td></td>
		</tr>
		{{#each .}}
		<tr class="goods-row goods" gid="{{gid}}">
			<td class="text-center">{{pid}}</td>
			<td class="text-center">{{uname}}({{uid}})</td>
			<td class="text-center">{{phone}}</td>
			<td class="text-center">{{address1}} {{address2}}</td>
			<td class="text-center">{{pdate}}</td>
			<td class="text-center">{{formatPrice sum}}</td>
			<td class="text-center">
				<div class="input-group">
					<select class="form-select status">
						<option value="0" {{selected status 0}}>결제대기</option>
						<option value="1" {{selected status 1}}>결제확인</option>
						<option value="2" {{selected status 2}}>배송준비</option>
						<option value="3" {{selected status 3}}>배송완료</option>
						<option value="4" {{selected status 4}}>주문완료</option>
					</select>
					<button class="btn btn-dark update" pid="{{pid}}">변경</button>
				</div>
			</td>
			<td class="text-center">
				<button type="button" class="btn btn-dark btn-sm px-3 orders" pid="{{pid}}" address1="{{address1}}" address2="{{address2}}">주문 상품</button>
			</td>
		</tr>
		{{/each}}
	</table>
</script>

<script>
	let key="uid";
	let word="";
	let page=1;
	let size=5;
	
	getData();
	function getData(){
		$.ajax({
			type:"get",
			url:"/admin/order/list.json",
			data:{key, word, page, size},
			dataType:"json",
			success:function(data){
				const temp = Handlebars.compile($("#temp_order_manage").html());
				$("#div_order_manage").html(temp(data));
			}
		});
	}
	
	// 상태변경 버튼을 클릭한 경우
	$("#div_order_manage").on("click", ".update", function(){
		const pid = $(this).attr("pid");
		const status = $(this).parent().find(".status").val();
		swal({
			  title: "주문 상태를 변경하시겠습니까?",
			  text: "",
			  icon: "info",
			  buttons: true,
			  dangerMode: false,
			})
			.then((willPurchase) => {
			  if (willPurchase) {
				  $.ajax({
					  type:"post",
					  url:"/admin/order/update",
					  data:{pid, status},
					  success:function(){
						  swal({
							  title: "상태 변경 완료!",
							  icon: "success",
							  button: "확인",
							});
					  }
					});
				}else{
				  swal({
					  title: "변경 취소!",
					  icon: "error",
					  button: "확인",
					});
				  return;
			  }
		});
	});

	Handlebars.registerHelper('selected', function(status, value) {
	    if(status == value) return "selected";
	});
	
	Handlebars.registerHelper('formatPrice', function(price) {
	    // 가격을 1000 단위로 ,를 넣어서 형식화
	    return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
	});
	
	Handlebars.registerHelper('status', function(status){
		switch(status){
		case 0:
			return "결제대기";
		case 1:
			return "결제확인";
		case 2:
			return "배송준비";
		case 3:
			return "배송완료";
		case 4:
			return "주문완료";
		}
	});
	
	let pid= "";
	$("#div_order_manage").on("click", ".orders", function(){
		pid=$(this).attr("pid");
		const address1 = $(this).attr("address1");
		const address2 = $(this).attr("address2");
		$("#modalOrders").modal("show");
		$("#pid").html("주문번호:" + pid);
		$("#address").html("배송지 : " + address1 + " " + address2);
		getOrders(pid);
	});
</script>