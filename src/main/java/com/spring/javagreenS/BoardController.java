package com.spring.javagreenS;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.javagreenS.pagination.PageProcess;
import com.spring.javagreenS.pagination.PageVO;
import com.spring.javagreenS.service.BoardService;
import com.spring.javagreenS.service.MemberService;
import com.spring.javagreenS.vo.BoardVO;
import com.spring.javagreenS.vo.MemberVO;

@Controller
@RequestMapping("/board")
public class BoardController {
	
	@Autowired
	BoardService boardService;
	
	@Autowired
	PageProcess pageProcess;
	
	@Autowired
	MemberService memberService;
	
	@RequestMapping(value = "/boList", method = RequestMethod.GET)
	public String boListGet(
			@RequestParam(name = "pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name = "pageSize", defaultValue = "5", required = false) int pageSize,
			Model model) {
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "board", "", "");
		List<BoardVO> vos = boardService.getBoardList(pageVO.getStartIndexNo(), pageSize);
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		
		return "board/boList";
	}
	
	@RequestMapping(value = "/boInput", method = RequestMethod.GET)
	public String boInputGet(Model model, HttpSession session) {
		String mid = (String) session.getAttribute("sMid");
		MemberVO vo = memberService.getMemIdCheck(mid);
		
		model.addAttribute("vo", vo);
		
		return "board/boInput";
	}
	
	@RequestMapping(value = "/boInput", method = RequestMethod.POST)
	public String boInputPost(BoardVO vo) {
		// System.out.println("vo : " + vo);
		// 만약에 content에 이미지가 저장되어 있다면, 저장된 이미지만을 /resources/data/ckeditor/board/ 폴더에 저장시켜준다.
		boardService.imgCheck(vo.getContent());
		
		// 이미지 복사작업이 끝나면, board폴더에 실제로 저장된 파일명을 DB에 저장시켜준다.
		vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/ckeditor/board/"));
		boardService.setBoardInput(vo);
		
		return "redirect:/msg/boardInputOk";
	}
	
	@RequestMapping(value = "/boContent", method = RequestMethod.GET)
	public String boContentGet(int idx, int pag, int pageSize, Model model, HttpSession session) {
		// 조회수 증가
		ArrayList<String> contentIdx = (ArrayList) session.getAttribute("sContentIdx");
		if(contentIdx == null) contentIdx = new ArrayList<String>();
		
		String imsiContentIdx = "board" + idx;
		if(!contentIdx.contains(imsiContentIdx)) {
			boardService.setReadNum(idx);
			contentIdx.add(imsiContentIdx);
		}
		session.setAttribute("sContentIdx", contentIdx);
		
		// 원본글 가져오기
		BoardVO vo = boardService.getBoardContent(idx);
		
		// '이전/다음'글 가져오기
		ArrayList<BoardVO> pnVos = boardService.getPreNext(idx);
		int minIdx = boardService.getMinIdx();
		
		model.addAttribute("vo", vo);
		model.addAttribute("pnVos", pnVos);
		model.addAttribute("minIdx", minIdx);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		
		return "board/boContent";
	}
	
	@RequestMapping(value = "/boSearch", method = RequestMethod.POST)
	public String boSearchPost(
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "5", required = false) int pageSize,
			String search,
			String searchString,
			Model model) {
		pageSize = 100;
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "board", search, searchString);
//		System.out.println("pageVO : " + pageVO);
		List<BoardVO> vos = boardService.getBoardSearch(pageVO.getStartIndexNo(), pageSize, search, searchString);
		
		String searchTitle;
		if(search.equals("title")) searchTitle = "글제목";
		else if(search.equals("nickName")) searchTitle = "닉네임";
		else searchTitle = "글내용";
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		model.addAttribute("searchTitle", searchTitle);
		model.addAttribute("searchString", searchString);
		
		return "board/boSearch";
	}
}
