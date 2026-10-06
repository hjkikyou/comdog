-- ==========================================
-- 더미 데이터 삽입 (PC 하드웨어 렌탈 서비스 기준)
-- ==========================================
SET FOREIGN_KEY_CHECKS = 0;

-- 1. 회원 (B2C 개인회원 7명, B2B 기업회원 3명)
-- ※ 모든 비밀번호는 평문 '1234'의 BCrypt 해시 (로그인 시 비밀번호: 1234)
INSERT INTO member (member_id, email, password, name, phone, birth_date, gender_digit, user_type, is_subscribed) VALUES
(1,  'janedoe@gmail.com',   '1234', '레제',   '010-1111-1111', '950315', '1', 'PERSONAL', 1),
(2,  'user2@gmail.com',     '1234', '이서연', '010-2222-2222', '980722', '2', 'PERSONAL', 0),
(3,  'user3@gmail.com',     '1234', '박도현', '010-3333-3333', '001210', '3', 'PERSONAL', 1),
(4,  'user4@gmail.com',     '1234', '최유진', '010-4444-4444', '921005', '2', 'PERSONAL', 0),
(5,  'user5@gmail.com',     '1234', '정민우', '010-5555-5555', '870428', '1', 'PERSONAL', 0),
(6,  'user6@gmail.com',     '1234', '강수아', '010-6666-6666', '991130', '4', 'PERSONAL', 1),
(7,  'user7@gmail.com',     '1234', '조현우', '010-7777-7777', '030817', '3', 'PERSONAL', 0),
(8,  'b2b1@company.com',    '1234', '윤태양', '010-8888-8888', '780601', '1', 'BUSINESS', 1),
(9,  'b2b2@startup.com',    '1234', '임지아', '010-9999-9999', '830214', '2', 'BUSINESS', 0),
(10, 'b2b3@enterprise.com', '1234', '한승민', '010-0000-0000', '910923', '1', 'BUSINESS', 1);

-- 2. 사업자 프로필 (기업 회원 3명)
INSERT INTO business_profile (member_id, company_name, business_reg_no, representative_name) VALUES
(8, '(주)테크솔루션', '123-45-67890', '윤태양'),
(9, '스타트업랩', '234-56-78901', '임지아'),
(10, '엔터프라이즈IT', '345-67-89012', '한승민');

-- 3. 배송지 (각 회원당 1개씩)
INSERT INTO address (address_id, member_id, address_name, recipient_name, phone, zip_code, base_address, detail_address, is_default) VALUES
(1, 1, '집', '레제', '010-1111-1111', '01234', '서울시 강남구 테헤란로', '101동 101호', 1),
(2, 2, '집', '이서연', '010-2222-2222', '02345', '서울시 서초구 서초대로', '202동 202호', 1),
(3, 3, '회사', '박도현', '010-3333-3333', '03456', '경기도 성남시 분당구 판교역로', '3층', 1),
(4, 4, '집', '최유진', '010-4444-4444', '04567', '서울시 송파구 올림픽로', '404호', 1),
(5, 5, '집', '정민우', '010-5555-5555', '05678', '인천시 연수구 송도과학로', '505호', 1),
(6, 6, '집', '강수아', '010-6666-6666', '06789', '부산시 해운대구 센텀중앙로', '606호', 1),
(7, 7, '회사', '조현우', '010-7777-7777', '07890', '대구시 수성구 달구벌대로', '7층', 1),
(8, 8, '본사', '윤태양', '010-8888-8888', '08901', '서울시 중구 세종대로', '테크솔루션 8층', 1),
(9, 9, '공유오피스', '임지아', '010-9999-9999', '09012', '서울시 강남구 역삼로', '위워크 9층', 1),
(10, 10, '물류센터', '한승민', '010-0000-0000', '10123', '경기도 용인시 처인구', '물류동 10번 게이트', 1);

-- 4. 카테고리 (계층형)
INSERT INTO category (category_id, name, parent_id) VALUES
-- 📌 1단계: 대분류 (Root Categories, parent_id = NULL)
(1, 'PC', NULL), -- 완제품 PC
(2, '조립 PC', NULL),      
(3, '모니터', NULL),
(4, '노트북', NULL),
(5, '스마트기기', NULL),
(6, '사무/주변기기', NULL),     
(7, '서버/워크스테이션', NULL), -- B2B 기업 렌탈용 핵심 카테고리
(8, 'PC 부품/업그레이드', NULL),

-- 📌 2단계: 중분류 (Sub Categories)
-- 1. 데스크탑 PC 하위 (parent_id = 1, 자연스럽게 완제품/브랜드 PC들이 들어옴)
(11, '일반/사무용 PC', 1),
(12, '전문가용 PC', 1),         
(13, '게이밍 PC', 1),
(14, '미니 PC', 1),

-- 2. 조립 PC 하위 (parent_id = 2) 
(21, '사무/인강용 조립 PC', 2),
(22, '하이엔드 조립 PC', 2),
(23, '게이밍 조립 PC', 2),
(24, 'AI 조립 PC', 2),

-- 3. 모니터 하위 (parent_id = 3)
(31, '일반/사무용 모니터 (FHD/QHD)', 3),
(32, '전문가용 모니터 (4K/디자이너)', 3),
(33, '게이밍 모니터 (고주사율)', 3),
(34, '휴대용 모니터', 3),

-- 4. 노트북 하위 (parent_id = 4)
(41, '일반/사무용 노트북', 4),     -- 예: LG그램, 갤럭시북
(42, '전문가용 노트북', 4),
(43, '게이밍 노트북', 4),   -- 예: ROG, 에일리언웨어

-- 5. 스마트기기 하위 (parent_id = 5)
(51, '태블릿 (iPad/GalaxyTab)', 5),
(52, '스마트워치/웨어러블', 5),
(53, 'VR/AR 기기', 5),

-- 6. 사무/주변기기 하위 (parent_id = 6)
(61, '프린터/복합기', 6),
(62, '빔프로젝터/화상장비', 6),
(63, '기타 (키보드/마우스/허브)', 6),
(64, '기타 (악세서리/관련 케이블)', 6),

-- 7. 서버/워크스테이션 하위 (parent_id = 7)
(71, '서버 (랙/타워형)', 7),
(72, '고성능 워크스테이션', 7),
(73, 'NAS / 스토리지', 7),

-- 8. PC 부품/ 업그레이드 하위, parent_id = 8)

-- 렌탈 수익이 안 나고 감가상각이 심한 부품들은 is_rentable = 'N'으로 막아둡니다. 
-- (오직 "구매(추가 옵션)"만 가능한 소모성 부품들)

-- 단기 수요가 확실하고 고가인 장비들은 is_rentable = 'Y'로 설정하여 렌탈 메인 화면에 노출합니다. 
-- ("구매와 렌탈" 모두 열어두는 고수익 하이엔드 부품들)

-- 고수익/고가 부품은 렌탈 노출(is_rentable='Y'), 감가가 심한 소모품은 조립용 구매 전용(is_rentable='N')으로 세팅

(81, 'CPU (프로세서)', 8),              -- [렌탈/구매 겸용] 일반 PC용은 구매 전용, 워크스테이션용(제온, 쓰레드리퍼)은 렌탈 병행 노출
(82, '그래픽카드 (VGA)', 8),            -- [렌탈 핵심 품목] 단기 렌탈 수요가 가장 많은 고수익 부품 (예: RTX 4090, 딥러닝용 A100 등)
(83, 'RAM (메모리)', 8),                -- [구매 전용] 단가가 낮고 감가상각이 심한 소모성 부품 (PC 조립 옵션용)
(84, '메인보드 (Motherboard)', 8),      -- [구매 전용] 단독 렌탈 수요가 거의 없는 조립 뼈대 부품
(85, '저장장치 (SSD/HDD)', 8),          -- [구매 전용] 수명(TBW) 소모와 개인정보 보안 이슈로 일반적인 단기 렌탈은 비추천
(86, '파워서플라이', 8),                -- [구매 전용] 단독 렌탈 수익성이 떨어지는 소모성 부품
(87, '케이스 / 쿨러 / 튜닝', 8);        -- [구매 전용] 고객 취향을 타는 외관용/소모성 부품


-- 5. 상품 (PC 하드웨어 및 부품)
-- 컬럼: 구매가능여부, 판매가, 대여가능여부, 대표렌탈가, 재고, 설명, 추천여부, 조회수, 렌탈수
INSERT INTO product (
    product_id, category_id, name, brand, model_name, 
    is_purchasable, base_price, is_rentable, rental_price, 
    stock_quantity, description, is_recommended, view_count, rental_count
) VALUES


--1. PC(일반/사무용 PC: 11, 전문가용 PC: 12, 게이밍 PC: 13, 미니 PC: 14)
-- (4, 12, 'RTX 4070 게이밍 데스크탑', 'ASUS', 'ROG-4070', 'Y', 2500000, 'Y', 75000, 20, '하이엔드 게이밍 브랜드 PC', 'N', 230, 18),
-- (8, 13, '사무용 미니 PC', 'Intel', 'NUC-13', 'Y', 700000, 'Y', 20000, 100, '공간 절약형 사무용 PC', 'N', 110, 55),

(100, 12, '[Apple] iMac 27인치 2024년형 M4', 'Apple', 'MWUC3KH/A', 'Y', 1940000, 'Y', 70000, 250, '애플 아이맥 27인치 2024년형 M4 실버 색상 PC입니다', 'Y', 300, 23),
(101, 12, '[Apple] iMac 27인치 2020년형 인텔i7', 'Apple', 'MGSCX4KH/A', 'Y', 1450000, 'Y', 65000, 14, '애플 아이맥 27인치 2019년형 인텔i9 PC입니다', 'Y', 400, 7),
(102, 12, '[Apple] iMac 27인치 2019년형 인텔i9', 'Apple', 'MRR12KH/A', 'Y', 910000, 'Y', 48000, 30, '애플 아이맥 27인치 2019년형 인텔i9 PC입니다', 'N', 999, 45),
(103, 12, '[Apple] iMac G3 1998년형', 'Apple', 'G300001/A', 'Y', 2000000, 'N', NULL, 2, '애플 아이맥 G3 1998년형 PC입니다', 'N', 100, 0),
(104, 12, '[Apple] Macintosh 1984년형', 'Apple', 'MAC1984/A', 'Y', 500000000, 'N', NULL, 1, '애플 아이맥 맥킨토시 1984년형 PC입니다', 'N', 12, 0),
(105, 14, '[Apple] Mac Mini 2023 M2 실버', 'Apple', 'Z1700003N', 'Y', 2180000, 'N', NULL, 55, '애플 맥 미니 2023년 M2 실버 미니PC입니다', 'Y', 112, 0),

-- (110, 42, '[삼성] 갤럭시북5 프로, IntelCore-Ultra_7, Coplit+ PC', 'Samsung', 'NT960XHA-KC71G', 'Y', 2499999, 'Y', 75000, 100, '삼성 갤럭시북5 프로, 인텔 코어 울트라 7, Copliot+ 노트북입니다', 'Y', 800, 12),
-- (111, 42, '[삼성] 갤럭시북6 프로, 그레이', 'Samsung', 'NT940XJG-K72A', 'Y', 3650000, 'N', NULL, 110, '삼성 갤럭시북6 프로 그레이 색상 노트북입니다(대여불가)', 'Y', 777, 0),
-- (112, 41, '[삼성] 갤럭시북6 엣지, Snapdragon X2 Elite, Copliot+ PC', 'Samsung', 'NT960XRD-KC01B', 'Y', 2870000, 'Y', 80000, 99, '삼성 갤럭시북6 엣지, 스냅드래곤X2엘리트 copliot+PC 노트북입니다', 'N', 500, 42),
-- (113, 41, '[삼성] 갤럭시북5, 그레이', 'Samsung', 'NT750XHD-K71A', 'Y', 2200000, 'N', NULL, 70, '삼성 갤럭시북5 그레이 색상 노트북입니다', 'Y', 76, 0),
-- (114, 41, '[삼성] 갤럭시북4, 그레이', 'Samsung', 'NT750XGR-A71A', 'Y', 1140000, 'N', NULL, 20, '삼성 갤럭시북4 그레이 색상 노트북입니다','N', 23, 0),

-- (120, 42, '[LG] 그램 Pro 360 AI, IntelCore-Ultra_7', 'LG', '16T90TP-GD7BK', 'Y', 2350000, 'Y', 70000, 100, 'LG 그램 프로 360 AI 인텔코어 울트라 7 노트북입니다', 'Y', 888, 28),
-- (121, 42, '[LG] 그램 Pro AI 2026, IntelCore-Ultra_5, Copilot+ PC', 'LG', '16Z90U-KS5WK', 'Y', 3240000, 'Y', 97000, 25, 'LG노트북입니다', 'Y', 120, 20),
-- (122, 42, '[LG] 그램 Pro AI 2026, AMD Ryzen-AI_5, Copilot+ PC', 'LG', '16Z95U-GS5W', 'Y', 3000000, 'Y', 95000, 33, 'LG노트북입니다', 'N', 100, 42 ),
-- (123, 41, '[LG] 그램 AI 2026, AMD Ryzen_AI-5, Copilot+ PC', 'LG', '15Z95U-GS5SK', 'Y', 2500000, 'Y', 72000, 12, 'LG노트북입니다', 'Y', 99, 9),
-- (124, 41, '[LG] 그램, IntelCore_Ultra-5', 'LG', '14ZB90S-GA5WK', 'Y', 1300000, 'N', NULL, 77, 'LG 노트북입니다(대여불가)', 'N', 43, 0),

(130, 11, '[Lenovo] Thinkcentre Neo 30t Gen5 13K8S00A00 (i5-13420H)', 'Lenovo', '13K8S00A00', 'Y', 1379000, 'Y', 40000, 20, 'Lenovo Thinkcentre Neo PC입니다', 'Y', 333, 23),
-- (131, 41, '[Lenovo] Ideapad Slim3-15IRU8', 'Lenovo', '82X700HWKR', 'Y', 1200000, 'N', NULL, 11, 'Lenovo Ideapad노트북 입니다(대여X)', 'N', 87, 0),
-- (132, 42, '[Lenovo] Thinkpad X1 carbone Gen 13', 'Lenovo', '21NSS02W00', 'Y', 2100000, 'Y', 62000, 15, 'Lenovo Thinkpad X1 노트북입니다', 'Y', 180, 8),

