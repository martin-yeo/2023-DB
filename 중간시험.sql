-- 22.
CREATE TABLE 의사 (
  의사번호 CHAR(4) NOT NULL,
  성명 VARCHAR(10),
  소속 VARCHAR(20) DEFAULT ‘가정의학과’,
  근무연수 INT, 
  PRIMARY KEY(의사번호),
  CHECK (근무연수 >= 1 AND 근무연수 <= 40)
);



-- 23에서 31문제
CREATE TABLE 고객 ( 
  고객아이디  VARCHAR(20) NOT NULL,  
  고객이름    VARCHAR(20) NOT NULL, 
  나이        INT,
  등급        VARCHAR(20) NOT NULL,
  직업        VARCHAR(20),
  적립금      INT DEFAULT 0,
  PRIMARY KEY (고객아이디)
); 

CREATE TABLE 제품 (
  제품번호    CHAR(3) NOT NULL,
  제품명      VARCHAR(20),
  재고량      INT,
  단가        INT,
  제조업체    VARCHAR(20),
  PRIMARY KEY (제품번호),
  CHECK (재고량 >= 0 AND 재고량 <= 10000)
);

CREATE TABLE 주문 (
  주문번호    CHAR(3) NOT NULL,
  주문고객    VARCHAR(20),
  주문제품    CHAR(3),
  수량        INT,
  배송지      VARCHAR(100),
  주문일자    DATE,
  PRIMARY KEY (주문번호),
  FOREIGN KEY (주문고객) REFERENCES 고객(고객아이디),
  FOREIGN KEY (주문제품) REFERENCES 제품(제품번호)
);

INSERT INTO 고객 VALUES ('apple', '정소화', 20, 'gold', '학생', 1000);
INSERT INTO 고객 VALUES ('banana', '김선우', 25, 'vip', '간호사', 2500);
INSERT INTO 고객 VALUES ('carrot', '고명석', 28, 'gold', '교사', 4500);
INSERT INTO 고객 VALUES ('orange', '김용욱', 22, 'silver', '학생', 0);
INSERT INTO 고객 VALUES ('melon', '성원용', 35, 'gold', '회사원', 5000);
INSERT INTO 고객 VALUES ('peach', '윤형식', 36, 'silver', '의사', 300);
INSERT INTO 고객 VALUES ('pear', '채광주', 31, 'silver', '회사원', 500);

INSERT INTO 제품 VALUES ('p01', '행복만두', 5000, 4500, '대한식품');
INSERT INTO 제품 VALUES ('p02', '매운쫄면', 2500, 5500, '민국푸드');
INSERT INTO 제품 VALUES ('p03', '쿵떡파이', 3600, 2600, '한빛제과');
INSERT INTO 제품 VALUES ('p04', '맛난초콜릿', 1250, 2500, '한빛제과');
INSERT INTO 제품 VALUES ('p05', '얼큰라면', 2200, 1200, '대한식품');
INSERT INTO 제품 VALUES ('p06', '통통우동면', 1000, 1550, '민국푸드');
INSERT INTO 제품 VALUES ('p07', '달콤비스킷', 1650, 1500, '한빛제과');

