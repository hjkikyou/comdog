package com.comdog.c2d.domain.product;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.comdog.c2d.domain.product.dto.ProductDto;

@Controller
@RequestMapping("/admin/product")
public class AdminProductController {
	
	@Autowired
	ProductService service;
	
	/*---조회---*/
	
	@GetMapping("/list")
	public String getProductListPage(Model model) {
		List<ProductDto> productList = service.findAllProducts();
		model.addAttribute("viewProductList", productList);
		
		return "admin/product/list";
	}
	


	/*---추가---*/
	
	@GetMapping("/add")
	public String showAddForm() {
		return "admin/product/add";
	}
	//showAddForm() : "나 상품 등록 화면 좀 보여줘" (Get)
	//글을 쓸 수 있는 빈 종이(화면)를 주는 것
	
	@PostMapping("/add")
	String addProduct(ProductDto item) {
		service.add(item);
		
		return "redirect:/admin/product/list";
				
	}
	//addProduct(Product item) : "입력 다 했어! 진짜로 DB에 추가해줘" (Post)
	//종이에 적힌 내용을 받아서 진짜 DB에 저장(추가)하는 녀석
	
	
	/*---변경---*/
	
	// 1. 수정된화면 띄우기
	@GetMapping("/update/{id}")
	String showUpdateForm(@PathVariable Long id, Model model) {
	// item 대신 'product' / 메서드명은 'findProductById'
	ProductDto product = service.findProductById(id);
	// 화면에 넘길 때도 "product"라는 이름표로
	model.addAttribute("viewProduct", product);
		return "admin/product/update";
	}
	
	
	// 2. 실제 수정 내용 DB에 반영하기
	@PostMapping("/update/{id}")
	public String updateProduct(@PathVariable Long id, ProductDto product) {
		// 자바 객체의 id 세팅
		product.setProductId(id);
		
		service.update(product);
		
		return "redirect:/admin/product/list";
	}

	/*---삭제---*/
	
	@GetMapping("/delete/{id}")
		String deleteProduct(@PathVariable Long id) {
			service.delete(id);
			
			return "redirect:/admin/product/list";
	}
}
	