(140, 13, '[ASUS] TUF GAMING TM500MH-R560W (Ryzen5)', 'ASUS', 'TM500MH-R560W', 'Y', 1892000, 'Y', 50000, 120, 'ASUS 터프게이밍 Ryzen5 PC입니다', 'Y', 1223, 43),
-- (141, 43, '[ASUS] ROG 제피러스 G16', 'ASUS', 'GU606AP-TB025W', 'Y', 1500000, 'N', NULL, 32, 'ASUS 제피러스 G16 게이밍 노트북입니다. (대여X)', 'Y', 32, 0),
-- (142, 42, '[ASUS] ExpertBook P1', 'ASUS', 'PM1503CDA-S70237', 'Y', 1760000, 'N', NULL, 88, 'AsUS ExpertBook P1 노트북입니다. (대여X)', 'N', 99, 0),

(150, 13, '[HP] 오멘 35L-GT16-1001KL Ryzen7-9800X3D', 'HP', '35L-GT16-1001KL', 'Y', 5100000, 'Y', 90000, 33, 'HP Omen Ryzen7 PC입니다', 'Y', 166, 32),
-- (151, 42, '[HP] 엘리트북 860 G11 울트라5-125H', 'HP', 'A1VH4PT', 'Y', 2280000, 'Y', 68000, 423, 'HP 엘리트북 860 G11 울트라5-125H 노트북입니다.', 'Y', 123, 33),
-- (152, 42, '[HP] 옴니북5 AI 코어5-320', 'HP', '14-kf0024TU', 'Y', 1700000, 'Y', 52000, 100, 'HP 옴니북5 AI 코어5-320 노트북입니다', 'Y', 79, 8),



--2. 조립PC (사무/인강용 조립 PC: 21, 하이엔드 조립 PC: 22, 게이밍 조립 PC: 23, AI조립: 24)
(3, 24, 'RTX 4090 딥러닝 워크스테이션', 'Custom', 'WS-4090', 'Y', 5500000, 'Y', 250000, 5, 'AI 개발 및 3D 렌더링용 조립 PC', 'Y', 890, 5),

-- (200, 42, '[Apple] MacBook Pro 16, M5, Silver', 'Apple', 'Z1N00005U', 'Y', 3000000, 'N', NULL, 250, '애플 맥북 프로 16 M5 실버 색상 노트북입니다(대여 불가)', 'Y', 300, 0),
-- (201, 42, '[Apple] MacBook Pro 14, M5, Silver', 'Apple', 'MGDR4KH/A', 'Y', 2500000, 'Y', 75000, 3, '애플 맥북 프로 14 M5 실버 색상 노트북입니다', 'Y', 400, 7),
-- (202, 41, '[Apple] MacBook Air 15, M3, StarLight', 'Apple', 'Z1GF00013', 'Y', 2000000, 'Y', 60000, 30, '애플 맥북 에어 15 M3 스타라이트 색상 노트북입니다', 'N', 520, 45),
-- (203, 41, '[Apple] MacBook Air 13, M5, Silver', 'Apple', 'Z1L0000Q0', 'Y', 2250000, 'Y', 69000, 24, '애플 맥북 에어 13 M5 실버 색상 노트북입니다.', 'Y', 520, 22),
-- (204, 41, '[Apple] MacBook Neo, A18, Silver', 'Apple', 'Z1TN0000F', 'Y', 1700000, 'N', NULL, 38, '애플 맥북 네오 A18 실버 색상 노트북입니다(대여불가)', 'Y', 388, 0),

-- (210, 42, '[삼성] 갤럭시북5 프로, IntelCore-Ultra_7, Coplit+ PC', 'Samsung', 'NT960XHA-KC71G', 'Y', 2499999, 'Y', 75000, 100, '삼성 갤럭시북5 프로, 인텔 코어 울트라 7, Copliot+ 노트북입니다', 'Y', 800, 12),
-- (211, 42, '[삼성] 갤럭시북6 프로, 그레이', 'Samsung', 'NT940XJG-K72A', 'Y', 3650000, 'N', NULL, 110, '삼성 갤럭시북6 프로 그레이 색상 노트북입니다(대여불가)', 'Y', 777, 0),
-- (212, 41, '[삼성] 갤럭시북6 엣지, Snapdragon X2 Elite, Copliot+ PC', 'Samsung', 'NT960XRD-KC01B', 'Y', 2870000, 'Y', 80000, 99, '삼성 갤럭시북6 엣지, 스냅드래곤X2엘리트 copliot+PC 노트북입니다', 'N', 500, 42),
-- (213, 41, '[삼성] 갤럭시북5, 그레이', 'Samsung', 'NT750XHD-K71A', 'Y', 2200000, 'N', NULL, 70, '삼성 갤럭시북5 그레이 색상 노트북입니다', 'Y', 76, 0),
-- (214, 41, '[삼성] 갤럭시북4, 그레이', 'Samsung', 'NT750XGR-A71A', 'Y', 1140000, 'N', NULL, 20, '삼성 갤럭시북4 그레이 색상 노트북입니다','N', 23, 0),

-- (220, 42, '[LG] 그램 Pro 360 AI, IntelCore-Ultra_7', 'LG', '16T90TP-GD7BK', 'Y', 2350000, 'Y', 70000, 100, 'LG 그램 프로 360 AI 인텔코어 울트라 7 노트북입니다', 'Y', 888, 28),
-- (221, 42, '[LG] 그램 Pro AI 2026, IntelCore-Ultra_5, Copilot+ PC', 'LG', '16Z90U-KS5WK', 'Y', 3240000, 'Y', 97000, 25, 'LG노트북입니다', 'Y', 120, 20),
-- (222, 42, '[LG] 그램 Pro AI 2026, AMD Ryzen-AI_5, Copilot+ PC', 'LG', '16Z95U-GS5W', 'Y', 3000000, 'Y', 95000, 33, 'LG노트북입니다', 'N', 100, 42 ),
-- (223, 41, '[LG] 그램 AI 2026, AMD Ryzen_AI-5, Copilot+ PC', 'LG', '15Z95U-GS5SK', 'Y', 2500000, 'Y', 72000, 12, 'LG노트북입니다', 'Y', 99, 9),
-- (224, 41, '[LG] 그램, IntelCore_Ultra-5', 'LG', '14ZB90S-GA5WK', 'Y', 1300000, 'N', NULL, 77, 'LG 노트북입니다(대여불가)', 'N', 43, 0),

-- (230, 42, '[Lenovo] Thinkpad E14 IPL G8 U7 3K AI', 'Lenovo', '21Y60065KR', 'Y', 1899000, 'Y', 60000, 200, 'Lenovo Thinkpad 노트북 입니다', 'N', 66, 21),
-- (231, 41, '[Lenovo] Ideapad Slim3-15IRU8', 'Lenovo', '82X700HWKR', 'Y', 1200000, 'N', NULL, 11, 'Lenovo Ideapad노트북 입니다(대여X)', 'N', 87, 0),
-- (232, 42, '[Lenovo] Thinkpad X1 carbone Gen 13', 'Lenovo', '21NSS02W00', 'Y', 2100000, 'Y', 62000, 15, 'Lenovo Thinkpad X1 노트북입니다', 'Y', 180, 8),

-- (240, 41, '[ASUS] 비보북 S16 QLED', 'ASUS', 'M3607HA-SH113', 'Y', 990000, 'N', NULL, 15, 'ASUS 비보북 노트북 입니다(대여X)', 'Y', 35, 0),
-- (241, 43, '[ASUS] ROG 제피러스 G16', 'ASUS', 'GU606AP-TB025W', 'Y', 1500000, 'N', NULL, 32, 'ASUS 제피러스 G16 게이밍 노트북입니다. (대여X)', 'Y', 32, 0),
-- (242, 42, '[ASUS] ExpertBook P1', 'ASUS', 'PM1503CDA-S70237', 'Y', 1760000, 'N', NULL, 88, 'AsUS ExpertBook P1 노트북입니다. (대여X)', 'N', 99, 0),

-- (250, 43, '[HP] HyperX 오멘, Intel_i7-14650HX', 'HP', '15-ga0030TX', 'Y', 3259000, 'N', NULL, 12, 'HP HyperX오멘 게이밍 노트북입니다. (대여X)', 'Y', 111, 0),
-- (251, 42, '[HP] 엘리트북 860 G11 울트라5-125H', 'HP', 'A1VH4PT', 'Y', 2280000, 'Y', 68000, 423, 'HP 엘리트북 860 G11 울트라5-125H 노트북입니다.', 'Y', 123, 33),
-- (252, 42, '[HP] 옴니북5 AI 코어5-320', 'HP', '14-kf0024TU', 'Y', 1700000, 'Y', 52000, 100, 'HP 옴니북5 AI 코어5-320 노트북입니다', 'Y', 79, 8),


--3. 모니터 (일반/사무용(FHD/QHD) : 31, 전문가용(4K/디자이너) : 32, 게이밍(고주사율): 33, 휴대용 모니터: 34)
-- (5, 33, '32인치 4K UHD 모니터', 'LG전자', '32UN880', 'Y', 800000, 'Y', 25000, 50, '디자인 작업용 4K 모니터', 'Y', 300, 25),
-- (9, 32, '27인치 QHD 게이밍 모니터', 'LG전자', '27GP850', 'Y', 500000, 'Y', 15000, 40, '165Hz 게이밍 모니터', 'N', 280, 32),

-- (300, 42, '[DELL] MacBook Pro 16, M5, Silver', 'Apple', 'Z1N00005U', 'Y', 3000000, 'N', NULL, 250, '애플 맥북 프로 16 M5 실버 색상 노트북입니다(대여 불가)', 'Y', 300, 0),
-- (301, 42, '[DELL] MacBook Pro 14, M5, Silver', 'Apple', 'MGDR4KH/A', 'Y', 2500000, 'Y', 75000, 3, '애플 맥북 프로 14 M5 실버 색상 노트북입니다', 'Y', 400, 7),
-- (302, 41, '[DELL] MacBook Air 15, M3, StarLight', 'Apple', 'Z1GF00013', 'Y', 2000000, 'Y', 60000, 30, '애플 맥북 에어 15 M3 스타라이트 색상 노트북입니다', 'N', 520, 45),
-- (303, 41, '[DELL] MacBook Air 13, M5, Silver', 'Apple', 'Z1L0000Q0', 'Y', 2250000, 'Y', 69000, 24, '애플 맥북 에어 13 M5 실버 색상 노트북입니다.', 'Y', 520, 22),
-- (304, 41, '[DELL] MacBook Neo, A18, Silver', 'Apple', 'Z1TN0000F', 'Y', 1700000, 'N', NULL, 38, '애플 맥북 네오 A18 실버 색상 노트북입니다(대여불가)', 'Y', 388, 0),

(310, 31, '[삼성] 모니터 S24C750P (61cm)', 'Samsung', 'S24C750P', 'Y', 1200000, 'N', NULL, 40, '삼성 일반 모니터입니다', 'Y', 132, 0),
(311, 32, '[삼성] 오디세이 OLED G8 G80SH 4K 240Hz (LS27HG802S)', 'Samsung', 'LS27HG802SKXKR', 'Y', 1440000, 'N', NULL, 110, '삼성 전문가용 모니터입니다(대여불가)', 'Y', 77, 0),
(312, 32, '[삼성] 뷰피니티 S8 S85TH 5K2K WUHD (LS40H852)', 'Samsung', 'LS40H852TAKXKR', 'Y', 1470000, 'Y', 50000, 99, '삼성 전문가용 모니터입니다', 'N', 132, 27),
(313, 32, '[삼성] 오디세이 OLED G8 G81SF 4K 240Hz (LS32FG812)', 'Samsung', 'LS32FG812SKXKR', 'Y', 1200000, 'N', NULL, 70, '삼성 전문가용 모니터입니다(대여X)', 'Y', 129, 0),
-- (314, 41, '[삼성] 갤럭시북4, 그레이', 'Samsung', 'NT750XGR-A71A', 'Y', 1140000, 'N', NULL, 20, '삼성 갤럭시북4 그레이 색상 노트북입니다','N', 23, 0),

(320, 31, '[LG] PC 모니터 U4 FHD', 'LG', '27U411B', 'Y', 180000, 'Y', 8000, 100, 'LG PC 모니터 입니다', 'Y', 888, 28),
(321, 32, '[LG] 울트라HD 모니터 4K', 'LG', '27US550', 'Y', 399000, 'Y', 25000, 120, 'LG 울트라HD 4K 모니터입니다', 'Y', 120, 20),
(322, 33, '[LG] 울트라기어 evo AI 올레드 게이밍모니터 GX9 5K', 'LG', '39GX950B', 'Y', 2070000, 'Y', 90000, 23, 'LG 게이밍모니터입니다', 'Y', 140, 23),
(323, 33, '[LG] 울트라기어 게이밍모니터 QHD', 'LG', '32GS60QC', 'Y', 369000, 'Y', 12000, 122, 'LG 게이밍 모니터입니다', 'Y', 363, 99),
-- (324, 41, '[LG] 그램, IntelCore_Ultra-5', 'LG', '14ZB90S-GA5WK', 'Y', 1300000, 'N', NULL, 77, 'LG 노트북입니다(대여불가)', 'N', 43, 0),

-- (330, 42, '[ASUS] Thinkpad E14 IPL G8 U7 3K AI', 'Lenovo', '21Y60065KR', 'Y', 1899000, 'Y', 60000, 200, 'Lenovo Thinkpad 노트북 입니다', 'N', 66, 21),
-- (331, 41, '[ASUS] Ideapad Slim3-15IRU8', 'Lenovo', '82X700HWKR', 'Y', 1200000, 'N', NULL, 11, 'Lenovo Ideapad노트북 입니다(대여X)', 'N', 87, 0),
-- (332, 42, '[ASUS] Thinkpad X1 carbone Gen 13', 'Lenovo', '21NSS02W00', 'Y', 2100000, 'Y', 62000, 15, 'Lenovo Thinkpad X1 노트북입니다', 'Y', 180, 8),

-- (340, 41, '[MSI] 비보북 S16 QLED', 'ASUS', 'M3607HA-SH113', 'Y', 990000, 'N', NULL, 15, 'ASUS 비보북 노트북 입니다(대여X)', 'Y', 35, 0),
-- (341, 43, '[MSI] ROG 제피러스 G16', 'ASUS', 'GU606AP-TB025W', 'Y', 1500000, 'N', NULL, 32, 'ASUS 제피러스 G16 게이밍 노트북입니다. (대여X)', 'Y', 32, 0),
-- (342, 42, '[MSI] ExpertBook P1', 'ASUS', 'PM1503CDA-S70237', 'Y', 1760000, 'N', NULL, 88, 'AsUS ExpertBook P1 노트북입니다. (대여X)', 'N', 99, 0),

