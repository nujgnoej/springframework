package com.spring.javagreenS;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.javagreenS.pagination.PageProcess;
import com.spring.javagreenS.pagination.PageVO;
import com.spring.javagreenS.service.GuestService;
import com.spring.javagreenS.vo.GuestVO;

@Controller
@RequestMapping("/guest")
public class GuestController {
	String msgFlag = "";
	
	@Autowired
	GuestService guestService;
	
	@Autowired
	PageProcess pageProcess;
	
	@RequestMapping(value = "/guestList", method = RequestMethod.GET)
	public String gusetListGet(Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "3", required = false) int pageSize) {
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "guest", "", "");
		ArrayList<GuestVO> vos = guestService.getGuestList(pageVO.getStartIndexNo(), pageSize);
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		
		return "guest/guestList";
	}
	
	@RequestMapping(value = "/guestInput", method = RequestMethod.GET)
	public String guestInputGet() {
		return "guest/guestInput";
	}
	
	@RequestMapping(value = "/guestInput", method = RequestMethod.POST)
	public String guestInputPost(GuestVO vo) {
		guestService.setGuestInput(vo);
		
		return "redirect:/msg/guestInputOk";
	}
}
