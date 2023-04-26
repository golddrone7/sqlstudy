
-- 트랜잭션
CREATE TABLE employees(
	id NUMBER PRIMARY KEY,
	name varchar2(50),
	salary number(8, 2)
);

INSERT INTO employees values(1, 'Alice', 5000);
INSERT INTO employees values(2, 'Bob', 6000);
INSERT INTO employees values(3, 'charlie', 7000);




COMMIT; -- 변경사항을 완전히 DB에 반영
-- 실무에선 오토 커밋을 하면안됨(수동커밋)

-- 트랜잭션 시작
BEGIN
	-- 모든 사원들의 급여를 1000씩 올려줄거다
	UPDATE EMPLOYEES 
	SET salary = salary + 1000;
	
	ROLLBACK;
END;

-- 급여 총합 조회
	SELECT sum(salary) FROM employees;


-- 내 돈이 빠짐
UPDATE account
SET balance = balance -1000
WHERE USER_NAME = '김철수';

UPDATE account
SET balance = balance +1000
WHERE USER_NAME = '박영희';

COMMIT;
ROLLBACK;

-- WHERE 조건절
SELECT 
	EMP_NO, EMP_NM, ADDR, SEX_CD 
FROM TB_EMP
WHERE SEX_CD = 2
;

-- where절로 pk 동등조건을 걸면
-- 무조건 단일행이 조회된다
SELECT emp_no, emp_nm, addr, sex_cd
FROM TB_EMP
WHERE emp_no = 1000000003;

-- 비교 연산자 (90년대 생만 조회)
SELECT 
	EMP_NO, EMP_NM, BIRTH_DE, TEL_NO 
FROM TB_EMP
WHERE birth_de >= '19900101'
	AND BIRTH_DE <='19991231'
;

-- between 연산자
SELECT 
	EMP_NO, EMP_NM, BIRTH_DE, TEL_NO 
FROM TB_EMP
WHERE BIRTH_DE BETWEEN '19900101' AND '19991231';

-- OR 연산
SELECT 
	EMP_NO, EMP_NM, DEPT_CD 
FROM TB_EMP
WHERE DEPT_CD = '100004'
	OR DEPT_CD = '100006'
;

-- IN 연산자
SELECT 
	EMP_NO, EMP_NM, DEPT_CD 
FROM TB_EMP
WHERE DEPT_CD IN('100004', '100006') 
;

-- NOT IN 연산자
SELECT 
	EMP_NO, EMP_NM, DEPT_CD 
FROM TB_EMP
WHERE DEPT_CD NOT IN('100004', '100006') 
;


-- LIKE 연산자
-- 검색에서 주로 사용
-- 와일드 카드 매핑 (%: 0글자 이상, _: 딱 1글자)
SELECT 
	EMP_NO, EMP_NM
FROM TB_EMP
WHERE EMP_NM LIKE '%심'
;


SELECT 
	emp_no, emp_nm, addr
FROM TB_EMP
WHERE ADDR LIKE '%용인%'
;



SELECT 
	emp_no, emp_nm
FROM TB_EMP
WHERE EMP_NM LIKE '이%'
;

-- 성씨가 김씨이면서, 부서가 100003, 100004, 100006번 중에
-- 하나이면서,
-- 90년대생인 사원의 사번, 이름, 생일, 부서코드를 조회
SELECT * FROM tb_emp;

-- 실무 꿀팁
-- 필터링할 때 사용함, AND가 하나씩 붙음
-- 호텔 예약 시스템만들 때 쿼리의 체크를 써줌
SELECT emp_no "사원의 사번", emp_nm 이름, birth_de 생일, dept_cd 부서코드
FROM tb_emp
WHERE 1=1
	--AND dept_cd IN (100003, 100004, 100006)  
	--AND emp_nm LIKE '김%' 
	AND birth_de BETWEEN '19900101' AND '19991231';

SELECT 
	emp_no, emp_nm
FROM TB_EMP
WHERE EMP_NM LIKE '_B%' -- 언더바 2번째 글자가 B인애를 찾음
;


-- 부정 일치 비교 연산자
SELECT 
	EMP_NO ,
	emp_nm,
	addr,
	sex_cd
FROM TB_EMP
WHERE sex_cd != 2
;
SELECT 
	EMP_NO ,
	emp_nm,
	addr,
	sex_cd
FROM TB_EMP
WHERE sex_cd ^= 2
;


SELECT 
	EMP_NO ,
	emp_nm,
	addr,
	sex_cd
FROM TB_EMP
WHERE sex_cd <> 2 -- 많이 쓰는 방식
;

SELECT 
	EMP_NO ,
	emp_nm,
	addr,
	sex_cd
FROM TB_EMP
WHERE NOT sex_cd = 2
;

SELECT * FROM tb_emp;

-- 성별 코드가 1이 아니면서 성씨가 이씨가 아닌 사람들의
-- 사번, 이름, 성별코드를 조회하세요

SELECT 
	emp_no 사번,
	emp_nm 이름,
	sex_cd 성별코드
FROM 
	TB_EMP
WHERE 1=1
	AND SEX_CD <> 1
	AND emp_nm NOT LIKE '이%'
;
	
-- null 값 조회
-- 반드시 IS NULL 연산자로 조회해야 한다
SELECT 
	emp_no,
	emp_nm,
	DIRECT_MANAGER_EMP_NO 
FROM TB_EMP
WHERE DIRECT_MANAGER_EMP_NO IS NOT NULL
;

-- 연산자 우선 순위
-- NOT > AND > OR 
SELECT 
	EMP_NO ,
	EMP_NM ,
	ADDR 
FROM TB_EMP
WHERE 1=1
	AND emp_nm LIKE '김%'
	AND (ADDR LIKE '%수원%' OR ADDR LIKE '%일산%')
;




