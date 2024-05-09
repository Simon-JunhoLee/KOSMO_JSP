<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
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
</style>
<div>
	<h1>강좌관리</h1>
	<div class="row">
		<div class="col-4">
			<form name="frm">
				<div class="input-group mb-3">
					<select class="form-select me-2" name="key">
						<option value="lname">강좌이름</option>
						<option value="lcode">강좌번호</option>
						<option value="pname">담당교수</option>
						<option value="room">강의실</option>
					</select>
					<input class="form-control" name="word" placeholder="검색어"/>
					<button class="btn btn-dark">검색</button>
				</div>
			</form>
		</div>
		<div class="col-4 pt-2" id="total"></div>
		<div class="col">
			<select class="form-select" name="size" id="size" style="width:100px;float:right;">
				<option value="3">3행</option>
				<option value="5" selected>5행</option>
				<option value="7">7행</option>
				<option value="10">10행</option>
				<option value="15">15행</option>
			</select>
		</div>
	</div>
	<div id="div_cou"></div>
	<div id="pagination" class="pagination justify-content-center mt-5"></div>
</div>

<script id="temp_cou" type="x-handlebars-template">
	<table class="table table-hover">
		<tr class="table-dark text-center">
			<th>강좌번호</th>
			<th>강좌이름</th>
			<th>강의시간</th>
			<th>강의실</th>
			<th>신청인원</th>
			<th>담당교수</th>
		</tr>
		{{#each .}}
		<tr class="text-center cou-row" data-lcode="{{lcode}}">
			<td>{{lcode}}</td>
			<td>{{lname}}</td>
			<td>{{hours}}</td>
			<td>{{room}}</td>
			<td>{{persons}}/{{capacity}}명</td>
			<td>{{pname}}({{instructor}})</td>
		</tr>
		{{/each}}
	</table>
</script>

<script>
	let page=1;
	let size=5;
	let key="lname";
	let word="";
	
	// getData();
	getTotal();
	
	$(document).ready(function(){
	    // 각 행에 클릭 이벤트 추가
	    $(document).on("click", ".cou-row", function() {
	        const lcode = $(this).data("lcode");
	        window.location.href = "/cou/read?lcode=" + lcode; // 페이지 이동
	    });
	});
	
	$(frm).on("submit", function(e){
		e.preventDefault();
		page=1;
		key = $(frm.key).val();
		word = $(frm.word).val();
		// getData();
		getTotal();
	});
	
	$("#size").on("change", function(){
		size = $("#size").val();
		// getData();
		getTotal();
	});
	
	function getData(){
		$.ajax({
			type:"get",
			url:"/cou/list.json",
			data:{page, size, key, word},
			dataType:"json",
			success:function(data){
				const temp = Handlebars.compile($("#temp_cou").html());
				$("#div_cou").html(temp(data));
			}
		});
	}
	
	function getTotal(){
		$.ajax({
			type:"get",
			url:"/cou/total",
			data:{key, word},
			success:function(data){
				let total = parseInt(data);
				
				if(total == 0){
					alert('검색 데이터가 없습니다.');
					$(frm.word).val("");
					return;
				}
				$("#total").html("총 " + data + "건");
				const totalPage = Math.ceil(data/size);
				$("#pagination").twbsPagination("changeTotalPages", totalPage, page);
				if(total > size){
					$("#pagination").show();
				}else {
					$("#pagination").hide();
				}
			}
		});
	}
	
	$('#pagination').twbsPagination({
	      totalPages:5, 
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