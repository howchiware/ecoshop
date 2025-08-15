package com.sp.app.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sp.app.admin.model.CategoryManage;
import com.sp.app.admin.service.CategoryManageService;
import com.sp.app.model.GongguProduct;
import com.sp.app.service.GongguService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/gonggu/*")
public class GongguController {

	private final CategoryManageService categoryManageService;
	private final GongguService gongguService;
	
	@GetMapping("list")
	public String gongguList(Model model) throws Exception {
		try {
			List<CategoryManage> listCategory = categoryManageService.listCategory();
			model.addAttribute("listCategory", listCategory);

			if (!listCategory.isEmpty()) {
		        List<GongguProduct> list = gongguService.listPackageByCategoryId(listCategory.get(0).getCategoryId());
		        model.addAttribute("list", list);
		       	}
		} catch (Exception e) {
			log.error("gongguList: ", e);
			throw e;
		}
		return "gonggu/list";
	} 
	
	@GetMapping("gongguProducts")
	public String productsByCategory(@RequestParam(value = "categoryId") long categoryId, Model model) throws Exception {
		try {
			List<GongguProduct> listGongguProduct = gongguService.listPackageByCategoryId(categoryId);
			model.addAttribute("listGongguProduct", listGongguProduct);
		} catch (Exception e) {
			log.error("gongguProductList : ", e);
			throw e;
		}
		
		return "gonggu/listDetail";
	}

}
