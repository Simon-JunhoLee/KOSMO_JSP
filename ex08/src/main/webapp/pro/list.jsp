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
	<h1>교수관리</h1>
	<div class="row mb-4">
		<div class="col-6">
		    <form name="frm" action="">
		        <div class="input-group">
		        	<select class="form-select me-3" name="key">
		        		<option value="pcode">교수번호</option>
		        		<option value="pname" selected>교수이름</option>
		        		<option value="dept">교수학과</option>
		        	</select>
		            <input class="form-control" name="word" type="text" value="" placeholder="교수 검색">
		            <button class="btn btn-dark">검색</button>
		        </div>
		    </form>
		 </div>
	    <div class="col pt-2">
	        <span id="total"></span>
	    </div>
		<div class="col-3 text-end mt-2">교수 출력 인원 :</div> 
		<div class="col-1">
	        <select class="form-select" id="size">
	            <option value="3">3</option>
	            <option value="5" selected>5</option>
	            <option value="7">7</option>
	            <option value="10">10</option>
	        </select>
		</div>
	</div>
	<div id="div_pro"></div>
    <div class="col text-end" id="div-insert">
        <a href="/pro/insert"><button class="btn btn-dark">교수 등록</button></a>
    </div>
	<div id="pagination" class="pagination justify-content-center"></div>
</div>

<script id="temp_pro" type="x-handlebars-template">
	<table class="table table-hover">
		<tr class="table-dark text-center">
			<th>교수번호</th>
			<th>교수이름</th>
			<th>교수학과</th>
			<th>교수직급</th>
			<th>교수급여</th>
			<th>임용일자</th>
		</tr>
		{{#each .}}
		<tr class="pro-row" data-pcode="{{pcode}}">
			<td class="text-center">{{pcode}}</td>
			<td class="text-center">{{pname}}</td>
			<td class="text-center">{{dept}}</td>
			<td class="text-center">{{title}}</td>
			<td class="text-center">{{salary}}</td>
			<td class="text-center">{{hiredate}}</td>
		</tr>
		{{/each}}
	</table>
</script>

<script>
	let page = 1;
	let size = $("#size").val();
	let key = $(frm.key).val();
	let word = $(frm.word).val();
	
	$(document).ready(function() {
	    // 각 행에 클릭 이벤트 추가
	    $(document).on("click", ".pro-row", function() {
	        const pcode = $(this).data("pcode");
	        window.location.href = "/pro/read?pcode=" + pcode; // 페이지 이동
	    });
	});
	
	$('#size').on("change", function(){
		size = $('#size').val();
		//getData();
		getTotal();
	});
	
	$(frm).on("submit", function(e){		
		e.preventDefault();
		key = $(frm.key).val();
		word = $(frm.word).val();
		page = 1;
		//getData();
		getTotal();
	});
	
	// getData();
	getTotal();
	function getData(){		
		$.ajax({
			type:"get",
			url:"/pro/list.json",
			data:{page, size, key, word},
			dataType:"json",
			success:function(data){
				// console.log(data);
				const temp = Handlebars.compile($("#temp_pro").html());
				$("#div_pro").html(temp(data));
			}
		});
	}
	
	function getTotal(){
		$.ajax({
			type:"get",
			url:"/pro/total",
			data: {key, word},
			success: function(data){
			 let total = parseInt(data);
			 const totalPage = Math.ceil(total/size);
				if(total == 0){
					alert("해당 검색 내용이 없습니다.");
					$(frm.word).val("");
					return;
				}
			 $("#total").html("총 " + total + "명");
			 $("#pagination").twbsPagination("changeTotalPages", totalPage, page);
				if(total <= size){
					$("#pagination").hide();
				}else {					
					 $("#pagination").show();
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