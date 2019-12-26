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

<title>회원탈퇴</title>
</head>
<script type="text/javascript">
	$(document).ready(function() {
		// 취소
		$(".cencle").on("click", function() {

			location.href = "/";

		})

		$("#logoutBtn").on("click", function() {
			location.href = "/member/logout";
		})
		$("#registerBtn").on("click", function() {
			location.href = "/member/register";
		})
		$("#memberUpdateBtn").on("click", function() {
			location.href = "/member/memberUpdateView";
		})
		$("#memberDeleteBtn").on("click", function() {
			location.href = "/member/memberDeleteView";
		})

		$("#submit").on("click", function() {
			if ($("#userPass").val() == "") {
				alert("비밀번호를 입력해주세요.");
				$("#userPass").focus();
				return false;
			}
			$.ajax({
				url : "/member/passChk",
				type : "POST",
				dataType : "json",
				data : $("#delForm").serializeArray(),
				success : function(data) {

					if(data==true){
						if(confirm("회원탈퇴하시겠습니까?")){
							$("#delForm").submit();
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
						<h1 style="font-size: 20px; font-weight: bold; color: #96A5FF">회원정보
							수정</h1>
					</a> <a href="/member/memberDeleteView">
						<h1 style="font-size: 20px; font-weight: bold; color: #FF7A85">회원탈퇴</h1>
					</a>
					<hr>
					<section id="container">
						<form action="/member/memberDelete" method="post" id="delForm">
							<div class="form-group has-feedback" align="center">
								<label class="control-label" for="userId"></label>
								<h1 style="font-size: 20px; margin-right: 240px">아이디</h1>
								<input class="form-control" maxlength="13"
									oninput="numberMaxLength(this);"
									style="font-size: 20px; width: 300px; height: 50px; font-weight: bold"
									type="text" id="userId" name="userId" value="${member.userId}"
									readonly="readonly" />
							</div>
							<div class="form-group has-feedback" align="center">
								<label class="control-label" for="userPass"></label>
								<h1 style="font-size: 20px; margin-right: 240px">비밀번호</h1>
								<input class="form-control" maxlength="13"
									oninput="numberMaxLength(this);"
									style="font-size: 20px; width: 300px; height: 50px; font-weight: bold"
									type="password" id="userPass" name="userPass" />
							</div>
							<div class="form-group has-feedback" align="center">
								<label class="control-label" for="userName"></label>
								<h1 style="font-size: 20px; margin-right: 240px">이름</h1>
								<input class="form-control" maxlength="13"
									oninput="numberMaxLength(this);"
									style="font-size: 20px; width: 300px; height: 50px; font-weight: bold"
									type="text" id="userName" name="userName"
									value="${member.userName}" readonly="readonly" />
							</div>
							<div class="form-group has-feedback" align="center">
								<label class="control-label" for="userEmail"></label>
								<h1 style="font-size: 20px; margin-right: 240px">이메일</h1>
								<input class="form-control" maxlength="13"
									oninput="numberMaxLength(this);"
									style="font-size: 20px; width: 300px; height: 50px; font-weight: bold"
									type="text" id="userEmail" name="userEmail"
									value="${member.userEmail}" readonly="readonly" />
							</div>
						</form>
						<div class="form-group has-feedback" align="center">
							<button class="btn btn-success"
								style="background-color: #4646CD; font-size: 15px; color: #ffffff"
								type="button" id="submit">회원탈퇴</button>
							<button class="cencle btn btn-danger"
								style="background-color: #FF7A85; font-size: 15px; color: #ffffff"
								type="button">취소</button>
						</div>
						<div>
							<c:if test="${msg == false}">
					비밀번호가 맞지 않습니다.
				</c:if>
						</div>
					</section>
				</div>
			</div>
		</div>
	</div>

</body>

</html>