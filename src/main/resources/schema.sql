-- ==========================================
-- 1. 외래 키 검사 임시 해제 (에러 방지용 치트키!)
-- ==========================================
SET FOREIGN_KEY_CHECKS = 0;

-- ==========================================
-- 2. 기존 테이블 일괄 삭제 (총 20개)
-- ==========================================
-- (1) 회원 관련
DROP TABLE IF EXISTS member;
DROP TABLE IF EXISTS business_profile;
DROP TABLE IF EXISTS address;

-- (2) 상품 관련
DROP TABLE IF EXISTS category;
DROP TABLE IF EXISTS product;
DROP TABLE IF EXISTS product_spec;
DROP TABLE IF EXISTS rental_prices;
DROP TABLE IF EXISTS review;

-- (3) 주문/결제/배송 관련
DROP TABLE IF EXISTS order_item;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS payment_history;
DROP TABLE IF EXISTS delivery;


-- (4) 계약 관련
DROP TABLE IF EXISTS contract;

-- (5) 장바구니/찜하기
DROP TABLE IF EXISTS cart;
DROP TABLE IF EXISTS wishlist;

-- (6) 구독 관련
DROP TABLE IF EXISTS subscription_plan;
DROP TABLE IF EXISTS subscription_status;

-- (7) B2B 전용
DROP TABLE IF EXISTS quote;
DROP TABLE IF EXISTS tax_invoice;

-- (8) 고객 지원
DROP TABLE IF EXISTS inquiry;
DROP TABLE IF EXISTS as_request;


-- =====x=x=x=x=x=x=x=x=x=x=x=x=x=x=x=x=x====
-- =x=x==x=x=x==x===x==x==x==x==x==x==x==x==x
-- =====x=x=x=x=x=x=x=x=x=x=x=x=x=x=x=x=x====

-- ==========================================
-- 아래부터 CREATE TABLE 문 시작
-- ==========================================

-- ======com.comdog.c2d.domain.member=======
-- =========================================
-- (1)          사용자 (member)
-- =========================================


CREATE TABLE member (
    member_id     BIGINT                      NOT NULL COMMENT '사용자 고유번호',
    email         VARCHAR(100)                NOT NULL COMMENT '이메일',
    password      VARCHAR(255)                NOT NULL COMMENT '비밀번호',
    name          VARCHAR(50)                 NOT NULL COMMENT '사용자 실명',
    phone         VARCHAR(20)                 NULL     COMMENT '연락처',
    birth_date    VARCHAR(6)                  NULL     COMMENT '생년월일 6자리',   -- ← 추가
    gender_digit  VARCHAR(1)                  NULL     COMMENT '성별 앞자리 (1~4)', -- ← 추가
    user_type     ENUM('PERSONAL','BUSINESS') NULL     DEFAULT 'PERSONAL' COMMENT '회원 구분',
    is_subscribed TINYINT(1)                  NULL     DEFAULT 0 COMMENT '구독 여부',
    created_at    DATETIME                    NULL     DEFAULT CURRENT_TIMESTAMP COMMENT '가입일'
)
COMMENT '사용자';

-- 사용자
ALTER TABLE member
	ADD CONSTRAINT PK_member -- 사용자 기본키
	PRIMARY KEY (
	member_id -- 사용자 고유번호
	);

-- 사용자 유니크 인덱스
CREATE UNIQUE INDEX uk_member_email
	ON member ( -- 사용자
		email ASC -- 이메일
	);

ALTER TABLE member
	MODIFY COLUMN member_id BIGINT NOT NULL AUTO_INCREMENT COMMENT '사용자 고유번호';
	
	
-- ==========================================
-- (1-1)    법인 프로필 (business_profile)
-- ==========================================

CREATE TABLE business_profile (
    member_id           BIGINT       NOT NULL COMMENT '사용자 고유번호', -- 사용자 고유번호 (회원 참조)
    company_name        VARCHAR(100) NOT NULL COMMENT '회사명', -- 회사명
    business_reg_no     VARCHAR(20)  NOT NULL COMMENT '사업자등록번호', -- 사업자등록번호
    representative_name VARCHAR(50)  NOT NULL COMMENT '대표자명' -- 대표자명
)
COMMENT '법인 프로필';

-- 법인 프로필 기본키 (member_id를 그대로 PK로 사용)
ALTER TABLE business_profile
    ADD CONSTRAINT PK_business_profile 
    PRIMARY KEY (
        member_id -- 사용자 고유번호
    );

-- 법인 프로필 외래키 설정
ALTER TABLE business_profile
    ADD CONSTRAINT FK_member_TO_business_profile
    FOREIGN KEY (
        member_id
    )
    REFERENCES member (
        member_id
    ) ON DELETE CASCADE;

