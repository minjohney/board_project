<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<title>회원가입</title>

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

<!-- 게시판 CSS -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
	integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
	crossorigin="anonymous">


<!--  JQuery 사용 -->
<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
	integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
	crossorigin="anonymous"></script>

<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js">
	
</script>
<script type="text/javascript">
	function chkword(obj, maxByte) {

		var strValue = obj.value;
		var strLen = strValue.length;
		var totalByte = 0;
		var len = 0;
		var oneChar = "";
		var str2 = "";

		for (var i = 0; i < strLen; i++) {
			oneChar = strValue.charAt(i);
			if (escape(oneChar).length > 4) {
				totalByte += 2;
			} else {
				totalByte++;
			}

			if (totalByte <= maxByte) {
				len = i + 1;
			}
		}

		if (totalByte > maxByte) {
			alert(maxByte + "수를 초과했습니다");
			str2 = strValue.substr(0, len);
			obj.value = str2;
			chkword(obj, 4000);
		}
	}
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
			if ($("#userId").val() == "") {
				alert("아이디를 입력해주세요.");
				$("#userId").focus();
				return false;
			}
			if ($("#userPass").val() == "") {
				alert("비밀번호를 입력해주세요.");
				$("#userPass").focus();
				return false;
			}
			if ($("#userName").val() == "") {
				alert("성명을 입력해주세요.");
				$("#userName").focus();
				return false;
			}
			var idChkVal = $("#idChk").val();
			if (idChkVal == "N") {
				alert("중복확인 버튼을 눌러주세요.");
			} else if (idChkVal == "Y") {
				alert("회원가입이 완료되었습니다");
				$("#regForm").submit();
			}
		});
	})

	function fn_idChk() {
		$.ajax({
			url : "/member/idChk",
			type : "post",
			dataType : "json",
			data : {
				"userId" : $("#userId").val()
			},
			success : function(data) {
				if (data == 1) {
					alert("중복된 아이디입니다.");
				} else if (data == 0) {
					$("#idChk").attr("value", "Y");
					alert("사용가능한 아이디입니다.");
				}
			}
		})
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
				<%@ include file="nav.jsp"%>
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
					<h1 style="font-size: 20px; font-weight: bold; color: #4646CD">
						회원가입</h1>
				</div>
				<hr>

				<div class="post-preview" align="center">
					<section id="container">
						<form action="/member/register" method="post">
							<div class="form-group has-feedback">
								<h1 class="control-label" for="userId"
									style="font-size: 15px; text-align: left; margin-left: 220px">아이디</h1>
								<input class="form-control" onkeyup="chkword(this, 20)"
									style="width: 300px; height: 45px" type="text" id="userId"
									name="userId" placeholder="아이디를 입력.." />
								<button class="btn btn-outline-primary" type="button" id="idChk"
									onclick="fn_idChk();" value="N"
									style="background-color: #4646CD; font-size: 15px; color: #ffffff; margin-right: 210px; margin-top: 10px">중복확인</button>
							</div>
							<div class="form-group has-feedback">
								<h1 class="control-label" for="userPass"
									style="font-size: 15px; text-align: left; margin-left: 220px">패스워드</h1>
								<input class="form-control" onkeyup="chkword(this, 20)"
									style="width: 300px; height: 45px" type="password"
									id="userPass" name="userPass" placeholder="비밀번호를 입력.." />
							</div>
							<div class="form-group has-feedback">
								<h1 class="control-label" for="userName"
									style="font-size: 15px; text-align: left; margin-left: 220px">이름</h1>
								<input class="form-control" onkeyup="chkword(this, 20)"
									style="width: 300px; height: 45px" type="text" id="userName"
									name="userName" placeholder="이름을  입력.." />
							</div>
							<div class="form-group has-feedback">
								<h1 class="control-label" for="userEmail"
									style="font-size: 15px; text-align: left; margin-left: 220px">이메일</h1>
								<input class="form-control" onkeyup="chkword(this, 20)"
									style="width: 300px; height: 45px" type="text" id="userEmail"
									name="userEmail" placeholder="이메일을 입력.." />
							</div>
							<div class="form-group has-feedback">
								<button class="btn btn-success" type="submit" id="submit"
									style="background-color: #4646CD; font-size: 15px; color: #ffffff">회원가입</button>
								<button class="cencle btn btn-danger"
									onclick="location.href='/index.jsp'" type="button"
									style="background-color: #FF7A85; font-size: 15px; color: #ffffff">취소</button>
							</div>
						</form>
					</section>
				</div>
			</div>
		</div>
	</div>

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
