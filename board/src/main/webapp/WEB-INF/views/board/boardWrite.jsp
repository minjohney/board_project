<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시판 작성</title>

<!-- 공통 CSS -->
<link rel="stylesheet" type="text/css" href="/css/common/common.css"/>

<!-- 공통 JavaScript -->
<script type="text/javascript" src="/js/common/jquery.js"></script>
<script type="text/javascript" src="/js/common/jquery.form.js"></script>
<script type="text/javascript">
function numberMaxLength(e) {
	if (e.value.length > e.maxlength) {
		e.value = e.value.slice(0, e.maxlength);
		alert("제목 글자수를 초과하였습니다");
	}
}
	
	$(document).ready(function(){		
		
	});
		
	/** 게시글 목록 페이지로 이동합니다 */
	function goBoardList(){				
		location.href = "/board/boardList";
	}
	
	/** 게시글을 작성합니다  */
	function insertBoard(){

		var b_title = $("#b_title").val();
		var b_content = $("#b_content").val();
			
		if (b_title == ""){			
			alert("제목을 입력해주세요.");
			$("#b_title").focus();
			return;
		}
		
		if (b_content == ""){			
			alert("내용을 입력해주세요.");
			$("#b_content").focus();
			return;
		}
			
		var yn = confirm("게시글을 등록하시겠습니까?");		
		if(yn){
				
			var filesChk = $("input[name='files[0]']").val();
			if(filesChk == ""){
				$("input[name='files[0]']").remove();
			}
			
			$("#boardForm").ajaxForm({
		    
				url		: "/board/insertBoard",
				enctype	: "multipart/form-data",
				cache   : false,
		        async   : true,
				type	: "POST",					 	
				success : function(obj) {
			    	insertBoardCallback(obj);				
			    },	       
			    error 	: function(xhr, status, error) {}
			    
		    }).submit();			 
		}
	}
	
	/** JSON 기반이므로 콜백함수를 정의합니다 */
	function insertBoardCallback(obj){
	
		if(obj != null){		
			
			var result = obj.result;
			
			if(result == "SUCCESS"){				
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
<div id="wrap">
	<div id="container">
		<div class="inner">		
			<h2>vinea</h2>
			<form id="boardForm" name="boardForm" action="/board/insertBoard" enctype="multipart/form-data" method="post" onsubmit="return false;">
				<table width="100%" class="table02">
				<caption><strong><span class="t_red">*</span> 표시는 필수입력 항목입니다.</strong></caption>
				    <colgroup>
				        <col width="20%">
				        <col width="*">
				    </colgroup>
				    <tbody id="tbody">
						<tr>
							<th>제목<span class="t_red">*</span></th>
							<td><input id="b_title"  maxlength="25"
									oninput="numberMaxLength(this);" name="v" value="" class="tbox01"/></td>
						</tr>
						 <tr>
							<th>작성자</th>
							<td id="b_writer"></td>
						</tr>
						<tr>
							<th>내용<span class="t_red">*</span></th>
							<td><textarea id="b_content" name="b_content" cols="10" rows="5" class="textarea01"></textarea></td>
						</tr>
						<tr>
							<th scope="row">첨부파일</th>
							<td><input type="file" id="files[0]" name="files[0]" value=""></td>
						</tr>
				    </tbody>
				</table>
			</form>
			<div class="btn_right mt15">
				<button type="button" class="btn black mr5" onclick="javascript:goBoardList();">목록</button>
				<button type="button" class="btn black" onclick="javascript:insertBoard();">업로드</button>
			</div>
		</div>
	</div>
</div>
</body>
</html>