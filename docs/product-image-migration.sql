-- 파일을 C:/upload/products/로 복사한 후 실행합니다.
START TRANSACTION;
UPDATE product
SET image_url = REPLACE(image_url, '/images/product/', '/images/products/')
WHERE image_url LIKE '/images/product/%';
-- 원본 static 폴더에도 파일이 없는 샘플 경로입니다.
UPDATE product SET image_url = NULL
WHERE image_url IN (
    '/images/products/rtx4090-workstation.jpg',
    '/images/products/mac-studio.jpg',
    '/images/products/rtx4090.jpg',
    '/images/products/ddr5-ram.jpg',
    '/images/products/canonprint.jpg',
    '/images/products/sonyvim.jpg',
    '/images/products/dragonfly.jpg',
    '/images/products/hdmi.jpg'
);
COMMIT;
