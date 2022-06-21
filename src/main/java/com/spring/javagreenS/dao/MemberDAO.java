package com.spring.javagreenS.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javagreenS.vo.MemberVO;

public interface MemberDAO {

	public MemberVO getMemIdCheck(@Param("mid") String mid);

	public MemberVO getNickNameCheck(@Param("nickName")  String nickName);

	public void setMemInputOk(@Param("vo") MemberVO vo);

	public void setMemberVisitProcess(@Param("mid") String mid, @Param("todayCnt") int todayCnt, @Param("newPoint") int newPoint);

	public ArrayList<MemberVO> getMemList();

	public void setMemUpdateOk(@Param("vo") MemberVO vo);

	public void setMemDeleteOk(@Param("mid") String mid);

	public void setPwdChange(@Param("mid") String mid, @Param("pwd") String pwd);

	public MemberVO getMemIdEmailCheck(@Param("mid") String mid, @Param("toMail") String toMail);

}