-- (350, 43, '[알파스캔] HyperX 오멘, Intel_i7-14650HX', 'HP', '15-ga0030TX', 'Y', 3259000, 'N', NULL, 12, 'HP HyperX오멘 게이밍 노트북입니다. (대여X)', 'Y', 111, 0),
-- (351, 42, '[알파스캔] 엘리트북 860 G11 울트라5-125H', 'HP', 'A1VH4PT', 'Y', 2280000, 'Y', 68000, 423, 'HP 엘리트북 860 G11 울트라5-125H 노트북입니다.', 'Y', 123, 33),
-- (352, 42, '[알파스캔] 옴니북5 AI 코어5-320', 'HP', '14-kf0024TU', 'Y', 1700000, 'Y', 52000, 100, 'HP 옴니북5 AI 코어5-320 노트북입니다', 'Y', 79, 8),




--4. 노트북 (사무용: 41, 전문가용: 42, 게이밍용: 43) // 총 24개 완료
-- (1, 42, '[Apple] MacBook Pro 16, M5, Silver', 'Apple', 'MGDR4KH/A', 'Y', 4500000, 'Y', 90000, 15, '전문가용 최고사양 맥북', 'Y', 350, 12),
-- (2, 44, 'MacBook Air 15 M3', 'Apple', 'MDVH4KH/A', 'Y', 2000000, 'Y', 60000, 30, '가벼운 사무용 맥북', 'N', 520, 45),
-- (6, 41, 'LG 그램북 AI 2026', 'LG전자', '15U50U-GA5HK', 'Y', 2200000, 'Y', 65000, 25, '가볍고 실용적이면서도 확장성까지 고려한 노트북', 'Y', 410, 30),

(400, 42, '[Apple] MacBook Pro 16, M5, Silver', 'Apple', 'Z1N00005U', 'Y', 3000000, 'N', NULL, 250, '애플 맥북 프로 16 M5 실버 색상 노트북입니다(대여 불가)', 'Y', 300, 0),
(401, 42, '[Apple] MacBook Pro 14, M5, Silver', 'Apple', 'MGDR4KH/A', 'Y', 2500000, 'Y', 75000, 3, '애플 맥북 프로 14 M5 실버 색상 노트북입니다', 'Y', 400, 7),
(402, 41, '[Apple] MacBook Air 15, M3, StarLight', 'Apple', 'Z1GF00013', 'Y', 2000000, 'Y', 60000, 30, '애플 맥북 에어 15 M3 스타라이트 색상 노트북입니다', 'N', 520, 45),
(403, 41, '[Apple] MacBook Air 13, M5, Silver', 'Apple', 'Z1L0000Q0', 'Y', 2250000, 'Y', 69000, 24, '애플 맥북 에어 13 M5 실버 색상 노트북입니다.', 'Y', 520, 22),
(404, 41, '[Apple] MacBook Neo, A18, Silver', 'Apple', 'Z1TN0000F', 'Y', 1700000, 'N', NULL, 38, '애플 맥북 네오 A18 실버 색상 노트북입니다(대여불가)', 'Y', 388, 0),

(410, 42, '[삼성] 갤럭시북5 프로, IntelCore-Ultra_7, Coplit+ PC', 'Samsung', 'NT960XHA-KC71G', 'Y', 2499999, 'Y', 75000, 100, '삼성 갤럭시북5 프로, 인텔 코어 울트라 7, Copliot+ 노트북입니다', 'Y', 800, 12),
(411, 42, '[삼성] 갤럭시북6 프로, 그레이', 'Samsung', 'NT940XJG-K72A', 'Y', 3650000, 'N', NULL, 110, '삼성 갤럭시북6 프로 그레이 색상 노트북입니다(대여불가)', 'Y', 777, 0),
(412, 41, '[삼성] 갤럭시북6 엣지, Snapdragon X2 Elite, Copliot+ PC', 'Samsung', 'NT960XRD-KC01B', 'Y', 2870000, 'Y', 80000, 99, '삼성 갤럭시북6 엣지, 스냅드래곤X2엘리트 copliot+PC 노트북입니다', 'N', 500, 42),
(413, 41, '[삼성] 갤럭시북5, 그레이', 'Samsung', 'NT750XHD-K71A', 'Y', 2200000, 'N', NULL, 70, '삼성 갤럭시북5 그레이 색상 노트북입니다', 'Y', 76, 0),
(414, 41, '[삼성] 갤럭시북4, 그레이', 'Samsung', 'NT750XGR-A71A', 'Y', 1140000, 'N', NULL, 20, '삼성 갤럭시북4 그레이 색상 노트북입니다','N', 23, 0),

(420, 42, '[LG] 그램 Pro 360 AI, IntelCore-Ultra_7', 'LG', '16T90TP-GD7BK', 'Y', 2350000, 'Y', 70000, 100, 'LG 그램 프로 360 AI 인텔코어 울트라 7 노트북입니다', 'Y', 888, 28),
(421, 42, '[LG] 그램 Pro AI 2026, IntelCore-Ultra_5, Copilot+ PC', 'LG', '16Z90U-KS5WK', 'Y', 3240000, 'Y', 97000, 25, 'LG노트북입니다', 'Y', 120, 20),
(422, 42, '[LG] 그램 Pro AI 2026, AMD Ryzen-AI_5, Copilot+ PC', 'LG', '16Z95U-GS5W', 'Y', 3000000, 'Y', 95000, 33, 'LG노트북입니다', 'N', 100, 42 ),
(423, 41, '[LG] 그램 AI 2026, AMD Ryzen_AI-5, Copilot+ PC', 'LG', '15Z95U-GS5SK', 'Y', 2500000, 'Y', 72000, 12, 'LG노트북입니다', 'Y', 99, 9),
(424, 41, '[LG] 그램, IntelCore_Ultra-5', 'LG', '14ZB90S-GA5WK', 'Y', 1300000, 'N', NULL, 77, 'LG 노트북입니다(대여불가)', 'N', 43, 0),

(430, 42, '[Lenovo] Thinkpad E14 IPL G8 U7 3K AI', 'Lenovo', '21Y60065KR', 'Y', 1899000, 'Y', 60000, 200, 'Lenovo Thinkpad 노트북 입니다', 'N', 66, 21),
(431, 41, '[Lenovo] Ideapad Slim3-15IRU8', 'Lenovo', '82X700HWKR', 'Y', 1200000, 'N', NULL, 11, 'Lenovo Ideapad노트북 입니다(대여X)', 'N', 87, 0),
(432, 42, '[Lenovo] Thinkpad X1 carbone Gen 13', 'Lenovo', '21NSS02W00', 'Y', 2100000, 'Y', 62000, 15, 'Lenovo Thinkpad X1 노트북입니다', 'Y', 180, 8),

(440, 41, '[ASUS] 비보북 S16 QLED', 'ASUS', 'M3607HA-SH113', 'Y', 990000, 'N', NULL, 15, 'ASUS 비보북 노트북 입니다(대여X)', 'Y', 35, 0),
(441, 43, '[ASUS] ROG 제피러스 G16', 'ASUS', 'GU606AP-TB025W', 'Y', 1500000, 'N', NULL, 32, 'ASUS 제피러스 G16 게이밍 노트북입니다. (대여X)', 'Y', 32, 0),
(442, 42, '[ASUS] ExpertBook P1', 'ASUS', 'PM1503CDA-S70237', 'Y', 1760000, 'N', NULL, 88, 'AsUS ExpertBook P1 노트북입니다. (대여X)', 'N', 99, 0),

(450, 43, '[HP] HyperX 오멘, Intel_i7-14650HX', 'HP', '15-ga0030TX', 'Y', 3259000, 'N', NULL, 12, 'HP HyperX오멘 게이밍 노트북입니다. (대여X)', 'Y', 111, 0),
(451, 42, '[HP] 엘리트북 860 G11 울트라5-125H', 'HP', 'A1VH4PT', 'Y', 2280000, 'Y', 68000, 423, 'HP 엘리트북 860 G11 울트라5-125H 노트북입니다.', 'Y', 123, 33),
(452, 42, '[HP] 옴니북5 AI 코어5-320', 'HP', '14-kf0024TU', 'Y', 1700000, 'Y', 52000, 100, 'HP 옴니북5 AI 코어5-320 노트북입니다', 'Y', 79, 8),


--5. 스마트 기기 (태블릿 (iPad/GalaxyTab): 51, 스마트워치/웨어러블: 52, VR/AR 기기: 53)
-- (13, 51, '애플 아이패드 프로', 'Apple', 'ipadprotest', 'Y', 1232323, 'Y', 30000, 999, '애플 아이패드 프로 태블릿입니다.', 'Y', 312, 21),
-- (14, 51, '갤럭시 탭 S10+', 'Samsung', 'SM-X820NZAAKOO', 'Y', 1240000, 'Y', 60000, 500, '삼성 갤럭시 탭 S10+ (Wi-Fi) 태블릿입니다.', 'Y', 412, 23),
-- (15, 52, '애플 워치 6', 'Apple', 'applewatch6', 'Y', 230000, 'N', NULL, 400, '애플워치6 입니다(대여x)', 'Y', 123, 0),
-- (16, 53, '메타 오큘러스 VR', 'Meta', 'oculus123', 'Y', 400000, 'N', NULL, 123, '메타 오큘러스 VR기기 입니다(대여x)', 'N', 32, 0),


(500, 51, '[Apple] Apple 2025 아이패드 프로 13(M5 모델) 스탠다드 글래스', 'Apple', 'MDYJ4KH/A', 'Y', 1900000, 'Y', 42000, 777, '애플 아이패드 프로 13(M5 모델) 스탠다드 글래스 태블릿입니다', 'Y', 888, 99),
-- (501, 42, '[Apple] MacBook Pro 14, M5, Silver', 'Apple', 'MGDR4KH/A', 'Y', 2500000, 'Y', 75000, 3, '애플 맥북 프로 14 M5 실버 색상 노트북입니다', 'Y', 400, 7),
-- (502, 41, '[Apple] MacBook Air 15, M3, StarLight', 'Apple', 'Z1GF00013', 'Y', 2000000, 'Y', 60000, 30, '애플 맥북 에어 15 M3 스타라이트 색상 노트북입니다', 'N', 520, 45),
(503, 52, '[Apple] Apple 워치 11 GPS 스페이스 그레이 알루미늄 46mm, 블랙 스포츠 밴드', 'Apple', 'MEV44KH/A', 'Y', 539000, 'N', NULL, 18, '애플워치 11 GPS 46mm 스페이스 그레이 알루미늄 케이스, 블랙 스포츠 밴드 스마트워치입니다', 'Y', 642, 99),
-- (504, 41, '[Apple] MacBook Neo, A18, Silver', 'Apple', 'Z1TN0000F', 'Y', 1700000, 'N', NULL, 38, '애플 맥북 네오 A18 실버 색상 노트북입니다(대여불가)', 'Y', 388, 0),

-- (510, 42, '[삼성] 갤럭시북5 프로, IntelCore-Ultra_7, Coplit+ PC', 'Samsung', 'NT960XHA-KC71G', 'Y', 2499999, 'Y', 75000, 100, '삼성 갤럭시북5 프로, 인텔 코어 울트라 7, Copliot+ 노트북입니다', 'Y', 800, 12),
-- (511, 42, '[삼성] 갤럭시북6 프로, 그레이', 'Samsung', 'NT940XJG-K72A', 'Y', 3650000, 'N', NULL, 110, '삼성 갤럭시북6 프로 그레이 색상 노트북입니다(대여불가)', 'Y', 777, 0),
(512, 51, '[삼성] 갤럭시탭 S10 Lite 라이트 128GB 그레이 (WI-FI)', 'Samsung', 'SM-X400NZAAKOO', 'Y', 530000, 'Y', 15000, 54, '삼성 갤탭 S10 라이트 태블릿입니다', 'N', 312, 12),
(513, 52, '[삼성] 갤럭시워치8 클래식 스마트워치 SM-L500N, 블랙, 46mm, 블루투스', 'Samsung', 'SM-L500N', 'Y', 500000, 'N', NULL, 70, '삼성 갤럭시워치8 클래식 46mm 블루투스 블랙 스마트워치입니다', 'Y', 124, 0),
-- (514, 41, '[삼성] 갤럭시북4, 그레이', 'Samsung', 'NT750XGR-A71A', 'Y', 1140000, 'N', NULL, 20, '삼성 갤럭시북4 그레이 색상 노트북입니다','N', 23, 0),

(520, 53, '[Meta] Meta Quest 3S 128GB VR', 'Meta', 'Meta-Quest-3S', 'Y', 550000, 'N', NULL, 33, 'Meta Quest 3S 128GB VR입니다', 'Y', 14, 0),
-- (521, 42, '[LG] 그램 Pro AI 2026, IntelCore-Ultra_5, Copilot+ PC', 'LG', '16Z90U-KS5WK', 'Y', 3240000, 'Y', 97000, 25, 'LG노트북입니다', 'Y', 120, 20),
-- (522, 42, '[LG] 그램 Pro AI 2026, AMD Ryzen-AI_5, Copilot+ PC', 'LG', '16Z95U-GS5W', 'Y', 3000000, 'Y', 95000, 33, 'LG노트북입니다', 'N', 100, 42 ),
-- (523, 41, '[LG] 그램 AI 2026, AMD Ryzen_AI-5, Copilot+ PC', 'LG', '15Z95U-GS5SK', 'Y', 2500000, 'Y', 72000, 12, 'LG노트북입니다', 'Y', 99, 9),
-- (524, 41, '[LG] 그램, IntelCore_Ultra-5', 'LG', '14ZB90S-GA5WK', 'Y', 1300000, 'N', NULL, 77, 'LG 노트북입니다(대여불가)', 'N', 43, 0),


--6. 사무/주변기기 (프린터/복합기 : 61, 빔프로젝터/화상장비: 62, 기타(키보드/마우스/허브): 63, 기타(악세서리/관련 케이블): 64)
(17, 61, '캐논 프린터', 'Canon', 'k12345', 'Y', 700000, 'Y', 20000, 29, '캐논 프린터입니다', 'N', 54, 2),
(18, 62, '소니 빔프로젝터', 'Sony', 'sa1020', 'Y', 800000, 'Y', 15000, 32, '소니 빔프로젝터입니다', 'Y', 41, 4),
(19, 63, '잠자리 마우스', 'VGN', 'A90123', 'Y', 80000, 'N', NULL, 99, '잠자리 마우스입니다', 'Y', 99, 0),
(20, 64, 'HDMI케이블', 'HDMI', '123123', 'Y', 20000, 'N', NULL, 100, 'HDMI케이블입니다', 'N', 100, 0),


