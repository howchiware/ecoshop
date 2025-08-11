package com.sp.app.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sp.app.admin.service.OrderStatusManageService;
import com.sp.app.common.PaginateUtil;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/admin/product/*")
public class ProductManageController {
	
	@GetMapping("deliveryInfo")
	public String handleDeliveryInfo(
			@RequestParam(name = "page", defaultValue = "1") int current_page,
			@RequestParam(name = "schType", defaultValue = "orderNum") String schType,
			@RequestParam(name = "kwd",defaultValue = "") String kwd,
			Model model,
			HttpServletRequest req) throws Exception {
		
		// 주문 현황
		// orderManage : 주문관리
		//    itemId : 100-주문완료(결제완료, 배송전부분취소), 110-배송관리, 120-주문전체리스트
		try {
			/*
			int size = 10;
			int total_page;
			int dataCount;
			
			kwd = URLDecoder.decode(kwd, "UTF-8");

			Map<String, Object> map = new HashMap<String, Object>();
			map.put("itemId", itemId);
			map.put("schType", schType);
			map.put("kwd", kwd);
			
			dataCount = service.orderCount(map);
			total_page = paginateUtil.pageCount(dataCount, size);

			current_page = Math.min(current_page, total_page);
			
			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;
			
			map.put("offset", offset);
			map.put("size", size);

			List<OrderManage> list = service.listOrder(map);
			
			String cp = req.getContextPath();
			String listUrl = cp + "/admin/order/orderManage/" + itemId;
			
			String query = "page=" + current_page;
			String qs = "";
			if (kwd.length() != 0) {
				qs = "schType=" + schType + "&kwd=" + URLEncoder.encode(kwd, "UTF-8");
				listUrl += "?" + qs;
				query += "&" + qs;
			}
			
			String paging = paginateUtil.pagingUrl(current_page, total_page, listUrl);
			
			String title = "주문 현황";
			if(itemId == 110) {
				title = "배송 현황";
			} else if(itemId == 120) {
				title = "주문 전체 리스트";
			}
			
			model.addAttribute("title", title);
			model.addAttribute("itemId", itemId);
			
			model.addAttribute("list", list);
			model.addAttribute("dataCount", dataCount);
			model.addAttribute("query", query);
			
			model.addAttribute("schType", schType);
			model.addAttribute("kwd", kwd);
			
			model.addAttribute("page", current_page);
			model.addAttribute("size", size);
			model.addAttribute("total_page", total_page);
			model.addAttribute("paging", paging);
			*/
		} catch (Exception e) {
			log.info("handleOrderManage : ", e);
		}

		return "admin/product/deliveryInfo";
	}
	
	@GetMapping("totalProductList")
	public String handleTotaLProductList(
			@RequestParam(name = "page", defaultValue = "1") int current_page,
			@RequestParam(name = "schType", defaultValue = "orderNum") String schType,
			@RequestParam(name = "kwd",defaultValue = "") String kwd,
			Model model,
			HttpServletRequest req) throws Exception {
		
		// 주문 현황
		// orderManage : 주문관리
		//    itemId : 100-주문완료(결제완료, 배송전부분취소), 110-배송관리, 120-주문전체리스트
		try {
			/*
			int size = 10;
			int total_page;
			int dataCount;
			
			kwd = URLDecoder.decode(kwd, "UTF-8");

			Map<String, Object> map = new HashMap<String, Object>();
			map.put("itemId", itemId);
			map.put("schType", schType);
			map.put("kwd", kwd);
			
			dataCount = service.orderCount(map);
			total_page = paginateUtil.pageCount(dataCount, size);

			current_page = Math.min(current_page, total_page);
			
			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;
			
			map.put("offset", offset);
			map.put("size", size);

			List<OrderManage> list = service.listOrder(map);
			
			String cp = req.getContextPath();
			String listUrl = cp + "/admin/order/orderManage/" + itemId;
			
			String query = "page=" + current_page;
			String qs = "";
			if (kwd.length() != 0) {
				qs = "schType=" + schType + "&kwd=" + URLEncoder.encode(kwd, "UTF-8");
				listUrl += "?" + qs;
				query += "&" + qs;
			}
			
			String paging = paginateUtil.pagingUrl(current_page, total_page, listUrl);
			
			String title = "주문 현황";
			if(itemId == 110) {
				title = "배송 현황";
			} else if(itemId == 120) {
				title = "주문 전체 리스트";
			}
			
			model.addAttribute("title", title);
			model.addAttribute("itemId", itemId);
			
			model.addAttribute("list", list);
			model.addAttribute("dataCount", dataCount);
			model.addAttribute("query", query);
			
			model.addAttribute("schType", schType);
			model.addAttribute("kwd", kwd);
			
			model.addAttribute("page", current_page);
			model.addAttribute("size", size);
			model.addAttribute("total_page", total_page);
			model.addAttribute("paging", paging);
			 */
		} catch (Exception e) {
			log.info("handleOrderManage : ", e);
		}
		
		return "admin/product/totalProductList";
	}
}