-- ==========================================
-- (1-2)          주소록 (address)
-- ==========================================

CREATE TABLE address (
    address_id     BIGINT       NOT NULL COMMENT '배송지 고유번호', -- 배송지 고유번호
    member_id      BIGINT       NOT NULL COMMENT '사용자 고유번호', -- 사용자 고유번호 (회원 참조)
    address_name   VARCHAR(50)  NOT NULL COMMENT '배송지명', -- 배송지명 (예: 집, 회사)
    recipient_name VARCHAR(50)  NOT NULL COMMENT '수령인 이름', -- 수령인 이름
    phone          VARCHAR(20)  NOT NULL COMMENT '연락처', -- 연락처
    zip_code       VARCHAR(10)  NOT NULL COMMENT '우편번호', -- 우편번호
    base_address   VARCHAR(255) NOT NULL COMMENT '기본 주소', -- 기본 주소
    detail_address VARCHAR(255) NOT NULL COMMENT '상세 주소', -- 상세 주소
    is_default     TINYINT(1)   NULL     DEFAULT 0 COMMENT '기본 배송지 여부' -- 기본 배송지 여부 (1: 기본, 0: 일반)
)
COMMENT '배송지';

-- 배송지 기본키
ALTER TABLE address
    ADD CONSTRAINT PK_address 
    PRIMARY KEY (
        address_id -- 배송지 고유번호
    );

-- 배송지 기본키 자동 증가 (AUTO_INCREMENT)
ALTER TABLE address
    MODIFY COLUMN address_id BIGINT NOT NULL AUTO_INCREMENT COMMENT '배송지 고유번호';

-- 배송지 외래키 설정
ALTER TABLE address
    ADD CONSTRAINT FK_member_TO_address
    FOREIGN KEY (
        member_id
    )
    REFERENCES member (
        member_id
    ) ON DELETE CASCADE;

-- =====com.comdog.c2d.domain.product========
-- ==========================================
-- (2-1)        카테고리 (category)
-- ==========================================
-- 외래키 참조 순서에 따라. product테이블보다 먼저 생성하거나 연결

CREATE TABLE category (
    category_id BIGINT      NOT NULL COMMENT '카테고리 고유번호', -- 카테고리 고유번호
    name        VARCHAR(50) NOT NULL COMMENT '카테고리명', -- 카테고리명
    parent_id   BIGINT      NULL     COMMENT '상위 카테고리 고유번호' -- 상위 카테고리 고유번호
)
COMMENT '카테고리';

-- 카테고리 기본키
ALTER TABLE category
    ADD CONSTRAINT PK_category 
    PRIMARY KEY (
        category_id
    );

-- 카테고리 기본키 자동 증가
ALTER TABLE category
    MODIFY COLUMN category_id BIGINT NOT NULL AUTO_INCREMENT COMMENT '카테고리 고유번호';

-- 계층형 카테고리 외래키 (자기 참조)
ALTER TABLE category
    ADD CONSTRAINT FK_category_parent
    FOREIGN KEY (
        parent_id
    )
    REFERENCES category (
        category_id
    ) ON DELETE SET NULL;



-- ==========================================
-- (2)           상품 (product) 
-- ==========================================

-- 1. 상품
CREATE TABLE product (
    product_id     BIGINT         NOT NULL AUTO_INCREMENT COMMENT '상품 고유번호', 
    category_id    BIGINT         NULL     COMMENT '카테고리 고유번호', 
    name           VARCHAR(100)   NOT NULL COMMENT '상품명', 
    brand          VARCHAR(50)    NOT NULL COMMENT '브랜드', 
    model_name     VARCHAR(100)   NOT NULL COMMENT '모델명', 
    
    -- 판매 및 대여 관련
    is_purchasable CHAR(1)        NOT NULL DEFAULT 'Y' COMMENT '구매 가능 여부 (Y/N)',
    base_price     INT            NOT NULL DEFAULT 0   COMMENT '판매가(출고가)', 
    is_rentable    CHAR(1)        NOT NULL DEFAULT 'Y' COMMENT '대여 가능 여부 (Y/N)',
    rental_price   INT            NULL                 COMMENT '월 대여료', -- 최저가 대표 금액
    
    stock_quantity INT            NOT NULL DEFAULT 0   COMMENT '재고 수량', 
    description    TEXT           NULL                 COMMENT '기기의 상세 스펙이나 렌탈 유의사항',
     image_url      VARCHAR(500)   NULL                 COMMENT '상품 대표 이미지 URL', -- ← 추가
    
    -- 웹 UI 정렬/필터링을 위해 새로 추가된 컬럼들!
    is_recommended CHAR(1)        NOT NULL DEFAULT 'N' COMMENT '추천 상품 여부 (Y/N) - 추천순/메인노출용',
    view_count     INT            NOT NULL DEFAULT 0   COMMENT '상세페이지 조회수 - 인기순 정렬용(1)',
    rental_count   INT            NOT NULL DEFAULT 0   COMMENT '누적 렌탈(결제) 횟수 - 인기순 정렬용(2)',
    created_at     DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '상품 등록일 - 최신순 정렬용',
    updated_at     DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '상품 정보 수정일',

    -- 상태 관리
    is_deleted     CHAR(1)        NOT NULL DEFAULT 'N' COMMENT '삭제 여부 (Y/N)', 
    
    PRIMARY KEY (product_id),
    CONSTRAINT FK_category_TO_product FOREIGN KEY (category_id) REFERENCES category (category_id) ON DELETE SET NULL
) COMMENT '상품';



