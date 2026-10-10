package com.comdog.c2d.domain.product;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.comdog.c2d.domain.contract.ContractDao;
import com.comdog.c2d.domain.product.dto.ProductDto;
import com.comdog.c2d.domain.category.CategoryService;

@Service
public class ProductServiceImpl implements ProductService {
	@Override
	public List<ProductDto> searchPurchasableProducts(Long categoryId, String keyword) {
		return searchPurchasableProducts(categoryId, keyword, "recommended");
	}
	@Override
	public List<ProductDto> searchPurchasableProducts(Long categoryId, String keyword, String sort) {
		return productDao.searchPurchasableProducts(categoryId,
				keyword == null ? "" : keyword.strip(), ProductSort.normalize(sort));
	}
	@Autowired
	CategoryService categoryService;

	@Autowired
	ProductDao productDao; // 상품테이블

	@Autowired
	ContractDao contractDao; // 계약 테이블

	// 조회
	@Override
	public List<ProductDto> findAllProducts() { // 💡 컨트롤러에서 호출한 이름과 똑같이 변경!
		return productDao.findAllProducts(); // 💡 DAO의 메서드 이름도 똑같이 맞춰주는 것이 관례상 가장 좋습니다.
	}

	// 추가
	@Override
	public void add(ProductDto item) {
		categoryService.validateSelection(item.getCategoryId(), null);
		if (item.getIsPurchasable() == null) item.setIsPurchasable("Y");
		if (item.getIsRentable() == null) item.setIsRentable("Y");
		productDao.add(item);
	}

	// 변경
	@Override
	public ProductDto findProductById(Long id) {
	return productDao.findProductById(id);  // 💡 DAO 메서드도 동일한 이름으로 호출하는 것이 정석입니다
	}

	@Override
	public void update(ProductDto product) {
		ProductDto previous = productDao.findProductById(product.getProductId());
		if (previous == null) throw new IllegalArgumentException("상품을 찾을 수 없습니다.");
		categoryService.validateSelection(product.getCategoryId(), previous.getCategoryId());
		if (product.getIsPurchasable() == null) product.setIsPurchasable(previous.getIsPurchasable());
		if (product.getIsRentable() == null) product.setIsRentable(previous.getIsRentable());
		if (product.getRentalPrice() == null) product.setRentalPrice(previous.getRentalPrice());
		if (product.getImageUrl() == null) product.setImageUrl(previous.getImageUrl());
		productDao.update(product);
	}

	// 삭제
	@Override
	@Transactional 
	public void delete(Long id) {

		// 1등: 이 상품과 연결된 계약의 자식들(결제내역, 리뷰)을 먼저 지웁니다.
		contractDao.deletePaymentByMemberId(id);
		contractDao.deleteReviewByMemberId(id);
		
		// 2등: 자식이 사라진 계약(contract) 데이터를 지웁니다.
		contractDao.deleteByMemberId(id);

		// 3등: 이 상품과 연결된 주문 상품 상세(order_item) 내역을 지웁니다.
		productDao.deleteOrderItemByProductId(id);

		// 4등: 모든 걸림돌이 사라졌으므로 진짜 상품(product) 데이터를 안전하게 지웁니다.
		productDao.delete(id);
	}

	/**********사용자 요청**************/
	
	@Override
	public List<ProductDto> findProductsWithSubCategories(Long categoryId) {
		return productDao.selectProductsWithSubCategories(categoryId);
	}

	@Override
	public String findCategoryNameById(Long categoryId) {
		return productDao.selectCategoryNameById(categoryId);
	}

}