-- (600, 42, '[Canon] MacBook Pro 16, M5, Silver', 'Apple', 'Z1N00005U', 'Y', 3000000, 'N', NULL, 250, '애플 맥북 프로 16 M5 실버 색상 노트북입니다(대여 불가)', 'Y', 300, 0),
-- (601, 42, '[Canon] MacBook Pro 14, M5, Silver', 'Apple', 'MGDR4KH/A', 'Y', 2500000, 'Y', 75000, 3, '애플 맥북 프로 14 M5 실버 색상 노트북입니다', 'Y', 400, 7),
-- (602, 41, '[Canon] MacBook Air 15, M3, StarLight', 'Apple', 'Z1GF00013', 'Y', 2000000, 'Y', 60000, 30, '애플 맥북 에어 15 M3 스타라이트 색상 노트북입니다', 'N', 520, 45),
-- (603, 41, '[Canon] MacBook Air 13, M5, Silver', 'Apple', 'Z1L0000Q0', 'Y', 2250000, 'Y', 69000, 24, '애플 맥북 에어 13 M5 실버 색상 노트북입니다.', 'Y', 520, 22),
-- (604, 41, '[Canon] MacBook Neo, A18, Silver', 'Apple', 'Z1TN0000F', 'Y', 1700000, 'N', NULL, 38, '애플 맥북 네오 A18 실버 색상 노트북입니다(대여불가)', 'Y', 388, 0),

-- (610, 42, '[EPSON] 갤럭시북5 프로, IntelCore-Ultra_7, Coplit+ PC', 'Samsung', 'NT960XHA-KC71G', 'Y', 2499999, 'Y', 75000, 100, '삼성 갤럭시북5 프로, 인텔 코어 울트라 7, Copliot+ 노트북입니다', 'Y', 800, 12),
-- (611, 42, '[EPSON] 갤럭시북6 프로, 그레이', 'Samsung', 'NT940XJG-K72A', 'Y', 3650000, 'N', NULL, 110, '삼성 갤럭시북6 프로 그레이 색상 노트북입니다(대여불가)', 'Y', 777, 0),
-- (612, 41, '[EPSON] 갤럭시북6 엣지, Snapdragon X2 Elite, Copliot+ PC', 'Samsung', 'NT960XRD-KC01B', 'Y', 2870000, 'Y', 80000, 99, '삼성 갤럭시북6 엣지, 스냅드래곤X2엘리트 copliot+PC 노트북입니다', 'N', 500, 42),
-- (613, 41, '[EPSON] 갤럭시북5, 그레이', 'Samsung', 'NT750XHD-K71A', 'Y', 2200000, 'N', NULL, 70, '삼성 갤럭시북5 그레이 색상 노트북입니다', 'Y', 76, 0),
-- (614, 41, '[EPSON] 갤럭시북4, 그레이', 'Samsung', 'NT750XGR-A71A', 'Y', 1140000, 'N', NULL, 20, '삼성 갤럭시북4 그레이 색상 노트북입니다','N', 23, 0),

-- (620, 42, '[SONY] 그램 Pro 360 AI, IntelCore-Ultra_7', 'LG', '16T90TP-GD7BK', 'Y', 2350000, 'Y', 70000, 100, 'LG 그램 프로 360 AI 인텔코어 울트라 7 노트북입니다', 'Y', 888, 28),
-- (621, 42, '[SONY] 그램 Pro AI 2026, IntelCore-Ultra_5, Copilot+ PC', 'LG', '16Z90U-KS5WK', 'Y', 3240000, 'Y', 97000, 25, 'LG노트북입니다', 'Y', 120, 20),
-- (622, 42, '[SONY] 그램 Pro AI 2026, AMD Ryzen-AI_5, Copilot+ PC', 'LG', '16Z95U-GS5W', 'Y', 3000000, 'Y', 95000, 33, 'LG노트북입니다', 'N', 100, 42 ),
-- (623, 41, '[SONY] 그램 AI 2026, AMD Ryzen_AI-5, Copilot+ PC', 'LG', '15Z95U-GS5SK', 'Y', 2500000, 'Y', 72000, 12, 'LG노트북입니다', 'Y', 99, 9),
-- (624, 41, '[SONY] 그램, IntelCore_Ultra-5', 'LG', '14ZB90S-GA5WK', 'Y', 1300000, 'N', NULL, 77, 'LG 노트북입니다(대여불가)', 'N', 43, 0),

-- (630, 42, '[Logitech] Thinkpad E14 IPL G8 U7 3K AI', 'Lenovo', '21Y60065KR', 'Y', 1899000, 'Y', 60000, 200, 'Lenovo Thinkpad 노트북 입니다', 'N', 66, 21),
-- (631, 41, '[Logitech] Ideapad Slim3-15IRU8', 'Lenovo', '82X700HWKR', 'Y', 1200000, 'N', NULL, 11, 'Lenovo Ideapad노트북 입니다(대여X)', 'N', 87, 0),
-- (632, 42, '[Logitech] Thinkpad X1 carbone Gen 13', 'Lenovo', '21NSS02W00', 'Y', 2100000, 'Y', 62000, 15, 'Lenovo Thinkpad X1 노트북입니다', 'Y', 180, 8),

-- (640, 41, '[RAZER] 비보북 S16 QLED', 'ASUS', 'M3607HA-SH113', 'Y', 990000, 'N', NULL, 15, 'ASUS 비보북 노트북 입니다(대여X)', 'Y', 35, 0),
-- (641, 43, '[RAZER] ROG 제피러스 G16', 'ASUS', 'GU606AP-TB025W', 'Y', 1500000, 'N', NULL, 32, 'ASUS 제피러스 G16 게이밍 노트북입니다. (대여X)', 'Y', 32, 0),
-- (642, 42, '[RAZER] ExpertBook P1', 'ASUS', 'PM1503CDA-S70237', 'Y', 1760000, 'N', NULL, 88, 'AsUS ExpertBook P1 노트북입니다. (대여X)', 'N', 99, 0),

-- (650, 43, '[VGN] HyperX 오멘, Intel_i7-14650HX', 'HP', '15-ga0030TX', 'Y', 3259000, 'N', NULL, 12, 'HP HyperX오멘 게이밍 노트북입니다. (대여X)', 'Y', 111, 0),
-- (651, 42, '[코드웨이] 엘리트북 860 G11 울트라5-125H', 'HP', 'A1VH4PT', 'Y', 2280000, 'Y', 68000, 423, 'HP 엘리트북 860 G11 울트라5-125H 노트북입니다.', 'Y', 123, 33),
-- (652, 42, '[마하링크] 옴니북5 AI 코어5-320', 'HP', '14-kf0024TU', 'Y', 1700000, 'Y', 52000, 100, 'HP 옴니북5 AI 코어5-320 노트북입니다', 'Y', 79, 8),


--7. 서버/워크스테이션 (서버 (랙/타워형): 71, 고성능 워크스테이션: 72, NAS / 스토리지: 73)
(10, 72, 'Mac Studio M2 Ultra', 'Apple', 'MAC-STU', 'Y', 6000000, 'Y', 180000, 3, '스튜디오용 영상편집 데스크탑', 'Y', 450, 4),


-- (700, 42, '[Apple] MacBook Pro 16, M5, Silver', 'Apple', 'Z1N00005U', 'Y', 3000000, 'N', NULL, 250, '애플 맥북 프로 16 M5 실버 색상 노트북입니다(대여 불가)', 'Y', 300, 0),
-- (701, 42, '[Apple] MacBook Pro 14, M5, Silver', 'Apple', 'MGDR4KH/A', 'Y', 2500000, 'Y', 75000, 3, '애플 맥북 프로 14 M5 실버 색상 노트북입니다', 'Y', 400, 7),
-- (702, 41, '[Apple] MacBook Air 15, M3, StarLight', 'Apple', 'Z1GF00013', 'Y', 2000000, 'Y', 60000, 30, '애플 맥북 에어 15 M3 스타라이트 색상 노트북입니다', 'N', 520, 45),
-- (703, 41, '[Apple] MacBook Air 13, M5, Silver', 'Apple', 'Z1L0000Q0', 'Y', 2250000, 'Y', 69000, 24, '애플 맥북 에어 13 M5 실버 색상 노트북입니다.', 'Y', 520, 22),
-- (704, 41, '[Apple] MacBook Neo, A18, Silver', 'Apple', 'Z1TN0000F', 'Y', 1700000, 'N', NULL, 38, '애플 맥북 네오 A18 실버 색상 노트북입니다(대여불가)', 'Y', 388, 0),

-- (710, 42, '[DELL] 갤럭시북5 프로, IntelCore-Ultra_7, Coplit+ PC', 'Samsung', 'NT960XHA-KC71G', 'Y', 2499999, 'Y', 75000, 100, '삼성 갤럭시북5 프로, 인텔 코어 울트라 7, Copliot+ 노트북입니다', 'Y', 800, 12),
-- (711, 42, '[DELL] 갤럭시북6 프로, 그레이', 'Samsung', 'NT940XJG-K72A', 'Y', 3650000, 'N', NULL, 110, '삼성 갤럭시북6 프로 그레이 색상 노트북입니다(대여불가)', 'Y', 777, 0),
-- (712, 41, '[DELL] 갤럭시북6 엣지, Snapdragon X2 Elite, Copliot+ PC', 'Samsung', 'NT960XRD-KC01B', 'Y', 2870000, 'Y', 80000, 99, '삼성 갤럭시북6 엣지, 스냅드래곤X2엘리트 copliot+PC 노트북입니다', 'N', 500, 42),
-- (713, 41, '[DELL] 갤럭시북5, 그레이', 'Samsung', 'NT750XHD-K71A', 'Y', 2200000, 'N', NULL, 70, '삼성 갤럭시북5 그레이 색상 노트북입니다', 'Y', 76, 0),
-- (714, 41, '[DELL] 갤럭시북4, 그레이', 'Samsung', 'NT750XGR-A71A', 'Y', 1140000, 'N', NULL, 20, '삼성 갤럭시북4 그레이 색상 노트북입니다','N', 23, 0),

-- (720, 42, '[HPE] 그램 Pro 360 AI, IntelCore-Ultra_7', 'LG', '16T90TP-GD7BK', 'Y', 2350000, 'Y', 70000, 100, 'LG 그램 프로 360 AI 인텔코어 울트라 7 노트북입니다', 'Y', 888, 28),
-- (721, 42, '[HPE] 그램 Pro AI 2026, IntelCore-Ultra_5, Copilot+ PC', 'LG', '16Z90U-KS5WK', 'Y', 3240000, 'Y', 97000, 25, 'LG노트북입니다', 'Y', 120, 20),
-- (722, 42, '[HPE] 그램 Pro AI 2026, AMD Ryzen-AI_5, Copilot+ PC', 'LG', '16Z95U-GS5W', 'Y', 3000000, 'Y', 95000, 33, 'LG노트북입니다', 'N', 100, 42 ),
-- (723, 41, '[HPE] 그램 AI 2026, AMD Ryzen_AI-5, Copilot+ PC', 'LG', '15Z95U-GS5SK', 'Y', 2500000, 'Y', 72000, 12, 'LG노트북입니다', 'Y', 99, 9),
-- (724, 41, '[HPE] 그램, IntelCore_Ultra-5', 'LG', '14ZB90S-GA5WK', 'Y', 1300000, 'N', NULL, 77, 'LG 노트북입니다(대여불가)', 'N', 43, 0),

-- (730, 42, '[Lenovo] Thinkpad E14 IPL G8 U7 3K AI', 'Lenovo', '21Y60065KR', 'Y', 1899000, 'Y', 60000, 200, 'Lenovo Thinkpad 노트북 입니다', 'N', 66, 21),
-- (731, 41, '[Lenovo] Ideapad Slim3-15IRU8', 'Lenovo', '82X700HWKR', 'Y', 1200000, 'N', NULL, 11, 'Lenovo Ideapad노트북 입니다(대여X)', 'N', 87, 0),
-- (732, 42, '[Lenovo] Thinkpad X1 carbone Gen 13', 'Lenovo', '21NSS02W00', 'Y', 2100000, 'Y', 62000, 15, 'Lenovo Thinkpad X1 노트북입니다', 'Y', 180, 8),

-- (740, 41, '[HP] 비보북 S16 QLED', 'ASUS', 'M3607HA-SH113', 'Y', 990000, 'N', NULL, 15, 'ASUS 비보북 노트북 입니다(대여X)', 'Y', 35, 0),
-- (741, 43, '[HP] ROG 제피러스 G16', 'ASUS', 'GU606AP-TB025W', 'Y', 1500000, 'N', NULL, 32, 'ASUS 제피러스 G16 게이밍 노트북입니다. (대여X)', 'Y', 32, 0),
-- (742, 42, '[HP] ExpertBook P1', 'ASUS', 'PM1503CDA-S70237', 'Y', 1760000, 'N', NULL, 88, 'AsUS ExpertBook P1 노트북입니다. (대여X)', 'N', 99, 0),

-- (750, 43, '[Synology] HyperX 오멘, Intel_i7-14650HX', 'HP', '15-ga0030TX', 'Y', 3259000, 'N', NULL, 12, 'HP HyperX오멘 게이밍 노트북입니다. (대여X)', 'Y', 111, 0),
-- (751, 42, '[Synology] 엘리트북 860 G11 울트라5-125H', 'HP', 'A1VH4PT', 'Y', 2280000, 'Y', 68000, 423, 'HP 엘리트북 860 G11 울트라5-125H 노트북입니다.', 'Y', 123, 33),
-- (752, 42, '[QNAP] 옴니북5 AI 코어5-320', 'HP', '14-kf0024TU', 'Y', 1700000, 'Y', 52000, 100, 'HP 옴니북5 AI 코어5-320 노트북입니다', 'Y', 79, 8),



