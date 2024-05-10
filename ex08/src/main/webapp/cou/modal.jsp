<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	#modal {
		top:30%;
	}
</style>
<!-- Modal -->
<div class="modal fade" id="modal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="staticBackdropLabel">교수검색</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      	<div class="row">  
      		<div class="col-2 pt-2 text-end"><span>학과 선택 : </span></div>    	
	      	<div class="col-6">
	      		<select class="form-select mb-2" id="word">
	      			<option value="">학과 선택</option>
	      			<option value="전산">컴퓨터공학과</option>
	      			<option value="전자">전자공학과</option>
	      			<option value="건축">건축공학과</option>
	      		</select>
	      	</div>
      	</div>
        <div id="div_pro"></div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
<script id="temp_pro" type="x-handlebars-template">
	<table class="table table-hover">
		<tr class="table-dark text-center">
			<td>교수번호</td>
			<td>교수이름</td>
			<td>교수학과</td>
		</tr>
		{{#each .}}
		<tr class="text-center pro" pcode="{{pcode}}" pname="{{pname}}" style="cursor:pointer">
			<td>{{pcode}}</td>
			<td>{{pname}}</td>
			<td>{{dept}}</td>
		{{/each}}
	</table>
</script>
<script>
	let page=1;
	let size=100;
	let key="dept";
	let word=$("#word").val();
	
	$("#word").on("change", function(){
		word=$("#word").val();
		getData();
	});
	
	//각행의 tr를 클릭한경우
	$("#div_pro").on("click", ".pro", function(){
		const pcode=$(this).attr("pcode");
		const pname=$(this).attr("pname");
		//alert(pcode + pname);
		$(frm.instructor).val(pcode);
		$(frm.pname).val(pname);
		$("#modal").modal("hide");
	});
	
	getData();
	function getData(){
		$.ajax({
			type:"get",
			url:"/pro/list.json",
			data:{page, size, key, word},
			dataType:"json",
			success:function(data){
				console.log(data);
				const temp=Handlebars.compile($("#temp_pro").html());
				$("#div_pro").html(temp(data));
			}
		});
	}
</script>