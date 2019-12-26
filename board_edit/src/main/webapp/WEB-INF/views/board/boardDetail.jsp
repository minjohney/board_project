<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<title>게시판 상세</title>
<%
	String boardSeq = request.getParameter("boardSeq");
%>

<!-- 게시글 번호 -->
<c:set var="boardSeq" value="<%=boardSeq%>" />

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

<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		getBoardDetail();
	});
	$("#logoutBtn").on("click", function(){
			location.href="/member/logout";
		});
		$("#registerBtn").on("click", function(){
			location.href="/member/register";
		});
		$("#memberUpdateBtn").on("click", function(){
			location.href="/member/memberUpdateView";
		});
		$("#memberDeleteBtn").on("click", function(){
			location.href="/member/memberDeleteView";
		});

	/** 게시판 - 목록 페이지 이동 */
	function goBoardList() {
		location.href = "/board/boardList";
	}

	/** 게시판 - 수정 페이지 이동 */
	function goBoardUpdate() {

		var boardSeq = $("#board_seq").val();

		location.href = "/board/boardUpdate?boardSeq=" + boardSeq;
	}


	/** 게시판 - 첨부파일 다운로드 */
	function fileDownload(fileNameKey, fileName, filePath) {

		location.href = "/board/fileDownload?fileNameKey=" + fileNameKey
				+ "&fileName=" + fileName + "&filePath=" + filePath;
	}

	/** 게시판 - 상세 조회  */
	function getBoardDetail(boardSeq) {

		var boardSeq = $("#board_seq").val();

		if (boardSeq != "") {

			$.ajax({

				url : "/board/getBoardDetail",
				data : $("#boardForm").serialize(),
				dataType : "JSON",
				cache : false,
				async : true,
				type : "POST",
				success : function(obj) {
					getBoardDetailCallback(obj);
				},
				error : function(xhr, status, error) {
				}

			});
		} else {
			alert("오류가 발생했습니다.\n관리자에게 문의하세요.");
		}
	}

	/** 게시판 - 상세 조회  콜백 함수 */
	function getBoardDetailCallback(obj) {

		var str = "";

		if (obj != null) {

			var boardSeq = obj.board_seq;
			var boardWriter = obj.board_writer;
			var boardSubject = obj.board_subject;
			var boardContent = obj.board_content;
			var boardHits = obj.board_hits;
			var delYn = obj.del_yn;
			var insUserId = obj.ins_user_id;
			var insDate = obj.ins_date;
			var updUserId = obj.upd_user_id;
			var updDate = obj.upd_date;
			var files = obj.files;
			var filesLen = files.length;

			str += "<tr>";
			str += "<th>제목</th>";
			str += "<td style='font-size: 20px; font-weight: bold'>" + boardSubject + "</td>";
			str += "<th>작성일</th>";
			str += "<td>" + insDate + "</td>";
			str += "</tr>";
			str += "<hr>";
			str += "<tr>";
			str += "<th>작성자</th>";
			str += "<td style='font-size: 15px; font-weight: bold; padding-top: 10px'>" + boardWriter + "</td>";
			str += "<th>수정일</th>";
			str += "<td>" + updDate + "</td>";
			str += "</tr>";
			str += "<tr>";
			str += "<th>내용</th>"
			str += "<td>" + boardContent + "</td>";
			str += "</tr>";


			if (filesLen > 0) {

				for (var a = 0; a < filesLen; a++) {

					var boardSeq = files[a].board_seq;
					var fileNo = files[a].file_no;
					var fileNameKey = files[a].file_name_key;
					var fileName = files[a].file_name;
					var filePath = files[a].file_path;
					var fileSize = files[a].file_size;
					var remark = files[a].remark;
					var delYn = files[a].del_yn;
					var insUserId = files[a].ins_user_id;
					var insDate = files[a].ins_date;
					var updUserId = files[a].upd_user_id;
					var updDate = files[a].upd_date;

					str += "<th style='color: #B90000'>첨부파일</th>";
					//str += "<td onclick='javascript:fileDownload(\"" + fileNameKey + "\", \"" + fileName + "\", \"" + filePath + "\");' style='cursor:Pointer'>"+ fileName +"</td>";
					str += "<td colspan='3'><a href='/board/fileDownload?fileNameKey="
							+ encodeURI(fileNameKey)
							+ "&fileName="
							+ encodeURI(fileName)
							+ "&filePath="
							+ encodeURI(filePath)
							+ "'>"
							+ fileName
							+ "</a></td>";
					str += "</tr>";
				}
			}

		} else {

			alert("등록된 글이 존재하지 않습니다.");
			return;
		}

		$("#tbody").html(str);
	}

	/** 게시판 - 삭제  */
	function deleteBoard() {

		var boardSeq = $("#board_seq").val();

		var yn = confirm("게시글을 삭제하시겠습니까?");
		if (yn) {

			$.ajax({

				url : "/board/deleteBoard",
				data : $("#boardForm").serialize(),
				dataType : "JSON",
				cache : false,
				async : true,
				type : "POST",
				success : function(obj) {
					deleteBoardCallback(obj);
				},
				error : function(xhr, status, error) {
				}

			});
		}
	}

	/** 게시판 - 삭제 콜백 함수 */
	function deleteBoardCallback(obj) {

		if (obj != null) {

			var result = obj.result;

			if (result == "SUCCESS") {
				alert("게시글 삭제를 성공하였습니다.");
				goBoardList();
			} else {
				alert("게시글 삭제를 실패하였습니다.");
				return;
			}
		}
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
					<h1 style="font-size: 20px; font-weight: bold; color: #4646CD"> 게시글 상세 </h1>
				</div>
				<hr>
				<div class="post-preview" align="center">
					<div id="wrap">
						<div id="container">
							<div class="inner">
								<form id="boardForm" name="boardForm">
									<table width="100%" class="table01">
										<colgroup>
											<col width="15%">
											<col width="35%">
											<col width="15%">
											<col width="*">
										</colgroup>
										<tbody id="tbody">

										</tbody>
									</table>
									<input type="hidden" id="board_seq" name="board_seq"
										value="${boardSeq}" />
									<!-- 게시글 번호 -->
									<input type="hidden" id="search_type" name="search_type"
										value="S" />
									<!-- 조회 타입 - 상세(S)/수정(U) -->
								</form>
								<div style="margin-top: 15px" align="right">
									<button type="button" class="btn btn-sm btn-lg" style="background-color: #4646CD; height: 50px; width: 70px; color: #ffffff; font-weight:bold"
										onclick="javascript:goBoardList();">목록</button>
									<button type="button" class="btn btn-sm btn-lg" style="background-color: #4646CD; height: 50px; width: 70px;   color: #ffffff; font-weight:bold"
										onclick="javascript:goBoardUpdate();">수정</button>
									<button type="button" class="btn btn-sm btn-lg" style="background-color: #4646CD; height: 50px; width: 70px;  color: #ffffff; font-weight:bold"
										onclick="javascript:deleteBoard();">삭제</button>
								</div>
							</div>
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
            <li class="list-inline-item">
              <a href="http://www.vinea.co.kr/">
                <span class="fa-stack fa-lg">
                  <i class="fas fa-circle fa-stack-2x"></i>
                  <i class="fa fa-home fa-stack-1x fa-inverse"></i>
                </span>
              </a>
            </li>
            <li class="list-inline-item">
              <a href="https://gitlab.com/minjohney/vineaproject1_1">
                <span class="fa-stack fa-lg">
                  <i class="fas fa-circle fa-stack-2x"></i>
                  <i class="fab fa-gitlab fa-stack-1x fa-inverse"></i>
                </span>
              </a>
            </li>
            <li class="list-inline-item">
              <a href="https://github.com/minjohney/vinea">
                <span class="fa-stack fa-lg">
                  <i class="fas fa-circle fa-stack-2x"></i>
                  <i class="fab fa-github fa-stack-1x fa-inverse"></i>
                </span>
              </a>
            </li>
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
