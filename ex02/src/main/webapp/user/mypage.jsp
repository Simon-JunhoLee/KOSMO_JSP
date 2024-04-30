<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="row justify-content-center">
	<div class="col-10 col-md-8 col-lg-6">
		<h1>마이페이지</h1>
		<div class="card shadow mb-4">
			<div class="card-body">
				<div class="row justify-content-center align-items-center mb-3">
                    <div class="col-3 text-end">
                        <h3>${user.uid} 님</h3>
                    </div>
                    <div class="col text-end">
                        <button class="btn btn-dark btn-sm px-3" id="btnPass">비밀번호 변경</button>
                    </div>
                </div>
				<hr>
				<div class="input-group mt-2 mb-3">	
					<div class="input-group">
						<span class="input-group-text justify-content-center w-25">이름</span>
						<span class="form-control px-3">${user.uname}</span>
					</div>
				</div>
				<div class="input-group mt-3">
					<span class="input-group-text justify-content-center w-25">주소</span>
					<span class="form-control px-3">${user.address1} ${user.address2}</span>
				</div>
				<div class="input-group mt-3">
					<span class="input-group-text  justify-content-center w-25">전화</span>
					<span class="form-control px-3">${user.phone}</span>
				</div>
				<div class="input-group mt-3">
					<span class="input-group-text  justify-content-center w-25">가입일</span>
					<span class="form-control px-3"><fmt:formatDate value="${user.jdate}" pattern="yyyy년 MM월 dd일 HH:mm:ss"/></span>
				</div>
				<div class="input-group mt-3">
					<span class="input-group-text  justify-content-center w-25">수정일</span>
					<span class="form-control px-3"><fmt:formatDate value="${user.udate}" pattern="yyyy년 MM월 dd일 HH:mm:ss"/></span>
				</div>
				<div class="col text-center mt-3 mb-1">
					<button class="btn btn-dark px-5" id="btnInfo">정보 수정</button>									
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="modal_info.jsp"/>
	<jsp:include page="modal_pass.jsp"/>
</div>
<script>
	$("#btnInfo").on("click", function(){
		$("#modalInfo").modal("show");
	});
	$("#btnPass").on("click", function(){
		$("#modalPass").modal("show");
	});
</script>