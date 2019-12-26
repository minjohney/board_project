package com.spring.board.dao;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.spring.board.dto.MemberVO;

@Repository
public class MemberDAOImpl implements MemberDAO {

	@Inject
	SqlSession sql;

	@Override
	public void register(MemberVO vo) throws Exception {
		sql.insert("com.spring.board.memberMapper.register", vo);
	}

	@Override
	public MemberVO login(MemberVO vo) throws Exception {
		return sql.selectOne("com.spring.board.memberMapper.login", vo);
	}

	@Override
	public void memberUpdate(MemberVO vo) throws Exception {
		sql.update("com.spring.board.memberMapper.memberUpdate", vo);
	}

	@Override
	public int passChk(MemberVO vo) throws Exception {
		int result = sql.selectOne("com.spring.board.memberMapper.passChk", vo);
		return result;
	}

	@Override
	public int idChk(MemberVO vo) throws Exception {
		int result = sql.selectOne("com.spring.board.memberMapper.idChk", vo);
		return result;
	}

	@Override
	public void memberDelete(MemberVO vo) throws Exception {
		sql.delete("com.spring.board.memberMapper.memberDelete", vo);

	}
}
