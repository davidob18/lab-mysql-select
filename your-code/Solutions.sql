USE Publications;

DROP TABLE IF EXISTS author_title;

CREATE TABLE author_title AS #BUENO CHALLENGE 1
SELECT au_id AS 'AUTHOR ID', au_lname AS 'LAST NAME', au_fname AS 'FIRST NAME', b.title AS 'TITLE', c.pub_name AS 'PUBLISHER'
FROM authors
JOIN `titleauthor` a USING(au_id)
JOIN `titles` b USING(title_id)
JOIN `publishers` c USING(pub_id)
ORDER BY `au_id`;

SELECT * FROM author_title;# IMPRESION DE TABLA CHALLENGE 1
SELECT COUNT(*) FROM author_title; #DIMENSION DE AUTHOR
SELECT COUNT(*) FROM titleauthor; #DIMENSION DE TITLE

CREATE TABLE author_title_2 AS #BUENO CHALLEGUEN 2
SELECT `AUTHOR ID`,`LAST NAME`, 
`FIRST NAME`,`PUBLISHER`,COUNT(`TITLE`) AS `COUNT TITLE` 
FROM author_title  
GROUP BY `PUBLISHER`,`AUTHOR ID`
ORDER BY `AUTHOR ID` DESC ;
#ORDER BY `COUNT TITLE` DESC ;

DROP TABLE IF EXISTS author_title_2;

SELECT * FROM author_title_2; #IMPRESION DE TABLA CHALLENGE 2

SELECT SUM(`COUNT TITLE`) AS 'SUMA COUNT TITLE' # CANTIDAD DE RENGLONES DE CHALLENGE 2
FROM author_title_2; #25

SELECT COUNT(*) AS 'NUMERO TOTAL DE REGISTROS' # CANTIDAD DE RENGLONES DE TITLEAUTHOR
FROM titleauthor; #25



DROP TABLE IF EXISTS author_title_4; # PRUEBA DE TABLA CON AUTORES, TITULOS Y PUBLICACIONES

CREATE TABLE author_title_4 AS
SELECT `AUTHOR ID`,`LAST NAME`, 
`FIRST NAME`,COUNT(`TITLE`) AS `COUNT TITLE` 
FROM author_title  
GROUP BY `AUTHOR ID`
ORDER BY `COUNT TITLE` DESC ;

SELECT * FROM author_title_4;
SELECT * FROM author_title ORDER BY `AUTHOR ID` ASC; #IMPRESION CON ORDEN EN BASE A AUTOR ID

SELECT * FROM sales;



DROP TABLE IF EXISTS author_title_ventas;

SELECT * FROM author_title_ventas;


CREATE TABLE author_title_ventas AS #BUENO CHALLENGE 3
SELECT au_id AS 'AUTHOR ID', au_lname AS 'LAST NAME', 
au_fname AS 'FIRST NAME', SUM(`qty`) AS 'TOTAL'
FROM authors
JOIN `titleauthor` a USING(au_id)
JOIN `sales` b USING(title_id)
GROUP BY au_id
ORDER BY `TOTAL` DESC
LIMIT 3;

SELECT * FROM author_title_ventas; #IMPRESION DE LOS 3 AUTORES CON MAS VENTAS



DROP TABLE IF EXISTS author_title_ventas_TODOS;

SELECT * FROM author_title_ventas;
SELECT * FROM author_title;

CREATE TABLE author_title_ventas_TODOS AS ## ## PRIEMRA PRUEBA CHALLENGE 4
SELECT l.au_id, l.au_lname, 
l.au_fname, f.`TOTAL`
FROM  authors l
LEFT JOIN  author_title_ventas f ON f.`AUTHOR ID` = l.au_id
ORDER BY `AUTHOR ID` DESC
limit 23;
#GROUP BY f.`AUTHOR ID`;
#ORDER BY `AUTHOR ID` DESC;

SELECT * FROM author_title_ventas_TODOS;# IMRPESION PRUEBA CHALLENGE 4
SELECT COUNT(*) FROM authors;
SELECT COUNT(*) FROM author_title_ventas_TODOS; ## 



