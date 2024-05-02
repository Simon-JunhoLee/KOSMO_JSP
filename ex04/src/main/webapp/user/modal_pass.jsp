<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	#modalPass{
		top:30%
	}
</style>

<!-- Modal -->
<div class="modal fade" id="modalPass" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">비밀번호 변경</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <input class="form-control mb-2" id="upass" type="password" value="" placeholder="현재 비밀번호"/>
        <input class="form-control mb-2" id="npass" type="password" value="" placeholder="새비밀번호"/>
        <input class="form-control mb-2" id="cpass" type="password" value="" placeholder="새비밀번호 확인"/>
      </div>
      <div class="text-center mb-5">
        <button id="btnSave" type="button" class="btn btn-dark">Save changes</button>
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
<script>
	$("#modalPass").on("click", "#btnSave", function(){
		const upass = $("#upass").val();
		const npass = $("#npass").val();
		const cpass = $("#cpass").val();
		if(upass == "" || npass == "" || cpass == ""){
			alert("모든 비밀번호를 입력하세요.");
		}else {
			$.ajax({
				type:"post",
				url:"/user/login",
				data:{uid, upass},
				success:function(data){
					if(data == 2){
						alert("현재 비밀번호가 일치하지 않습니다.");
						$("#upass").val("");
						$("#upass").focus();
					}else {
						if(npass != cpass){
							alert("새비밀번호가 일치하지 않습니다.");
							$("#cpass").val("");
							$("#cpass").focus();
						}else {
							if(!confirm("비밀번호를 변경하시겠습니까?")) return;
							// 비밀번호 변경
							$.ajax({
								type:"post",
								url:"/user/update/pass",
								data:{uid, npass},
								success:function(data){
									alert("비밀번호가 변경되었습니다.");
									location.href="/user/logout";
								}
							});
						}
					}
				}
			});
		}
	});
</script>