-- ==========================================
-- (2-2)   상품 상세 사양 (product_spec)
-- ==========================================


CREATE TABLE product_spec (
    product_id BIGINT       NOT NULL COMMENT '상품 고유번호', 
    spec_key   VARCHAR(50)  NOT NULL COMMENT '사양 항목', 
    spec_value VARCHAR(255) NOT NULL COMMENT '사양 값',
    
    -- 기본키와 외래키를 안으로 이동!
    CONSTRAINT PK_product_spec PRIMARY KEY (product_id, spec_key),
    CONSTRAINT FK_product_TO_product_spec FOREIGN KEY (product_id) REFERENCES product (product_id) ON DELETE CASCADE
) COMMENT '상품 상세 사양';


-- ==========================================
-- (2-3)    렌탈가 관리 (rental_prices)
-- ==========================================


CREATE TABLE rental_prices (
    rental_price_id BIGINT      NOT NULL AUTO_INCREMENT COMMENT '렌탈가 고유번호', 
    product_id      BIGINT      NOT NULL COMMENT '상품 고유번호', 
    duration        INT         NOT NULL COMMENT '렌탈 기간(개월)', 
    monthly_fee     INT         NOT NULL COMMENT '월 렌탈료', 
    deposit_fee     INT         NOT NULL DEFAULT 0 COMMENT '보증금/초기등록비', 
    is_b2b_only     CHAR(1)     NOT NULL DEFAULT 'N' COMMENT 'B2B 전용 여부 (Y/N)', 
    is_active       CHAR(1)     NOT NULL DEFAULT 'Y' COMMENT '활성화 여부 (Y/N)', 

    -- 👇 기본키 제약조건을 여기에 한 번만 작성합니다.
    CONSTRAINT PK_rental_prices PRIMARY KEY (rental_price_id),

    -- 👇 외래키 제약조건도 여기에 한 번만 작성합니다.
    CONSTRAINT FK_product_TO_rental_prices FOREIGN KEY (product_id) REFERENCES product (product_id) ON DELETE CASCADE
) COMMENT '렌탈가 관리';

-- ❌ 아래에 있던 3개의 ALTER TABLE 구문들은 모두 삭제하세요. 
-- (위의 CREATE TABLE에서 모두 처리되었습니다.)



-- =====com.comdog.c2d.domain.orders=========
-- ==========================================
-- (3)            주문 (orders) 
-- ==========================================

-- 1. 주문 (영수증 머리말)
CREATE TABLE orders (
    order_id        BIGINT         NOT NULL AUTO_INCREMENT COMMENT '주문 고유번호', 
    member_id       BIGINT         NOT NULL COMMENT '회원 고유번호', 
    total_amount    INT            NOT NULL DEFAULT 0 COMMENT '총 결제 금액', 
    order_status    VARCHAR(20)    NOT NULL DEFAULT '결제대기' COMMENT '주문 상태', 
    tracking_number VARCHAR(100)   NULL     COMMENT '송장 번호', 
    payment_method  VARCHAR(50)    NOT NULL COMMENT '결제 수단', 
    billing_key     VARCHAR(255)   NULL     COMMENT '빌링 키', 
    created_at      DATETIME       NULL     DEFAULT CURRENT_TIMESTAMP COMMENT '주문 일시',
    
    -- 기본키(PK)와 외래키(FK)를 테이블 생성 시 한 번에 세팅합니다.
    PRIMARY KEY (order_id),
    CONSTRAINT FK_member_TO_orders FOREIGN KEY (member_id) REFERENCES member (member_id)
) COMMENT '주문';


