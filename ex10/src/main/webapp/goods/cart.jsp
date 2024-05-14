<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div>
	<h1>장바구니</h1>
	<div id="div_cart"></div>
</div>

<script id="temp_cart" type="x-handlebars-template">
	<table class="table table-hover">
		<colgroup>
			<col width="20%"/>
			<col width="10%"/>
			<col width="30%"/>
			<col width="20%"/>
			<col width="10%"/>
			<col width="10%"/>
		</colgroup>
		<tr class="table-dark text-center">
			<td>상품 번호</td>
			<td colspan=2>상품명</td>
			<td>상품가격</td>
			<td>수량</td>
			<td></td>
		</tr>
		{{#each .}}
		<tr class="goods-row" data-gid="{{gid}}">
			<td class="text-center">{{gid}}</td>
			<td><img src="{{image}}" width="50px"></td>
			<td><div class="ellipsis">{{{title}}}</div></td>
			<td class="text-center">{{formatPrice price}}</td>
			<td class="text-center"><input class="text-center px-2" value="{{qnt}}" size=2></td>
			<td class="text-center"><button class="btn btn-dark btn-sm px-3 buy">구매</button></td>
		</tr>
		{{/each}}
	</table>
</script>

<script>
	getData();
	function getData(){
		$.ajax({
			type:"get",
			url:"/cart/list.json",
			data:{uid},
			dataType:"json",
			success:function(data){
				const temp = Handlebars.compile($("#temp_cart").html());
				$("#div_cart").html(temp(data));
			}
		});
	}
	
	Handlebars.registerHelper('formatPrice', function(price) {
	    // 가격을 1000 단위로 ,를 넣어서 형식화
	    return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	});
	
	// 각 행을 누르면 readPage 이동
	$(document).ready(function(){
	    // 각 행에 클릭 이벤트 추가
		$(document).on("click", ".goods-row", function() {
            const gid = $(this).data("gid");
            window.location.href = "/goods/read?gid=" + gid; // 페이지 이동
	    });
	});
</script>