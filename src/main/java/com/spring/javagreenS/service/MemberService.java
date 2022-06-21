package com.spring.javagreenS.service;

import java.util.ArrayList;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javagreenS.vo.MemberVO;

public interface MemberService {

	public MemberVO getMemIdCheck(String mid);

	public MemberVO getNickNameCheck(String nickName);

	public int setMemInputOk(MultipartFile fName, MemberVO vo);

	public void setMemberVisitProcess(MemberVO vo);

	public ArrayList<MemberVO> getMemList();

	public int setMemUpdateOk(MultipartFile fName, MemberVO vo);

	public void setMemDeleteOk(String mid);

	public void setPwdChange(String mid, String encode);

	public MemberVO getMemIdEmailCheck(String mid, String toMail);


}
