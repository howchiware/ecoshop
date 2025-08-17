package com.sp.app.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sp.app.admin.model.CategoryManage;
import com.sp.app.admin.service.CategoryManageService;
import com.sp.app.model.GongguProduct;
import com.sp.app.model.Product;
import com.sp.app.service.ProductService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/products/*")
public class ProductController {

	private final CategoryManageService categoryManageService;
	private final ProductService productService;
	
	
	@GetMapping("main")
	public String productsList(Model model) throws Exception {
		try {
			List<CategoryManage> listCategory = categoryManageService.listCategory();
			model.addAttribute("listCategory", listCategory);

			if (! listCategory.isEmpty()) {
		        List<Product> list = productService.listProductByCategoryId(listCategory.get(0).getCategoryId());
		        model.addAttribute("list", list);
		       	}
		} catch (Exception e) {
			log.error("gongguList: ", e);
			throw e;
		}
		return "products/main";
	} 

	public String productsList() {
		return "products/main";
	} 
	
	// AJAX - JSON
	@GetMapping("list")
	public Map<String, ?> list(
			@RequestParam(name = "categoryNum") long categoryNum,
			@RequestParam(name = "sortBy", defaultValue = "0") int sortBy,
			HttpSession session) throws Exception {
		
		Map<String, Object> model = new HashMap<String, Object>();
		
		
		return model;
	}
	
	@GetMapping("{productNum}")
	public String detailRequest(@PathVariable("productNum") long productNum,
			HttpSession session, Model model) throws Exception{
		
		try {
			
			return "products/productInfo";
			
		} catch (NullPointerException e) {
		} catch (Exception e) {
			log.info("detailRequest : ", e);
		}
		
		return "redirect:/products/main";
	}
}