--8. 기타 PC 부품 (CPU (프로세서): 81, 그래픽카드 (VGA): 82, RAM (메모리): 83, 메인보드 (Motherboard): 84, 저장장치 (SSD/HDD): 85, 파워서플라이: 86, 케이스 / 쿨러 / 튜닝: 87)
(11, 82, '지포스 RTX 4090 D6X 24GB', 'NVIDIA', 'RTX-4090', 'Y', 2800000, 'Y', 200000, 10, '고수익 단기 렌탈용 하이엔드 그래픽카드', 'Y', 600, 10),
(12, 83, 'DDR5-5600 16GB RAM', '삼성전자', 'DDR5-16G', 'Y', 60000, 'N', NULL, 300, '단순 판매 및 조립 옵션용 (대여 불가)', 'N', 50, 0);

-- (800, 81, '[CPU - Intel] MacBook Pro 16, M5, Silver', 'Apple', 'Z1N00005U', 'Y', 3000000, 'N', NULL, 250, '애플 맥북 프로 16 M5 실버 색상 노트북입니다(대여 불가)', 'Y', 300, 0),
-- (801, 42, '[CPU - Intel] MacBook Pro 14, M5, Silver', 'Apple', 'MGDR4KH/A', 'Y', 2500000, 'Y', 75000, 3, '애플 맥북 프로 14 M5 실버 색상 노트북입니다', 'Y', 400, 7),
-- (802, 41, '[CPU - Intel] MacBook Air 15, M3, StarLight', 'Apple', 'Z1GF00013', 'Y', 2000000, 'Y', 60000, 30, '애플 맥북 에어 15 M3 스타라이트 색상 노트북입니다', 'N', 520, 45),
-- (803, 41, '[CPU - Intel] MacBook Air 13, M5, Silver', 'Apple', 'Z1L0000Q0', 'Y', 2250000, 'Y', 69000, 24, '애플 맥북 에어 13 M5 실버 색상 노트북입니다.', 'Y', 520, 22),
-- (804, 41, '[CPU - Intel] MacBook Neo, A18, Silver', 'Apple', 'Z1TN0000F', 'Y', 1700000, 'N', NULL, 38, '애플 맥북 네오 A18 실버 색상 노트북입니다(대여불가)', 'Y', 388, 0),

-- (810, 81, '[CPU - AMD] 갤럭시북5 프로, IntelCore-Ultra_7, Coplit+ PC', 'Samsung', 'NT960XHA-KC71G', 'Y', 2499999, 'Y', 75000, 100, '삼성 갤럭시북5 프로, 인텔 코어 울트라 7, Copliot+ 노트북입니다', 'Y', 800, 12),
-- (811, 42, '[CPU - AMD] 갤럭시북6 프로, 그레이', 'Samsung', 'NT940XJG-K72A', 'Y', 3650000, 'N', NULL, 110, '삼성 갤럭시북6 프로 그레이 색상 노트북입니다(대여불가)', 'Y', 777, 0),
-- (812, 41, '[CPU - AMD] 갤럭시북6 엣지, Snapdragon X2 Elite, Copliot+ PC', 'Samsung', 'NT960XRD-KC01B', 'Y', 2870000, 'Y', 80000, 99, '삼성 갤럭시북6 엣지, 스냅드래곤X2엘리트 copliot+PC 노트북입니다', 'N', 500, 42),
-- (813, 41, '[CPU - AMD] 갤럭시북5, 그레이', 'Samsung', 'NT750XHD-K71A', 'Y', 2200000, 'N', NULL, 70, '삼성 갤럭시북5 그레이 색상 노트북입니다', 'Y', 76, 0),
-- (814, 41, '[CPU - AMD] 갤럭시북4, 그레이', 'Samsung', 'NT750XGR-A71A', 'Y', 1140000, 'N', NULL, 20, '삼성 갤럭시북4 그레이 색상 노트북입니다','N', 23, 0),

-- (820, 82, '[VGA - NVIDIA] 그램 Pro 360 AI, IntelCore-Ultra_7', 'LG', '16T90TP-GD7BK', 'Y', 2350000, 'Y', 70000, 100, 'LG 그램 프로 360 AI 인텔코어 울트라 7 노트북입니다', 'Y', 888, 28),
-- (821, 42, '[LG] 그램 Pro AI 2026, IntelCore-Ultra_5, Copilot+ PC', 'LG', '16Z90U-KS5WK', 'Y', 3240000, 'Y', 97000, 25, 'LG노트북입니다', 'Y', 120, 20),
-- (822, 42, '[LG] 그램 Pro AI 2026, AMD Ryzen-AI_5, Copilot+ PC', 'LG', '16Z95U-GS5W', 'Y', 3000000, 'Y', 95000, 33, 'LG노트북입니다', 'N', 100, 42 ),
-- (823, 41, '[LG] 그램 AI 2026, AMD Ryzen_AI-5, Copilot+ PC', 'LG', '15Z95U-GS5SK', 'Y', 2500000, 'Y', 72000, 12, 'LG노트북입니다', 'Y', 99, 9),
-- (824, 41, '[LG] 그램, IntelCore_Ultra-5', 'LG', '14ZB90S-GA5WK', 'Y', 1300000, 'N', NULL, 77, 'LG 노트북입니다(대여불가)', 'N', 43, 0),

-- (830, 83, '[RAM - SK] Thinkpad E14 IPL G8 U7 3K AI', 'Lenovo', '21Y60065KR', 'Y', 1899000, 'Y', 60000, 200, 'Lenovo Thinkpad 노트북 입니다', 'N', 66, 21),
-- (831, 41, '[Lenovo] Ideapad Slim3-15IRU8', 'Lenovo', '82X700HWKR', 'Y', 1200000, 'N', NULL, 11, 'Lenovo Ideapad노트북 입니다(대여X)', 'N', 87, 0),
-- (832, 42, '[Lenovo] Thinkpad X1 carbone Gen 13', 'Lenovo', '21NSS02W00', 'Y', 2100000, 'Y', 62000, 15, 'Lenovo Thinkpad X1 노트북입니다', 'Y', 180, 8),

-- (840, 41, '[ASUS] 비보북 S16 QLED', 'ASUS', 'M3607HA-SH113', 'Y', 990000, 'N', NULL, 15, 'ASUS 비보북 노트북 입니다(대여X)', 'Y', 35, 0),
-- (841, 43, '[ASUS] ROG 제피러스 G16', 'ASUS', 'GU606AP-TB025W', 'Y', 1500000, 'N', NULL, 32, 'ASUS 제피러스 G16 게이밍 노트북입니다. (대여X)', 'Y', 32, 0),
-- (842, 42, '[ASUS] ExpertBook P1', 'ASUS', 'PM1503CDA-S70237', 'Y', 1760000, 'N', NULL, 88, 'AsUS ExpertBook P1 노트북입니다. (대여X)', 'N', 99, 0),

-- (850, 43, '[HP] HyperX 오멘, Intel_i7-14650HX', 'HP', '15-ga0030TX', 'Y', 3259000, 'N', NULL, 12, 'HP HyperX오멘 게이밍 노트북입니다. (대여X)', 'Y', 111, 0),
-- (851, 42, '[HP] 엘리트북 860 G11 울트라5-125H', 'HP', 'A1VH4PT', 'Y', 2280000, 'Y', 68000, 423, 'HP 엘리트북 860 G11 울트라5-125H 노트북입니다.', 'Y', 123, 33),
-- (852, 42, '[HP] 옴니북5 AI 코어5-320', 'HP', '14-kf0024TU', 'Y', 1700000, 'Y', 52000, 100, 'HP 옴니북5 AI 코어5-320 노트북입니다', 'Y', 79, 8),




--======이미지 경로=======--
-- 예시 데이터 --
-- UPDATE product SET image_url = '/images/product/MacBook Air 15 M3.jpg'        WHERE product_id = 2; //노트북
UPDATE product SET image_url = '/images/product/rtx4090-workstation.jpg' WHERE product_id = 3;
UPDATE product SET image_url = '/images/product/rog-4070.jpg'           WHERE product_id = 4;
-- UPDATE product SET image_url = '/images/product/lg-4k-monitor.jpg'      WHERE product_id = 5; //모니터
-- UPDATE product SET image_url = '/images/product/LG 그램북 AI 2026.jpg'       WHERE product_id = 6; //노트북 
-- UPDATE product SET image_url = '/images/product/레노버 씽크패드 X1 카본 Gen 13.jpg'        WHERE product_id = 7; //노트북 
-- UPDATE product SET image_url = '/images/product/intel-nuc.jpg'          WHERE product_id = 8; //PC
-- UPDATE product SET image_url = '/images/product/lg-gaming-monitor.jpg'  WHERE product_id = 9; //모니터
UPDATE product SET image_url = '/images/product/mac-studio.jpg'         WHERE product_id = 10;
UPDATE product SET image_url = '/images/product/rtx4090.jpg'            WHERE product_id = 11;
UPDATE product SET image_url = '/images/product/ddr5-ram.jpg'           WHERE product_id = 12;
-- UPDATE product SET image_url = '/images/product/galaxy-tab.jpg'           WHERE product_id = 13; //스마트 기기
UPDATE product SET image_url = '/images/product/ipad.jpg'           WHERE product_id = 14;
-- UPDATE product SET image_url = '/images/product/applewatch.jpg'           WHERE product_id = 15; //스마트 기기
-- UPDATE product SET image_url = '/images/product/meta-vr.jpg'           WHERE product_id = 16; //스마트 기기
UPDATE product SET image_url = '/images/product/canonprint.jpg'           WHERE product_id = 17;
UPDATE product SET image_url = '/images/product/sonyvim.jpg'           WHERE product_id = 18;
UPDATE product SET image_url = '/images/product/dragonfly.jpg'           WHERE product_id = 19;
UPDATE product SET image_url = '/images/product/hdmi.jpg'           WHERE product_id = 20;



--1.PC
UPDATE product SET image_url = '/images/product/desktop/Apple-iMac-24-2024-M4.jpg'  WHERE product_id = 100; 
UPDATE product SET image_url = '/images/product/desktop/Apple-iMac-27-2020-i7.jpg' WHERE product_id = 101;
UPDATE product SET image_url = '/images/product/desktop/Apple-iMac-27-2019-i9.jpg' WHERE product_id = 102;
UPDATE product SET image_url = '/images/product/desktop/Apple-iMac-G3-1998.jpg' WHERE product_id = 103;
UPDATE product SET image_url = '/images/product/desktop/Apple-Macintosh-1984.jpg' WHERE product_id = 104;
UPDATE product SET image_url = '/images/product/desktop/Apple-MacMini-2023-M2.jpg' WHERE product_id = 105;

-- UPDATE product SET image_url = '/images/product/laptop/삼성-갤럭시북5-프로-IntelCoreUltra7-Copilot+PC.jpg' WHERE product_id = 110;
-- UPDATE product SET image_url = '/images/product/laptop/삼성-갤럭시북6-프로-그레이.jpg' WHERE product_id = 111;
-- UPDATE product SET image_url = '/images/product/laptop/삼성-갤럭시북6-엣지-Snapdragon X2Elite-Copilot+PC.jpg' WHERE product_id = 112;
-- UPDATE product SET image_url = '/images/product/laptop/삼성-갤럭시북5-그레이.jpg' WHERE product_id = 113;
-- UPDATE product SET image_url = '/images/product/laptop/삼성-갤럭시북4-그레이.jpg' WHERE product_id = 114;

-- UPDATE product SET image_url = '/images/product/monitor/LG-PC모니터-U4-FHD.jpg' WHERE product_id = 120;
-- UPDATE product SET image_url = '/images/product/laptop/LG-그램-Pro-AI2026-Copilot+PC-IntelCoreUltra5.jpg' WHERE product_id = 121;
-- UPDATE product SET image_url = '/images/product/laptop/LG-그램-Pro-AI2026-Copilot+PC-AMDRyzenAI5.jpg' WHERE product_id = 122;
-- UPDATE product SET image_url = '/images/product/laptop/LG-그램-AI2026-Copilot+PC-AMD RyzenAI5.jpg' WHERE product_id = 123;
-- UPDATE product SET image_url = '/images/product/laptop/LG-그램-IntelCoreUltra5.jpg' WHERE product_id = 124;

UPDATE product SET image_url = '/images/product/desktop/Lenovo-Thinkcentre-Neo-30t-Gen5-12K8S00A00.jpg' WHERE product_id = 130;
-- UPDATE product SET image_url = '/images/product/laptop/Lenovo-Ideapad-Slim3-15IRU8.jpg' WHERE product_id = 131;
-- UPDATE product SET image_url = '/images/product/laptop/Lenovo-Thinkpad-X1-carbon-Gen13-AuraEdition.jpg' WHERE product_id = 132;

UPDATE product SET image_url = '/images/product/desktop/ASUS-TUFGaming-Ryzen5-TM500MH-R560W.jpg' WHERE product_id = 140;
-- UPDATE product SET image_url = '/images/product/laptop/ASUS-ROG-제피러스-G16.jpg' WHERE product_id = 141;
-- UPDATE product SET image_url = '/images/product/laptop/ASUS-ExpertBook-P1.jpg' WHERE product_id = 142;

UPDATE product SET image_url = '/images/product/desktop/HP-Omen-35L-GT16-1001KL-Ryzen7-9800X3D.jpg' WHERE product_id = 150;
-- UPDATE product SET image_url = '/images/product/laptop/HP-엘리트북-860-G11-A1VH4PT-울트라5-125H.jpg' WHERE product_id = 151;
-- UPDATE product SET image_url = '/images/product/laptop/HP-옴니북5-AI-코어5-320.jpg' WHERE product_id = 152;


--2.조립PC
-- UPDATE product SET image_url = '/images/product/laptop/Apple-MacBook-Pro16-M5-Silver.jpg'  WHERE product_id = 200;
-- UPDATE product SET image_url = '/images/product/laptop/Apple-MacBook-Pro14-M5-Silver.jpg' WHERE product_id = 201;
-- UPDATE product SET image_url = '/images/product/laptop/Apple-MacBook-Air15-M3-Starlight.jpg' WHERE product_id = 202;
-- UPDATE product SET image_url = '/images/product/laptop/Apple-MacBook-Air13-M5-Silver.jpg' WHERE product_id = 203;
-- UPDATE product SET image_url = '/images/product/laptop/Apple-MacBook-Neo-A18-Silver.jpg' WHERE product_id = 204;

