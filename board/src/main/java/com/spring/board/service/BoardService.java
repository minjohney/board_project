package com.spring.board.service;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.spring.board.common.PagingUtil;
import com.spring.board.common.ResultUtil;
import com.spring.board.dao.BoardDao;
import com.spring.board.dto.BoardDto;
import com.spring.board.dto.CommonDto;
import com.spring.board.form.BoardFileForm;
import com.spring.board.form.BoardForm;
import com.spring.board.form.CommonForm;

@Service
public class BoardService {

	protected final Logger logger = LoggerFactory.getLogger(BoardService.class);

	@Autowired
	private BoardDao boardDao;

	/*1.게시글 목록을 조회합니다*/
	public ResultUtil getBoardList(BoardForm boardForm) throws Exception {

		ResultUtil resultUtil = new ResultUtil();

		CommonDto commonDto = new CommonDto();

		int totalCount = boardDao.getBoardCnt(boardForm);
		if (totalCount != 0) {
			CommonForm commonForm = new CommonForm();
			commonForm.setFunction_name(boardForm.getFunction_name());
			commonForm.setCurrent_page_no(boardForm.getCurrent_page_no());
			commonForm.setCount_per_page(10);
			commonForm.setCount_per_list(10);
			commonForm.setTatal_list_count(totalCount);
			commonDto = PagingUtil.setPageUtil(commonForm);
		}

		boardForm.setLimit(commonDto.getLimit());
		boardForm.setOffset(commonDto.getOffset());

		List<BoardDto> list = boardDao.getBoardList(boardForm);

		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("list", list);
		resultMap.put("totalCount", totalCount);
		resultMap.put("pagination", commonDto.getPagination());

		resultUtil.setData(resultMap);
		resultUtil.setState("SUCCESS");

		return resultUtil;
	}

	/*2.게시글 목록을 상세 조회합니다*/
	public BoardDto getBoardDetail(BoardForm boardForm) throws Exception {

		logger.debug("해당 게시글을 상세 조회합니다_@vinea");

		BoardDto boardDto = new BoardDto();

		String searchType = boardForm.getSearch_type();

		if ("S".equals(searchType)) {

			boardDao.updateBoardHits(boardForm);
		}

		boardDto = boardDao.getBoardDetail(boardForm);

		BoardFileForm boardFileForm = new BoardFileForm();
		boardFileForm.setB_num(boardForm.getB_num());

		boardDto.setFiles(boardDao.getBoardFileList(boardFileForm));

		logger.debug("해당 게시글 상세조회를 마치겠습니다_@vinea");

		return boardDto;
	}

	/*3.게시글을 작성합니다*/
	public BoardDto insertBoard(BoardForm boardForm) throws Exception {

		BoardDto boardDto = new BoardDto();

		int insertCnt = 0;


		insertCnt = boardDao.insertBoard(boardForm);

		/*첨부파일을 작성하기 위한 정의입니다*/
		List<BoardFileForm> boardFileList = getBoardFileInfo(boardForm);
		for (BoardFileForm boardFileForm : boardFileList) {
			boardDao.insertBoardFile(boardFileForm);
		}

		if (insertCnt > 0) {
			boardDto.setResult("SUCCESS");
		} else {
			boardDto.setResult("FAIL");
		}

		return boardDto;
	}

	/*4.첨부파일의 정보를 조회합니다*/
	public List<BoardFileForm> getBoardFileInfo(BoardForm boardForm) throws Exception {

		List<MultipartFile> files = boardForm.getFiles();

		List<BoardFileForm> boardFileList = new ArrayList<BoardFileForm>();

		BoardFileForm boardFileForm = new BoardFileForm();

		int b_num = boardForm.getB_num();
		String fileName = null;
		String fileExt = null;
		String fileNameKey = null;
		String fileSize = null;
		// 파일이 저장될 Path 설정
		String filePath = "C:\\board\\file";

		if (files != null && files.size() > 0) {

			File file = new File(filePath);

			// 디렉토리가 없으면 생성
			if (file.exists() == false) {
				file.mkdirs();
			}

			for (MultipartFile multipartFile : files) {

				fileName = multipartFile.getOriginalFilename();
				fileExt = fileName.substring(fileName.lastIndexOf("."));
				// 파일명 변경(uuid로 암호화) + 확장자
				fileNameKey = getRandomString() + fileExt;
				fileSize = String.valueOf(multipartFile.getSize());

				// 설정한 Path에 파일 저장
				file = new File(filePath + "/" + fileNameKey);

				multipartFile.transferTo(file);

				boardFileForm = new BoardFileForm();
				boardFileForm.setB_num(b_num);
				boardFileForm.setFile_name(fileName);
				boardFileForm.setFile_name_key(fileNameKey);
				boardFileForm.setFile_path(filePath);
				boardFileForm.setFile_size(fileSize);
				boardFileList.add(boardFileForm);
			}
		}

		return boardFileList;
	}

	/*5.게시글을 삭제합니다*/
	public BoardDto deleteBoard(BoardForm boardForm) throws Exception {
		
		logger.debug("게시글 삭제를 시도합니다_@vinea");

		BoardDto boardDto = new BoardDto();

		int deleteCnt = boardDao.deleteBoard(boardForm);

		if (deleteCnt > 0) {
			boardDto.setResult("SUCCESS");
		} else {
			boardDto.setResult("FAIL");
		}

		logger.debug("게시글 삭제를 시도합니다_@vinea");
		
		return boardDto;
	}

	/*6.게시글을 수정합니다*/
	public BoardDto updateBoard(BoardForm boardForm) throws Exception {

		logger.debug("게시글 수정을 시도합니다_@vinea");
		
		BoardDto boardDto = new BoardDto();

		int updateCnt = boardDao.updateBoard(boardForm);

		String deleteFile = boardForm.getDelete_file();
		if (!"".equals(deleteFile)) {

			String[] deleteFileInfo = deleteFile.split("!");

			int b_num = Integer.parseInt(deleteFileInfo[0]);
			int fileNo = Integer.parseInt(deleteFileInfo[1]);

			BoardFileForm deleteBoardFileForm = new BoardFileForm();
			deleteBoardFileForm.setB_num(b_num);
			deleteBoardFileForm.setFile_no(fileNo);

			boardDao.deleteBoardFile(deleteBoardFileForm);
		}

		List<BoardFileForm> boardFileList = getBoardFileInfo(boardForm);
		for (BoardFileForm boardFileForm : boardFileList) {
			boardDao.insertBoardFile(boardFileForm);
		}

		if (updateCnt > 0) {
			boardDto.setResult("SUCCESS");
		} else {
			boardDto.setResult("FAIL");
		}

		logger.debug("게시글 수정을 시도합니다_@vinea");
		
		return boardDto;
	}

	/*첨부파일 정보를 불러오기 위한 랜덤문자열 생성*/
	public static String getRandomString() {

		return UUID.randomUUID().toString().replaceAll("-", "");
	}
}
