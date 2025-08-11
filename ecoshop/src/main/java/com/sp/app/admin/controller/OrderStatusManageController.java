package com.sp.app.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
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
@RequestMapping("/admin/order/*")
public class OrderStatusManageController {
	private final OrderStatusManageService service;
	private final PaginateUtil paginateUtil;
	
	@GetMapping("orderManage")
	public String handleOrderManage(
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

		return "admin/orderStatus/orderManage";
	}
	
	@GetMapping("orderManage/{orderNum}")
	public String handelOrderDetails(
			@PathVariable("itemId") int itemId,
			@PathVariable("orderNum") String orderNum,
			@RequestParam(name = "page") String page,
			@RequestParam(name = "schType", defaultValue = "orderNum") String schType,
			@RequestParam(name = "kwd", defaultValue = "") String kwd,		
			Model model) throws Exception {
		
		// 주문번호에 대한 주문상세 리스트
		String query = "page=" + page;
		try {
			/*
			kwd = URLDecoder.decode(kwd, "utf-8");

			if (! kwd.isBlank()) {
				query += "&schType=" + schType + "&kwd=" + URLEncoder.encode(kwd, "UTF-8");
			}
			
			// 주문 정보
			OrderManage order = Objects.requireNonNull(service.findByOrderId(orderNum));
			
			// 주문 정보의 상세 리스트 
			List<OrderDetailManage> listDetail = service.listOrderDetails(orderNum);

			// 배송 회사
			List<Map<String, Object>> listDeliveryCompany = service.listDeliveryCompany();
			
			// 배송지
			OrderManage delivery = service.findByDeliveryId(orderNum);
			
			model.addAttribute("itemId", itemId);
			model.addAttribute("order", order);
			model.addAttribute("listDetail", listDetail);
			model.addAttribute("listDeliveryCompany", listDeliveryCompany);
			model.addAttribute("delivery", delivery);

			model.addAttribute("query", query);
			model.addAttribute("page", page);
			*/
			return "admin/orderStatus/orderDetail";
			
		} catch (NullPointerException e) {
		} catch (Exception e) {
			log.info("handelOrderDetails : ", e);
		}
		
		return "redirect:/admin/order/orderManage/" + query;
	}
	
	@GetMapping("detailManage")
	public String handleDetailManageList(
			@RequestParam(name = "page", defaultValue = "1") int current_page,
			@RequestParam(name = "schType", defaultValue = "orderNum") String schType,
			@RequestParam(name = "kwd",defaultValue = "") String kwd,
			Model model,
			HttpServletRequest req) throws Exception {
		// 주문 상세 리스트
		
		// orderDetailManage-주문상세관리
		//    itemId : 100-배송후교환, 110-구매확정,
		//            200-배송전환불, 210-배송후반품, 220-판매취소, 230-취소전체리스트
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
			
			dataCount = service.detailCount(map);
			total_page = paginateUtil.pageCount(dataCount, size);

			current_page = Math.min(current_page, total_page);
			
			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;
			
			map.put("offset", offset);
			map.put("size", size);

			List<OrderDetailManage> list = service.listDetails(map);
			
			String cp = req.getContextPath();
			String listUrl = cp + "/admin/order/detailManage/" + itemId;
			
			String query = "page=" + current_page;
			String qs = "";
			if (kwd.length() != 0) {
				qs = "schType=" + schType + "&kwd=" + URLEncoder.encode(kwd, "UTF-8");
				
				listUrl += "?" + qs;
				query += "&" + qs;
			}
			
			String paging = paginateUtil.pagingUrl(current_page, total_page, listUrl);
			
			String title = "구매확정 현황";
			if(itemId == 100) {
				title = "배송후 교환 현황";
			} else if(itemId == 200) {
				title = "배송전 환불 현황";
			} else if(itemId == 210) {
				title = "배송후 반품 현황";
			} else if(itemId == 220) {
				title = "판매취소 현황";
			} else if(itemId == 230) {
				title = "취소 전체 리스트";
			}
			
			model.addAttribute("title", title);
			model.addAttribute("itemId", itemId);
			
			model.addAttribute("list", list);
			model.addAttribute("dataCount", dataCount);
			
			model.addAttribute("schType", schType);
			model.addAttribute("kwd", kwd);
			
			model.addAttribute("page", current_page);
			model.addAttribute("size", size);
			model.addAttribute("total_page", total_page);
			model.addAttribute("paging", paging);
			model.addAttribute("query", query);
			*/
		} catch (Exception e) {
			log.info("handleDetailManageList : ", e);
		}
		
		return "admin/orderStatus/detailManage";
	}
	
	@GetMapping("detailManage/{orderDetailNum}")
	public String handleDetailView(
			@PathVariable("orderDetailNum") Long orderDetailNum,
			@RequestParam(name = "page") String page,
			@RequestParam(name = "schType", defaultValue = "orderNum") String schType,
			@RequestParam(name = "kwd",defaultValue = "") String kwd,
			Model model,
			HttpServletRequest req) throws Exception {
		// 주문 상세 보기
		
		// orderDetailManage-주문상세관리
		//    itemId : 100-배송후교환, 110-구매확정,
		//            200-배송전환불, 210-배송후반품, 220-판매취소, 230-취소전체리스트

		String query = "page=" + page;
		try {
			/*
			kwd = URLDecoder.decode(kwd, "utf-8");

			if (! kwd.isBlank()) {
				query += "&schType=" + schType + "&kwd=" + URLEncoder.encode(kwd, "UTF-8");
			}
			
			// 주문 상세 정보
			OrderDetailManage dto = Objects.requireNonNull(service.findByDetailId(orderDetailNum));
			
			// 주문 정보의 구매 리스트 
			List<OrderDetailManage> listBuy = service.listOrderDetails(dto.getOrderNum());
			
			// 결제 정보
			Map<String, Object> payDetail = service.findByPayDetail(dto.getOrderNum());

			model.addAttribute("itemId", itemId);
			model.addAttribute("dto", dto);
			model.addAttribute("listBuy", listBuy);
			model.addAttribute("payDetail", payDetail);
			
			model.addAttribute("query", query);
			model.addAttribute("page", page);
			*/
			return "admin/orderStatus/detailView";
			
		} catch (NullPointerException e) {
		} catch (Exception e) {
			log.info("handleDetailView : ", e);
		}
		
		return "redirect:/admin/order/detailManage/" + query;
	}
}
