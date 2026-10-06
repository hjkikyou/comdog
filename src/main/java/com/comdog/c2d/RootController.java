package com.comdog.c2d;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.comdog.c2d.domain.product.dto.ProductDto;

@Controller
public class RootController {

	  @GetMapping("/")
	    public String home(){
	        return "user/index";
	    }
	  
	  @GetMapping("/admin")
	    public String admin(){
	        return "admin/index";
	    }
	  

	@GetMapping("/wishlist")
	public String wishlist() {
		return "user/order/wishlist";
	}

	@GetMapping("/recent")
	public String recent() {
		return "user/order/recent";
	}

	@GetMapping("/board")
	public String board() {
		return "user/board/board";
	}
	
	@GetMapping("/event")
	public String event() {
		return "user/board/event";
	}
	

	@GetMapping("/community_board")
	public String communityBoard() {
		return "user/board/community_board";
	}
	
	@GetMapping("/refurb_list")
	public String refubList() {
		return "user/exclusive/refurb_list";
	}
	
	@GetMapping("/center")
	public String center() {
		return "user/center/center";
	}
	
	@GetMapping("/sub-rental")
	public String subRental() {
		return "user/exclusive/sub-rental";
	}
	@GetMapping("/my-page")
	public String myPage() {
		return "user/mypage/my-page";
	}
	
	 @GetMapping("/assembly_pc_purchase_list")
	    public String productCtPcList(){
	        return "user/product/assembly_pc_purchase_list";
	    }
	    
	    @GetMapping("/assembly_pc_rental_list")
	    public String rentalCtPcList(){
	        return "user/product/assembly_pc_rental_list";
	    }
	    
	    @GetMapping("/assembly_pc_detail")
	    public String ctPcDetail(Model model) {
	        ProductDto product = new ProductDto();
	        product.setName("테스트 PC");
	        product.setBrand("HP");
	        product.setModelName("프로 데스크 4 G1i");
	        product.setBasePrice(3000000);
	        product.setStockQuantity(10);
	        model.addAttribute("product", product);
	        return "user/product/assembly_pc_detail";
	    }
	    
	    @GetMapping("/product_list")
	    public String productList(){
	        return "user/product/product_list";
	    }
		
	}