-- 2. 주문 상품 상세내역 (영수증 개별 항목)
CREATE TABLE order_item (
    order_item_id BIGINT         NOT NULL AUTO_INCREMENT COMMENT '주문 상세 번호',
    order_id      BIGINT         NOT NULL COMMENT '주문 고유번호 (orders 테이블 FK)',
    product_id    BIGINT         NOT NULL COMMENT '상품 고유번호 (product 테이블 FK)',
    order_price   INT            NOT NULL COMMENT '주문 당시의 상품 가격',
    count         INT            NOT NULL DEFAULT 1 COMMENT '주문 수량',
    
    -- 기본키(PK)와 외래키(FK) 세팅
    PRIMARY KEY (order_item_id),
    CONSTRAINT FK_order_TO_item FOREIGN KEY (order_id) REFERENCES orders(order_id),
    CONSTRAINT FK_product_TO_item FOREIGN KEY (product_id) REFERENCES product(product_id)
) COMMENT '주문 상품 상세내역';

	
-- =====com.comdog.c2d.domain.orders=========	
-- ==========================================
-- (3-1)    결제 내역 (payment_history)
-- ==========================================

--초기 orders 테이블은 '처음 계약할 때의 결제(또는 보증금)'를 기록하기엔 좋지만, 
--36개월 렌탈 중 14개월 차에 결제가 성공했는지, 한도 초과로 실패했는지 추적하려면 
--별도의 이력 테이블이 반드시 필요합니다.
	
CREATE TABLE payment_history (
    payment_history_id BIGINT       NOT NULL COMMENT '결제 내역 고유번호', -- 결제 내역 고유번호
    contract_id        BIGINT       NOT NULL COMMENT '계약 고유번호', -- 어떤 렌탈/구독 계약에 대한 결제인지
    amount             INT          NOT NULL COMMENT '결제 금액', -- 결제 금액
    payment_date       DATETIME     NULL     DEFAULT CURRENT_TIMESTAMP COMMENT '결제 일시', -- 결제 일시
    status             VARCHAR(20)  NOT NULL COMMENT '결제 상태', -- SUCCESS(성공), FAILED(실패)
    fail_reason        VARCHAR(255) NULL     COMMENT '실패 사유', -- 실패 시 사유 (예: 잔액 부족, 한도 초과)
    billing_key        VARCHAR(100) NULL     COMMENT '빌링 키' -- 정기 결제용 키
)
COMMENT '결제 내역';

-- 결제 내역 기본키
ALTER TABLE payment_history
    ADD CONSTRAINT PK_payment_history
    PRIMARY KEY (
        payment_history_id
    );

-- 결제 내역 기본키 자동 증가
ALTER TABLE payment_history
    MODIFY COLUMN payment_history_id BIGINT NOT NULL AUTO_INCREMENT COMMENT '결제 내역 고유번호';

-- 결제 내역 외래키
-- (주의: contract 테이블이 먼저 생성되어 있어야 합니다)
ALTER TABLE payment_history
    ADD CONSTRAINT FK_contract_TO_payment_history
    FOREIGN KEY (
        contract_id
    )
    REFERENCES contract (
        contract_id
    );

-- =====com.comdog.c2d.domain.orders=========
-- ==========================================
-- (3-2)         배송 (delivery)
-- ==========================================

--고가의 PC나 장비가 오가는 만큼, 출고 상태와 반납(회수) 상태를 관리해야 합니다. 
-- orders 테이블에 배송 컬럼을 넣으면 반납 배송을 추적하기 애매해지므로 분리하는 것이 정석입니다.

CREATE TABLE delivery (
    delivery_id     BIGINT       NOT NULL COMMENT '배송 고유번호', -- 배송 고유번호
    order_id        BIGINT       NOT NULL COMMENT '주문 고유번호', -- 최초 출고 배송 시 주문과 연결
    tracking_number VARCHAR(100) NULL     COMMENT '운송장 번호', -- 운송장 번호
    carrier         VARCHAR(50)  NULL     COMMENT '택배사', -- 택배사 (예: CJ대한통운, 자체 직배송)
    status          VARCHAR(20)  NOT NULL DEFAULT 'PREPARING' COMMENT '배송 상태', -- PREPARING(상품준비중), SHIPPING(배송중), DELIVERED(배송완료), RETURN_SHIPPING(반납배송중)
    dispatched_at   DATETIME     NULL     COMMENT '발송 일시', -- 발송 일시
    delivered_at    DATETIME     NULL     COMMENT '도착 일시' -- 도착 일시
)
COMMENT '배송';

-- 배송 기본키
ALTER TABLE delivery
    ADD CONSTRAINT PK_delivery
    PRIMARY KEY (
        delivery_id
    );

