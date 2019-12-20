<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>재능 나눔</title>
<script language="JavaScript" type="text/javascript">
	function layer_toggle(obj) {

		if (obj.style.display == 'none')
			obj.style.display = 'block';

		else if (obj.style.display == 'block')
			obj.style.display = 'none';

	}
</script>

<!-- Bootstrap core CSS -->
<link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="css/blog-home.css" rel="stylesheet">

</head>

<body>

	<!-- Navigation -->
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
		<div class="container">
			<a class="navbar-brand" href="#">재능 나눔</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarResponsive" aria-controls="navbarResponsive"
				aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarResponsive">
				<ul class="navbar-nav ml-auto">
					<li class="nav-item active"><a class="nav-link" href="#">HOME
							<span class="sr-only">(current)</span>
					</a></li>
					<li class="nav-item"><a class="nav-link" href="#"></a></li>
					<li class="nav-item"><a class="nav-link" href="#">LOGIN</a></li>
					<li class="nav-item"><a class="nav-link" href="#">SIGN</a></li>
				</ul>
			</div>
		</div>
	</nav>

	<hr>

	<div align=center>
		<a href="All_form.jsp" style="color: #228B22">전체 게시글</a> <a
			href="Notice.jsp" style="color: #228B22">공지사항</a> <a
			href="One_eye.jsp" style="color: #228B22">내 활동 한번에 보기</a>
	</div>

	<hr>

	<!-- Page Content -->
	<div class="container">

		<div class="row">

			<!-- Blog Entries Column -->
			<div class="col-md-8">

				<h1 class="my-4">
					Page Heading <small>Secondary Text</small>
				</h1>

				<!-- Blog Post -->
				<div class="card mb-4">
					<img class="card-img-top" src="http://placehold.it/750x300"
						alt="Card image cap">
					<div class="card-body">
						<h2 class="card-title">Post Title</h2>
						<p class="card-text">Lorem ipsum dolor sit amet, consectetur
							adipisicing elit. Reiciendis aliquid atque, nulla? Quos cum ex
							quis soluta, a laboriosam. Dicta expedita corporis animi vero
							voluptate voluptatibus possimus, veniam magni quis!</p>
						<a href="#" class="btn btn-primary">Read More &rarr;</a>
					</div>
					<div class="card-footer text-muted">
						Posted on January 1, 2017 by <a href="#">Start Bootstrap</a>
					</div>
				</div>



				<!-- Pagination -->
				<ul class="pagination justify-content-center mb-4">
					<li class="page-item"><a class="page-link" href="#">&larr;
							Older</a></li>
					<li class="page-item disabled"><a class="page-link" href="#">Newer
							&rarr;</a></li>
				</ul>

			</div>

			<!-- Sidebar Widgets Column -->
			<div class="col-md-4">

				<!-- Search Widget -->
				<div class="card my-4">
					<h5 class="card-header">회원정보</h5>
					<div class="card-body">
						<div class="input-group">
							<input type="button" class="form-control" value="재능나눔 가입하기">
						</div>
					</div>
				</div>


				<!-- Categories Widget -->
				<div class="card my-4">
					<h5 class="card-header">게시글정보</h5>
					<div class="card-body">
						<div class="row">

							<div align="center">
								<p style="color: #000">★전체게시글★</p>
								<div style="display: block;" id="kanadel001-1">
									<a
										onclick="layer_toggle(document.getElementById('kanadel001-1')); layer_toggle(document.getElementById('kanadel001-2')); return false;"
										href="#">
										<p>※꼭 읽어주세요</p>
									</a>
								</div>

								<div style="display: none" id="kanadel001-2">
									<a
										onclick="layer_toggle(document.getElementById('kanadel001-1')); layer_toggle(document.getElementById('kanadel001-2')); return false;"
										href="#">
										<p style="color: red">※꼭 읽어주세요</p>
									</a>
									<p style="color: #b4b4b4">☆공지사항</p>
								</div>

								<div style="display: block;" id="kanadel001-3">
									<a
										onclick="layer_toggle(document.getElementById('kanadel001-3')); layer_toggle(document.getElementById('kanadel001-4')); return false;"
										href="#">
										<p style="color: black;">▼재능기부마당</p>
									</a>
								</div>

								<div style="display: none;" id="kanadel001-4">
									<a
										onclick="layer_toggle(document.getElementById('kanadel001-3')); layer_toggle(document.getElementById('kanadel001-4')); return false;"
										href="#">
										<p style="color: black;">▲재능기부마당</p>
									</a>

									<div style="display: block;" id="kanadel001-5">
										<a
											onclick="layer_toggle(document.getElementById('kanadel001-5')); layer_toggle(document.getElementById('kanadel001-6')); return false;"
											href="#">
											<p style="color: black">▼외국어</p>
										</a>
									</div>

									<div style="display: none" id="kanadel001-6">
										<a
											onclick="layer_toggle(document.getElementById('kanadel001-5')); layer_toggle(document.getElementById('kanadel001-6')); return false;"
											href="#">
											<p style="color: black">▲외국어</p>
										</a>
										<div style="width: 137px" align="left">
											<a style="color: #b4b4b4" href="All_form.jsp">☞TOEIC</a><br>
											<a style="color: #b4b4b4" href="All_form.jsp">☞회화</a><br>
											<a style="color: #b4b4b4" href="All_form.jsp">☞Voca</a>
										</div>

									</div>
									<div style="display: block;" id="kanadel001-9">
										<a
											onclick="layer_toggle(document.getElementById('kanadel001-9')); layer_toggle(document.getElementById('kanadel001-10')); return false;"
											href="#">
											<p style="color: black">▼스포츠</p>
										</a>
									</div>

									<div style="display: none" id="kanadel001-10">
										<a
											onclick="layer_toggle(document.getElementById('kanadel001-9')); layer_toggle(document.getElementById('kanadel001-10')); return false;"
											href="#">
											<p style="color: black">▲스포츠</p>
										</a>
										<div style="width: 137px" align="left">
											<a style="color: #b4b4b4" href="All_form.jsp">☞축구</a><br>
											<a style="color: #b4b4b4" href="All_form.html">☞야구</a><br>
											<a style="color: #b4b4b4" href="All_form.jsp">☞수영</a>
										</div>

									</div>

									<div style="display: block;" id="kanadel001-11">
										<a
											onclick="layer_toggle(document.getElementById('kanadel001-11')); layer_toggle(document.getElementById('kanadel001-12')); return false;"
											href="#">
											<p style="color: black">▼MATH</p>
										</a>
									</div>

									<div style="display: none" id="kanadel001-12">
										<a
											onclick="layer_toggle(document.getElementById('kanadel001-11')); layer_toggle(document.getElementById('kanadel001-12')); return false;"
											href="#">
											<p style="color: black">▲MATH</p>
										</a>
										<div style="width: 137px" align="left">
											<a style="color: #b4b4b4" href="All_form.jsp">☞중등과정</a><br>
											<a style="color: #b4b4b4" href="All_form.html">☞고등과정</a><br>
											<a style="color: #b4b4b4" href="All_form.jsp">☞전문과정</a>
										</div>

									</div>

									<div style="display: block;" id="kanadel001-13">
										<a
											onclick="layer_toggle(document.getElementById('kanadel001-13')); layer_toggle(document.getElementById('kanadel001-14')); return false;"
											href="#">
											<p style="color: black">▼BEAUTY</p>
										</a>
									</div>

									<div style="display: none" id="kanadel001-14">
										<a
											onclick="layer_toggle(document.getElementById('kanadel001-13')); layer_toggle(document.getElementById('kanadel001-14')); return false;"
											href="#">
											<p style="color: black">▲BEAUTY</p>
										</a>
										<div style="width: 137px" align="left">
											<a style="color: #b4b4b4" href="All_form.jsp">☞네일아트</a><br>
											<a style="color: #b4b4b4" href="All_form.html">☞색조화장</a><br>
											<a style="color: #b4b4b4" href="All_form.jsp">☞피부관리</a>
										</div>

									</div>

									<div style="display: block;" id="kanadel001-15">
										<a
											onclick="layer_toggle(document.getElementById('kanadel001-15')); layer_toggle(document.getElementById('kanadel001-16')); return false;"
											href="#">
											<p style="color: black">▼Programming</p>
										</a>
									</div>

									<div style="display: none" id="kanadel001-16">
										<a
											onclick="layer_toggle(document.getElementById('kanadel001-15')); layer_toggle(document.getElementById('kanadel001-16')); return false;"
											href="#">
											<p style="color: black">▲Programming</p>
										</a>
										<div style="width: 137px" align="left">
											<a style="color: #b4b4b4" href="All_form.jsp">☞C Language</a><br>
											<a style="color: #b4b4b4" href="All_form.html">☞JAVA</a><br>
											<a style="color: #b4b4b4" href="All_form.jsp">☞Android</a><br>
											<a style="color: #b4b4b4" href="All_form.jsp">☞R studio</a>
										</div>

									</div>


								</div>


							</div>



						</div>
					</div>
				</div>


				<!-- Side Widget -->
				<div class="card my-4">
					<h5 class="card-header">Our Application?</h5>
					<div class="card-body">
						당신의 재능을 널리 알려주세요!<br> 당신에게서 새로운 재능을 발견하세요!<br> 이 모든 것을 할
						수 있는 이 곳<br> ☆재능 나눔에서 경험해보세요☆
					</div>
				</div>

			</div>

		</div>
		<!-- /.row -->

	</div>
	<!-- /.container -->

	<!-- Footer -->
	<footer class="py-5 bg-dark">
		<div class="container">
			<p class="m-0 text-center text-white">Copyright &copy; Your
				Website 2019</p>
		</div>
		<!-- /.container -->
	</footer>

	<!-- Bootstrap core JavaScript -->
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

</body>

</html>
