<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<title>게시판 수정</title>
<%
	String boardSeq = request.getParameter("boardSeq");
%>


<!-- ckeditor 사용 servlet-context.xml에서 경로 설정 -->
<script src="${path}/ckeditor/ckeditor.js"></script>
<!-- 게시글 번호 -->
<c:set var="boardSeq" value="<%=boardSeq%>" />

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
<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
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
			alert(maxByte + "수를 초과했습니다");
			str2 = strValue.substr(0, len);
			obj.value = str2;
			chkword(obj, 4000);
		}
	}

	$(document).ready(function() {
		getBoardDetail();
	});
	$("#logoutBtn").on("click", function() {
		location.href = "/member/logout";
	});
	$("#registerBtn").on("click", function() {
		location.href = "/member/register";
	});
	$("#memberUpdateBtn").on("click", function() {
		location.href = "/member/memberUpdateView";
	});
	$("#memberDeleteBtn").on("click", function() {
		location.href = "/member/memberDeleteView";
	});

	/** 게시판 - 목록 페이지 이동 */
	function goBoardList() {
		location.href = "/board/boardList";
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

			$("#board_subject").val(boardSubject);
			$("#board_content").val(boardContent);
			$("#board_writer").text(boardWriter);

			var fileStr = "";

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

					fileStr += "<a href='/board/fileDownload?fileNameKey="
							+ encodeURI(fileNameKey) + "&fileName="
							+ encodeURI(fileName) + "&filePath="
							+ encodeURI(filePath) + "'>" + fileName + "</a>";
					fileStr += "<button type='button' class='btn black ml15' style='padding:3px 5px 6px 5px;' onclick='javascript:setDeleteFile("
							+ boardSeq + ", " + fileNo + ")'>X</button>";
				}

			} else {

				fileStr = "<input type='file' id='files[0]' name='files[0]' value=''></td>";
			}

			$("#file_td").html(fileStr);

		} else {
			alert("등록된 글이 존재하지 않습니다.");
			return;
		}
	}

	/** 게시판 - 수정  */
	function updateBoard() {

		var boardSubject = $("#board_subject").val();
		//var boardContent = $("#board_content").val();

		ck = CKEDITOR.instances.board_content.getData();

		alert(ck);

		if (CKEDITOR.instances.board_content.getData().length < 1) {
			alert("내용을 입력해주세요");
			return;
		}

		if (CKEDITOR.instances.board_content.getData().length > 1000) {
			alert("최대 1000자를 초과했습니다");
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

		var yn = confirm("게시글을 수정하시겠습니까?");
		if (yn) {

			var filesChk = $("input[name='files[0]']").val();
			if (filesChk == "") {
				$("input[name='files[0]']").remove();
			}

			$("#boardForm").ajaxForm({

				url : "/board/updateBoard",
				enctype : "multipart/form-data",
				cache : false,
				async : true,
				type : "POST",
				success : function(obj) {
					updateBoardCallback(obj);
				},
				error : function(xhr, status, error) {
				}

			}).submit();
		}
	}

	/** 게시판 - 수정 콜백 함수 */
	function updateBoardCallback(obj) {

		if (obj != null) {

			var result = obj.result;

			if (result == "SUCCESS") {
				alert("게시글 수정을 성공하였습니다.");
				goBoardList();
			} else {
				alert("게시글 수정을 실패하였습니다.");
				return;
			}
		}
	}

	/** 게시판 - 삭제할 첨부파일 정보 */
	function setDeleteFile(boardSeq, fileSeq){
		
		var deleteFile = boardSeq + "!" + fileSeq;		
		$("#delete_file").val(deleteFile);
				
		var fileStr = "<input type='file' id='files[0]' name='files[0]' value=''>";		
		$("#file_td").html(fileStr);		
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
	<div class="container">
		<div class="row">
			<div class="col-lg-8 col-md-10 mx-auto">
				<div id="wrap">
					<div id="container">
						<div class="inner">
							<h1 style="font-size: 20px; font-weight: bold; color: #4646CD">
								게시글 수정</h1>
							<hr>
							<form id="boardForm" name="boardForm" action="/board/updateBoard"
								enctype="multipart/form-data" method="post"
								onsubmit="return false;">
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
												<th style="font-size: 16px; margin-left: 450px"></th>
												<td><input class="form-control" type="hidden"
													name="board_writer" value="${member.userId}">${member.userId}</td>
											</tr>
										</div>
										<tr>
											<th style="font-size: 16px; margin-left: 450px">내용<span
												class="t_red" style="color: #ff00ff">*</span></th>
											<td><textarea style="width: 300px; height: 100px"
													class="form-control" id="board_content"
													name="board_content" cols="5" rows="10"></textarea></td>
										</tr>
										<script>
											CKEDITOR
													.replace(
															'board_content',
															{
																filebrowserUploadUrl : '/fileUpload.do'
															});
										</script>
										<div class="mb-3">
											<tr>
												<th style="font-size: 16px; margin-left: 450px" scope="row">첨부파일</th>
												<td colspan="3" id="file_td"><input type="file" id="files[0]" name="files[0]" value=""></td>
											</tr>
										</div>
									</tbody>
								</table>
								<input type="hidden" id="board_seq" name="board_seq"
									value="${boardSeq}" />
								<!-- 게시글 번호 -->
								<input type="hidden" id="search_type" name="search_type"
									value="U" />
								<!-- 조회 타입 - 상세(S)/수정(U) -->
								<input type="hidden" id="delete_file" name="delete_file"
									value="" />
								<!-- 삭제할 첨부파일 -->
							</form>
							<div align="center" style="margin-top: 15px">
								<button type="button" class="btn btn-sm btn-lg"
									style="background-color: #4646CD; color: #ffffff; margin-left: 60px; font-size: 15px; height: 50px; width: 70px; font-weight: bold"
									onclick="javascript:goBoardList();">목록</button>
									<c:if test="${member == null}">
						<a href="javascript:window.alert('로그인이 필요한 서비스입니다')">
								<button type="button" class="btn btn-sm btn-lg"
									style="background-color: #4646CD; color: #ffffff; font-size: 15px; height: 50px; width: 70px; font-weight: bold"
									onclick="javascript:updateBoard();">수정</button></a>
									</c:if>
											<c:if test="${member != null}">
								<button type="button" class="btn btn-sm btn-lg"
									style="background-color: #4646CD; color: #ffffff; font-size: 15px; height: 50px; width: 70px; font-weight: bold"
									onclick="javascript:updateBoard();">수정</button>
									</c:if>
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