INSERT INTO 주문 VALUES ('d01', 'apple', 'p03', 10, '서울시 마포구', to_date('2022-01-01', 'YYYY-MM-DD'));
INSERT INTO 주문 VALUES ('d02', 'melon', 'p01', 5, '인천시 계양구', to_date('2022-01-10', 'YYYY-MM-DD'));
INSERT INTO 주문 VALUES ('d03', 'banana', 'p06', 45, '경기도 부천시', to_date('2022-01-11', 'YYYY-MM-DD'));
INSERT INTO 주문 VALUES ('d04', 'carrot', 'p02', 8, '부산시 금정구', to_date('2022-02-01', 'YYYY-MM-DD'));
INSERT INTO 주문 VALUES ('d05', 'melon', 'p06', 36, '경기도 용인시', to_date('2022-02-20', 'YYYY-MM-DD'));
INSERT INTO 주문 VALUES ('d06', 'banana', 'p01', 19, '충청북도 보은군', to_date('2022-03-02', 'YYYY-MM-DD'));
INSERT INTO 주문 VALUES ('d07', 'apple', 'p03', 22, '서울시 영등포구', to_date('2022-03-15', 'YYYY-MM-DD'));
INSERT INTO 주문 VALUES ('d08', 'pear', 'p02', 50, '강원도 춘천시', to_date('2022-04-10', 'YYYY-MM-DD'));
INSERT INTO 주문 VALUES ('d09', 'banana', 'p04', 15, '전라남도 목포시', to_date('2022-04-11', 'YYYY-MM-DD'));
INSERT INTO 주문 VALUES ('d10', 'carrot', 'p03', 20, '경기도 안양시', to_date('2022-05-22', 'YYYY-MM-DD'));

-- 23.
SELECT 제품명, 재고량, 단가 FROM 제품
WHERE 단가 < 1700 AND 재고량 > 2000;

-- 24.
SELECT 고객이름, 등급 FROM 고객
WHERE 적립금 > 3000;

-- 25.
SELECT 고객.고객이름, 고객.등급, 주문.주문제품, 주문.수량 FROM 고객, 주문
WHERE 고객.고객이름 = '고명석' AND 주문.주문고객 = 고객.고객아이디;

-- 26. 다음 SQL문 실행시 반환되는 결과테이블을 작성하시오. [1점]
SELECT 주문고객, 주문제품, 수량, 주문일자 FROM 주문
WHERE 수량 >= 30 ORDER BY 주문제품 ASC, 수량 DESC;

-- 27. 다음 SQL문 실행시 반환되는 결과테이블을 작성하시오. [1점]
SELECT 고객.고객이름, 고객.적립금, 제품.제품명 FROM 고객, 제품, 주문
WHERE 고객.등급 = 'vip'
AND 주문.주문고객 = 고객.고객아이디 AND 제품.제품번호 = 주문.주문제품;

-- 28. 주문 테이블에서 정소화 고객의 주문수량을 20% 증가시키는 SQL 문을 작성하시오. [1점]
SELECT * FROM 주문 WHERE 주문고객 IN (SELECT 고객아이디 FROM 고객 WHERE 고객이름 = '정소화');

UPDATE 주문
SET 수량 = 수량 * 1.2
WHERE 주문고객 IN (SELECT 고객아이디 FROM 고객 WHERE 고객이름 = '정소화');

SELECT * FROM 주문 WHERE 주문고객 IN (SELECT 고객아이디 FROM 고객 WHERE 고객이름 = '정소화');

-- 29. 가격이 가장 최저가인 제품의 제품명을 중복 없이 검색하는 SQL문을 작성하고, 그 SQL문 실행시 반환되는 결과테이블을 작성하시오. [2점]
SELECT DISTINCT 제품명
FROM 제품
WHERE 단가 = (SELECT MIN(단가) FROM 제품);


-- 30. 주문수량의 합계가 60개 이상인 고객에 대해 고객별 주문 횟수와 주문수량의 합계를 검색하는 SQL문을 작성하고, 그 SQL문 실행시 반환되는 결과테이블을 작성하시오. [2점]
SELECT 주문고객, COUNT(*) AS 주문횟수, SUM(수량) AS 주문수량합계
FROM 주문
GROUP BY 주문고객 HAVING SUM(수량) >= 60;

-- 31. 제품명에 ‘면’이 포함된 제품을 주문한 고객의 이름을 검색하는 SQL 문을 작성고, 그 SQL문 실행시 반환되는 결과테이블을 작성하시오. [2점]
SELECT 고객.고객이름 FROM 고객, 제품, 주문 
WHERE 제품.제품명 LIKE '%면%' 
AND 고객.고객아이디 = 주문.주문고객 AND 제품.제품번호 = 주문.주문제품;
