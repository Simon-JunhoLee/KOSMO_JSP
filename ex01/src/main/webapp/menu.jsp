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
					<a class="nav-link active" aria-current="page" href="/">회사소개</a>
				</li>
				<li class="nav-item">
					<a class="nav-link active" aria-current="page" href="/kakao/book">도서검색</a>
				</li>
				<li class="nav-item">
					<a class="nav-link active" aria-current="page" href="/kakao/local">지역검색</a>
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