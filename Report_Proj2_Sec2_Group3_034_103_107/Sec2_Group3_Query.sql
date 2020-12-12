# Project02
# Queries 30 

#q1 show all customer infomation.
SELECT * FROM customer;

#q2 show productID, product name, and product price that have price more than 500 Baht.
SELECT prod_id, prod_name, prod_price FROM product
WHERE prod_price > 500;

#q3 show productID, product name that begin with 'b'
SELECT prod_id, prod_name FROM product
WHERE prod_name LIKE 'b%';

#q4 show shop infomation that begin with m and sort by alphabet.
SELECT * FROM shop
WHERE shop_name LIKE 'm%'
ORDER BY shop_name;

#q5 show customer firstname and lastname that begin with 'p'
SELECT customer_fname, customer_lname FROM customer
WHERE customer_lname LIKE 'p%';

#q6 show paymentId, creat date, deliver date from receipt which ID is higher than 5000
SELECT pay_id, rec_createdDate, rec_deliveryDate FROM receipt
WHERE rec_id > 5000;

#q7 show product infomation where type is dessert
SELECT * FROM product
WHERE prod_type LIKE "dessert";

#q8 show customer firstname and lastname sort by firstname and follow by lastname in alphabet.
SELECT customer_fname, customer_lname FROM customer
ORDER BY customer_fname, customer_lname;

#q9 show orderId and payment amount where payment amount is more than 1000 baht.
SELECT or_id, pay_id FROM payment
WHERE pay_amount > 1000;

#q10 show product name and product price which price is higher than 500 Baht and sort by price.
SELECT prod_name, prod_price FROM product
WHERE prod_price > 500
ORDER BY prod_price;

#q11 count how many product have in database.
SELECT COUNT(*) as count FROM product;

#q12 show the average price of product type is dessert.
SELECT AVG(prod_price) as average FROM product;

#q13 show product infomation where product description is not null.
SELECT * FROM product
WHERE  prod_des IS NOT NULL;

#q14 show the most expensive product.
SELECT MAX(prod_price) as max FROM product;

#q15 show the receipt that was created before 2020-11-10
SELECT * FROM receipt
WHERE date(rec_createdDate) < "2020-11-10";

-------------------------------------------------------------------------------------------------

#q16 show infomation of product which is have highest price
SELECT * FROM product
WHERE prod_price = (SELECT MAX(prod_price) FROM product);

#q17 find order that have quantity more than 2

SELECT order_id from _order
where order_id in (select or_id from _orderline where ol_quantity > 2);

#q18 count how many brownie was bought.
select count(*) as count from _orderline
where pro_id in (select prod_id from product where prod_name = "brownie");

#q19 show paymentID and name on card that use VISA **serial number**
SELECT p.pay_id,c.serial_number FROM payment AS p
JOIN credit_card AS c 
ON p.pay_id = c.pay_id
WHERE cc_type = "VISA";

#20 show shop name, product name, product price, and product id with product name is cheese cake(Hints: remove duplicate shop
SELECT DISTINCT s.shop_name, p.prod_name, p.prod_price, p.prod_price FROM product AS p
JOIN shop AS s
ON s.shop_id =  p.shop_id
WHERE p.prod_name = "cheese cake";

#21 count how many order was ordered in september.
SELECT COUNT(*) FROM _order
WHERE MONTH(order_createDate) = 11;

#22 list the most rich customer. (tops 3 who have highest payment)
SELECT c.customer_id, CONCAT(c.customer_fname,' ',c.customer_lname) AS 'cus name', p.pay_amount FROM customer AS c
JOIN _order AS o ON o.customer_id = c.customer_id
JOIN payment AS p ON o.order_ID = p.Or_id
ORDER BY p.pay_amount DESC
LIMIT 5;

#23 show order that was made by customer name start with "P"
SELECT o.order_ID, o.order_createDate  FROM _order AS o
WHERE o.customer_ID IN (SELECT customer_id FROM customer WHERE customer_fname LIKE "P%");

#24 show how many each shop sell a product.
SELECT s.shop_name AS "shop name",COUNT(p.prod_id) AS 'products amount' FROM product AS p
JOIN shop AS s ON s.shop_id = p.shop_id
GROUP BY s.shop_name;

#25 create view that show shop name and product in there shop.
CREATE VIEW vw_productandshop
AS
SELECT p.prod_id, s.shop_name AS "shop name", p.prod_price AS "price" FROM product AS p
JOIN shop AS s ON s.shop_id = p.shop_id;

SELECT * FROM vw_productandshop;
/**
please continue here till 30 -- k kaa
**/

#26 show shops that have the product type is dessert and order alphabet
SELECT s.shop_name AS "Shop Name", p.prod_name AS "Product Name", p.prod_type AS "Product Type"
FROM shop s
JOIN product p ON p.shop_id = s.shop_id
WHERE p.prod_type LIKE 'dessert'
GROUP BY p.prod_name
ORDER BY s.shop_name ASC;

#27 count how many order was ordered on month 11 day 11
SELECT COUNT(*) FROM _order
WHERE DAY(order_createDate) = 11 AND MONTH(order_createDate) = 11;

#28 avg money that pay by VISA
SELECT ROUND(AVG(pay_amount)) AS AVG
FROM credit_card WHERE cc_type = 'VISA';

#29 find shop and price that has the max value of a product is electronic type
SELECT s.shop_name AS "Shop name", MAX(prod_price) AS "MAX"
FROM product
JOIN shop s ON s.shop_id = product.shop_id
WHERE prod_type LIKE 'electronic';

#30 find the min value of product that pay by MSTC
SELECT MIN(prod_price) AS "MIN VALUE PRODUCT"
FROM product p
JOIN _orderLine ordL ON ordL.Pro_id = p.prod_ID
JOIN payment pa ON pa.Or_id = ordL.Or_id
JOIN Credit_card c ON c.pay_id = pa.pay_id
WHERE c.cc_type LIKE 'MSTC';

