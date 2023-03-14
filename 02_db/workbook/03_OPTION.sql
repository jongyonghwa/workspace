--1. 학생이름과 주소지를 표시하시오. 
--단, 출력 헤더는 "학생 이름", "주소지"로 하고, 정렬은 이름으로 오름차순 표시하도록 한다.
SELECT STUDENT_NAME"학생 이름",STUDENT_ADDRESS"주소지"
FROM TB_STUDENT
ORDER BY STUDENT_NAME ;

--2. 휴학중인 학생들의 이름과 주민번호를 나이가 적은 순서로 화면에 출력하시오
SELECT STUDENT_NAME ,STUDENT_SSN 
FROM TB_STUDENT 
WHERE ABSENCE_YN ='Y'
ORDER BY STUDENT_SSN DESC;

--3. 주소지가 강원도나 경기도인 학생들 중 1900년대 학번을 가진 학생들의
--이름과 학번, 주소를 이름의 오름차순으로 화면에 출력하시오.
--단, 출력헤더에는 "학생이름", "학번", "거주지 주소"가 출력되도록 한다.

SELECT STUDENT_NAME"학생이름" , STUDENT_NO"학번" ,STUDENT_ADDRESS"거주지 주소"
FROM TB_STUDENT 
WHERE STUDENT_NO LIKE '9%' 
AND STUDENT_ADDRESS LIKE '경기도%'
ORDER BY STUDENT_NAME ASC;