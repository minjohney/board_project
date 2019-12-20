package com.spring.board.dao;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.spring.board.dto.BoardDto;
import com.spring.board.dto.BoardFileDto;
import com.spring.board.form.BoardFileForm;
import com.spring.board.form.BoardForm;

@Repository
public class BoardDao {

	@Resource(name = "sqlSession")
	private SqlSession sqlSession;

	private static final String NAMESPACE = "com.spring.board.boardMapper";

	/*게시글 목록 수*/
	public int getBoardCnt(BoardForm boardForm) throws Exception {

		return sqlSession.selectOne(NAMESPACE + ".getBoardCnt", boardForm);
	}

	/*비네아_게시글 목록 조회*/
	public List<BoardDto> getBoardList(BoardForm boardForm) throws Exception {

		return sqlSession.selectList(NAMESPACE + ".getBoardList", boardForm);
	}

	/*비네아_게시글 조회수를 업데이트 합니다*/
	public int updateBoardHits(BoardForm boardForm) throws Exception {

		return sqlSession.update(NAMESPACE + ".updateBoardHits", boardForm);
	}

	/*비네아_업로드 된 게시글의 제목을 클릭하면 그 글의 상세정보를 볼 수 있습니다*/
	public BoardDto getBoardDetail(BoardForm boardForm) throws Exception {

		return sqlSession.selectOne(NAMESPACE + ".getBoardDetail", boardForm);
	}
	
	/*비네아_첨부파일을 조회합니다*/
	public List<BoardFileDto> getBoardFileList(BoardFileForm boardFileForm) throws Exception {

		return sqlSession.selectList(NAMESPACE + ".getBoardFileList", boardFileForm);
	}

	public int getBoardReRef(BoardForm boardForm) throws Exception {

		return sqlSession.selectOne(NAMESPACE + ".getBoardReRef", boardForm);
	}
	
	/*비네아_게시글을 업로드할수 있습니다*/
	public int insertBoard(BoardForm boardForm) throws Exception {
		return sqlSession.insert(NAMESPACE + ".insertBoard", boardForm);
	}
	
	/*게시글 작성시, 첨부파일도 같이 업로드 합니다*/
	public int insertBoardFile(BoardFileForm boardFileForm) throws Exception {
		return sqlSession.insert(NAMESPACE + ".insertBoardFile", boardFileForm);
	}

	/* 등록에 실패한 경우에 log로 Fail문자를 날려줍니다*/
	public int insertBoardFail(BoardForm boardForm) throws Exception {
		return sqlSession.insert(NAMESPACE + ".insertBoardFail", boardForm);
	}

	/*비네아_게시글을 삭제합니다*/
	public int deleteBoard(BoardForm boardForm) throws Exception {

		return sqlSession.delete(NAMESPACE + ".deleteBoard", boardForm);
	}

	/*비네아_게시글을 삭제합니다*/
	public int updateBoard(BoardForm boardForm) throws Exception {

		return sqlSession.update(NAMESPACE + ".updateBoard", boardForm);
	}
	
	
	/*비네아_수정시에 첨부파일을 삭제할 수 있습니다*/
	public int deleteBoardFile(BoardFileForm boardFileForm) throws Exception {
		return sqlSession.update(NAMESPACE + ".deleteBoardFile", boardFileForm);
	}
	
}
