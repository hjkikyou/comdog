# PROJECT - COMDOG #

컴퓨터 구매&렌탈 서비스 사이트 개발

🛠 기술 스택 (Tech Stack)
* Language: Java
* Framework: Spring Boot
* Database: MariaDB
* DB Migration: Flyway

⚙️ 주요 기능 (Features)
* 회원 관리: 개인(PERSONAL) / 사업자(BUSINESS) 구분 및 관리
* 상품 관리: 기기 상세 스펙 및 재고 관리
* 주문/결제: 주문 상태 관리 및 빌링 키 기반 결제
* 계약 관리: 단기 렌탈(RENTAL) 및 정기 구독(SUBSCRIPTION) 라이프사이클 관리

📂 프로젝트 핵심 구조
* `docs/`: 데이터베이스 ERD 및 초기 설계 원본 문서
* `src/main/resources/db/migration/`: Flyway 데이터베이스 형상 관리 스크립트

🚀 실행 방법 (Getting Started)
1. `application.properties` 파일에 로컬 MariaDB 접속 정보를 설정합니다.
2. 애플리케이션을 실행하면 Flyway가 자동으로 최신 테이블을 생성하고 초기 데이터를 주입합니다.