-- 배송 기본키 자동 증가
ALTER TABLE delivery
    MODIFY COLUMN delivery_id BIGINT NOT NULL AUTO_INCREMENT COMMENT '배송 고유번호';

-- 배송 외래키
ALTER TABLE delivery
    ADD CONSTRAINT FK_orders_TO_delivery
    FOREIGN KEY (
        order_id
    )
    REFERENCES orders (
        order_id
    );

-- =====com.comdog.c2d.domain.contract=======
-- ==========================================
-- (4)           계약 (contract) 
-- ==========================================


CREATE TABLE contract (
    contract_id     BIGINT                                 NOT NULL COMMENT '계약 고유번호',
    member_id       BIGINT                                 NOT NULL COMMENT '회원 고유번호', -- NOT NULL로 수정
    order_id        BIGINT                                 NOT NULL COMMENT '주문 고유번호', -- NOT NULL로 수정
    product_id      BIGINT                                 NOT NULL COMMENT '상품 고유번호', -- NOT NULL로 수정
    monthly_fee     INT                                    NOT NULL COMMENT '약정 월 렌탈료', -- 추가 (가격 변동 대비)
    duration        INT                                    NOT NULL COMMENT '약정 기간(개월)', -- 추가 (계약 기간 명시)
    contract_type   ENUM('RENTAL','SUBSCRIPTION')          NOT NULL COMMENT '계약 유형',
    contract_status ENUM('USING','RETURNING','TERMINATED') NULL     DEFAULT 'USING' COMMENT '계약 상태',
    start_date      DATE                                   NOT NULL COMMENT '대여 시작일',
    end_date        DATE                                   NULL     COMMENT '대여 종료일'
)
COMMENT '계약';

-- 계약 기본키
ALTER TABLE contract
    ADD CONSTRAINT PK_contract 
    PRIMARY KEY (
        contract_id
    );

-- 계약 기본키 자동 증가
ALTER TABLE contract
    MODIFY COLUMN contract_id BIGINT NOT NULL AUTO_INCREMENT COMMENT '계약 고유번호';

-- 계약 외래키
ALTER TABLE contract
    ADD CONSTRAINT FK_member_TO_contract 
    FOREIGN KEY (member_id) REFERENCES member (member_id); -- 삭제 방지 (RESTRICT 기본값)

ALTER TABLE contract
    ADD CONSTRAINT FK_orders_TO_contract 
    FOREIGN KEY (order_id) REFERENCES orders (order_id);

ALTER TABLE contract
    ADD CONSTRAINT FK_product_TO_contract 
    FOREIGN KEY (product_id) REFERENCES product (product_id) ;
-- =====com.comdog.c2d.domain.product========
-- ==========================================
-- (2-4)          리뷰 (review)  
-- ==========================================
-- 계약 고유 번호가 필요하기 때문에 , 계약 테이블 다음 생성

CREATE TABLE review (
    review_id   BIGINT       NOT NULL COMMENT '리뷰 고유번호', -- 리뷰 고유번호
    member_id   BIGINT       NOT NULL COMMENT '사용자 고유번호', -- 사용자 고유번호 (BIGINT로 수정)
    product_id  BIGINT       NOT NULL COMMENT '상품 고유번호', -- 상품 고유번호 (BIGINT로 수정)
    contract_id BIGINT       NOT NULL COMMENT '계약 고유번호', -- 계약 고유번호 (BIGINT로 통일 권장)
    rating      INT          NOT NULL COMMENT '별점(1~5)', -- 1~5점 별점
    content     TEXT         NOT NULL COMMENT '리뷰 내용', -- 리뷰 내용
    image_url   VARCHAR(500) NULL     COMMENT '이미지 URL', -- 포토리뷰용 이미지 URL
    created_at  DATETIME     NULL     DEFAULT CURRENT_TIMESTAMP COMMENT '작성일' -- 작성일
)
COMMENT '리뷰';

-- 리뷰 기본키
ALTER TABLE review
    ADD CONSTRAINT PK_review 
    PRIMARY KEY (
        review_id
    );

-- 리뷰 기본키 자동 증가
ALTER TABLE review
    MODIFY COLUMN review_id BIGINT NOT NULL AUTO_INCREMENT COMMENT '리뷰 고유번호';

-- 리뷰 별점 제약조건 (CHECK)
ALTER TABLE review
    ADD CONSTRAINT CHK_review_rating 
    CHECK (rating >= 1 AND rating <= 5);

-- 리뷰 외래키 설정
ALTER TABLE review
    ADD CONSTRAINT FK_member_TO_review
    FOREIGN KEY (member_id) REFERENCES member (member_id) ON DELETE CASCADE;

