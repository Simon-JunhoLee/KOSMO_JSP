<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<nav class="navbar bg-dark navbar-expand-lg bg-body-tertiary" data-bs-theme="dark">
	<div class="container-fluid">
		<a class="navbar-brand" href="/">KOSMO</a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
			data-bs-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav me-auto mb-2 mb-lg-0">
				<li class="nav-item">
					<a class="nav-link active" aria-current="page" href="/">Home</a>
				</li>
				<li class="nav-item" id="cart-item">
		        	<a class="nav-link active" aria-current="page" href="/cart/list">장바구니</a>
		        </li>
				<li class="nav-item" id="search-item">
		        	<a class="nav-link active" aria-current="page" href="/goods/search">상품검색</a>
		        </li>
				<li class="nav-item" id="list-item">
		        	<a class="nav-link active" aria-current="page" href="/goods/list">상품목록</a>
		        </li>
			</ul>
			<form class="d-flex" role="search">
				<input class="form-control me-2" type="search" placeholder="Search"
					aria-label="Search">
				<button class="btn btn-outline-success" type="submit">Search</button>
			</form>
			<ul class="navbar-nav ms-4 me-2 mb-2 mb-lg-0">
	          <li class="nav-item" id="login">
	            <a class="nav-link active" aria-current="page" href="/user/login">로그인</a>
	          </li>
	          <li class="nav-item" id="uid" style="display: none;">
	            <a class="nav-link active" aria-current="page" href="#"></a>
	          </li>
	          <li class="nav-item" id="logout" style="display: none;">
	            <a class="nav-link active" aria-current="page" href="#">로그아웃</a>
	          </li>
	        </ul>
		</div>
	</div>
</nav>

<script>
	// front-end에 세션값 저장
	// const uid = sessionStorage.getItem("uid");
	// back-end에 세션값 저장
	const uid = "${uid}";
	const uname = '${user.uname}';
	if(uid){
        $('#login').hide();
        $('#logout').show();
        $('#uid').show();
        $('#uid a').html(uid + " 님");
        
    }else {
        $('#login').show();
        $('#logout').hide();
        $('#uid').hide();
        $('#cart-item').hide();
        $("#search-item").hide();
		$("#list-item").hide();
    }
	
    if(uid == "admin"){
		$("#search-item").show();
		$("#list-item").show;
		$("#cart-item").hide
	}else{
		$("#search-item").hide();
		$("#list-item").hide();
	}
	
	// 로그아웃 버튼 클릭한 경우
    $('#logout').on("click", "a", function(e){
        e.preventDefault();
        swal({
        	  title: "Are you sure?",
        	  text: "로그아웃하시겠습니까?",
        	  icon: "warning",
        	  buttons: true,
        	  dangerMode: true,
        	})
        	.then((willLogout) => {
        	  if (willLogout) {
        	    sessionStorage.clear();
        	    location.href="/user/logout";
        	  } else {
        	    return;
        	  }
        	});
    });

    // 유저아이디 클릭한 경우
    $('#uid').on("click", "a", function(e){
        e.preventDefault();
        location.href="/user/mypage?uid=" + uid;
    })
</script>