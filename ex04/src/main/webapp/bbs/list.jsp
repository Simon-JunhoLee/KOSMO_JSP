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
	<h1>게시판</h1>
	<div class="row mb-4">
		<div class="col-4">
		    <form name="frm" action="">
		        <div class="input-group">
		            <input class="form-control" name="query" type="text" value="" placeholder="게시글 검색">
		            <button class="btn btn-dark">검색</button>
		        </div>
		    </form>
		 </div>
	    <div class="col pt-2">
	        <span id="total"></span>
	    </div>
		<div class="col-3 text-end mt-2">출력 게시글 개수 :</div> 
		<div class="col-1">
	        <select class="form-control" id="size">
	            <option value="5">5</option>
	            <option value="10" selected>10</option>
	            <option value="20">20</option>
	        </select>
		</div>
	    <div class="col text-end" id="div-write" style="display: none;">
	        <a href="/bbs/insert"><button class="btn btn-dark">글쓰기</button></a>
	    </div>
	</div>
	<div id="div_bbs"></div>
	<div id="pagination" class="pagination justify-content-center mt-5"></div>
</div>

<script id="temp_bbs" type="x-handlebars-template">
	<table class="table table-hover">
		<colgroup>
            <col width="10%" />
            <col width="55%" />
            <col width="15%" />
            <col width="20%" />
        </colgroup>
        <tr class="table-dark text-center">
			<th>ID</th>
			<th class="text-start">Title</th>
			<th>Writer</th>
			<th>Date</th>
		</tr>
		{{#each .}}
			<tr>
				<td class="text-center">{{bid}}</td>
				<td><a href="/bbs/read?bid={{bid}}">{{title}}</a></td>
				<td class="text-center">{{uname}}({{writer}})</td>
				<td class="text-center">{{bdate}}</td>
			</tr>
		{{/each}}
	</table>
</script>

<script>
	let query = $(frm.query).val();
	let page = 1;
	let size = $('#size').val();
	getData();
	getTotal();	
	
	$('#size').on("change", function(){
		size = $('#size').val();
		getData();
		getTotal();
	});
	
	if(uid){
        $('#div-write').show();
    }else {
        $('#div-write').hide();
    }
	
	$(frm).on("submit", function(e){
        e.preventDefault();
        query = $(frm.query).val();
        getTotal();
        getData();
        page=1;
	});
	
	function getData(){
		$.ajax({
			type:"get",
			url:"/bbs/list.json",
			dataType:"json",
			data:{query:query, page:page, size:size},
			success:function(data){
				const temp = Handlebars.compile($("#temp_bbs").html());
				$("#div_bbs").html(temp(data));
				// console.log(data);
			}
		});
	}
   	
	function getTotal(){
		$.ajax({
			type:"get",
			url:"/bbs/total",
			data: {query:query},
			success: function(data){
				if(data == 0){
					alert("해당 검색 내용이 없습니다.");
					$(frm.query).val("");
				}else if(data <= size){
					$("#pagination").hide();
				}else {					
					 const totalPage = Math.ceil(data/size);
					 $("#total").html("총 " + data + "건");
					 $("#pagination").twbsPagination("changeTotalPages", totalPage, page);
					 $("#pagination").show();
				}
			}
		});
	}
	$('#pagination').twbsPagination({
	      totalPages:1, 
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