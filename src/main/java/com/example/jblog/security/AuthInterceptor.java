package com.example.jblog.security;

import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.example.jblog.vo.UserVo;

public class AuthInterceptor extends HandlerInterceptorAdapter{
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		// 1. 핸들러 종류 확인
		if(handler instanceof HandlerMethod == false) {
			return true;
		}
		
		// 2.핸들러를 핸들러 메소드로 casting
		HandlerMethod handlerMethod = (HandlerMethod)handler;
		
		// 3. Method에 붙어 있는 Auth를 받아오기
		Auth auth = handlerMethod.getMethodAnnotation(Auth.class);
		
		// 4. Method에 붙어있지 않으면, class에 @Auth를 받아오기
		if(auth == null) {
			auth = handlerMethod.getMethod().getDeclaringClass().getAnnotation(Auth.class);
		}
		
		// 5. Method와 Type에 @Auth가 없을때, return
		if(auth == null) {
			return true;
		}
		
		// 6. @Auth가 붙어 있다 인증여부
		HttpSession session = request.getSession();

		UserVo authUser = null;
		
		if(session!= null) {
			authUser = (UserVo)session.getAttribute("authUser");
		}
		
		// TODO  판별을 어떻게 할것인가???
		// url의 user ID와 세션의 user ID 비교 
		if(authUser == null) {
			/* 로그인이 되어있지 않으면 */
			response.sendRedirect(request.getContextPath()+"/user/login");
			
			/*System.out.println("패스 : "+request.getContextPath());
			System.out.println("uri : "+request.getRequestURI());
			System.out.println("url : "+request.getRequestURL());*/
			
			// contextPath : /jblog
			// uri : /jblog/blog/algml812/admin/basicsetting
			// url : http://localhost:8080/jblog/blog/algml812/admin/basicsetting
			
			
			return false;
		} else {
			/* 로그인이 되어있으면 */
			/* 세션의 아이디와 , url의 아이디 비교 */
			StringTokenizer st = new StringTokenizer(request.getRequestURI(), "/");
			
			String tokens[] = new String[10];
			int i = 0;
			
			while(st.hasMoreTokens()) {
				tokens[i] = st.nextToken();
				i++;
			}
			
			System.out.println(tokens[2]); // 유저 아이디
			
			if(!(authUser.getId().equals(tokens[2]))){
				response.sendRedirect(request.getContextPath()+"/user/warning");
				return false;
			}
		}
		return true;
	}
}
