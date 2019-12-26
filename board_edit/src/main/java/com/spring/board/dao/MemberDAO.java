package com.spring.board.dao;

import org.apache.ibatis.session.SqlSession;

import com.spring.board.dto.MemberVO;

public interface MemberDAO {
	
	public void register(MemberVO vo) throws Exception;

	
	public  MemberVO  login(MemberVO vo) throws Exception;
	
	public void memberUpdate(MemberVO vo) throws Exception;
	
	public int passChk(MemberVO vo) throws Exception;
	
	public int idChk(MemberVO vo) throws Exception;
	
	public void memberDelete(MemberVO vo) throws Exception;
	

}
