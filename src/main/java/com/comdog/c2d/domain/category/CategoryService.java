package com.comdog.c2d.domain.category;

import java.util.List;
import org.springframework.stereotype.Service;

@Service
public class CategoryService {
    private final CategoryDao dao;
    public CategoryService(CategoryDao dao) { this.dao = dao; }
    public List<CategoryDto> findAll() { return dao.findAll(); }
    public void validateSelection(Long id, Long previousId) {
        List<CategoryDto> categories = findAll();
        if (id == null || categories.stream().noneMatch(c -> id.equals(c.getCategoryId()))) {
            throw new IllegalArgumentException("카테고리를 선택하세요.");
        }
        // 기존 상품의 중분류는 소분류 추가 후에도 그대로 수정할 수 있다.
        if (!id.equals(previousId) && categories.stream().anyMatch(c -> id.equals(c.getParentId()))) {
            throw new IllegalArgumentException("하위 카테고리까지 선택하세요.");
        }
    }
}
