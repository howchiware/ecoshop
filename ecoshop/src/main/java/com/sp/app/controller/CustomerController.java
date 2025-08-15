package com.sp.app.controller;

import java.sql.SQLException;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/customer")
public class CustomerController {
	
	// private final CustomerService service;
	
	@GetMapping("list")
	public String customerPage(Model model, HttpSession session) throws SQLException {
	    
	    try {
			
		} catch (Exception e) {
		}

	    return "customer/main";
	}


}
