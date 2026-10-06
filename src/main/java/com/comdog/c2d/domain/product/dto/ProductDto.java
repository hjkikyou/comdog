package com.comdog.c2d.domain.product.dto;

import java.util.List;
import java.util.Map;

public class ProductDto {

    // ── product 테이블 ──
    private Long productId;       // 상품 고유번호
    private Long categoryId;      // 카테고리 고유번호
    private String name;          // 상품명
    private String brand;         // 브랜드
    private String modelName;     // 모델명
    private int basePrice;        // 출고가
    private int stockQuantity;    // 재고 수량
    private String description;   // 상세 스펙 / 렌탈 유의사항
    private String isDeleted;     // 삭제 여부 (Y/N)
    
    private String isPurchasable; // 구매 가능 여부 (Y/N) ← 추가
    private String isRentable;    // 대여 가능 여부 (Y/N) ← 추가
    private Integer rentalPrice;  // 대표 월 렌탈료 (NULL 가능) ← 추가
    
    
    //그대로 두면 되는 미사용 필드: avgRating, reviewCount, discountRate, salePrice
    //— 리뷰·할인 기능 만들 때 채울 거라 지금은 비워둬도 무방해요. 삭제 안 해도 돼요.
    
    //테이블엔 있는데 DTO엔 없는 컬럼: is_purchasable, is_rentable, rental_price, is_recommended,
    //view_count, rental_count,
    //created_at, updated_at, is_deleted. 이 중 정렬·필터·상태관리에 쓰이는 것들이라 화면에서 점점 필요해질 거예요.
    
    

    // ── product_spec 테이블 (JOIN) ──
    // spec_key → spec_value 형태로 Map에 담기
    // 예: {"CPU": "i7-13700", "RAM": "32GB", "GPU": "RTX 4070"}
    private Map<String, String> specs;

    // ── rental_prices 테이블 (JOIN) ──
    private List<RentalPriceDto> rentalPrices; // 기간별 렌탈가 목록
    private int minMonthlyFee;    // 최저 월 렌탈료 (목록 표시용)
    private int minDuration;      // 최단 렌탈 기간 (목록 표시용)

    // ── 목록 표시용 추가 필드 ──
    private String imageUrl;      // 상품 대표 이미지 URL
    private double avgRating;     // 평균 별점
    private int reviewCount;      // 리뷰 수
    private int discountRate;     // 할인율 (%)
    private int salePrice;        // 할인 적용가 (구매용)
    private boolean isB2bOnly;    // B2B 전용 여부
    
    //RentalPriceDto엔 앞서 말한 depositFee 추가가 필요, 나중에

    // ── 내부 클래스: 렌탈가 ──
    public static class RentalPriceDto {
        private Long rentalPriceId;
        private int duration;      // 렌탈 기간(개월)
        private int monthlyFee;    // 월 렌탈료
        private boolean isB2bOnly; // B2B 전용 여부

        public Long getRentalPriceId() { return rentalPriceId; }
        public void setRentalPriceId(Long rentalPriceId) { this.rentalPriceId = rentalPriceId; }

        public int getDuration() { return duration; }
        public void setDuration(int duration) { this.duration = duration; }

        public int getMonthlyFee() { return monthlyFee; }
        public void setMonthlyFee(int monthlyFee) { this.monthlyFee = monthlyFee; }

        public boolean isB2bOnly() { return isB2bOnly; }
        public void setB2bOnly(boolean b2bOnly) { isB2bOnly = b2bOnly; }
    }

    // ── Getters & Setters ──

    public Long getProductId() { return productId; }
    public void setProductId(Long productId) { this.productId = productId; }

    public Long getCategoryId() { return categoryId; }
    public void setCategoryId(Long categoryId) { this.categoryId = categoryId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getBrand() { return brand; }
    public void setBrand(String brand) { this.brand = brand; }

    public String getModelName() { return modelName; }
    public void setModelName(String modelName) { this.modelName = modelName; }

    public int getBasePrice() { return basePrice; }
    public void setBasePrice(int basePrice) { this.basePrice = basePrice; }

    public int getStockQuantity() { return stockQuantity; }
    public void setStockQuantity(int stockQuantity) { this.stockQuantity = stockQuantity; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getIsDeleted() { return isDeleted; }
    public void setIsDeleted(String isDeleted) { this.isDeleted = isDeleted; }

    public Map<String, String> getSpecs() { return specs; }
    public void setSpecs(Map<String, String> specs) { this.specs = specs; }

    public List<RentalPriceDto> getRentalPrices() { return rentalPrices; }
    public void setRentalPrices(List<RentalPriceDto> rentalPrices) { this.rentalPrices = rentalPrices; }

    public int getMinMonthlyFee() { return minMonthlyFee; }
    public void setMinMonthlyFee(int minMonthlyFee) { this.minMonthlyFee = minMonthlyFee; }

    public int getMinDuration() { return minDuration; }
    public void setMinDuration(int minDuration) { this.minDuration = minDuration; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    public double getAvgRating() { return avgRating; }
    public void setAvgRating(double avgRating) { this.avgRating = avgRating; }

    public int getReviewCount() { return reviewCount; }
    public void setReviewCount(int reviewCount) { this.reviewCount = reviewCount; }

    public int getDiscountRate() { return discountRate; }
    public void setDiscountRate(int discountRate) { this.discountRate = discountRate; }

    public int getSalePrice() { return salePrice; }
    public void setSalePrice(int salePrice) { this.salePrice = salePrice; }

    public boolean isB2bOnly() { return isB2bOnly; }
    public void setB2bOnly(boolean b2bOnly) { isB2bOnly = b2bOnly; }
    
    public String getIsPurchasable() { return isPurchasable; }
    public void setIsPurchasable(String isPurchasable) { this.isPurchasable = isPurchasable; }

    public String getIsRentable() { return isRentable; }
    public void setIsRentable(String isRentable) { this.isRentable = isRentable; }

    public Integer getRentalPrice() { return rentalPrice; }
    public void setRentalPrice(Integer rentalPrice) { this.rentalPrice = rentalPrice; }
}