ALTER TABLE review
    ADD CONSTRAINT FK_product_TO_review
    FOREIGN KEY (product_id) REFERENCES product (product_id) ON DELETE CASCADE;

-- (주의) contract 테이블이 먼저 생성되어 있어야 아래 외래키가 작동합니다.
ALTER TABLE review
    ADD CONSTRAINT FK_contract_TO_review
    FOREIGN KEY (contract_id) REFERENCES contract (contract_id);


-- ========com.comdog.c2d.domain.cart========
-- ==========================================
-- (5)           장바구니 (cart) 
-- ==========================================


CREATE TABLE cart (
    cart_id     BIGINT                        NOT NULL COMMENT '장바구니 고유번호', -- 장바구니 고유번호
    member_id   BIGINT                        NOT NULL COMMENT '사용자 고유번호', -- 사용자 고유번호
    product_id  BIGINT                        NOT NULL COMMENT '상품 고유번호', -- 상품 고유번호
    rental_type ENUM('RENTAL','SUBSCRIPTION') NOT NULL COMMENT '렌탈 유형', -- RENTAL, SUBSCRIPTION
    duration    INT                           NULL     COMMENT '약정 기간(개월)', -- 렌탈일 경우 개월 수
    quantity    INT                           NOT NULL DEFAULT 1 COMMENT '수량' -- 수량
)
COMMENT '장바구니';

-- 장바구니 기본키
ALTER TABLE cart
    ADD CONSTRAINT PK_cart 
    PRIMARY KEY (
        cart_id
    );

-- 장바구니 기본키 자동 증가
ALTER TABLE cart
    MODIFY COLUMN cart_id BIGINT NOT NULL AUTO_INCREMENT COMMENT '장바구니 고유번호';

-- 장바구니 외래키
ALTER TABLE cart
    ADD CONSTRAINT FK_member_TO_cart
    FOREIGN KEY (member_id) REFERENCES member (member_id) ON DELETE CASCADE;

ALTER TABLE cart
    ADD CONSTRAINT FK_product_TO_cart
    FOREIGN KEY (product_id) REFERENCES product (product_id) ON DELETE CASCADE;


-- ========com.comdog.c2d.domain.cart========
-- ==========================================
-- (5-1)         찜하기 (wishlist) 
-- ==========================================

CREATE TABLE wishlist (
    wishlist_id BIGINT   NOT NULL COMMENT '찜하기 고유번호', -- 찜하기 고유번호
    member_id   BIGINT   NOT NULL COMMENT '사용자 고유번호', -- 사용자 고유번호
    product_id  BIGINT   NOT NULL COMMENT '상품 고유번호', -- 상품 고유번호
    created_at  DATETIME NULL     DEFAULT CURRENT_TIMESTAMP COMMENT '등록일' -- 등록일
)
COMMENT '찜하기';

-- 찜하기 기본키
ALTER TABLE wishlist
    ADD CONSTRAINT PK_wishlist 
    PRIMARY KEY (
        wishlist_id
    );

-- 찜하기 기본키 자동 증가
ALTER TABLE wishlist
    MODIFY COLUMN wishlist_id BIGINT NOT NULL AUTO_INCREMENT COMMENT '찜하기 고유번호';

-- 동일 사용자가 같은 상품을 여러 번 찜하는 것 방지 (유니크 인덱스)
ALTER TABLE wishlist
    ADD CONSTRAINT UK_wishlist_member_product 
    UNIQUE (member_id, product_id);

-- 찜하기 외래키
ALTER TABLE wishlist
    ADD CONSTRAINT FK_member_TO_wishlist
    FOREIGN KEY (member_id) REFERENCES member (member_id) ON DELETE CASCADE;

ALTER TABLE wishlist
    ADD CONSTRAINT FK_product_TO_wishlist
    FOREIGN KEY (product_id) REFERENCES product (product_id) ON DELETE CASCADE;


-- ===============com.comdog.c2d.domain.subscription====================
-- =====================================================================
-- (6)              구독 - 플랜 (subscription_plan)
-- =====================================================================



CREATE TABLE subscription_plan (
    plan_id       BIGINT      NOT NULL COMMENT '구독 플랜 고유번호', -- 구독 플랜 고유번호
    plan_name     VARCHAR(50) NOT NULL COMMENT '플랜명', -- 베이직, 프로, 마스터 등
    monthly_fee   INT         NOT NULL COMMENT '월 구독료', -- 월 구독료
    benefits_desc TEXT        NULL     COMMENT '혜택 설명' -- 혜택 설명
)
COMMENT '구독 플랜';

-- 구독 플랜 기본키
ALTER TABLE subscription_plan
    ADD CONSTRAINT PK_subscription_plan 
    PRIMARY KEY (
        plan_id
    );

