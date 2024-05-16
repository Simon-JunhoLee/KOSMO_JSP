<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- Outer Row -->
<div class="row justify-content-center">

    <div class="col-xl-10 col-lg-12 col-md-9">

        <div class="card o-hidden border-0 shadow-lg my-5">
            <div class="card-body p-0">
                <!-- Nested Row within Card Body -->
                <div class="row">
                    <div class="col-lg-6">
                        <img src="/image/login3.jpg" width="100%" alt="">
                    </div>
                    <div class="col-lg-6">
                        <div class="p-5">
                            <div class="text-center">
                                <h1 class="h4 text-gray-900 mb-4">Login</h1>
                            </div>
                            <form name="frm">
                                <div class="form-group">
                                    <input class="form-control mb-2" name="uid" value="" placeholder="Enter ID">
                                </div>
                                <div class="form-group">
                                    <input class="form-control mb-2" type="password" name="upass" value="" placeholder="Password">
                                </div>
                                
                                <button class="btn btn-dark w-100">Login</button>
                                <hr>
                            </form>
                            <div class="text-center">
	                            <a href="#" class="btn btn-google btn-user btn-block">
	                                <i class="fab fa-google fa-fw"></i> Login with Google
	                            </a>
	                            <a href="#" class="btn btn-facebook btn-user btn-block">
	                                <i class="fab fa-facebook-f fa-fw"></i> Login with Facebook
	                            </a>
                            </div>
                            <hr>
                            <div class="text-center">
                                <a class="small" href="#">Forgot Password?</a>
                            </div>
                            <div class="text-center">
                                <a class="small" href="#">Create an Account!</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
	$(frm).on("submit", function(e){
		e.preventDefault();
		const uid = $(frm.uid).val();
		const upass = $(frm.upass).val();
		if(uid==""){
			swal("아이디를 입력하세요!", "", "info")
			.then((value) => {
				$(frm.uid).focus();
			});
			return;
		}
		if(upass==""){
			swal("비밀번호를 입력하세요!", "", "info")
			.then((value) => {
				$(frm.upass).focus();
			});
			return;
		}
		// 로그인체크
		$.ajax({
			type:"post",
			url:"/user/login",
			data:{uid, upass},
			success:function(data){
				const result = parseInt(data);
				if(result == 0){
					swal("아이디가 존재하지 않습니다.", "", "error")
					.then((value) => {
						$(frm.uid).focus();
					});
				}else if(result == 2){
					swal("비밀번호가 일치하지 않습니다.", "", "error")
					.then((value) => {
						$(frm.upass).focus();
					});
				}else if(result == 1){
					sessionStorage.setItem("uid", uid);
					// 그 전 페이지 세션에 저장
					const target = sessionStorage.getItem("target");
					if(target){
						location.href=target;
					}else{						
						location.href="/";
					}
				}
			}
		});
	});
</script>