-- UPDATE product SET image_url = '/images/product/laptop/삼성-갤럭시북5-프로-IntelCoreUltra7-Copilot+PC.jpg' WHERE product_id = 210;
-- UPDATE product SET image_url = '/images/product/laptop/삼성-갤럭시북6-프로-그레이.jpg' WHERE product_id = 211;
-- UPDATE product SET image_url = '/images/product/laptop/삼성-갤럭시북6-엣지-Snapdragon X2Elite-Copilot+PC.jpg' WHERE product_id = 212;
-- UPDATE product SET image_url = '/images/product/laptop/삼성-갤럭시북5-그레이.jpg' WHERE product_id = 213;
-- UPDATE product SET image_url = '/images/product/laptop/삼성-갤럭시북4-그레이.jpg' WHERE product_id = 214;

-- UPDATE product SET image_url = '/images/product/monitor/LG-PC모니터-U4-FHD.jpg' WHERE product_id = 220;
-- UPDATE product SET image_url = '/images/product/laptop/LG-그램-Pro-AI2026-Copilot+PC-IntelCoreUltra5.jpg' WHERE product_id = 221;
-- UPDATE product SET image_url = '/images/product/laptop/LG-그램-Pro-AI2026-Copilot+PC-AMDRyzenAI5.jpg' WHERE product_id = 222;
-- UPDATE product SET image_url = '/images/product/laptop/LG-그램-AI2026-Copilot+PC-AMD RyzenAI5.jpg' WHERE product_id = 223;
-- UPDATE product SET image_url = '/images/product/laptop/LG-그램-IntelCoreUltra5.jpg' WHERE product_id = 224;

-- UPDATE product SET image_url = '/images/product/laptop/Lenovo-Thinkpad-E14IPLG8U7-3K-AI.jpg' WHERE product_id = 230;
-- UPDATE product SET image_url = '/images/product/laptop/Lenovo-Ideapad-Slim3-15IRU8.jpg' WHERE product_id = 231;
-- UPDATE product SET image_url = '/images/product/laptop/Lenovo-Thinkpad-X1-carbon-Gen13-AuraEdition.jpg' WHERE product_id = 232;

-- UPDATE product SET image_url = '/images/product/laptop/ASUS-비보북-S16-OLED.jpg' WHERE product_id = 240;
-- UPDATE product SET image_url = '/images/product/laptop/ASUS-ROG-제피러스-G16.jpg' WHERE product_id = 241;
-- UPDATE product SET image_url = '/images/product/laptop/ASUS-ExpertBook-P1.jpg' WHERE product_id = 242;

-- UPDATE product SET image_url = '/images/product/laptop/HP-HyperX-오멘-인텔i7-14650HX.jpg' WHERE product_id = 250;
-- UPDATE product SET image_url = '/images/product/laptop/HP-엘리트북-860-G11-A1VH4PT-울트라5-125H.jpg' WHERE product_id = 251;
-- UPDATE product SET image_url = '/images/product/laptop/HP-옴니북5-AI-코어5-320.jpg' WHERE product_id = 252;




--3.모니터
-- UPDATE product SET image_url = '/images/product/laptop/Apple-MacBook-Pro16-M5-Silver.jpg'  WHERE product_id = 300;
-- UPDATE product SET image_url = '/images/product/laptop/Apple-MacBook-Pro14-M5-Silver.jpg' WHERE product_id = 301;
-- UPDATE product SET image_url = '/images/product/laptop/Apple-MacBook-Air15-M3-Starlight.jpg' WHERE product_id = 302;
-- UPDATE product SET image_url = '/images/product/laptop/Apple-MacBook-Air13-M5-Silver.jpg' WHERE product_id = 303;
-- UPDATE product SET image_url = '/images/product/laptop/Apple-MacBook-Neo-A18-Silver.jpg' WHERE product_id = 304;

UPDATE product SET image_url = '/images/product/monitor/삼성-모니터-S24C750P-61cm.jpg' WHERE product_id = 310;
UPDATE product SET image_url = '/images/product/monitor/삼성-오디세이-OLED-G8-G80SH-4K-240Hz-LS27HG802S.jpg' WHERE product_id = 311;
UPDATE product SET image_url = '/images/product/monitor/삼성-뷰피니티-S8-S85TH-5K2K-WUHD-LS40H852.jpg' WHERE product_id = 312;
UPDATE product SET image_url = '/images/product/monitor/삼성-오디세이-OLED-G8-G81SF-4K-240HZ-LS32FG812.jpg' WHERE product_id = 313;
-- UPDATE product SET image_url = '/images/product/laptop/삼성-갤럭시북4-그레이.jpg' WHERE product_id = 314;

UPDATE product SET image_url = '/images/product/monitor/LG-PC모니터-U4-FHD.jpg' WHERE product_id = 320;
UPDATE product SET image_url = '/images/product/monitor/LG-울트라HD-4K-모니터.jpg' WHERE product_id = 321;
UPDATE product SET image_url = '/images/product/monitor/LG-울트라기어-evo-AI-올레드-게이밍모니터-GX9-5K.jpg' WHERE product_id = 322;
UPDATE product SET image_url = '/images/product/monitor/LG-울트라기어-게이밍모니터-QHD.jpg' WHERE product_id = 323;
-- UPDATE product SET image_url = '/images/product/laptop/LG-그램-IntelCoreUltra5.jpg' WHERE product_id = 324;

-- UPDATE product SET image_url = '/images/product/laptop/Lenovo-Thinkpad-E14IPLG8U7-3K-AI.jpg' WHERE product_id = 330;
-- UPDATE product SET image_url = '/images/product/laptop/Lenovo-Ideapad-Slim3-15IRU8.jpg' WHERE product_id = 331;
-- UPDATE product SET image_url = '/images/product/laptop/Lenovo-Thinkpad-X1-carbon-Gen13-AuraEdition.jpg' WHERE product_id = 332;

-- UPDATE product SET image_url = '/images/product/laptop/ASUS-비보북-S16-OLED.jpg' WHERE product_id = 340;
-- UPDATE product SET image_url = '/images/product/laptop/ASUS-ROG-제피러스-G16.jpg' WHERE product_id = 341;
-- UPDATE product SET image_url = '/images/product/laptop/ASUS-ExpertBook-P1.jpg' WHERE product_id = 342;

-- UPDATE product SET image_url = '/images/product/laptop/HP-HyperX-오멘-인텔i7-14650HX.jpg' WHERE product_id = 350;
-- UPDATE product SET image_url = '/images/product/laptop/HP-엘리트북-860-G11-A1VH4PT-울트라5-125H.jpg' WHERE product_id = 351;
-- UPDATE product SET image_url = '/images/product/laptop/HP-옴니북5-AI-코어5-320.jpg' WHERE product_id = 352;


--4.노트북 
UPDATE product SET image_url = '/images/product/laptop/Apple-MacBook-Pro16-M5-Silver.jpg'  WHERE product_id = 400;
UPDATE product SET image_url = '/images/product/laptop/Apple-MacBook-Pro14-M5-Silver.jpg' WHERE product_id = 401;
UPDATE product SET image_url = '/images/product/laptop/Apple-MacBook-Air15-M3-Starlight.jpg' WHERE product_id = 402;
UPDATE product SET image_url = '/images/product/laptop/Apple-MacBook-Air13-M5-Silver.jpg' WHERE product_id = 403;
UPDATE product SET image_url = '/images/product/laptop/Apple-MacBook-Neo-A18-Silver.jpg' WHERE product_id = 404;

UPDATE product SET image_url = '/images/product/laptop/삼성-갤럭시북5-프로-IntelCoreUltra7-Copilot+PC.jpg' WHERE product_id = 410;
UPDATE product SET image_url = '/images/product/laptop/삼성-갤럭시북6-프로-그레이.jpg' WHERE product_id = 411;
UPDATE product SET image_url = '/images/product/laptop/삼성-갤럭시북6-엣지-Snapdragon X2Elite-Copilot+PC.jpg' WHERE product_id = 412;
UPDATE product SET image_url = '/images/product/laptop/삼성-갤럭시북5-그레이.jpg' WHERE product_id = 413;
UPDATE product SET image_url = '/images/product/laptop/삼성-갤럭시북4-그레이.jpg' WHERE product_id = 414;

UPDATE product SET image_url = '/images/product/laptop/LG-그램-Pro-360 AI-IntelCoreUltra7.jpg' WHERE product_id = 420;
UPDATE product SET image_url = '/images/product/laptop/LG-그램-Pro-AI2026-Copilot+PC-IntelCoreUltra5.jpg' WHERE product_id = 421;
UPDATE product SET image_url = '/images/product/laptop/LG-그램-Pro-AI2026-Copilot+PC-AMDRyzenAI5.jpg' WHERE product_id = 422;
UPDATE product SET image_url = '/images/product/laptop/LG-그램-AI2026-Copilot+PC-AMD RyzenAI5.jpg' WHERE product_id = 423;
UPDATE product SET image_url = '/images/product/laptop/LG-그램-IntelCoreUltra5.jpg' WHERE product_id = 424;

UPDATE product SET image_url = '/images/product/laptop/Lenovo-Thinkpad-E14IPLG8U7-3K-AI.jpg' WHERE product_id = 430;
UPDATE product SET image_url = '/images/product/laptop/Lenovo-Ideapad-Slim3-15IRU8.jpg' WHERE product_id = 431;
UPDATE product SET image_url = '/images/product/laptop/Lenovo-Thinkpad-X1-carbon-Gen13-AuraEdition.jpg' WHERE product_id = 432;

UPDATE product SET image_url = '/images/product/laptop/ASUS-비보북-S16-OLED.jpg' WHERE product_id = 440;
UPDATE product SET image_url = '/images/product/laptop/ASUS-ROG-제피러스-G16.jpg' WHERE product_id = 441;
UPDATE product SET image_url = '/images/product/laptop/ASUS-ExpertBook-P1.jpg' WHERE product_id = 442;

UPDATE product SET image_url = '/images/product/laptop/HP-HyperX-오멘-인텔i7-14650HX.jpg' WHERE product_id = 450;
UPDATE product SET image_url = '/images/product/laptop/HP-엘리트북-860-G11-A1VH4PT-울트라5-125H.jpg' WHERE product_id = 451;
UPDATE product SET image_url = '/images/product/laptop/HP-옴니북5-AI-코어5-320.jpg' WHERE product_id = 452;


--5.스마트 기기 
UPDATE product SET image_url = '/images/product/device/Apple-iPad-Pro13-2025-M5-스탠다드글래스.jpg'  WHERE product_id = 500;
-- UPDATE product SET image_url = '/images/product/laptop/Apple-MacBook-Pro14-M5-Silver.jpg' WHERE product_id = 501;
-- UPDATE product SET image_url = '/images/product/laptop/삼성-갤럭시북6-엣지-Snapdragon X2Elite-Copilot+PC.jpg' WHERE product_id = 502;
UPDATE product SET image_url = '/images/product/device/AppleWatch-11-GPS-스페이스그레이-알루미늄46mm-블랙스포츠밴드.jpg' WHERE product_id = 503;
-- UPDATE product SET image_url = '/images/product/laptop/Apple-MacBook-Neo-A18-Silver.jpg' WHERE product_id = 504;

-- UPDATE product SET image_url = '/images/product/laptop/삼성-갤럭시북5-프로-IntelCoreUltra7-Copilot+PC.jpg' WHERE product_id = 510;
-- UPDATE product SET image_url = '/images/product/laptop/삼성-갤럭시북6-프로-그레이.jpg' WHERE product_id = 511;
UPDATE product SET image_url = '/images/product/device/삼성-갤럭시탭-S10-Lite-128GB-그레이-WIFI.jpg' WHERE product_id = 512;
UPDATE product SET image_url = '/images/product/device/Samsung-GalaxyWatch-8-Classic-SM-L500N-46mm-Black-Bluetooth.jpg' WHERE product_id = 513;
-- UPDATE product SET image_url = '/images/product/laptop/삼성-갤럭시북4-그레이.jpg' WHERE product_id = 514;

UPDATE product SET image_url = '/images/product/device/Meta-Quest-3S-128GB-VR.jpg' WHERE product_id = 520;
-- UPDATE product SET image_url = '/images/product/laptop/LG-그램-Pro-AI2026-Copilot+PC-IntelCoreUltra5.jpg' WHERE product_id = 521;
-- UPDATE product SET image_url = '/images/product/laptop/LG-그램-Pro-AI2026-Copilot+PC-AMDRyzenAI5.jpg' WHERE product_id = 522;
-- UPDATE product SET image_url = '/images/product/laptop/LG-그램-AI2026-Copilot+PC-AMD RyzenAI5.jpg' WHERE product_id = 523;
-- UPDATE product SET image_url = '/images/product/laptop/LG-그램-IntelCoreUltra5.jpg' WHERE product_id = 524;

-- UPDATE product SET image_url = '/images/product/laptop/Lenovo-Thinkpad-E14IPLG8U7-3K-AI.jpg' WHERE product_id = 530;
-- UPDATE product SET image_url = '/images/product/laptop/Lenovo-Ideapad-Slim3-15IRU8.jpg' WHERE product_id = 531;
-- UPDATE product SET image_url = '/images/product/laptop/Lenovo-Thinkpad-X1-carbon-Gen13-AuraEdition.jpg' WHERE product_id = 532;

-- UPDATE product SET image_url = '/images/product/laptop/ASUS-비보북-S16-OLED.jpg' WHERE product_id = 540;
-- UPDATE product SET image_url = '/images/product/laptop/ASUS-ROG-제피러스-G16.jpg' WHERE product_id = 541;
-- UPDATE product SET image_url = '/images/product/laptop/ASUS-ExpertBook-P1.jpg' WHERE product_id = 542;

-- UPDATE product SET image_url = '/images/product/laptop/HP-HyperX-오멘-인텔i7-14650HX.jpg' WHERE product_id = 550;
-- UPDATE product SET image_url = '/images/product/laptop/HP-엘리트북-860-G11-A1VH4PT-울트라5-125H.jpg' WHERE product_id = 551;
-- UPDATE product SET image_url = '/images/product/laptop/HP-옴니북5-AI-코어5-320.jpg' WHERE product_id = 552;


--6.사무/주변기기
-- UPDATE product SET image_url = '/images/product/laptop/Apple-MacBook-Pro16-M5-Silver.jpg'  WHERE product_id = 600;
-- UPDATE product SET image_url = '/images/product/laptop/Apple-MacBook-Pro14-M5-Silver.jpg' WHERE product_id = 601;
-- UPDATE product SET image_url = '/images/product/laptop/Apple-MacBook-Air15-M3-Starlight.jpg' WHERE product_id = 602;
-- UPDATE product SET image_url = '/images/product/laptop/Apple-MacBook-Air13-M5-Silver.jpg' WHERE product_id = 603;
-- UPDATE product SET image_url = '/images/product/laptop/Apple-MacBook-Neo-A18-Silver.jpg' WHERE product_id = 604;