-- 구독 플랜 기본키 자동 증가
ALTER TABLE subscription_plan
    MODIFY COLUMN plan_id BIGINT NOT NULL AUTO_INCREMENT COMMENT '구독 플랜 고유번호';


-- ===============com.comdog.c2d.domain.subscription====================
-- =====================================================================
-- (6-1)               구독 상태 (subscription_status)
-- =====================================================================

CREATE TABLE subscription_status (
    subscription_status_id BIGINT      NOT NULL COMMENT '구독 상태 고유번호', -- 구독 상태 고유번호
    member_id              BIGINT      NOT NULL COMMENT '사용자 고유번호', -- 사용자 고유번호
    plan_id                BIGINT      NOT NULL COMMENT '구독 플랜 고유번호', -- 구독 플랜 고유번호
    status                 VARCHAR(20) NOT NULL COMMENT '구독 상태', -- ACTIVE(활성), CANCELED(해지) 등
    start_date             DATE        NOT NULL COMMENT '구독 시작일', -- 구독 시작일
    end_date               DATE        NULL     COMMENT '구독 종료일', -- 구독 종료일
    next_billing_date      DATE        NOT NULL COMMENT '다음 결제 예정일' -- 다음 결제 예정일
)
COMMENT '구독 상태';

-- 구독 상태 기본키
ALTER TABLE subscription_status
    ADD CONSTRAINT PK_subscription_status 
    PRIMARY KEY (
        subscription_status_id
    );

-- 구독 상태 기본키 자동 증가
ALTER TABLE subscription_status
    MODIFY COLUMN subscription_status_id BIGINT NOT NULL AUTO_INCREMENT COMMENT '구독 상태 고유번호';

-- 구독 상태 외래키 (회원)
ALTER TABLE subscription_status
    ADD CONSTRAINT FK_member_TO_subscription_status
    FOREIGN KEY (
        member_id
    )
    REFERENCES member (
        member_id
    ) ON DELETE CASCADE;

-- 구독 상태 외래키 (플랜)
ALTER TABLE subscription_status
    ADD CONSTRAINT FK_plan_TO_subscription_status
    FOREIGN KEY (
        plan_id
    )
    REFERENCES subscription_plan (
        plan_id
    );


-- ===============com.comdog.c2d.domain.b2b================
-- ========================================================
-- (7)          B2B전용 - 대량견적 (quote) 
-- ========================================================


CREATE TABLE quote (
    quote_id        BIGINT      NOT NULL COMMENT '견적 고유번호', -- 견적 고유번호
    member_id       BIGINT      NOT NULL COMMENT '사용자 고유번호', -- 사용자 고유번호
    status          VARCHAR(20) NOT NULL DEFAULT 'REQUEST' COMMENT '견적 상태', -- REQUEST(요청), APPROVED(승인), COMPLETED(완료)
    total_quantity  INT         NOT NULL COMMENT '총 수량', -- 총 수량
    proposed_amount INT         NOT NULL COMMENT '제안 총 금액', -- 제안(견적) 총 금액
    admin_comment   TEXT        NULL     COMMENT '관리자 검토 의견', -- 관리자 검토 의견
    created_at      DATETIME    NULL     DEFAULT CURRENT_TIMESTAMP COMMENT '요청 일시' -- 요청 일시
)
COMMENT '대량견적';

-- 대량견적 기본키
ALTER TABLE quote
    ADD CONSTRAINT PK_quote 
    PRIMARY KEY (
        quote_id
    );

-- 대량견적 기본키 자동 증가
ALTER TABLE quote
    MODIFY COLUMN quote_id BIGINT NOT NULL AUTO_INCREMENT COMMENT '견적 고유번호';

-- 대량견적 외래키 (회원)
ALTER TABLE quote
    ADD CONSTRAINT FK_member_TO_quote
    FOREIGN KEY (
        member_id
    )
    REFERENCES member (
        member_id
    ) ON DELETE CASCADE;

-- ===============com.comdog.c2d.domain.b2b================
-- ========================================================
-- (7-1)             세금계산서 (tax_invoice) 
-- ========================================================

CREATE TABLE tax_invoice (
    tax_invoice_id BIGINT       NOT NULL COMMENT '세금계산서 고유번호', -- 세금계산서 고유번호
    order_id       BIGINT       NOT NULL COMMENT '주문 고유번호', -- 주문 고유번호
    status         VARCHAR(20)  NOT NULL DEFAULT 'APPLIED' COMMENT '발행 상태', -- APPLIED(신청), ISSUED(발행완료)
    invoice_url    VARCHAR(500) NULL     COMMENT '세금계산서 URL', -- 세금계산서 조회/출력용 외부 링크
    created_at     DATETIME     NULL     DEFAULT CURRENT_TIMESTAMP COMMENT '신청 일시' -- 신청 일시
)
COMMENT '세금계산서';

