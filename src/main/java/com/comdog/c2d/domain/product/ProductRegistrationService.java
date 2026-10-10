package com.comdog.c2d.domain.product;

import java.io.IOException;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.comdog.c2d.domain.product.dto.ProductDto;

@Service
public class ProductRegistrationService {

    private final ProductService productService;
    private final ProductImageService imageService;

    public ProductRegistrationService(
            ProductService productService,
            ProductImageService imageService) {
        this.productService = productService;
        this.imageService = imageService;
    }

    public void register(ProductDto product, MultipartFile image)
            throws IOException {

        String imageUrl = imageService.save(image);
        product.setImageUrl(imageUrl);

        try {
            productService.add(product);
        } catch (RuntimeException ex) {
            // DB 저장이 실패하면 방금 저장한 파일도 정리합니다.
            try {
                imageService.delete(imageUrl);
            } catch (IOException cleanupError) {
                ex.addSuppressed(cleanupError);
            }
            product.setImageUrl(null);
            throw ex;
        }
    }
}