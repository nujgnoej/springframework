package com.spring.javagreenS.interceptor;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class MemberInterceptor extends HandlerInterceptorAdapter {
	@Override
  public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
  	HttpSession session = request.getSession();
  	int level = session.getAttribute("sLevel")==null ? 99 : (int) session.getAttribute("sLevel");
  	if(level > 4) { 	// 비회원들...
  		RequestDispatcher dispatcher = request.getRequestDispatcher("/msg/lelvelMemberNo");
  		dispatcher.forward(request, response);
  		return false;
  	}
  	
  	return true;
  }
}