-- 세금계산서 기본키
ALTER TABLE tax_invoice
    ADD CONSTRAINT PK_tax_invoice 
    PRIMARY KEY (
        tax_invoice_id
    );

-- 세금계산서 기본키 자동 증가
ALTER TABLE tax_invoice
    MODIFY COLUMN tax_invoice_id BIGINT NOT NULL AUTO_INCREMENT COMMENT '세금계산서 고유번호';

-- 세금계산서 외래키 (주문)
ALTER TABLE tax_invoice
    ADD CONSTRAINT FK_orders_TO_tax_invoice
    FOREIGN KEY (
        order_id
    )
    REFERENCES orders (
        order_id
    ) ON DELETE CASCADE;

-- ============com.comdog.c2d.domain.support===============
-- ========================================================
-- (8)          고객지원  - 1:1 문의 (inquiry)
-- ========================================================

CREATE TABLE inquiry (
    inquiry_id     BIGINT       NOT NULL COMMENT '문의 고유번호', -- 문의 고유번호
    member_id      BIGINT       NOT NULL COMMENT '사용자 고유번호', -- 사용자 고유번호
    title          VARCHAR(100) NOT NULL COMMENT '문의 제목', -- 문의 제목 (넉넉하게 100자로 확장)
    content        TEXT         NOT NULL COMMENT '문의 내용', -- 문의 내용
    image_url      VARCHAR(500) NULL     COMMENT '첨부 이미지 URL', -- 첨부 이미지 URL
    answer_content TEXT         NULL     COMMENT '답변 내용', -- 답변 내용
    status         VARCHAR(20)  NOT NULL DEFAULT 'PENDING' COMMENT '답변 상태', -- PENDING(대기), ANSWERED(답변완료)
    created_at     DATETIME     NULL     DEFAULT CURRENT_TIMESTAMP COMMENT '작성 일시' -- 작성 일시
)
COMMENT '1:1 문의';

-- 1:1 문의 기본키
ALTER TABLE inquiry
    ADD CONSTRAINT PK_inquiry 
    PRIMARY KEY (
        inquiry_id
    );

-- 1:1 문의 기본키 자동 증가
ALTER TABLE inquiry
    MODIFY COLUMN inquiry_id BIGINT NOT NULL AUTO_INCREMENT COMMENT '문의 고유번호';

-- 1:1 문의 외래키 (회원)
ALTER TABLE inquiry
    ADD CONSTRAINT FK_member_TO_inquiry
    FOREIGN KEY (
        member_id
    )
    REFERENCES member (
        member_id
    ) ON DELETE CASCADE;

-- ============com.comdog.c2d.domain.support===============
-- ========================================================
-- (8-1)               AS 접수 (as_request) 
-- ========================================================
CREATE TABLE as_request (
    as_request_id BIGINT      NOT NULL COMMENT 'AS 접수 고유번호', -- AS 접수 고유번호
    contract_id   BIGINT      NOT NULL COMMENT '계약 고유번호', -- 계약 고유번호
    symptom       TEXT        NOT NULL COMMENT '고장 증상', -- 고장 증상
    visit_date    DATE        NOT NULL COMMENT '방문 희망일(예정일)', -- 방문 희망일 혹은 방문 예정일
    status        VARCHAR(20) NOT NULL DEFAULT 'RECEIVED' COMMENT 'AS 접수 상태', -- RECEIVED(접수), IN_PROGRESS(수리중), COMPLETED(완료)
    created_at    DATETIME    NULL     DEFAULT CURRENT_TIMESTAMP COMMENT '접수 일시' -- 접수 일시
)
COMMENT 'AS 접수';

-- AS 접수 기본키
ALTER TABLE as_request
    ADD CONSTRAINT PK_as_request 
    PRIMARY KEY (
        as_request_id
    );

-- AS 접수 기본키 자동 증가
ALTER TABLE as_request
    MODIFY COLUMN as_request_id BIGINT NOT NULL AUTO_INCREMENT COMMENT 'AS 접수 고유번호';

-- AS 접수 외래키 (계약)
ALTER TABLE as_request
    ADD CONSTRAINT FK_contract_TO_as_request
    FOREIGN KEY (
        contract_id
    )
    REFERENCES contract (
        contract_id
    ) ON DELETE CASCADE;


-- 모든 테이블 생성이 끝난 후 파일 맨 마지막에 추가
SET FOREIGN_KEY_CHECKS = 1;