<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<title>Home</title>
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

<title>회원정보 업데이트</title>
</head>
<script type="text/javascript">
	
	function numberMaxLength(e){
	    if(e.value.length > e.maxLength){
	        e.value = e.value.slice(0, e.maxLength);
	    }
	}
		$(document).ready(function(){
			// 취소
			$(".cencle").on("click", function(){
				
				location.href = "/";
						    
			})
			
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
		
			$("#submit").on("click", function(){
				if($("#userPass").val()==""){
					alert("비밀번호를 입력해주세요.");
					$("#userPass").focus();
					return false;
				}
				if($("#userName").val()==""){
					alert("이름을 입력해주세요.");
					$("#userName").focus();
					return false;
				}
				if($("#userEmail").val()==""){
					alert("이메일을 입력해주세요.");
					$("#userEmail").focus();
					return false;
				}
				$.ajax({
					url : "/member/passChk",
					type : "POST",
					dateType : "json",
					data : $("#updateForm").serializeArray(),
					success: function(data){
						
						if(data==true){
							if(confirm("회원수정하시겠습니까?")){
								$("#updateForm").submit();
							}
							
						}else{
							alert("패스워드가 틀렸습니다.");
							return;
							
						}
					}
				})
				
			});
			
				
			
		})
	</script>
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
				 <%@ include file = "nav.jsp" %>
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
				<a href="/member/memberUpdateView">
						<h1 style="font-size: 20px; font-weight: bold; color: #96A5FF">회원정보 수정</h1>
					</a>
					<a href="/member/memberDeleteView">
						<h1 style="font-size: 20px; font-weight: bold; color: #FF7A85">회원탈퇴</h1>
					</a>
					<section id="container">
						<form action="/member/memberUpdate" method="post">
							<div class="form-group has-feedback" align="center">
								<label class="control-label" for="userId"></label>
								<h1 style="font-size: 20px; margin-right: 240px">아이디</h1>
								<input class="form-control"
									style="font-size: 20px; width: 300px; height: 50px; font-weight: bold"
									maxlength="13" oninput="numberMaxLength(this);" type="text"
									id="userId" name="userId" value="${member.userId}"
									readonly="readonly" />
							</div>
							<div class="form-group has-feedback" align="center">
								<label class="control-label" for="userPass"></label>
								<h1 style="font-size: 20px; margin-right: 220px">비밀번호</h1>
								<input class="form-control"
									style="font-size: 20px; width: 300px; height: 50px; font-weight: bold"
									maxlength="13" oninput="numberMaxLength(this);" type="password"
									id="userPass" name="userPass" />
							</div>
							<div class="form-group has-feedback" align="center">
								<label class="control-label" for="userName"></label>
								<h1 style="font-size: 20px; margin-right: 260px">이름</h1>
								<input class="form-control" maxlength="13"
									oninput="numberMaxLength(this);"
									style="font-size: 20px; width: 300px; height: 50px; font-weight: bold"
									type="text" id="userName" name="userName"
									value="${member.userName}" />
							</div>
							<div class="form-group has-feedback" align="center">
								<label class="control-label" for="userEmail"></label>
								<h1 style="font-size: 20px; margin-right: 240px">이메일</h1>
								<input class="form-control" maxlength="13"
									oninput="numberMaxLength(this);"
									style="font-size: 20px; width: 300px; height: 50px; font-weight: bold"
									type="text" id="userEmail" name="userEmail"
									value="${member.userEmail}" />
							</div>
							<div class="form-group has-feedback" align="center">
								<button class="btn btn-success"
									style="background-color: #4646CD; font-size: 15px; color: #ffffff"
									type="submit" id="submit">회원정보수정</button>
								<button class="cencle btn btn-danger"
									style="background-color: #FF7A85; font-size: 15px; color: #ffffff"
									type="button">취소</button>
							</div>
						</form>
					</section>
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
