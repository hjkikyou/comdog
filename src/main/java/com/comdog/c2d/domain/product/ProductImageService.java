package com.comdog.c2d.domain.product;

import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.imageio.ImageReader;
import javax.imageio.stream.ImageInputStream;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class ProductImageService {

    private final Path uploadDir;

    public ProductImageService(
            @Value("${app.upload.product-dir}") String uploadDir) {
        this.uploadDir = Path.of(uploadDir).toAbsolutePath().normalize();
    }

    public String save(MultipartFile file) throws IOException {
        if (file == null || file.isEmpty()) {
            return null; // 이미지는 선택 사항
        }

        if (file.getSize() > 5 * 1024 * 1024) {
            throw new IllegalArgumentException("이미지는 5MB 이하로 등록하세요.");
        }

        BufferedImage image;
        String extension;

        try (InputStream input = file.getInputStream();
             ImageInputStream stream = ImageIO.createImageInputStream(input)) {

            if (stream == null) {
                throw new IllegalArgumentException("이미지를 읽을 수 없습니다.");
            }

            var readers = ImageIO.getImageReaders(stream);
            if (!readers.hasNext()) {
                throw new IllegalArgumentException("이미지 파일을 선택하세요.");
            }

            ImageReader reader = readers.next();

            try {
                reader.setInput(stream);
                String format = reader.getFormatName();

                if ("JPEG".equalsIgnoreCase(format)) {
                    extension = "jpg";
                } else if ("PNG".equalsIgnoreCase(format)) {
                    extension = "png";
                } else {
                    throw new IllegalArgumentException(
                            "JPEG 또는 PNG만 등록할 수 있습니다.");
                }

                int width = reader.getWidth(0);
                int height = reader.getHeight(0);

                if (width <= 0 || height <= 0
                        || (long) width * height > 20_000_000) {
                    throw new IllegalArgumentException("이미지 크기가 너무 큽니다.");
                }

                image = reader.read(0);
            } finally {
                reader.dispose();
            }
        }

        Files.createDirectories(uploadDir);

        String filename = UUID.randomUUID() + "." + extension;
        Path target = uploadDir.resolve(filename);

        try {
            // 실제 이미지로 다시 저장해 파일 내용을 검증합니다.
            if (!ImageIO.write(image, extension, target.toFile())) {
                throw new IOException("이미지를 저장할 수 없습니다.");
            }
        } catch (IOException | RuntimeException ex) {
            Files.deleteIfExists(target);
            throw ex;
        }

        return "/images/products/" + filename;
    }

    public void delete(String imageUrl) throws IOException {
        if (imageUrl == null) {
            return;
        }

        String prefix = "/images/products/";
        if (!imageUrl.startsWith(prefix)) {
            throw new IllegalArgumentException("잘못된 이미지 경로입니다.");
        }

        Path target = uploadDir.resolve(
                imageUrl.substring(prefix.length())).normalize();

        if (!uploadDir.equals(target.getParent())) {
            throw new IllegalArgumentException("잘못된 이미지 경로입니다.");
        }

        Files.deleteIfExists(target);
    }
}