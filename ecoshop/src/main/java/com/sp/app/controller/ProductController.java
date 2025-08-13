package com.sp.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/products/*")
public class ProductController {
	
	@GetMapping("{productNum}")
	public String detailRequest(@PathVariable("productNum") long productNum,
			HttpSession session, Model model) throws Exception{
		
		try {
			/*
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			
			// 상품
			Product dto = Objects.requireNonNull(service.findById(productNum));
			if(dto.getShowSpecial() == 0) {
				return "redirect:/products/main";
			}
			
			if(info != null) {
				// 찜 여부
				Map<String, Object> map = new HashMap<>();
				map.put("member_id", info.getMember_id());
				map.put("productNum", dto.getProductNum());
				
				dto.setUserWish(myShoppingService.findByWishId(map)== null ? 0 : 1);
			}
			
			// 추가 이미지
			List<Product> listFile = service.listProductFile(productNum);
			
			// 옵션명
			List<Product> listOption = service.listProductOption(productNum);
			
			// 옵션1 옵션값
			List<Product> listOptionDetail = null;
			if(listOption.size() > 0) {
				listOptionDetail = service.listOptionDetail(listOption.get(0).getOptionNum());
			}
			
			Map<String, Object> map = new HashMap<String, Object>();
			List<Product> listStock = null;
			if(dto.getOptionCount() < 2) {
				map.put("productNum", dto.getProductNum());
				listStock = service.listOptionDetailStock(map);
				
				if(dto.getOptionCount() == 0 && listStock.size() > 0) {
					// 옵션이 없는 경우 재고 수량
					dto.setStockNum(listStock.get(0).getStockNum());
					dto.setTotalStock(listStock.get(0).getTotalStock());
				} else if(dto.getOptionCount() > 0) {
					// 옵션이 하나인 경우 재고 수량
					for(Product vo : listOptionDetail) {
						for(Product ps : listStock) {
							if(vo.getDetailNum() == ps.getDetailNum()) {
								vo.setStockNum(ps.getStockNum());
								vo.setTotalStock(ps.getTotalStock());
								break;
							}
						}
					}
				}
			}
			
			// 추가 이미지
			dto.setFilename(dto.getThumbnail());
			listFile.add(0, dto);
			
			model.addAttribute("dto", dto);
			model.addAttribute("listOption", listOption);
			model.addAttribute("listOptionDetail", listOptionDetail);
			model.addAttribute("listFile", listFile);
			*/
			return "products/productInfo";
			
		} catch (NullPointerException e) {
		} catch (Exception e) {
			log.info("detailRequest : ", e);
		}
		
		return "redirect:/products/main";
	}
}
