<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	#modalInfo{
		top:30%
	}
</style>

<!-- Modal -->
<div class="modal fade" id="modalInfo" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">정보 수정</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      	<input class="form-control mb-2" id="uname" value="${user.uname}" placeholder="이름"/>
      	<input class="form-control mb-2" id="phone" value="${user.phone}" placeholder="전화번호"/>
      	<div class="input-group mb-2">
      		<input class="form-control" id="address1" value="${user.address1}" placeholder="전화번호"/>
      		<button class="btn btn-dark" id="btnSearch">주소 검색</button>
      	</div>
      	<input class="form-control" id="address2" value="${user.address2}" placeholder="상세주소"/>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-dark" id="btnSave">Save changes</button>
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
<script>
	$("#btnSearch").on("click", function(){
		new daum.Postcode({
            oncomplete:function(data){
                console.log(data);
                const building=data.buildingName;
                let address="";
                if(building!=""){
                    address = data.address + '(' + building + ')';
                }else {
                    address = data.address;
                }
                $("#address1").val(address);
            }
        }).open();
	});
	$("#modalInfo").on("click", "#btnSave" ,function(){
		const uname = $("#uname").val();
		const phone = $("#phone").val();
		const address1 = $("#address1").val();
		const address2 = $("#address2").val();
		console.log(uname, phone, address1, address2, uid);
		if(confirm("수정하시겠습니까?")){
			// 수정하기
			$.ajax({
				type:"post",
				url:"/user/update",
				data:{uid, uname, phone, address1, address2},
				success:function(){
					alert("수정이 완료되었습니다.");
					location.reload(true);
				}
			});
			
			$("#modalInfo").modal("hide");
		}
	});
</script>