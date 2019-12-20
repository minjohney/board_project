<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>비네아 게시글 목록보기</title>

<!-- 공통 CSS -->
<link rel="stylesheet" type="text/css" href="/css/common/common.css"/>

<!-- 공통 JavaScript -->
<script type="text/javascript" src="/js/common/jquery.js"></script>
<script type="text/javascript">

	$(document).ready(function(){	
		getBoardList();
	});		
	
	/** 게시글 상세 페이지로 이동합니다 */
	function goBoardDetail(b_num){				
		location.href = "/board/boardDetail?b_num="+ b_num;
	}
	
	/** 게시글 작성 페이지로 이동합니다 */
	function goBoardWrite(){		
		location.href = "/board/boardWrite";
	}

	/** 게시글 목록을 조회합니다  */
	function getBoardList(currentPageNo){
				
		if(currentPageNo === undefined){
			currentPageNo = "1";
		}
		
		$("#current_page_no").val(currentPageNo);
		
		$.ajax({	
		
		    url		:"/board/getBoardList",
		    data    : $("#boardForm").serialize(),
	        dataType:"JSON",
	        cache   : false,
			async   : true,
			type	:"POST",	
	        success : function(obj) {
				getBoardListCallback(obj);				
	        },	       
	        error 	: function(xhr, status, error) {}
	        
	     });
	}
	
	/**게시글 목록을 조회하기 위한 콜백함수 입니다_JSON 사용 */
	function getBoardListCallback(obj){

		var state = obj.state;
		
		if(state == "SUCCESS"){
			
			var data = obj.data;			
			var list = data.list;
			var listLen = list.length;		
			var totalCount = data.totalCount;
			var pagination = data.pagination;
				
			var str = "";
			
			if(listLen >  0){
				
				for(var a=0; a<listLen; a++){
					
					var b_num		= list[a].b_num; 
					var b_writer 	= list[a].b_writer; 
					var b_title 	= list[a].b_title; 
					var b_content 	= list[a].b_content; 
					var b_count 		= list[a].b_count;
					var delYn 			= list[a].del_yn; 
					var b_id 		= list[a].b_id;
					var b_date 		= list[a].b_date; 
					var b_uid 		= list[a].b_uid;
					var b_udate 		= list[a].b_udate;
					
					str += "<tr>";
					str += "<td>"+ b_num +"</td>";
										
					str += "<td onclick='javascript:goBoardDetail("+ b_num +");' style='cursor:Pointer'>";
					
					str += b_title +"</td>";
										
					str += "<td>"+ b_count +"</td>";
					str += "<td>"+ b_writer +"</td>";	
					str += "<td>"+ b_date +"</td>";	
					str += "</tr>";
					
				} 
				
			} else {
				
				str += "<tr>";
				str += "<td colspan='5'>작성된 글이 없습니다.</td>";
				str += "<tr>";
			}
			
			$("#tbody").html(str);
			$("#total_count").text(totalCount);
			$("#pagination").html(pagination);
			
		} else {
			alert("오류발생_@vinea");
			return;
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
				<input type="hidden" id="function_name" name="function_name" value="getBoardList" />
				<input type="hidden" id="current_page_no" name="current_page_no" value="1" />
				
				<div class="page_info">
					<span class="total_count"><strong>전체</strong> : <span id="total_count" class="t_red">0</span>개</span>
				</div>
			
				<table width="100%" class="table01">
					<colgroup>
						<col width="10%" />
						<col width="25%" />
						<col width="10%" />
						<col width="15%" />
						<col width="20%" />
					</colgroup>
					<thead>		
						<tr>
							<th>No.</th>
							<th>글 제목</th>
							<th>조회수</th>
							<th>글 작성자</th>
							<th>글 작성일</th>
						</tr>
					</thead>
					<tbody id="tbody">
					
					</tbody>	
				</table>
			</form>			
			<div class="btn_right mt15">
				<button type="button" class="btn black mr5" onclick="javascript:goBoardWrite();">글쓰기</button>
			</div>
		</div>
		
		<div id="pagination"></div>
			
	</div>
</div>
</body>
</html>