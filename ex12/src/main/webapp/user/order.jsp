<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div>
	<h1>주문 목록</h1>
	<div id="div_purchase"></div>
	<jsp:include page="modal_orders.jsp"/>
</div>

<script id="temp_purchase" type="x-handlebars-template">
	<table class="table table-hover">
		<colgroup>
			<col width="15%"/>
			<col width="12%"/>
			<col width="23%"/>
			<col width="23%"/>
			<col width="10%"/>
			<col width="7%"/>
			<col width="10%"/>			
		</colgroup>
		<tr class="table-dark text-center">
			<td>주문번호</td>
			<td>전화번호</td>
			<td>배송지</td>
			<td>주문일자</td>
			<td>주문금액</td>
			<td>상태</td>
			<td></td>
		</tr>
		{{#each .}}
		<tr class="goods-row goods" gid="{{gid}}" price="{{price}}" qnt="{{qnt}}">
			<td class="text-center">{{pid}}</td>
			<td class="text-center">{{phone}}</td>
			<td class="text-center">{{address1}} {{address2}}</td>
			<td class="text-center">{{pdate}}</td>
			<td class="text-center">{{formatPrice sum}}</td>
			<td class="text-center">{{status status}}</td>
			<td class="text-center">
				<button type="button" class="btn btn-dark btn-sm px-3 orders" pid="{{pid}}" address1="{{address1}}" address2="{{address2}}">주문 상품</button>
			</td>
		</tr>
		{{/each}}
	</table>
</script>

<script>
	getData();
	function getData(){
		$.ajax({
			type:"get",
			url:"/purchase/list.json",
			data:{uid},
			dataType:"json",
			success:function(data){
				const temp = Handlebars.compile($("#temp_purchase").html());
				$("#div_purchase").html(temp(data));
			}
		});
	}
	
	let pid= "";
	$("#div_purchase").on("click", ".orders", function(){
		pid=$(this).attr("pid");
		const address1 = $(this).attr("address1");
		const address2 = $(this).attr("address2");
		$("#modalOrders").modal("show");
		$("#pid").html("주문번호:" + pid);
		$("#address").html("배송지 : " + address1 + " " + address2);
		getOrders(pid);
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
</script>