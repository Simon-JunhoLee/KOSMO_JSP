<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	#size { 
		width:100px;
		float: right;
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
	<h1>상품검색</h1>
		<div class="row mt-5 mb-3">
			<form class="col-6" name="frm">
				<div class="input-group">
					<select class="form-select me-3" name="key">
						<option value="productId">상품아이디</option>
						<option value="title" selected>상품명</option>
						<option value="lprice">상품가격</option>
					</select>
					<input placeholder="검색어" class="form-control" name="word" value="">
					<button class="btn btn-dark">검색</button>
				</div>
			</form>
			<div class="col">		
				<span id="total" class="mt-2 ms-3"></span>
			</div>
			<div class="col">
				<select class="form-select" id="size">
					<option value="3">3행</option>
					<option value="5">5행</option>
					<option value="10" selected>10행</option>
					<option value="20">20행</option>
				</select>
			</div>
		</div>
	<div id="div_shop"></div>
	<div id="pagination" class="pagination justify-content-center mt-5"></div>
</div>

<script id="temp_shop" type="x-handlebars-template">
	<button class="btn btn-dark px-3 mb-2" id="insert">선택 담기</button>
	<table class="table table-hover">
		<colgroup>
			<col width="5%"/>
            <col width="20%"/>
            <col width="10%"/>
            <col width="30%"/>
            <col width="20%"/>                        
            <col width="10%"/>                        
        </colgroup>
		<tr class="table-dark text-center">
			<td><input class="form-check-input" id="all" type="checkbox"></td>
			<td>아이디</td>
			<td colspan=2>상품명</td>
			<td>상품가격</td>
			<td></td>
		</tr>
		{{#each items}}
		<tr gid="{{productId}}" img="{{image}}" title="{{title}}" brand="{{brand}}" price="{{lprice}}">
			<td class="text-center"><input class="form-check-input chk" type="checkbox"></td>
			<td class="text-center">{{productId}}</td>
			<td class="text-center"><img src={{image}} width="50"/></td>
			<td><div class="ellipsis">{{{title}}}</div></td>
			<td class="text-center">{{formatPrice lprice}}원</td>
			<td class="text-center"><button class="btn btn-dark insert">담기</button></td>
		</tr>
		{{/each}}
	</table>
</script>

<script>
	let query = $(frm.word).val();
	let page = 1;
	let size=$("#size").val();
	let totalPages = 10;
	
	// 전체선택 체크박스를 클릭한 경우
	$("#div_shop").on("click", "#all", function(){
		if($(this).is(":checked")){
			$("#div_shop .chk").each(function(){
				$(this).prop("checked", true);
			});
		}else{
			$("#div_shop .chk").each(function(){
				$(this).prop("checked", false);
			});
		}
	});
	
	// 각행의 체크박스를 클릭한 경우
	$("#div_shop").on("click", ".chk", function(){
		let all = $("#div_shop .chk").length;
		let chk = $("#div_shop .chk:checked").length;
		if(chk==all){
			$("#div_shop #all").prop("checked", true);
		}else {
			$("#div_shop #all").prop("checked", false);
		}
	});
	
	$(frm).on("submit", function(e){
		e.preventDefault();
		query = $(frm.word).val();
		page = 1;
		size = $("#size").val();
		getData();
	});
	
	$("#size").on("change", function(){
		size=$("#size").val();
		page=1;
		getData();
	});
	
	// 선택 담기 버튼을 클릭한 경우
	$("#div_shop").on("click", "#insert", function(){
		let chk = $("#div_shop .chk:checked").length;
		if(chk == 0){
			alert("담을 상품을 선택하세요.");
			return;
		}
		if(!confirm(chk + "개 상품을 담으시겠습니까?")) return;
		// 성적 수정
		let cnt = 0;
		let success = 0;
		$("#div_shop .chk:checked").each(function(){
			let tr = $(this).parent().parent();
			let gid = tr.attr("gid");
			let title = tr.attr("title");
			let image = tr.attr("img");
			let price = tr.attr("price");
			let brand = tr.attr("brand");
			$.ajax({
				type:"post",
				url:"/goods/insert",
				data:{gid, title, image, price, brand},
				success:function(data){
					cnt++;
					if(data == "true") success++;
					if(chk == cnt){
						alert(success + "개 상품 담기 성공");
						getData();
					}
				}
			});
		});
	});
	
	// 담기 버튼을 클릭한 경우
	$("#div_shop").on("click", ".insert", function(){
		let tr = $(this).parent().parent();
		let gid = tr.attr("gid");
		let title = tr.attr("title");
		let image = tr.attr("img");
		let price = tr.attr("price");
		let brand = tr.attr("brand");
		console.log(gid, title, image, price, brand);
		$.ajax({
			type:"post",
			url:"/goods/insert",
			data:{gid, title, image, price, brand},
			success:function(data){
				if(data == "true"){
					alert("입력 성공");
				}else{
					alert("이미 등록한 상품입니다.")
				}
			}
		});
	});
	
	getData();
	function getData(){
		$.ajax({
			type:"get",
			url:"/goods/search.json",
			data:{query, page, size},
			dataType:"json",
			success:function(data){
				console.log(data);
				const temp = Handlebars.compile($("#temp_shop").html());
				$("#div_shop").html(temp(data));
				let total=parseInt(data.total);
				if(total==0) {
					alert("검색내용이 없습니다.");
					return;
				}
				let totalPage=Math.ceil(total/size);
				$("#pagination").twbsPagination("changeTotalPages", totalPage, page);
				if(total > size){
					$("#pagination").show();
				}else{
					$("#pagination").hide();
				}
			}
		});
	}
	
	Handlebars.registerHelper('formatPrice', function(price) {
        // 가격을 1000 단위로 ,를 넣어서 형식화
        return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    });
	
	$('#pagination').twbsPagination({
		totalPages:totalPages, 
		visiblePages: 5, 
		startPage : 1,
		initiateStartPageClick: false, 
		first:'<i class="bi bi-chevron-double-left"></i>', 
		prev :'<i class="bi bi-chevron-left"></i>',
		next :'<i class="bi bi-chevron-right"></i>',
		last :'<i class="bi bi-chevron-double-right"></i>',
		onPageClick: function (event, clickPage) {
			if (clickPage !== page) { // 페이지가 변경될 때만 getData() 호출
                page = clickPage; 
                getData();
             }
			if (clickPage === totalPages) { // 마지막 페이지 버튼을 클릭했을 때
                page = totalPages;
                getData();
             }
		}
	});
</script>