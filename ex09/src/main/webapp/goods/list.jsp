<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div>
	<h1>상품 목록</h1>
	<div id="div_shop"></div>
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
		{{#each .}}
		<tr>
			<td class="text-center"><input class="form-check-input chk" type="checkbox"></td>
			<td class="text-center">{{gid}}</td>
			<td class="text-center"><img src={{image}} width="50"/></td>
			<td>
				<div class="ellipsis">{{{title}}}</div>
				<div style="color:gray;">{{regDate}}</div>
			</td>
			<td class="text-center">{{formatPrice price}}원</td>
			<td class="text-center"><button class="btn btn-dark delete" gid="{{gid}}">삭제</button></td>
		</tr>
		{{/each}}
	</table>
</script>

<script>
	getData();
	function getData(){
		$.ajax({
			type:"get",
			url:"/goods/list.json",
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
						   	getData();
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
</script>