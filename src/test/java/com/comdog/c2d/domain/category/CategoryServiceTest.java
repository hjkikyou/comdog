package com.comdog.c2d.domain.category;

import java.util.List;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

class CategoryServiceTest {
    private CategoryDto category(long id, Long parent) {
        CategoryDto item = new CategoryDto();
        item.setCategoryId(id);
        item.setParentId(parent);
        return item;
    }
    @Test
    void newProductsMustSelectAnExistingLeaf() {
        CategoryDao dao = mock(CategoryDao.class);
        when(dao.findAll()).thenReturn(List.of(category(8, null), category(81, 8L), category(811, 81L)));
        CategoryService service = new CategoryService(dao);
        assertThrows(IllegalArgumentException.class, () -> service.validateSelection(null, null));
        assertThrows(IllegalArgumentException.class, () -> service.validateSelection(999L, null));
        assertThrows(IllegalArgumentException.class, () -> service.validateSelection(8L, null));
        assertThrows(IllegalArgumentException.class, () -> service.validateSelection(81L, null));
        assertDoesNotThrow(() -> service.validateSelection(811L, null));
    }
    @Test
    void existingProductsMayKeepTheirOriginalIntermediateCategory() {
        CategoryDao dao = mock(CategoryDao.class);
        when(dao.findAll()).thenReturn(List.of(category(81, 8L), category(811, 81L)));
        CategoryService service = new CategoryService(dao);
        assertDoesNotThrow(() -> service.validateSelection(81L, 81L));
        assertDoesNotThrow(() -> service.validateSelection(811L, 81L));
        assertThrows(IllegalArgumentException.class, () -> service.validateSelection(81L, 811L));
    }
}
