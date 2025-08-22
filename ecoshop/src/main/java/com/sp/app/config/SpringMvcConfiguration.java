package com.sp.app.config;

import java.util.ArrayList;
import java.util.List;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.sp.app.interceptor.LoginCheckInterceptor;

@Configuration
public class SpringMvcConfiguration implements WebMvcConfigurer {

	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		List<String> excludePaths = new ArrayList<>();
		excludePaths.add("/");
		excludePaths.add("/dist/**");
		excludePaths.add("/uploads/**");
		excludePaths.add("/member/login");
		excludePaths.add("/member/logout");
		excludePaths.add("/member/account");
		excludePaths.add("/member/userIdCheck");
		excludePaths.add("/member/complete");
		excludePaths.add("/member/pwdFind");
		excludePaths.add("/products/**");
		excludePaths.add("/review/**");
		excludePaths.add("/inquiry/**");
		excludePaths.add("/gonggu/**");
		excludePaths.add("/event/**");
		excludePaths.add("/notice/**");
		excludePaths.add("/workshop/**");
		excludePaths.add("/challenge/**");
		excludePaths.add("/customer/**");
		excludePaths.add("/tipBoard/**");
		excludePaths.add("/free/dairyList");
		
		
		excludePaths.add("/favicon.ico");
		
		registry.addInterceptor(new LoginCheckInterceptor()).excludePathPatterns(excludePaths);
	}
}
