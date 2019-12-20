package com.spring.board.common;

import com.spring.board.dto.CommonDto;
import com.spring.board.form.CommonForm;

/*페이징 처리를 위한 자바 클래스입니다*/
public class PagingUtil {

	public static CommonDto setPageUtil(CommonForm commonForm) {

		CommonDto commonDto = new CommonDto();

		String pagination = ""; //페이징 처리 된 결과값
		String functionName = commonForm.getFunction_name(); 
		int currentPage = commonForm.getCurrent_page_no(); 
		int countPerList = commonForm.getCount_per_list(); //한 화면에 출력될 게시물
		int countPerPage = commonForm.getCount_per_page(); //한 화면에 출력될 페이지
		int totalListCount = commonForm.getTatal_list_count(); 
		int totalPageCount = totalListCount / countPerList;
		
		//총 페이지 수는 int형으로 반환합니다
		if (totalListCount % countPerList > 0) { 
			totalPageCount = totalPageCount + 1;
		}

		int viewFirstPage = (((currentPage - 1) / countPerPage) * countPerPage) + 1; // 한 화면에 첫 페이지 번호
		int ViewLastPage = viewFirstPage + countPerPage - 1; // 한 화면에 마지막 페이지 번호
		if (ViewLastPage > totalPageCount) { // 마지막 페이지의 수가 총 페이지의 수보다 큰 경우는 게시물이 존재하지 않기 때문에 마지막 페이지의 수를 수정
			ViewLastPage = totalPageCount;
		}

		int totalFirstPage = 1; 
		int totalLastPage = totalPageCount; 
		//이전 화면에서의 첫 페이지 번호
		int prePerPage = 0; 
		if (viewFirstPage - countPerPage > 0) {
			prePerPage = viewFirstPage - countPerPage;
		} else {
			prePerPage = totalFirstPage;
		}
		//이후 화면에서의 첫번째 번호 
		int nextPerPage = 0;
		if (viewFirstPage + countPerPage < totalPageCount) {
			nextPerPage = viewFirstPage + countPerPage;
		} else {
			nextPerPage = totalPageCount;
		}

		// 페이징 처리 되는 navigation
		pagination += "<div class='pagination' align='center'>";
		pagination += "<a href='javascript:" + functionName + "(\"" + totalFirstPage + "\");' class=\"direction_left01\">[<<]</a>";
		pagination += "<a href='javascript:" + functionName + "(" + prePerPage + ");' class=\"direction_left01\">[<]</a>";
		for (int a = viewFirstPage; a <= ViewLastPage; a++) {
			if (a == currentPage) {
				pagination += "<a href='javascript:" + functionName + "(\"" + a + "\");' class='onpage'>[" + a + "]</a>";
			} else {
				pagination += "<a href='javascript:" + functionName + "(\"" + a + "\");'>[" + a + "]</a>";
			}
		}
		pagination += "<a href='javascript:" + functionName + "(" + nextPerPage + ");' class=\"direction_right01\">[>]</a>";
		pagination += "<a href='javascript:" + functionName + "(" + totalLastPage + ");' class=\"direction_right01\">[>>]</a>";
		pagination += "</div>";

		int offset = ((currentPage - 1) * countPerList); 

		// LIMIT는 가져올 row의 수, OFFSET은 몇 번째 row부터 가져올지를 결정
		commonDto.setLimit(countPerList);
		commonDto.setOffset(offset);
		commonDto.setPagination(pagination);

		return commonDto;
	}
}
