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
    #div_shop img {
    	cursor: pointer;
    	border-radius: 20%;
    }
</style>
<div>
	<h1>상품 목록</h1>
	<div class="row mb-2">
		<div class="col">
			<button class="btn btn-dark px-3" id="delete">선택 삭제</button>
		</div>
		<div class="col text-end mt-2">
			<span id="total"></span>
		</div>
		<form class="col-4" name="frm">
			<div class="input-group">
				<input placeholder="검색어" class="form-control" name="word" value="">
				<button class="btn btn-dark">검색</button>
			</div>
		</form>
	</div>
	<div id="div_shop"></div>
	<div id="pagination" class="pagination justify-content-center mt-5"></div>
</div>
<script id="temp_shop" type="x-handlebars-template">
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
		{{#each .}}
		<tr class="text-center goods-row" data-gid="{{gid}}">
			<td class="text-center"><input class="form-check-input chk" gid="{{gid}}" type="checkbox"></td>
			<td class="text-center">{{gid}}</td>
			<td class="text-center"><img src={{image}} width="50" data-bs-toggle="modal" data-bs-target="#modal{{@index}}"/></td>
			<td>
				<div class="ellipsis">{{{title}}}</div>
				<div style="color:gray;">{{regDate}}</div>
			</td>
			<td class="text-center">{{formatPrice price}}원</td>
			<td class="text-center">
				<button class="btn btn-dark delete" gid="{{gid}}">삭제</button>
				<jsp:include page="modal_image.jsp"/>
			</td>
		</tr>
		{{/each}}
	</table>
</script>

<script>
	let page = 1;
	let size = 10;
	let word = "";
	
	
	$("#div_shop").on("click", "img", function(){
		if ($(this).attr("data-bs-toggle") === "modal") {
            const index = $(this).attr("index");
            $("#modal" + index).modal("show");
        }
	});
	
	
	// 각 행을 누르면 readPage 이동
	$(document).ready(function(){
	    // 각 행에 클릭 이벤트 추가
		$(document).on("click", ".goods-row", function() {
			if($(event.target).is("img") || $(event.target).parent().is("img")) return;
	            const gid = $(this).data("gid");
	            window.location.href = "/goods/read?gid=" + gid; // 페이지 이동
	    });
	});
	
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

	// getData();
	function getData(){
		$.ajax({
			type:"get",
			url:"/goods/list.json",
			data:{word, page, size},
			dataType:"json",
			success:function(data){
				const temp = Handlebars.compile($("#temp_shop").html());
				$("#div_shop").html(temp(data));
			}
		});
	}
	
	Handlebars.registerHelper('formatPrice', function(price) {
        // 가격을 1000 단위로 ,를 넣어서 형식화
        return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    });
	
	// 삭제 버튼 클릭
	$("#div_shop").on("click", ".delete", function(){
		const gid = $(this).attr("gid");
		swal({
			  title: "Are you sure?",
			  text: gid + "번 상품을 삭제하시겠습니까?",
			  icon: "warning",
			  buttons: true,
			  dangerMode: true,
			})
			.then((willDelete) => {
			  if (willDelete) {
				  $.ajax({
						type:"post",
						url:"/goods/delete",
						data:{gid},
						success:function(data){
						    swal("삭제 성공!", {
						      icon: "success",
						    });
						   	// getData();
						   	getTotal();
						}
				  });
			  } else {
				  swal({
					  title: "삭제 실패!",
					  icon: "error",
					  button: "확인",
					});
			  }
			});
		});
	
	// 선택삭제버튼 클릭한 경우
	$("#delete").on("click", function(){
		const chk = $("#div_shop .chk:checked").length;
		let cnt = 0;
		let success = 0;
		if(chk == 0){
			swal("삭제할 상품을 선택하세요!", "", "error");
			return;
		}
		swal({
			  title: "Are you sure?",
			  text: chk + "개의 상품을 삭제하시겠습니까?",
			  icon: "warning",
			  buttons: true,
			  dangerMode: true,
		})
		.then((willDelete) => {
		  if (willDelete) {
			// 삭제하기
			$("#div_shop .chk:checked").each(function(){
				const gid=$(this).attr("gid");
				$.ajax({
					type:"post",
					url:"/goods/delete",
					data:{gid},
					success:function(data){
						cnt++;
						if(data == "true") success++;
						
						if(cnt == chk){						
						    swal(success + "개 삭제 완료!", {
						      icon: "success",
						    });
						   	// getData();
						   	getTotal();
						}
					}
			  	});
			});
		  } else {
			  swal({
				  title: "삭제 취소!",
				  icon: "error",
				  button: "확인",
				});
		  }
		});
	
	});
	
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
		const all = $("#div_shop .chk").length;
		const chk = $("#div_shop .chk:checked").length;
		if(all == chk){
			$("#div_shop #all").prop("checked", true);
		}else{
			$("#div_shop #all").prop("checked", false);
		}
	});
	
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
	
</script>