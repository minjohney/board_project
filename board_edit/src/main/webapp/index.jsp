<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>
<html>
<head>
<meta charset="utf-8">
<meta name="description" content="">
<meta name="author" content="">

<title>Home</title>

<!-- 게시판 CSS -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
	integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
	crossorigin="anonymous">

<!-- 전체 템플릿 CSS -->
<link href="/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="/vendor/fontawesome-free/css/all.min.css" rel="stylesheet"
	type="text/css">
<link
	href='https://fonts.googleapis.com/css?family=Lora:400,700,400italic,700italic'
	rel='stylesheet' type='text/css'>
<link
	href='https://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800'
	rel='stylesheet' type='text/css'>
<link href="/css/clean-blog.min.css" rel="stylesheet">

<!--  JQuery 사용 -->
<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
	integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
	crossorigin="anonymous"></script>

<script type="text/javascript">
function numberMaxLength(e){
    if(e.value.length > e.maxLength){
        e.value = e.value.slice(0, e.maxLength);
    }
}

	$(document).ready(function(){
		$("#logoutBtn").on("click", function(){
			location.href="/member/logout";
		})
		$("#registerBtn").on("click", function(){
			location.href="/member/register";
		})
		$("#memberUpdateBtn").on("click", function(){
			location.href="/member/memberUpdateView";
		})
		$("#memberDeleteBtn").on("click", function(){
			location.href="/member/memberDeleteView";
		})
		
		
	})
	
	
	
	
	
	
	function goBoardList() {
		location.href = "/board/boardList";
	}
</script>

</head>
<body>

	<!-- Navigation -->
	<nav class="navbar navbar-expand-lg navbar-light fixed-top"
		id="mainNav">
		<div class="container">
			<a class="navbar-brand" href="/index.jsp" style="font-size: 20px">HOME</a>
			<button class="navbar-toggler navbar-toggler-right" type="button"
				data-toggle="collapse" data-target="#navbarResponsive"
				aria-controls="navbarResponsive" aria-expanded="false"
				aria-label="Toggle navigation">
				Menu <i class="fas fa-bars"></i>
			</button>
			<div class="collapse navbar-collapse" id="navbarResponsive">
				<ul class="navbar-nav ml-auto">
					<c:if test="${member == null}">
						<li class="nav-item"><a class="nav-link" href="/"
							style="font-size: 15px">LOGIN</a></li>
						<li class="nav-item"><a class="nav-link"
							href="/member/register" style="font-size: 15px">SIGN</a></li>
					</c:if>
					<c:if test="${member != null}">
						<li class="nav-item"><a style="font-size: 15px">${member.userId}님</a>
						</li>
						<li class="nav-item"><a class="nav-link"
							href="/member/logout" style="font-size: 15px">LOGOUT</a></li>
						<li class="nav-item"><a class="nav-link"
							href="/member/memberUpdateView" style="font-size: 15px">MY</a></li>
					</c:if>
				</ul>
			</div>
		</div>
	</nav>

	<!-- Page Header -->
	<header class="masthead"
		style="background-image: url('/img/background.png')">
		<div class="overlay"></div>
		<div class="container">
			<div class="row">
				<div class="col-lg-8 col-md-10 mx-auto">
					<div class="site-heading">
						<h1 style="color: #A0AFFF">Vinea Board</h1>
						<span class="subheading"
							style="font-size: 18px; color: #ffffff; font-weight: bold">made
							by SEOMINJIN</span>
					</div>
				</div>
			</div>
		</div>
	</header>

	<!-- Main Content -->
	<div class="container">
		<div class="row">
			<div class="col-lg-8 col-md-10 mx-auto">


				<div class="post-preview">
					<c:if test="${member == null}">
						<a href="javascript:window.alert('로그인이 필요한 서비스입니다')">
							<h1 style="font-size: 20px; font-weight: bold; color: #4646CD">
								게시판(바로가기)</h1>
						</a>
						<hr>
					</c:if>
					<c:if test="${member != null}">
						<a href="/board/boardList">
							<h1 style="font-size: 20px; font-weight: bold; color: #4646CD">
								게시판(바로가기)</h1>
						</a>
						<hr>
					</c:if>

					<form name='homeForm' method="post" action="/member/login">
						<c:if test="${member == null}">
							<div align="center" style="margin-bottom: 10px">
								<label for="userId"></label>
								<h1 style="font-size: 20px; margin-right: 220px">아이디</h1>
								<input class="form-control"
									style="font-size: 20px; width: 300px; height: 50px; font-weight: bold"
									type="text" id="userId" name="userId">
							</div>
							<div align="center" style="margin-bottom: 10px">
								<label for="userPass"></label>
								<h1 style="font-size: 20px; margin-right: 215px">비밀번호</h1>
								<input class="form-control"
									style="font-size: 20px; width: 300px; height: 50px; font-weight: bold"
									type="password" id="userPass" name="userPass">
							</div>
							<div class="form-group has-feedback" align="center">
								<button class="btn btn-success"
									style="background-color: #4646CD; font-size: 15px; color: #ffffff"
									type="submit" id="submit">로그인</button>
								<button class="cencle btn btn-danger"
									onclick="location.href='/member/register'" type="button"
									style="background-color: #FF7A85; font-size: 15px; color: #ffffff">회원가입</button>
							</div>
						</c:if>

						<c:if test="${msg == false}">
								<p style="color: #ff0">아이디와 비밀번호가 일치하지 않습니다</p>
						</c:if>

					</form>

				</div>


			</div>
		</div>
	</div>

	<hr>

	<footer>
		<div class="container">
			<div class="row">
				<div class="col-lg-8 col-md-10 mx-auto">
					<ul class="list-inline text-center">
						<li class="list-inline-item"><a
							href="http://www.vinea.co.kr/"> <span class="fa-stack fa-lg">
									<i class="fas fa-circle fa-stack-2x"></i> <i
									class="fa fa-home fa-stack-1x fa-inverse"></i>
							</span>
						</a></li>
						<li class="list-inline-item"><a
							href="https://gitlab.com/minjohney/vineaproject1_1"> <span
								class="fa-stack fa-lg"> <i
									class="fas fa-circle fa-stack-2x"></i> <i
									class="fab fa-gitlab fa-stack-1x fa-inverse"></i>
							</span>
						</a></li>
						<li class="list-inline-item"><a
							href="https://github.com/minjohney/vinea"> <span
								class="fa-stack fa-lg"> <i
									class="fas fa-circle fa-stack-2x"></i> <i
									class="fab fa-github fa-stack-1x fa-inverse"></i>
							</span>
						</a></li>
					</ul>
					<p class="copyright text-muted">Copyright &copy; SEOMINJIN 2019</p>
				</div>
			</div>
		</div>
	</footer>

	<!-- Bootstrap core JavaScript -->
	<script src="/vendor/jquery/jquery.min.js"></script>
	<script src="/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Custom scripts for this template -->
	<script src="/js/clean-blog.min.js"></script>

</body>

</html>