CREATE TABLE author_title_ventas_TODOS2 AS ## BUENO CHALLENGE 4 IF NULL /// ESTA LINEA LO QUE HACE ES GUARDARA LA TABLA EN PUBLICACIONES 
SELECT l.au_id, l.au_lname, l.au_fname, IfNULL(f.`TOTAL`,0) #LINEA DE IMPRESION, AUTHOR ID , NOMBRE , APELLIDO , TOTAL (CON 0 EN VES DE NULL)
FROM  authors l #LLAMAMOS COMO TABLA PRINCIAPL A TABLA AUTHORS EL CUAL CONTIENE (AUTHOR ID , NOMBRE , APELLIDO)
LEFT JOIN  author_title_ventas f ON f.`AUTHOR ID` = l.au_id #AQUI ESTOY JALANDO LA TABLA QUE CREE PARA EL CHALLENGE 3, (EN TU CASO 
#TE FALTARIA AL CHALLENGE 3 LO CREES COMO TABLA )
ORDER BY `AUTHOR ID` DESC
limit 23;

DROP TABLE IF EXISTS author_title_ventas_TODOS2; 
SELECT * FROM author_title_ventas_TODOS2;# IMPRESION CHALLENGE 4 CON IF NULL 
SELECT COUNT(*) FROM author_title_ventas_TODOS2;

SELECT * FROM roysched;
SELECT * FROM titles;

CREATE TABLE TITLE_PROFIT AS # PRIEMRA TABLA PROFIT PARA BONUS (HACE EL CALCULO POR TITULO CUANTO GENERO DE GANANCIAS)
SELECT title_id,title, advance + (ytd_sales * (royalty/100)) AS PROFIT 
FROM titles
ORDER BY title_id;

SELECT * FROM TITLE_PROFIT; # IMPRESION TABLA PROFIT TABLA REQUEIRDA PARA BONUS
SELECT * FROM authors;
DROP TABLE IF EXISTS TITLE_PROFIT; # IM
SELECT COUNT(*) FROM TITLE_PROFIT;
SELECT COUNT(*) FROM titles;
SELECT COUNT(*) FROM authors;

CREATE TABLE BONUS_2 AS # BUENO FINAL BONUS CHALLENGE (SE REQUIERE CORRER LA TABLA ANTERIOR)
SELECT au_id AS 'AUTHOR ID', au_lname AS 'LAST NAME', au_fname AS 'FIRST NAME', SUM(b.PROFIT) AS PROFIT, b.title_id
FROM authors
JOIN titleauthor a USING(au_id)
JOIN TITLE_PROFIT b USING(title_id)
GROUP BY au_id
ORDER BY PROFIT DESC 
LIMIT 3;

SELECT * FROM TITLE_PROFIT;
SELECT * FROM BONUS_2; #IMPRESION BONUS  FINAL 
DROP TABLE IF EXISTS BONUS_2; # IM






#################################### PRUEBAS NO HACER CASO #############################

CREATE TABLE BONUS AS #BUENO CHALLENGE BONUS
SELECT au_id AS 'AUTHOR ID', au_lname AS 'LAST NAME', au_fname AS 'FIRST NAME', b.title AS 'TITLE', b.advance AS 'ADVANCES', b.royalty, b.ytd_sales
FROM authors
JOIN `titleauthor` a USING(au_id)
JOIN `titles` b USING(title_id)
ORDER BY `au_id`;

SELECT * FROM BONUS ;
DROP TABLE IF EXISTS BONUS; # IM
SELECT COUNT(*) FROM BONUS;

SELECT * FROM BONUS GROUP BY 'AUTHOR ID';

CREATE TABLE BONUS2 AS #BUENO CHALLENGE BONUS
SELECT au_id AS 'AUTHOR ID', au_lname AS 'LAST NAME', au_fname AS 'FIRST NAME', b.advance, b.royalty, b.ytd_sales
FROM authors
JOIN `titleauthor` a USING(au_id)
JOIN `titles` b USING(title_id);
#GROUP BY au_id;

SELECT * FROM BONUS2 ;

SELECT ROYALTYPER, SUM(ROYALTYPER) FROM TITLEAUTHOR GROUP BY TITLE_ID ;

SELECT * FROM TITLEAUTHOR;

DROP TABLE IF EXISTS BONUS2; # IM
SELECT COUNT(*) FROM BONUS2;


