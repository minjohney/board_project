<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>비네아 게시판 수정하기</title>
<%	
	String b_num = request.getParameter("b_num");		
%>

<c:set var="b_num" value="<%=b_num%>"/> <!-- 게시글 번호 -->

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
		getBoardDetail();		
	});
	
	/** 게시글 목록 페이지로 이동합니다 */
	function goBoardList(){				
		location.href = "/board/boardList";
	}
	
	/** 게시글 제목 클릭시 상세 조회합니다  */
	function getBoardDetail(b_num){
		
		var b_num = $("#b_num").val();

		if(b_num != ""){
			
			$.ajax({	
				
			    url		: "/board/getBoardDetail",
			    data    : $("#boardForm").serialize(),
		        dataType: "JSON",
		        cache   : false,
				async   : true,
				type	: "POST",	
		        success : function(obj) {
		        	getBoardDetailCallback(obj);				
		        },	       
		        error 	: function(xhr, status, error) {}
		        
		     });
			
		} else {
			alert("오류발생_@vinea");
		}	
	}
	
	/** 게시판 - 상세 조회  콜백 함수 */
	function getBoardDetailCallback(obj){
				
		if(obj != null){								
							
			var b_num		= obj.b_num; 
			var b_writer 	= obj.b_writer; 
			var b_title 	= obj.b_title; 
			var b_content 	= obj.b_content; 
			var b_count 		= obj.b_count;
			var delYn 			= obj.del_yn; 
			var b_id 		= obj.b_id;
			var b_date 		= obj.b_date; 
			var b_uid 		= obj.b_uid;
			var b_udate 		= obj.b_udate;
			var files			= obj.files;		
			var filesLen		= files.length;
								
			$("#b_title").val(b_title);			
			$("#b_content").val(b_content);
			$("#b_writer").text(b_writer);
			
			var fileStr = "";
			
			if(filesLen > 0){
				
				for(var a=0; a<filesLen; a++){
					
					
					var b_num	= files[a].b_num;
					var fileNo 		= files[a].file_no;
					var fileNameKey = files[a].file_name_key;
					var fileName 	= files[a].file_name;
					var filePath 	= files[a].file_path;
					var fileSize 	= files[a].file_size;
					var remark 		= files[a].remark;
					var delYn 		= files[a].del_yn;
					var b_id 	= files[a].b_id;
					var b_date 	= files[a].b_date;
					var b_uid 	= files[a].b_uid;
					var b_udate 	= files[a].b_udate;
					
					fileStr += "<a href='/board/fileDownload?fileNameKey="+encodeURI(fileNameKey)+"&fileName="+encodeURI(fileName)+"&filePath="+encodeURI(filePath)+"'>" + fileName + "</a>";
					fileStr += "<button type='button' class='btn black ml15' style='padding:3px 5px 6px 5px;' onclick='javascript:setDeleteFile("+ b_num +", "+ fileNo +")'>X</button>";
				}			
								
			} else {
				
				fileStr = "<input type='file' id='files[0]' name='files[0]' value=''></td>";
			}
			
			$("#file_td").html(fileStr);
			
		} else {			
			alert("작성된 글이 없습니다.");
			return;
		}		
	}
	
	/** 게시글을 수정합니다 **/
	function updateBoard(){

		var b_title = $("#b_title").val();
		var b_content = $("#b_content").val();
			
		if (b_title == ""){			
			alert("제목을 입력하지 않았습니다_@vinea");
			$("#b_title").focus();
			return;
		}
		
		if (b_content == ""){			
			alert("내용을 입력하지 않았습니다_@vinea");
			$("#b_content").focus();
			return;
		}
		
		var yn = confirm("게시글을 수정하겠습니까?");		
		if(yn){
				
			var filesChk = $("input[name='files[0]']").val();
			if(filesChk == ""){
				$("input[name='files[0]']").remove();
			}
			
			$("#boardForm").ajaxForm({
		    
				url		: "/board/updateBoard",
				enctype	: "multipart/form-data",
				cache   : false,
		        async   : true,
				type	: "POST",					 	
				success : function(obj) {
					updateBoardCallback(obj);				
			    },	       
			    error 	: function(xhr, status, error) {}
			    
		    }).submit();
		}
	}
	
	/** 게시판 - 수정 콜백 함수 */
	function updateBoardCallback(obj){
	
		if(obj != null){		
			
			var result = obj.result;
			
			if(result == "SUCCESS"){				
				alert("게시글 수정 성공_@vinea");				
				goBoardList();				 
			} else {				
				alert("게시글 수정 실패_@vinea");	
				return;
			}
		}
	}
	
	/** 게시판 - 삭제할 첨부파일 정보 */
	function setDeleteFile(b_num, fileSeq){
		
		var deleteFile = b_num + "!" + fileSeq;		
		$("#delete_file").val(deleteFile);
				
		var fileStr = "<input type='file' id='files[0]' name='files[0]' value=''>";		
		$("#file_td").html(fileStr);		
	}
		
</script>
</head>
<body>
<div id="wrap">
	<div id="container">
		<div class="inner">	
			<h2>vinea</h2>
			<form id="boardForm" name="boardForm" action="/board/updateBoard" enctype="multipart/form-data" method="post" onsubmit="return false;">	
				<table width="100%" class="table02">
				<caption><strong><span class="t_red">*</span> 표시는 필수입력 항목입니다.</strong></caption>
				    <colgroup>
				         <col width="20%">
				        <col width="*">
				    </colgroup>
				    <tbody id="tbody">
				       <tr>
							<th>제목<span class="t_red">*</span></th>
							<td><input id="b_title" maxlength="25"
									oninput="numberMaxLength(this);" name="b_title" value="" class="tbox01"/></td>
						</tr>
						 <tr>
							<th>작성자</th>
							<td id="board_writer"></td>
						</tr>
						<tr>
							<th>내용<span class="t_red">*</span></th>
							<td colspan="3"><textarea id="b_content" name="b_content" cols="50" rows="5" class="textarea01"></textarea></td>
						</tr>
						<tr>
							<th>첨부파일</th>
							<td colspan="3" id="file_td"><input type="file" id="files[0]" name="files[0]" value=""></td>
						</tr>
				    </tbody>
				</table>	
				<input type="hidden" id="b_num"		name="b_num"	value="${b_num}"/> <!-- 게시글 번호 -->
				<input type="hidden" id="search_type"	name="search_type"	value="U"/> <!-- 수정 -->
				<input type="hidden" id="delete_file"	name="delete_file"	value=""/> <!-- 삭제할 첨부파일 -->
			</form>
			<div class="btn_right mt15">
				<button type="button" class="btn black mr5" onclick="javascript:goBoardList();">목록</button>
				<button type="button" class="btn black" onclick="javascript:updateBoard();">업로드</button>
			</div>
		</div>
	</div>
</div>
</body>
</html>