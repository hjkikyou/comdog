package com.comdog.c2d.domain.product;

import java.util.List;

import com.comdog.c2d.domain.product.dto.ProductDto;

public interface ProductService {
		
		//조회
		List<ProductDto> findAllProducts(); // 💡 컨트롤러에서 호출한 이름과 똑같이 변경!
		
		//추가
		void add(ProductDto item);
		
		//변경
		ProductDto findProductById(Long id);
		
		void update(ProductDto product);
		
		//삭제
		void delete(Long id);
		
		/**********사용자 요청**************/

		List<ProductDto> findProductsWithSubCategories(Long categoryId);

		String findCategoryNameById(Long categoryId);

		

		

}
