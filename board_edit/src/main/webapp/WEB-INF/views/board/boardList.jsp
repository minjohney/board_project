<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style type="text/css">
td:hover {
	color: blue;
}
</style>
<meta charset="utf-8">
<meta name="description" content="">
<meta name="author" content="">
<title>게시판 목록</title>

<!--  전체 템플릿 CSS -->
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

<!-- 공통 JavaScript -->
<script type="text/javascript" src="/js/common/jquery.js"></script>
<script type="text/javascript">
	function Message() {
		alert('로그인이 필요한 서비스 입니다');
		location.href = "/";
	}
	$(document).ready(function() {
		getBoardList();
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

	/** 게시판 - 상세 페이지 이동 */
	function goBoardDetail(boardSeq) {
		location.href = "/board/boardDetail?boardSeq=" + boardSeq;
	}

	/** 게시판 - 작성 페이지 이동 */
	function goBoardWrite() {
		location.href = "/board/boardWrite";
	}

	/** 게시판 - 목록 조회  */
	function getBoardList(currentPageNo) {

		if (currentPageNo === undefined) {
			currentPageNo = "1";
		}

		$("#current_page_no").val(currentPageNo);

		$.ajax({

			url : "/board/getBoardList",
			data : $("#boardForm").serialize(),
			dataType : "JSON",
			cache : false,
			async : true,
			type : "POST",
			success : function(obj) {
				getBoardListCallback(obj);
			},
			error : function(xhr, status, error) {
			}

		});
	}

	/** 게시판 - 목록 조회  콜백 함수 */
	function getBoardListCallback(obj) {

		var state = obj.state;

		if (state == "SUCCESS") {

			var data = obj.data;
			var list = data.list;
			var listLen = list.length;
			var totalCount = data.totalCount;
			var pagination = data.pagination;

			var str = "";

			if (listLen > 0) {

				for (var a = 0; a < listLen; a++) {

					var boardSeq = list[a].board_seq;
					var boardWriter = list[a].board_writer;
					var boardSubject = list[a].board_subject;
					var boardContent = list[a].board_content;
					var boardHits = list[a].board_hits;
					var delYn = list[a].del_yn;
					var insUserId = list[a].ins_user_id;
					var insDate = list[a].ins_date;
					var updUserId = list[a].upd_user_id;
					var updDate = list[a].upd_date;

					str += "<tr>";
					str += "<td>" + boardSeq + "</td>";

					str += "<td onclick='javascript:goBoardDetail(" + boardSeq
							+ ");' style='cursor:Pointer; text-align:left'>"

					str += boardSubject + "</td>";

					str += "<td>" + boardWriter + "</td>";
					str += "<td>" + insDate + "</td>";
					str += "<td>" + boardHits + "</td>";
					str += "</tr>";

				}

			} else {

				str += "<tr>";
				str += "<td colspan='5'>등록된 글이 존재하지 않습니다.</td>";
				str += "<tr>";
			}

			$("#tbody").html(str);
			$("#total_count").text(totalCount);
			$("#pagination").html(pagination);

		} else {
			alert("오류입니다");
			return;
		}
	}
</script>
</head>
<body>
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

	<div class="container">
		<div class="row">
			<div class="col-lg-8 col-md-10 mx-auto">
				<div class="post-preview">
					<h1
						style="font-size: 20px; font-weight: bold; margin-bottom: 20px; color: #4646CD">
						게시글 목록</h1>
				</div>
				<div class="page_info" align="left" style="margin-bottom: 10px">
					<span class="total_count"><strong>총 게시물 수</strong> : <span
						id="total_count" class="t_red" style="color: #ff00ff">0</span>건
						<div class="form-group row justify-content-center"
							style="margin-right: 400px; margin-top: 15px">
							<div class="w100" style="padding-right: 10px">
								<select class="form-control form-control-sm" name="searchType"
									id="select_searchType"?>
									<option value="board_title" selected="selected">제목</option>
									<option value="board_writer" selected="selected">작성자</option>
								</select>
							</div>
							<div class="w300" style="padding-right: 10px">
								<input class="form-control form-control-sm" type="text"
									name="searchWord" id="searchWord" placeholder="구현중입니다...">
							</div>
							<div>
								<a href="javascript:fn_searchList()"
									class="btn btn-sm btn-primary"
									style="background-color: #4646CD">검색</a>
							</div>
						</div> </span>
				</div>
				<div class="post-preview" align="center">
					<div id="wrap">
						<div id="container">
							<div class="inner">
								<form id="boardForm" name="boardForm">
									<input type="hidden" id="function_name" name="function_name"
										value="getBoardList" /> <input type="hidden"
										id="current_page_no" name="current_page_no" value="1" />

									<div class="table-responsive">
										<table width="100%" class="table table-striped table-sm">
											<colgroup>
												<col width="10%" />
												<col width="25%" />
												<col width="10%" />
												<col width="15%" />
												<col width="20%" />
											</colgroup>
											<thead align="center" style="font-weight: bold">
												<tr>
													<th>No</th>
													<th>제목</th>
													<th>작성자</th>
													<th>작성일</th>
													<th>조회수</th>
												</tr>
											</thead>
											<tbody id="tbody" align="center">
											</tbody>

										</table>
									</div>
								</form>
								<div align="right" style="margin-top: 15px">
									<button type="button" class="btn btn-sm btn-lg"
										onclick="javascript:goBoardWrite();"
										style="background-color: #4646CD; font-size: 15px; height: 50px; width: 70px; color: #ffffff; font-weight: bold">작성</button>

								</div>
							</div>

							<div id="pagination" style="margin-left: 300px; margin-top: 20px"></div>

						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
<footer>
	<div class="container">
		<div class="row">
			<div class="col-lg-8 col-md-10 mx-auto">
				<ul class="list-inline text-center">
					<li class="list-inline-item"><a href="http://www.vinea.co.kr/">
							<span class="fa-stack fa-lg"> <i
								class="fas fa-circle fa-stack-2x"></i> <i
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