-- UPDATE product SET image_url = '/images/product/laptop/삼성-갤럭시북5-프로-IntelCoreUltra7-Copilot+PC.jpg' WHERE product_id = 610;
-- UPDATE product SET image_url = '/images/product/laptop/삼성-갤럭시북6-프로-그레이.jpg' WHERE product_id = 611;
-- UPDATE product SET image_url = '/images/product/laptop/삼성-갤럭시북6-엣지-Snapdragon X2Elite-Copilot+PC.jpg' WHERE product_id = 612;
-- UPDATE product SET image_url = '/images/product/laptop/삼성-갤럭시북5-그레이.jpg' WHERE product_id = 613;
-- UPDATE product SET image_url = '/images/product/laptop/삼성-갤럭시북4-그레이.jpg' WHERE product_id = 614;

-- UPDATE product SET image_url = '/images/product/laptop/LG-그램-Pro-360 AI-IntelCoreUltra7.jpg' WHERE product_id = 620;
-- UPDATE product SET image_url = '/images/product/laptop/LG-그램-Pro-AI2026-Copilot+PC-IntelCoreUltra5.jpg' WHERE product_id = 621;
-- UPDATE product SET image_url = '/images/product/laptop/LG-그램-Pro-AI2026-Copilot+PC-AMDRyzenAI5.jpg' WHERE product_id = 622;
-- UPDATE product SET image_url = '/images/product/laptop/LG-그램-AI2026-Copilot+PC-AMD RyzenAI5.jpg' WHERE product_id = 623;
-- UPDATE product SET image_url = '/images/product/laptop/LG-그램-IntelCoreUltra5.jpg' WHERE product_id = 624;

-- UPDATE product SET image_url = '/images/product/laptop/Lenovo-Thinkpad-E14IPLG8U7-3K-AI.jpg' WHERE product_id = 630;
-- UPDATE product SET image_url = '/images/product/laptop/Lenovo-Ideapad-Slim3-15IRU8.jpg' WHERE product_id = 631;
-- UPDATE product SET image_url = '/images/product/laptop/Lenovo-Thinkpad-X1-carbon-Gen13-AuraEdition.jpg' WHERE product_id = 632;

-- UPDATE product SET image_url = '/images/product/laptop/ASUS-비보북-S16-OLED.jpg' WHERE product_id = 640;
-- UPDATE product SET image_url = '/images/product/laptop/ASUS-ROG-제피러스-G16.jpg' WHERE product_id = 641;
-- UPDATE product SET image_url = '/images/product/laptop/ASUS-ExpertBook-P1.jpg' WHERE product_id = 642;

-- UPDATE product SET image_url = '/images/product/laptop/HP-HyperX-오멘-인텔i7-14650HX.jpg' WHERE product_id = 650;
-- UPDATE product SET image_url = '/images/product/laptop/HP-엘리트북-860-G11-A1VH4PT-울트라5-125H.jpg' WHERE product_id = 651;
-- UPDATE product SET image_url = '/images/product/laptop/HP-옴니북5-AI-코어5-320.jpg' WHERE product_id = 652;

--7. 서버/워크스테이션
-- UPDATE product SET image_url = '/images/product/laptop/Apple-MacBook-Pro16-M5-Silver.jpg'  WHERE product_id = 700;
-- UPDATE product SET image_url = '/images/product/laptop/Apple-MacBook-Pro14-M5-Silver.jpg' WHERE product_id = 701;
-- UPDATE product SET image_url = '/images/product/laptop/Apple-MacBook-Air15-M3-Starlight.jpg' WHERE product_id = 702;
-- UPDATE product SET image_url = '/images/product/laptop/Apple-MacBook-Air13-M5-Silver.jpg' WHERE product_id = 703;
-- UPDATE product SET image_url = '/images/product/laptop/Apple-MacBook-Neo-A18-Silver.jpg' WHERE product_id = 704;

-- UPDATE product SET image_url = '/images/product/laptop/삼성-갤럭시북5-프로-IntelCoreUltra7-Copilot+PC.jpg' WHERE product_id = 710;
-- UPDATE product SET image_url = '/images/product/laptop/삼성-갤럭시북6-프로-그레이.jpg' WHERE product_id = 711;
-- UPDATE product SET image_url = '/images/product/laptop/삼성-갤럭시북6-엣지-Snapdragon X2Elite-Copilot+PC.jpg' WHERE product_id = 712;
-- UPDATE product SET image_url = '/images/product/laptop/삼성-갤럭시북5-그레이.jpg' WHERE product_id = 713;
-- UPDATE product SET image_url = '/images/product/laptop/삼성-갤럭시북4-그레이.jpg' WHERE product_id = 714;

-- UPDATE product SET image_url = '/images/product/laptop/LG-그램-Pro-360 AI-IntelCoreUltra7.jpg' WHERE product_id = 720;
-- UPDATE product SET image_url = '/images/product/laptop/LG-그램-Pro-AI2026-Copilot+PC-IntelCoreUltra5.jpg' WHERE product_id = 721;
-- UPDATE product SET image_url = '/images/product/laptop/LG-그램-Pro-AI2026-Copilot+PC-AMDRyzenAI5.jpg' WHERE product_id = 722;
-- UPDATE product SET image_url = '/images/product/laptop/LG-그램-AI2026-Copilot+PC-AMD RyzenAI5.jpg' WHERE product_id = 723;
-- UPDATE product SET image_url = '/images/product/laptop/LG-그램-IntelCoreUltra5.jpg' WHERE product_id = 724;

-- UPDATE product SET image_url = '/images/product/laptop/Lenovo-Thinkpad-E14IPLG8U7-3K-AI.jpg' WHERE product_id = 730;
-- UPDATE product SET image_url = '/images/product/laptop/Lenovo-Ideapad-Slim3-15IRU8.jpg' WHERE product_id = 731;
-- UPDATE product SET image_url = '/images/product/laptop/Lenovo-Thinkpad-X1-carbon-Gen13-AuraEdition.jpg' WHERE product_id = 732;

-- UPDATE product SET image_url = '/images/product/laptop/ASUS-비보북-S16-OLED.jpg' WHERE product_id = 740;
-- UPDATE product SET image_url = '/images/product/laptop/ASUS-ROG-제피러스-G16.jpg' WHERE product_id = 741;
-- UPDATE product SET image_url = '/images/product/laptop/ASUS-ExpertBook-P1.jpg' WHERE product_id = 742;

-- UPDATE product SET image_url = '/images/product/laptop/HP-HyperX-오멘-인텔i7-14650HX.jpg' WHERE product_id = 750;
-- UPDATE product SET image_url = '/images/product/laptop/HP-엘리트북-860-G11-A1VH4PT-울트라5-125H.jpg' WHERE product_id = 751;
-- UPDATE product SET image_url = '/images/product/laptop/HP-옴니북5-AI-코어5-320.jpg' WHERE product_id = 752;

--8. 기타 PC 부품들 
-- UPDATE product SET image_url = '/images/product/laptop/Apple-MacBook-Pro16-M5-Silver.jpg'  WHERE product_id = 800;
-- UPDATE product SET image_url = '/images/product/laptop/Apple-MacBook-Pro14-M5-Silver.jpg' WHERE product_id = 801;
-- UPDATE product SET image_url = '/images/product/laptop/Apple-MacBook-Air15-M3-Starlight.jpg' WHERE product_id = 802;
-- UPDATE product SET image_url = '/images/product/laptop/Apple-MacBook-Air13-M5-Silver.jpg' WHERE product_id = 803;
-- UPDATE product SET image_url = '/images/product/laptop/Apple-MacBook-Neo-A18-Silver.jpg' WHERE product_id = 804;

-- UPDATE product SET image_url = '/images/product/laptop/삼성-갤럭시북5-프로-IntelCoreUltra7-Copilot+PC.jpg' WHERE product_id = 810;
-- UPDATE product SET image_url = '/images/product/laptop/삼성-갤럭시북6-프로-그레이.jpg' WHERE product_id = 811;
-- UPDATE product SET image_url = '/images/product/laptop/삼성-갤럭시북6-엣지-Snapdragon X2Elite-Copilot+PC.jpg' WHERE product_id = 812;
-- UPDATE product SET image_url = '/images/product/laptop/삼성-갤럭시북5-그레이.jpg' WHERE product_id = 813;
-- UPDATE product SET image_url = '/images/product/laptop/삼성-갤럭시북4-그레이.jpg' WHERE product_id = 814;

-- UPDATE product SET image_url = '/images/product/laptop/LG-그램-Pro-360 AI-IntelCoreUltra7.jpg' WHERE product_id = 820;
-- UPDATE product SET image_url = '/images/product/laptop/LG-그램-Pro-AI2026-Copilot+PC-IntelCoreUltra5.jpg' WHERE product_id = 821;
-- UPDATE product SET image_url = '/images/product/laptop/LG-그램-Pro-AI2026-Copilot+PC-AMDRyzenAI5.jpg' WHERE product_id = 822;
-- UPDATE product SET image_url = '/images/product/laptop/LG-그램-AI2026-Copilot+PC-AMD RyzenAI5.jpg' WHERE product_id = 823;
-- UPDATE product SET image_url = '/images/product/laptop/LG-그램-IntelCoreUltra5.jpg' WHERE product_id = 824;

-- UPDATE product SET image_url = '/images/product/laptop/Lenovo-Thinkpad-E14IPLG8U7-3K-AI.jpg' WHERE product_id = 830;
-- UPDATE product SET image_url = '/images/product/laptop/Lenovo-Ideapad-Slim3-15IRU8.jpg' WHERE product_id = 831;
-- UPDATE product SET image_url = '/images/product/laptop/Lenovo-Thinkpad-X1-carbon-Gen13-AuraEdition.jpg' WHERE product_id = 832;

-- UPDATE product SET image_url = '/images/product/laptop/ASUS-비보북-S16-OLED.jpg' WHERE product_id = 840;
-- UPDATE product SET image_url = '/images/product/laptop/ASUS-ROG-제피러스-G16.jpg' WHERE product_id = 841;
-- UPDATE product SET image_url = '/images/product/laptop/ASUS-ExpertBook-P1.jpg' WHERE product_id = 842;

-- UPDATE product SET image_url = '/images/product/laptop/HP-HyperX-오멘-인텔i7-14650HX.jpg' WHERE product_id = 850;
-- UPDATE product SET image_url = '/images/product/laptop/HP-엘리트북-860-G11-A1VH4PT-울트라5-125H.jpg' WHERE product_id = 851;
-- UPDATE product SET image_url = '/images/product/laptop/HP-옴니북5-AI-코어5-320.jpg' WHERE product_id = 852;



-- 6. 상품 상세 사양 (product_spec)
INSERT INTO product_spec (product_id, spec_key, spec_value) VALUES

--예시데이터--
(1, 'CPU', 'M3 Max 16코어'),(1, 'RAM', '64GB'),(1, 'SSD', '2TB'),
(3, 'GPU', 'RTX 4090 24GB'), (3, 'RAM', '128GB'), (3, 'POWER', '1200W'),
(5, '해상도', '3840x2160 (4K)'), (5, '패널', 'IPS'),
(6, 'CPU', 'Intel Core Ultra 7'), (6, 'RAM', '32GB'),
(11, 'VRAM', '24GB'), (11, '권장파워', '1000W 이상'), 
(12, '클럭', '5600MHz'), (12, '용량', '16GB');


--1.PC
--2.조립PC
--3.모니터
--4.노트북
--5.스마트기기
--6.사무/기타기기
--7.서버/워크스테이션


-- 7. 렌탈가 관리 (rental_prices)
-- 💡 명시된 컬럼: 렌탈기간, 월렌탈료, 보증금(deposit_fee), B2B여부, 활성화여부
INSERT INTO rental_prices (
    rental_price_id, product_id, duration, monthly_fee, deposit_fee, is_b2b_only, is_active
) VALUES

--예시데이터--
(1, 1, 36, 130000, 0, 'N', 'Y'),      -- 맥북 프로 36개월 B2C
(2, 1, 60, 90000, 0, 'N', 'Y'),       -- 맥북 프로 60개월 B2C (장기할인)
(3, 3, 24, 250000, 500000, 'Y', 'Y'), -- RTX 4090 워크스테이션 24개월 (B2B 전용, 보증금 50만 원)
(4, 5, 36, 25000, 0, 'N', 'Y'),       -- 4K 모니터 36개월
(5, 6, 36, 65000, 0, 'N', 'Y'),       -- 갤북4 프로 36개월
(6, 8, 36, 20000, 0, 'Y', 'Y'),       -- 사무용 미니PC (B2B 대량렌탈 전용)
(7, 8, 12, 30000, 0, 'Y', 'Y'),       -- 사무용 미니PC 단기
(8, 10, 36, 180000, 0, 'N', 'Y'),     -- 맥 스튜디오 36개월
(9, 2, 36, 60000, 0, 'N', 'Y'),       -- 맥북 에어 36개월
(10, 4, 36, 75000, 0, 'N', 'Y'),      -- 게이밍 데스크탑 36개월
(11, 11, 1, 200000, 300000, 'N', 'Y');-- RTX 4090 부품 단기(1개월) 고수익 렌탈 (보증금 30만 원)





-- 1. 주문 테이블 (영수증 머리말)
-- 상태를 타임리프 화면과 맞춰서 '결제완료', '주문취소'로 변경했습니다.
INSERT INTO orders (order_id, member_id, total_amount, order_status, payment_method, billing_key) VALUES
(1, 1, 130000, '결제완료', 'CREDIT_CARD', 'bk_card_001'),
(2, 2, 60000, '결제완료', 'CREDIT_CARD', 'bk_card_002'),
(3, 3, 75000, '결제완료', 'NAVER_PAY', 'bk_npay_003'),
(4, 4, 180000, '결제완료', 'KAKAO_PAY', 'bk_kpay_004'),
(5, 5, 25000, '결제완료', 'CREDIT_CARD', 'bk_card_005'),
(6, 8, 250000, '결제완료', 'BANK_TRANSFER', NULL), 
(7, 9, 200000, '결제완료', 'BANK_TRANSFER', NULL),
(8, 10, 30000, '결제완료', 'CREDIT_CARD', 'bk_card_008'),
(9, 6, 65000, '결제완료', 'TOSS_PAY', 'bk_toss_009'),
(10, 7, 25000, '주문취소', 'CREDIT_CARD', NULL);


