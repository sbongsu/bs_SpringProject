package com.sbs.exam.bsProject.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.sbs.exam.bsProject.intercepter.BeforeActionInterceptor;
import com.sbs.exam.bsProject.intercepter.NeedLoginInterceptor;
import com.sbs.exam.bsProject.intercepter.NeedLogoutInterceptor;

@Configuration
public class MyWebMvcConfigurer implements WebMvcConfigurer {
	// beforeActionInterceptor 인터셉터 불러오기
	@Autowired
	BeforeActionInterceptor beforeActionInterceptor;

	// needLoginInterceptor 인터셉터 불러오기
	@Autowired
	NeedLoginInterceptor needLoginInterceptor;
	
	// needLogoutInterceptor 인터셉터 불러오기
	@Autowired
	NeedLogoutInterceptor needLogoutInterceptor;
	
	// 이 함수는 인터셉터를 적용하는 역할을 합니다.
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		InterceptorRegistration ir;
		
		ir = registry.addInterceptor(beforeActionInterceptor);
		ir.addPathPatterns("/**");
		ir.excludePathPatterns("/resource/**");
		ir.excludePathPatterns("/error");
		
		ir = registry.addInterceptor(needLoginInterceptor);
		ir.addPathPatterns("/usr/member/showMyPage");
		ir.addPathPatterns("/usr/member/loginCheck");
		ir.addPathPatterns("/usr/member/doLoginCheck");
		ir.addPathPatterns("/usr/member/showModify");
		ir.addPathPatterns("/usr/member/doModify");
		ir.addPathPatterns("/usr/member/doLogout");
		ir.addPathPatterns("/usr/reply/doModifyReplyAjax");
		ir.addPathPatterns("/usr/reply/dowrite");
		ir.addPathPatterns("/usr/reply/doDeleteReplyAjax");
		ir.addPathPatterns("/usr/article/write");
		ir.addPathPatterns("/usr/article/dowrite");
		ir.addPathPatterns("/usr/article/modify");
		ir.addPathPatterns("/usr/article/write");
		ir.addPathPatterns("/usr/article/dowrite");
		ir.addPathPatterns("/usr/article/modify");
		ir.addPathPatterns("/usr/article/doModify");
		ir.addPathPatterns("/usr/article/doDelete");
		ir.addPathPatterns("/usr/reactionPoint/doGoodReaction");
		ir.addPathPatterns("/usr/reactionPoint/doBadReaction");
		ir.addPathPatterns("/usr/reactionPoint/doGoodDelReaction");
		ir.addPathPatterns("/usr/reactionPoint/doBadDelReaction");
		ir.addPathPatterns("/admin/article/doAdminDelete");
		
		ir = registry.addInterceptor(needLogoutInterceptor);
		ir.addPathPatterns("/usr/member/showJoin");
		ir.addPathPatterns("/usr/member/doJoin");
		ir.addPathPatterns("/usr/member/showLogin");
		ir.addPathPatterns("/usr/member/doLogin");
	}
}
