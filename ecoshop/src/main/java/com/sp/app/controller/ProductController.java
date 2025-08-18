package com.sp.app.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sp.app.admin.model.CategoryManage;
import com.sp.app.admin.service.CategoryManageService;
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
		        List<Product> listProduct = productService.listProductByCategoryId(listCategory.get(0).getCategoryId());
		        model.addAttribute("listProduct", listProduct);
		    }
		} catch (Exception e) {
			log.error("productsList: ", e);
			throw e;
		}
		return "products/main";
	} 
	
	@GetMapping("products")
	public String productsByCategory(@RequestParam(value = "categoryId") long categoryId, Model model) throws Exception {
		try {
			List<Product> listProduct = productService.listProductByCategoryId(categoryId);
			model.addAttribute("listProduct", listProduct);
		} catch (Exception e) {
			log.error("productsByCategory : ", e);
			throw e;
		}
		
		return "products/listDetail";
	}

/*
	// AJAX - JSON
	@GetMapping("list")
	public Map<String, ?> list(
			@RequestParam(name = "categoryNum") long categoryNum,
			@RequestParam(name = "sortBy", defaultValue = "0") int sortBy,
			HttpSession session) throws Exception {
		
		Map<String, Object> model = new HashMap<String, Object>();
		
		
		return model;
	}
 */
	
	@GetMapping("{productId}")
	public String detailRequest(@PathVariable("productId") long productId,
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
