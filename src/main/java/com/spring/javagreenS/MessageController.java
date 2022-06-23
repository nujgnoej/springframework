package com.spring.javagreenS;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MessageController {

	@RequestMapping(value="/msg/{msgFlag}", method=RequestMethod.GET)
	public String msgGet(@PathVariable String msgFlag, Model model,
			@RequestParam(value="flag", defaultValue = "", required=false) String flag,
			@RequestParam(value="name", defaultValue = "", required=false) String name,
			@RequestParam(value="mid", defaultValue = "", required=false) String mid,
			@RequestParam(value="idx", defaultValue = "0", required=false) int idx) {
		
		if(msgFlag.equals("guestInputOk")) {
			model.addAttribute("msg", "방명록에 글이 등록 되었습니다.");
			model.addAttribute("url", "guest/guestList");
		}
		else if(msgFlag.equals("memberLogout")) {
			model.addAttribute("msg", name + "님 로그아웃 되었습니다.");
			model.addAttribute("url", "member/memberLogin");
		}
		else if(msgFlag.equals("operatorCheckNo")) {
			model.addAttribute("msg", "아이디가 중복되었습니다. 다시 입력하세요.");
			model.addAttribute("url", "study/password2/operatorMenu");
		}
		else if(msgFlag.equals("operatorInputOk")) {
			model.addAttribute("msg", "새로운 운영자로 등록되었습니다.");
			model.addAttribute("url", "study/password2/operatorMenu");
		}
		else if(msgFlag.equals("productInputOk")) {
			model.addAttribute("msg", "상품이 등록되었습니다.");
			model.addAttribute("url", "shop/input/productMenu");
		}
		else if(msgFlag.equals("mailSendOk")) {
			model.addAttribute("msg", "메일이 전송되었습니다.");
			model.addAttribute("url", "study/mail/mailForm");
		}
		else if(msgFlag.equals("memIdCheckNo")) {
			model.addAttribute("msg", "아이디가 중복되었습니다. 체크하세요.");
			model.addAttribute("url", "member/memJoin");
		}
		else if(msgFlag.equals("memNickCheckNo")) {
			model.addAttribute("msg", "닉네임이 중복되었습니다. 체크하세요.");
			model.addAttribute("url", "member/memJoin");
		}
		else if(msgFlag.equals("memNickCheckNo2")) {
			model.addAttribute("msg", "닉네임이 중복되었습니다. 체크하세요.");
			model.addAttribute("url", "member/memPwdCheck");
		}
		else if(msgFlag.equals("memInputOk")) {
			model.addAttribute("msg", "회원 가입되었습니다.");
			model.addAttribute("url", "member/memLogin");
		}
		else if(msgFlag.equals("memInputNo")) {
			model.addAttribute("msg", "회원 가입 실패~~");
			model.addAttribute("url", "member/memJoin");
		}
		else if(msgFlag.equals("fileUploadOk")) {
			model.addAttribute("msg", "파일이 업로드 되었습니다.");
			model.addAttribute("url", "study/fileUpload/fileUpload");
		}
		else if(msgFlag.equals("fileUploadNo")) {
			model.addAttribute("msg", "파일이 업로드 실패~~");
			model.addAttribute("url", "study/fileUpload/fileUpload");
		}
		else if(msgFlag.equals("memLoginOk")) {
			model.addAttribute("msg", mid+"님 로그인 되셨습니다.");
			model.addAttribute("url", "member/memMain");
		}
		else if(msgFlag.equals("memLoginNo")) {
			model.addAttribute("msg", "로그인 실패~~~");
			model.addAttribute("url", "member/memLogin");
		}
		else if(msgFlag.equals("memLogout")) {
			model.addAttribute("msg", mid+"님 로그아웃 되셨습니다.");
			model.addAttribute("url", "member/memLogin");
		}
		else if(msgFlag.equals("levelMemberNo")) {
			model.addAttribute("msg", "로그인후 사용하세요.");
			model.addAttribute("url", "member/memLogin");
		}
		else if(msgFlag.equals("levelMemberNo")) {
			model.addAttribute("msg", "로그인후 사용하세요.");
			model.addAttribute("url", "member/memLogin");
		}
		else if(msgFlag.equals("levelConfirmNo")) {
			model.addAttribute("msg", "현재 등급으로는 사용하실수 없습니다.");
			model.addAttribute("url", "member/memMain");
		}
		else if(msgFlag.equals("memPwdCheckNo")) {
			model.addAttribute("msg", "비밀번호를 확인하세요.");
			model.addAttribute("url", "member/memPwdCheck");
		}
		else if(msgFlag.equals("memUpdateOk")) {
			model.addAttribute("msg", "회원정보가 수정되었습니다.");
			model.addAttribute("url", "member/memPwdCheck");
		}
		else if(msgFlag.equals("memUpdateNo")) {
			model.addAttribute("msg", "회원정보 수정 실패~~");
			model.addAttribute("url", "member/memPwdCheck");
		}
		else if(msgFlag.equals("memDeleteOk")) {
			model.addAttribute("msg", mid + "회원님! 탕퇴 되셨습니다.\\n같은 아이디로 1개월동안 다시 가입하실 수 없습니다.");
			model.addAttribute("url", "");
		}
		else if(msgFlag.equals("memIdPwdSearchOk")) {
			model.addAttribute("msg", "신규비밀번호가 이메일로 전송되었습니다.");
			model.addAttribute("url", "member/memLogin");
		}
		else if(msgFlag.equals("memIdPwdSearchNo")) {
			model.addAttribute("msg", "입력하신 정보를 확인해 주세요.");
			model.addAttribute("url", "member/memLogin");
		}
		else if(msgFlag.equals("boardInputOk")) {
			model.addAttribute("msg", "게시글이 등록되었습니다.");
			model.addAttribute("url", "board/boList");
		}
		else if(msgFlag.equals("boardDeleteOk")) {
			model.addAttribute("msg", "게시글이 삭제되었습니다.");
			model.addAttribute("url", "board/boList"+flag);
		}
		else if(msgFlag.equals("boUpdateOk")) {
			model.addAttribute("msg", "게시글이 수정되었습니다.");
			model.addAttribute("url", "board/boList"+flag);
		}
		
		return "include/message";
	}
	
}
