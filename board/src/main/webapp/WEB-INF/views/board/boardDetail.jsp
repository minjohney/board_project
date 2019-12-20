<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>비네아 게시판 상세보기</title>
<%	
	String b_num = request.getParameter("b_num");		
%>

<c:set var="b_num" value="<%=b_num%>"/> <!-- 게시글 번호 -->

<!-- 공통 CSS -->
<link rel="stylesheet" type="text/css" href="/css/common/common.css"/>

<!-- 공통 JavaScript -->
<script type="text/javascript" src="/js/common/jquery.js"></script>
<script type="text/javascript">
	
	$(document).ready(function(){		
		getBoardDetail();		
	});
	
	/** 게시글 목록 페이지로 이동합니다 */
	function goBoardList(){				
		location.href = "/board/boardList";
	}
	
	/** 게시글 정보를 수정합니다 */
	function goBoardUpdate(){
		
		var b_num = $("#b_num").val();
		
		location.href = "/board/boardUpdate?b_num="+ b_num;
	}
	
	/** 게시글 작성시 첨부파일을 다운로드 합니다 */
	function fileDownload(fileNameKey, fileName, filePath){
			
		location.href = "/board/fileDownload?fileNameKey="+fileNameKey+"&fileName="+fileName+"&filePath="+filePath;
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
	
	/** 상세 조회시 콜백되는 함수 정의입니다 */
	function getBoardDetailCallback(obj){
		
		var str = "";
		
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
						
			str += "<tr>";
			str += "<th>제목</th>";
			str += "<td>"+ b_title +"</td>";
			str += "<th>작성일시</th>";
			str += "<td>"+ b_date +"</td>";
			str += "</tr>";		
			str += "<tr>";
			str += "<th>작성자</th>";
			str += "<td colspan='3'>"+ b_writer +"</td>";
			str += "</tr>";		
			str += "<tr>";
			str += "<th>내용</th>";
			str += "<td colspan='3'>"+ b_content +"</td>";
			str += "</tr>";
			
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
					
					str += "<th>첨부파일</th>";
					//str += "<td onclick='javascript:fileDownload(\"" + fileNameKey + "\", \"" + fileName + "\", \"" + filePath + "\");' style='cursor:Pointer'>"+ fileName +"</td>";
					str += "<td colspan='3'><a href='/board/fileDownload?fileNameKey="+encodeURI(fileNameKey)+"&fileName="+encodeURI(fileName)+"&filePath="+encodeURI(filePath)+"'>" + fileName + "</a></td>";
					str += "</tr>";
				}	
			}			
			
		} else {
			
			alert("작성된 글이 없습니다");
			return;
		}		
		
		$("#tbody").html(str);
	}
	
	/** 게시판 - 삭제  */
	function deleteBoard(){

		var b_num = $("#b_num").val();
		
		var yn = confirm("게시글을 삭제하시겠습니까?");		
		if(yn){
			
			$.ajax({	
				
			    url		: "/board/deleteBoard",
			    data    : $("#boardForm").serialize(),
		        dataType: "JSON",
		        cache   : false,
				async   : true,
				type	: "POST",	
		        success : function(obj) {
		        	deleteBoardCallback(obj);				
		        },	       
		        error 	: function(xhr, status, error) {}
		        
		     });
		}		
	}
	
	/** 게시판 - 삭제 콜백 함수 */
	function deleteBoardCallback(obj){
	
		if(obj != null){		
			
			var result = obj.result;
			
			if(result == "SUCCESS"){				
				alert("삭제 성공_@vinea");				
				goBoardList();				
			} else {				
				alert("삭제 실패_@vinea");	
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
				<input type="hidden" id="b_num"		name="b_num"	value="${b_num}"/> <!-- 게시글 번호 -->
				<input type="hidden" id="search_type"	name="search_type" 	value="S"/> <!-- 상세 조회 -->
			</form>
			<div class="btn_right mt15">
				<button type="button" class="btn black mr5" onclick="javascript:goBoardList();">목록</button>
				<button type="button" class="btn black mr5" onclick="javascript:goBoardUpdate();">수정</button>
				<button type="button" class="btn black" onclick="javascript:deleteBoard();">삭제</button>
			</div>
		</div>
	</div>
</div>
</body>
</html>