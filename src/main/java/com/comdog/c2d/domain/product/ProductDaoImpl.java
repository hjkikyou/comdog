package com.comdog.c2d.domain.product;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.comdog.c2d.domain.product.dto.ProductDto;

@Repository
public class ProductDaoImpl implements ProductDao {
	@Override
	public List<ProductDto> searchPurchasableProducts(Long categoryId, String keyword, String sort) {
		java.util.Map<String, Object> params = new java.util.HashMap<>();
		params.put("categoryId", categoryId);
		params.put("sort", ProductSort.normalize(sort));
		params.put("keyword", keyword.replace("!", "!!").replace("%", "!%").replace("_", "!_"));
		return sql.selectList("product.searchPurchasableProducts", params);
	}

	@Autowired
	SqlSession sql;

	// 조회
	@Override
	public List<ProductDto> findAllProducts() {
		return sql.selectList("product.findAllProducts"); 
		// 💡 뒤의 "list"를 "findAllProducts"로 맞춰줍니다!
	}

	// 추가
	@Override
	public void add(ProductDto item) {
		sql.insert("product.add", item);

	}

	// 변경
	@Override
	public ProductDto findProductById(Long id) {
	
		return sql.selectOne("product.findProductById", id);
	}

	@Override
	public void update(ProductDto product) {
		sql.update("product.update", product);
	}

	// 삭제
	@Override
	public void delete(Long id) {
		sql.delete("product.delete", id);

	}
	@Override
	public void deleteOrderItemByProductId(Long id) {
		sql.delete("product.deleteOrderItemByProductId", id); 

	}
	
	/**********사용자 요청**************/

	
    @Override
    public List<ProductDto> selectProductsWithSubCategories(Long categoryId) {
    	return sql.selectList("product.findProductsWithSubCategories", categoryId);
    }


    @Override
    public String selectCategoryNameById(Long categoryId) {
        return sql.selectOne("product.findCategoryNameById", categoryId);
    }
}


