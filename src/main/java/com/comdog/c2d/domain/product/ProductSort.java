package com.comdog.c2d.domain.product;

import java.util.Set;

public final class ProductSort {
    private static final Set<String> VALUES = Set.of(
            "recommended", "newest", "sales", "rating", "price_desc", "price_asc");
    private ProductSort() {}
    public static String normalize(String sort) {
        return sort != null && VALUES.contains(sort) ? sort : "recommended";
    }
}