-- 2. 주문 상세 테이블 (영수증 알맹이 - 우리가 추가해야 할 진짜 알맹이!)
-- product_id는 기존 상품 테이블에 1, 2, 3번 상품이 있다고 가정한 더미 데이터입니다.
INSERT INTO order_item (order_id, product_id, order_price, count) VALUES
(1, 1, 130000, 1), -- 1번 주문: 1번 상품 1개 구매
(2, 2, 30000, 2),  -- 2번 주문: 2번 상품 2개 구매 (총액 6만)
(3, 3, 75000, 1),  -- 3번 주문: 3번 상품 1개 구매
(4, 1, 90000, 2),  -- 4번 주문: 1번 상품 2개 구매 (총액 18만)
(5, 2, 25000, 1),  -- 5번 주문: 2번 상품 1개 구매
(6, 4, 250000, 1), -- 6번 주문: 4번 상품 1개 구매
(7, 5, 100000, 2), -- 7번 주문: 5번 상품 2개 구매
(8, 1, 30000, 1),  -- 8번 주문: 1번 상품 1개 구매
(9, 3, 65000, 1),  -- 9번 주문: 3번 상품 1개 구매
(10, 2, 25000, 1); -- 10번 주문: 2번 상품 1개 구매 (취소됨)

-- 보너스: 다중 장바구니 결제 테스트용 (1번 주문에 상품 하나 더 추가!)
INSERT INTO order_item (order_id, product_id, order_price, count) VALUES
(1, 2, 0, 1); -- 1번 회원은 상품 2개를 같이 샀다는 것을 보여주기 위한 테스트용

-- 9. 계약 (렌탈 및 구독)
INSERT INTO contract (contract_id, member_id, order_id, product_id, monthly_fee, duration, contract_type, contract_status, start_date, end_date) VALUES
(1, 1, 1, 1, 130000, 36, 'RENTAL', 'USING', '2024-01-01', '2027-01-01'),
(2, 2, 2, 2, 60000, 36, 'RENTAL', 'USING', '2024-02-15', '2027-02-15'),
(3, 3, 3, 4, 75000, 36, 'RENTAL', 'USING', '2024-03-10', '2027-03-10'),
(4, 4, 4, 10, 180000, 36, 'RENTAL', 'USING', '2024-04-05', '2027-04-05'),
(5, 5, 5, 5, 25000, 36, 'RENTAL', 'USING', '2024-04-20', '2027-04-20'),
(6, 8, 6, 3, 250000, 24, 'RENTAL', 'USING', '2024-05-01', '2026-05-01'),
(7, 9, 7, 8, 200000, 36, 'RENTAL', 'USING', '2024-05-10', '2027-05-10'), -- 수량 10대 계약 가정(주문금액 20만)
(8, 10, 8, 8, 30000, 12, 'RENTAL', 'USING', '2024-06-01', '2025-06-01'),
(9, 6, 9, 6, 65000, 36, 'SUBSCRIPTION', 'TERMINATED', '2023-01-01', '2024-01-01'), -- 중도해지
(10, 1, 1, 6, 25000, 36, 'RENTAL', 'USING', '2024-01-01', '2027-01-01'); -- 회원1번이 모니터도 같이 빌림

-- 10. 결제 이력 (스케줄러에 의해 매달 결제되는 내역)
INSERT INTO payment_history (payment_history_id, contract_id, amount, status, fail_reason, billing_key) VALUES
(1, 1, 130000, 'SUCCESS', NULL, 'bk_card_001'),
(2, 2, 60000, 'SUCCESS', NULL, 'bk_card_002'),
(3, 3, 75000, 'SUCCESS', NULL, 'bk_npay_003'),
(4, 4, 180000, 'FAILED', '잔액 부족', 'bk_kpay_004'),
(5, 5, 25000, 'SUCCESS', NULL, 'bk_card_005'),
(6, 6, 250000, 'SUCCESS', NULL, NULL),
(7, 7, 200000, 'SUCCESS', NULL, NULL),
(8, 8, 30000, 'SUCCESS', NULL, 'bk_card_008'),
(9, 9, 65000, 'SUCCESS', NULL, 'bk_toss_009'),
(10, 1, 130000, 'SUCCESS', NULL, 'bk_card_001'); -- 2회차 결제 성공

-- 11. 배송 내역
INSERT INTO delivery (delivery_id, order_id, tracking_number, carrier, status, dispatched_at, delivered_at) VALUES
(1, 1, 'CJ1234567890', 'CJ대한통운', 'DELIVERED', '2024-01-02 10:00:00', '2024-01-03 15:00:00'),
(2, 2, 'CJ1234567891', 'CJ대한통운', 'DELIVERED', '2024-02-16 10:00:00', '2024-02-17 14:00:00'),
(3, 3, 'HN0987654321', '한진택배', 'DELIVERED', '2024-03-11 11:00:00', '2024-03-12 12:00:00'),
(4, 4, 'LT1122334455', '롯데택배', 'SHIPPING', '2024-04-06 09:00:00', NULL),
(5, 5, 'CJ1234567892', 'CJ대한통운', 'PREPARING', NULL, NULL),
(6, 6, 'DR00001', '자체직배송', 'DELIVERED', '2024-05-02 09:00:00', '2024-05-02 11:00:00'), -- B2B 직배송
(7, 7, 'DR00002', '자체직배송', 'DELIVERED', '2024-05-11 09:00:00', '2024-05-11 13:00:00'),
(8, 8, 'CJ1234567893', 'CJ대한통운', 'SHIPPING', '2024-06-02 10:00:00', NULL),
(9, 9, 'CJ1234567894', 'CJ대한통운', 'RETURN_SHIPPING', '2024-01-05 10:00:00', NULL), -- 반납 중
(10, 1, 'CJ1234567895', 'CJ대한통운', 'DELIVERED', '2024-01-02 10:00:00', '2024-01-03 15:00:00'); -- 모니터 배송

-- 12. 리뷰
INSERT INTO review (review_id, member_id, product_id, contract_id, rating, content, image_url) VALUES
(1, 1, 1, 1, 5, '성능 최고입니다. 렌탈로 초기비용 아껴서 좋아요.', 'img1.jpg'),
(2, 2, 2, 2, 5, '디자인 예쁘고 가벼워서 휴대하기 좋습니다.', 'img2.jpg'),
(3, 3, 4, 3, 4, '게임 잘 돌아가는데 쿨러 소음이 약간 있네요.', NULL),
(4, 6, 6, 9, 3, '사용하다가 일이 생겨서 중도해지 했습니다. 기기는 좋아요.', NULL),
(5, 8, 3, 6, 5, '딥러닝용으로 여러 대 렌탈했습니다. 법인 비용처리 편해요.', NULL),
(6, 1, 5, 10, 5, '맥북이랑 같이 쓰려고 모니터도 렌탈했어요. 화질 미쳤음', 'img3.jpg'),
(7, 2, 2, 2, 4, '배송이 빨라서 좋았습니다.', NULL),
(8, 3, 4, 3, 5, 'RTX4070 확실히 프레임 잘 뽑아줍니다.', 'img4.jpg'),
(9, 5, 5, 5, 5, '디자인 작업용으로 가성비 짱짱맨', NULL),
(10, 10, 8, 8, 4, '직원들 사무용으로 작고 딱 맞습니다.', 'img5.jpg');

-- 13. 장바구니
INSERT INTO cart (cart_id, member_id, product_id, rental_type, duration, quantity) VALUES
(1, 1, 3, 'RENTAL', 36, 1),
(2, 1, 5, 'RENTAL', 36, 2),
(3, 2, 1, 'SUBSCRIPTION', NULL, 1),
(4, 3, 9, 'RENTAL', 24, 1),
(5, 4, 6, 'RENTAL', 60, 1),
(6, 8, 8, 'RENTAL', 12, 10), -- 기업회원 대량 담기
(7, 9, 3, 'RENTAL', 24, 2),
(8, 10, 5, 'RENTAL', 36, 5),
(9, 5, 2, 'SUBSCRIPTION', NULL, 1),
(10, 6, 4, 'RENTAL', 36, 1);

-- 14. 찜하기
INSERT INTO wishlist (wishlist_id, member_id, product_id) VALUES
(1, 1, 10), (2, 1, 3), (3, 2, 1), (4, 3, 4), (5, 3, 9),
(6, 4, 1), (7, 5, 6), (8, 8, 3), (9, 9, 8), (10, 10, 10);

-- 15. 구독 플랜 (멤버십)
INSERT INTO subscription_plan (plan_id, plan_name, monthly_fee, benefits_desc) VALUES
(1, '베이직', 9900, '전 상품 5% 할인, 기본 배송 무료'),
(2, '프로', 19900, '전 상품 10% 할인, 무료 반품, 프리미엄 AS'),
(3, '마스터', 29900, '전 상품 15% 할인, 최우선 배송, VIP 전담 매니저');

-- 16. 구독 상태
INSERT INTO subscription_status (subscription_status_id, member_id, plan_id, status, start_date, end_date, next_billing_date) VALUES
(1, 1, 1, 'ACTIVE', '2024-01-01', NULL, '2024-02-01'),
(2, 3, 1, 'ACTIVE', '2024-03-01', NULL, '2024-04-01'),
(3, 6, 2, 'ACTIVE', '2024-04-01', NULL, '2024-05-01'),
(4, 8, 3, 'ACTIVE', '2023-10-01', NULL, '2024-06-01'),
(5, 10, 2, 'ACTIVE', '2024-05-01', NULL, '2024-06-01'),
(6, 2, 1, 'CANCELED', '2023-01-01', '2023-12-01', '2023-12-01'),
(7, 4, 1, 'CANCELED', '2023-05-01', '2023-08-01', '2023-08-01'),
(8, 5, 1, 'ACTIVE', '2024-06-01', NULL, '2024-07-01'),
(9, 7, 3, 'ACTIVE', '2024-06-15', NULL, '2024-07-15'),
(10, 9, 2, 'ACTIVE', '2024-06-20', NULL, '2024-07-20');

-- 17. 대량 견적 (B2B 전용)
INSERT INTO quote (quote_id, member_id, status, total_quantity, proposed_amount, admin_comment) VALUES
(1, 8, 'COMPLETED', 20, 14000000, '할인율 15% 적용 승인되었습니다.'),
(2, 9, 'APPROVED', 50, 35000000, '요청하신 사양으로 세팅 가능합니다.'),
(3, 10, 'REQUEST', 5, 25000000, NULL),
(4, 8, 'REQUEST', 10, 7000000, NULL),
(5, 9, 'COMPLETED', 30, 21000000, '최종 견적서 발송 완료'),
(6, 10, 'REQUEST', 2, 11000000, NULL),
(7, 8, 'APPROVED', 15, 10500000, '승인 대기 중'),
(8, 9, 'REQUEST', 100, 70000000, '물량 확보 확인 중'),
(9, 10, 'COMPLETED', 10, 7000000, '납품 완료'),
(10, 8, 'REQUEST', 3, 6000000, NULL);

-- 18. 세금계산서 (B2B 전용)
INSERT INTO tax_invoice (tax_invoice_id, order_id, status, invoice_url) VALUES
(1, 6, 'ISSUED', 'https://invoice.link/1234'),
(2, 7, 'ISSUED', 'https://invoice.link/5678'),
(3, 8, 'APPLIED', NULL),
(4, 6, 'ISSUED', 'https://invoice.link/9012'),
(5, 7, 'ISSUED', 'https://invoice.link/3456'),
(6, 8, 'APPLIED', NULL),
(7, 6, 'ISSUED', 'https://invoice.link/7890'),
(8, 7, 'APPLIED', NULL),
(9, 8, 'ISSUED', 'https://invoice.link/1122'),
(10, 6, 'APPLIED', NULL);

-- 19. 1:1 문의
INSERT INTO inquiry (inquiry_id, member_id, title, content, answer_content, status) VALUES
(1, 1, '결제 카드 변경하고 싶습니다.', '어떻게 하나요?', '마이페이지 > 결제수단 관리에서 변경 가능합니다.', 'ANSWERED'),
(2, 2, '배송 언제 되나요?', '급해서요.', NULL, 'PENDING'),
(3, 3, '램 업그레이드 문의', '추가금 내고 64GB로 변경되나요?', '렌탈 상품은 임의 개조가 불가능합니다.', 'ANSWERED'),
(4, 8, '대량 렌탈 세금계산서 발행 시점 문의', '언제 되나요?', '매월 10일에 일괄 발행됩니다.', 'ANSWERED'),
(5, 9, '중도 해지 위약금 문의', '얼마인가요?', '잔여 렌탈료의 30%입니다.', 'ANSWERED'),
(6, 4, '상품 흠집 관련', '받았는데 기스가 있어요', '사진 첨부해주시면 교환 처리 돕겠습니다.', 'ANSWERED'),
(7, 5, '반납 방법', '택배로 보내면 되나요?', NULL, 'PENDING'),
(8, 10, '견적서 요청', '서면 견적서 부탁드립니다.', '이메일로 발송해 드렸습니다.', 'ANSWERED'),
(9, 6, '할인 쿠폰 적용 문의', '안 먹히네요.', NULL, 'PENDING'),
(10, 7, '회원 탈퇴 방법', '탈퇴하고 싶습니다.', '계약 진행 중인 건이 있어 탈퇴가 제한됩니다.', 'ANSWERED');

-- 20. AS 접수
INSERT INTO as_request (as_request_id, contract_id, symptom, visit_date, status) VALUES
(1, 1, '화면이 갑자기 안 나옵니다.', '2024-05-15', 'COMPLETED'),
(2, 3, '팬 소음이 너무 심해요.', '2024-05-20', 'IN_PROGRESS'),
(3, 4, '부팅이 안 됩니다.', '2024-05-25', 'RECEIVED'),
(4, 6, 'GPU 렌더링 중 블루스크린 발생', '2024-05-21', 'COMPLETED'),
(5, 7, '키보드 하나가 안 눌림', '2024-05-22', 'IN_PROGRESS'),
(6, 2, '발열이 너무 심해요', '2024-06-01', 'RECEIVED'),
(7, 8, '모니터에 데드픽셀이 있어요', '2024-05-23', 'COMPLETED'),
(8, 10, '전원이 안 켜짐', '2024-05-28', 'RECEIVED'),
(9, 5, '와이파이 연결 끊김', '2024-05-29', 'RECEIVED'),
(10, 1, '트랙패드 클릭 안됨', '2024-06-05', 'RECEIVED');

SET FOREIGN_KEY_CHECKS = 1;