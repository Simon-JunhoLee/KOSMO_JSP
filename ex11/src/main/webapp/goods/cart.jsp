<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	input[type="checkbox"] {
	    width: 20px;
	    height: 20px;
	}
	input[type="checkbox"]:checked {
        background-color: black; /* Change to desired color */
        border : none;
    }
</style>
<div>
	<h1>장바구니</h1>
	<div id="div_cart"></div>
	<div class="alert alert-dark text-end" id="div_total"></div>
</div>

<script id="temp_cart" type="x-handlebars-template">
	<button class="btn btn-dark px-3 mb-2" id="delete">선택 삭제</button>
	<table class="table table-hover">
		<colgroup>
			<col width="5%"/>
			<col width="10%"/>
			<col width="11%"/>
			<col width="29%"/>
			<col width="10%"/>
			<col width="15%"/>
			<col width="10%"/>
			<col width="10%"/>
		</colgroup>
		<tr class="table-dark text-center">
			<td><input class="form-check-input" id="all" type="checkbox"></td>
			<td>상품 번호</td>
			<td colspan=2>상품명</td>
			<td>상품가격</td>
			<td>수량</td>
			<td>총합</td>
			<td></td>
		</tr>
		{{#each .}}
		<tr class="goods-row" gid="{{gid}}">
			<td class="text-center"><input class="form-check-input chk" type="checkbox"></td>
			<td class="text-center">{{gid}}</td>
			<td class="text-end"><img src="{{image}}" width="50px"></td>
			<td class="title"><div class="ellipsis">{{{title}}}</div></td>
			<td class="text-center">{{formatPrice price}}</td>
			<td class="text-center">
				<input class="text-center px-2 qnt" value="{{qnt}}" size=2>
				<button class ="btn btn-dark btn-sm px-3 update">수정</button>
			</td>
			<td class="text-center">{{sum price qnt}}</td>
			<td class="text-center"><button class="btn btn-dark btn-sm px-3 delete">삭제</button></td>
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
				let total = 0;
				$(data).each(function(){
					const price = this.price;
					const qnt = this.qnt;
					const sum = price * qnt;
					total += sum;
				});
				$("#div_total").html("합계 : " + total.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원");
			}
		});
	}
	
	Handlebars.registerHelper('formatPrice', function(price) {
	    // 가격을 1000 단위로 ,를 넣어서 형식화
	    return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	});
	
	Handlebars.registerHelper("sum", function(price, qnt){
		const sum = price * qnt;
		return sum.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
	});
	
	// 각 행을 누르면 readPage 이동
	$("#div_cart").on("click", ".title", function(){
		const gid = $(this).parent().attr("gid");
		location.href = "/goods/read?gid=" + gid;
	});
	
	// 각행의 수정버튼을 클릭한 경우
	$("#div_cart").on("click", ".update", function(){
		const qnt = $(this).parent().find(".qnt").val();
		const gid = $(this).parent().parent().attr("gid");
		// alert(uid + ":" + qnt);
		$.ajax({
			type:"post",
			url:"/cart/update",
			data:{gid, uid, qnt},
			success:function(data){
				getData();
			}
		});
	});
	
	// 각행의 삭제버튼을 클릭한 경우
	$("#div_cart").on("click", ".delete", function(){
		const gid = $(this).parent().parent().attr("gid");
		swal({
      	  title: "장바구니 삭제",
      	  text: gid + "번 상품을 삭제하시겠습니까?",
      	  icon: "warning",
      	  buttons: true,
      	  dangerMode: true,
      	})
      	.then((willDelete) => {
      	  if (willDelete) {
      		// 삭제하기
      	    $.ajax({
      	    	type:"post",
      	    	url:"/cart/delete",
      	    	data:{gid, uid},
      	    	success:function(data){
      	    		getData();
      	    	}
      	    });
      	  } else {
      	    return;
      	  }
      	});
	});
	
	// 전체선택 체크박스를 클릭한 경우
	$("#div_cart").on("click", "#all", function(){
		if($(this).is(":checked")){
			$("#div_cart .chk").each(function(){
				$(this).prop("checked", true);
			});
		}else{
			$("#div_cart .chk").each(function(){
				$(this).prop("checked", false);
			});
		}
	});
	
	$("#div_cart").on("click", ".chk", function(){
		let all = $("#div_cart .chk").length;
		let chk = $("#div_cart .chk:checked").length;
		if(all == chk){
			$("#div_cart #all").prop("checked", true);
		}else{
			$("#div_cart #all").prop("checked", false);
		}
	});
	
	// 선택삭제 버튼을 클릭한 경우
	$("#div_cart").on("click", "#delete", function(){
		let chk = $("#div_cart .chk:checked").length;
		if(chk == 0){
			alert("삭제할 상품을 선택하세요.");
			return;
		}
		let cnt = 0;
		swal({
	      	  title: "장바구니 삭제",
	      	  text: chk + "개의 상품을 삭제하시겠습니까?",
	      	  icon: "warning",
	      	  buttons: true,
	      	  dangerMode: true,
	      	})
	      	.then((willDelete) => {
	      	  if (willDelete) {
	      		$("#div_cart .chk:checked").each(function(){	      			
		      		const gid = $(this).parent().parent().attr("gid");
		      		// 삭제하기
		      	    $.ajax({
		      	    	type:"post",
		      	    	url:"/cart/delete",
		      	    	data:{gid, uid},
		      	    	success:function(data){
		      	    		cnt++;
		      	    		if(chk == cnt){
		      	    			swal(cnt + "개의 상품이 삭제 완료되었습니다.", "", "success");	      	    			
			      	    		getData();
		      	    		}
		      	    	}
		      	    });
	      		});
	      	  } else {
	      	    return;
	      	  }
	      	});
	});
</script>