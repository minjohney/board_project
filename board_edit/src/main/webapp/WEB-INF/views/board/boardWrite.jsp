<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<meta name="description" content="">
<meta name="author" content="">
<title>게시판 작성</title>


<!-- ckeditor 사용 servlet-context.xml에서 경로 설정 -->
<script src="${path}/ckeditor/ckeditor.js"></script>

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
	

<!-- 공통 JavaScript -->
<script type="text/javascript" src="/js/common/jquery.js"></script>
<script type="text/javascript" src="/js/common/jquery.form.js"></script>
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
        alert("최대" + maxByte +"자를 초과했습니다");
        str2 = strValue.substr(0, len);
        obj.value = str2;
        chkword(obj, 4000);
    }
}

	/*function numberMaxLength(e) {
		if (e.value.length > e.maxLength) {
			e.value = e.value.slice(0, e.maxLength);
		}
	})*/

	$(document).ready(function() {

	});

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

	/** 게시판 - 목록 페이지 이동 */
	function goBoardList() {
		location.href = "/board/boardList";
	}

	/** 게시판 - 작성  */
	function insertBoard() {
		
		var boardSubject = $("#board_subject").val();
		//var boardContent = $("#board_content").val();
		
		ck = CKEDITOR.instances.board_content.getData();
		
		alert(ck);

		if (CKEDITOR.instances.board_content.getData().length < 1) {
			alert("내용을 입력해주세요");
			return;
		}
		
		if (CKEDITOR.instances.board_content.getData().length > 2000) {
			alert("최대 2000자를 초과했습니다");
			return;
		}
		
		if (boardSubject == "") {
			alert("제목을 입력해주세요.");
			$("#board_subject").focus();
			return;
		}

		/*if (boardContent == "") {
			alert("내용을 입력해주세요.");
			$("#board_content").focus();
			return;
		}*/

		var yn = confirm("게시글을 등록하시겠습니까?");
		if (yn) {

			var filesChk = $("input[name='files[0]']").val();
			if (filesChk == "") {
				$("input[name='files[0]']").remove();
			}

			$("#boardForm").ajaxForm({

				url : "/board/insertBoard",
				enctype : "multipart/form-data",
				cache : false,
				async : true,
				type : "POST",
				success : function(obj) {
					insertBoardCallback(obj);
				},
				error : function(xhr, status, error) {
				}

			}).submit();
		}
	}

	/** 게시판 - 작성 콜백 함수 */
	function insertBoardCallback(obj) {

		if (obj != null) {

			var result = obj.result;

			if (result == "SUCCESS") {
				alert("게시글 등록을 성공하였습니다.");
				goBoardList();
			} else {
				alert("게시글 등록을 실패하였습니다.");
				return;
			}
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
	<div class="container">
		<div class="row">
			<div class="col-lg-8 col-md-10 mx-auto">
				<div id="wrap">
					<div id="container">
						<div class="inner">
							<h1 style="font-size: 20px; font-weight: bold; color: #4646CD">
								게시글 작성</h1>
						</div>
						<hr>
						<form align="center" id="boardForm" name="boardForm"
							action="/board/insertBoard" enctype="multipart/form-data"
							method="post" onsubmit="return false;">						
							<table width="100%" class="table02">
								<colgroup>
									<col width="20%">
									<col width="*">
								</colgroup>
								<tbody id="tbody">
									<div class="mb-3">
									<tr>
										<th style="font-size: 16px; margin-left: 450px">제목<span
											class="t_red" style="color: #ff00ff">*</span></th>
										<td><input onkeyup="chkword(this, 20)"
											style="width: 600px; height: 45px" class="form-control"
											id="board_subject" name="board_subject" value=""
											placeholder="제목을 입력해주세요" /></td>
									</tr>
									</div>
									<div class="mb-3">
									<tr>
										<th style="font-size: 16px; margin-left: 450px">작성자</th>
										<td><input class="form-control" type="hidden" name="board_writer" value="${member.userId}">${member.userId}</td>
									</tr>
									</div>
									<tr>
										<th>내용<span class="t_red" style="color: #ff00ff">*</span></th>
							<td><textarea style="width: 600px; height: 100px"  id="board_content" name="board_content" cols="10" rows="5"></textarea></td>
									</tr>
					
							
								<script>
										CKEDITOR.replace('board_content',{	
											filebrowserUploadUrl : '/fileUpload.do'
														});
									</script> 
									<div class="mb-3">
									<tr>
										<th scope="row">첨부파일</th>
										<td><input type="file" id="files[0]" name="files[0]" value=""></td>								
									</tr>
									</div>
								</tbody>
							</table>
						</form>
						<div align="center"
							style="margin-top: 15px">
							<button type="button" class="btn btn-sm btn-lg"
								style="background-color: #4646CD; font-size: 15px; color: #ffffff; margin-left: 60px; height: 50px; width: 70px; font-weight: bold"
								onclick="javascript:goBoardList();">목록</button>
								<c:if test="${member == null}">
						<a href="javascript:window.alert('로그인이 필요한 서비스입니다')">
							<button type="button" class="btn btn-sm btn-lg"
								style="background-color: #4646CD; font-size: 15px; color: #ffffff; height: 50px; width: 70px; font-weight: bold"
								onclick="javascript:insertBoard();">작성</button></a>
								</c:if>
									<c:if test="${member != null}">
							<button type="button" class="btn btn-sm btn-lg"
								style="background-color: #4646CD; font-size: 15px; color: #ffffff; height: 50px; width: 70px; font-weight: bold"
								onclick="javascript:insertBoard();">작성</button>
								</c:if>
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
</body>
</html>