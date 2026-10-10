package com.comdog.c2d.domain.category;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class CategoryDao {
    private final SqlSession sql;
    public CategoryDao(SqlSession sql) { this.sql = sql; }
    public List<CategoryDto> findAll() {
        return sql.selectList("category.findAll");
    }
}
