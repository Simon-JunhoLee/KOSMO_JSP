<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div>
	<h1>주문하기</h1>
	<div id="div_order"></div>
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
		<tr class="goods-row" gid="{{gid}}">
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
	function getOrder(data){
		const temp=Handlebars.compile($("#temp_order").html());
		$("#div_order").html(temp(data));
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