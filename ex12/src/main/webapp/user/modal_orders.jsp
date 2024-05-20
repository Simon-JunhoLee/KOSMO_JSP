<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<style>
	#modalOrders{
		top:20%;
	}
</style>

<!-- Modal -->
<div class="modal fade" id="modalOrders" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="pid"></h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <div id="address"></div> <hr>
        <div id="div_orders"></div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

<script id="temp_orders" type="x-handlebars-template">
	<table class="table table-hover">
		<colgroup>
			<col width="20%"/>
			<col width="10%"/>
			<col width="30%"/>
			<col width="15%"/>
			<col width="10%"/>
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
		<tr class="goods-row goods" gid="{{gid}}">
			<td class="text-center">{{gid}}</td>
			<td class="text-end"><img src="{{image}}" width="50px"></td>
			<td class="title"><div class="ellipsis">{{{title}}}</div></td>
			<td class="text-center">{{formatPrice price}}</td>
			<td class="text-center">{{qnt}}개</td>
			<td class="text-center">{{sum price qnt}}</td>
		</tr>
		{{/each}}
	</table>
</script>

<script>
	function getOrders(pid){
		$.ajax({
			type:"get",
			url:"/order/olist.json",
			data:{pid},
			dataType:"json",
			success:function(data){
				const temp = Handlebars.compile($("#temp_orders").html());
				$("#div_orders").html(temp(data));
			}
		});
	}
	
	Handlebars.registerHelper("sum", function(price, qnt){
		const sum = price * qnt;
		return sum.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
	});
</script>