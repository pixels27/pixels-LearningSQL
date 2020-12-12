/*
$Project02 034 103 107
$update history:
	,November 05,2020	- change datatype
							pay_id(int) > varchar
                            order_id(int) > varchar
	,November 04,2020	- a customer can make more than 1 order, 
						rename column name `cc_nameOncard` to `serial_number`
					 	- update orderline number.
					 	- fix total price on payment table ให้มันคล้องกับราคาสินค้าที่มีใน order
	,November 03,2020 (fix date on orderline)
$note here:

$
*/

CREATE DATABASE DB_PROJECT2;
USE DB_PROJECT2;

CREATE TABLE shop(
shop_ID VARCHAR(9) PRIMARY KEY,
shop_name VARCHAR(100) NOT NULL
);

CREATE TABLE product(
prod_ID VARCHAR(9) PRIMARY KEY,
prod_name VARCHAR(100) NOT NULL,
prod_price DECIMAL(12,2) NOT NULL,
prod_des VARCHAR(100),
prod_type VARCHAR(100) NOT NULL,
shop_id VARCHAR(9) NOT NULL
-- CONSTRAINT FK_shop_ID FOREIGN KEY (shop_id)
-- REFERENCES shop(shop_ID)
);

CREATE TABLE customer(
customer_ID VARCHAR(9) PRIMARY KEY,
customer_fname VARCHAR(100) NOT NULL,
customer_lname VARCHAR(100) NOT NULL
);

CREATE TABLE _order(
order_ID VARCHAR(9) PRIMARY KEY,
order_createDate DATE NOT NULL,
customer_ID VARCHAR(9)
-- CONSTRAINT FK_customer_ID FOREIGN KEY (customer_ID)
-- REFERENCES customer(customer_ID)
);

CREATE TABLE _orderLine(
OL_quantity INT NOT NULL,
OL_no INT NOT NULL,
OL_price DECIMAL(10,2),
OL_productName VARCHAR(100),
Pro_id VARCHAR(9) NOT NULL,
Or_id VARCHAR(9) NOT NULL,
CONSTRAINT FK_product_id FOREIGN KEY (Pro_id) REFERENCES product(prod_ID),
CONSTRAINT FK_order_id FOREIGN KEY (Or_id) REFERENCES _order(order_ID)
);

CREATE TABLE Payment(
pay_id VARCHAR(9) PRIMARY KEY,
pay_datetime DATETIME,
pay_amount DECIMAL(10,2),
Or_id VARCHAR(9),
CONSTRAINT FK_order_id2 FOREIGN KEY (Or_id) REFERENCEs _order(order_ID)
);

CREATE TABLE Credit_card(
pay_id INT,
cc_id INT,
pay_datetime DATETIME,
cc_type VARCHAR(4) CHECK (cc_type in("VISA","MSTC")),
cc_nameOncard VARCHAR(10),
pay_amount DECIMAL(10,2),
PRIMARY KEY(pay_id,cc_id)
);

ALTER TABLE `db_project2`.`credit_card` 
CHANGE COLUMN `cc_nameOncard` `serial_number` VARCHAR(10) NOT NULL ;

CREATE TABLE Receipt(
rec_id INT PRIMARY KEY,
rec_createdDate DATETIME,
rec_deliveryDate DATE,
pay_id VARCHAR(9),
CONSTRAINT FK_payment_id2 FOREIGN KEY (pay_id) REFERENCEs payment(pay_id)
);


INSERT INTO `shop` (`shop_ID`, `shop_name`) 
VALUES
('88001','sheek bakery'),
('88002','Mark bakery'),
('88003','Pixelizu'),
('88004','deku daifuku'),
('88005','baby brownie'),
('88006','toppy furniture'),
('88007','pongsakorn khai mhai'),
('88008','sampromtech'),
('88009','noeyiii bag'),
('88010','bakugo toy'),
('88011','pranung film'),
('88012','markki photo'),
('88013','babycrystal plant'),
('88014','jungkook CD'),
('88015','kirito sword'),
('88016','keyboard oreo'),
('88017','BTS preoder'),
('88018','eigth teen dress'),
('88019','prom noodle'),
('88020','ipad case'),
('88021','mark sonie'),
('88022','konkeng bag'),
('88023','mupa tshirt'),
('88024','nhai khee shoes'),
('88025','adidatttt shoes'),
('88026','asus kak'),
('88027','macbook dee'),
('88028','ping cosmetic'),
('88029','bodyandbath'),
('88030','mai tum ngan gaming');
INSERT INTO `product` (`prod_ID`, `prod_name`, `prod_price`, `prod_des`, `prod_type`, `shop_id`) 
VALUES
('00001','brownie', '20.00', 'aroi makk', 'dessert','88001'),
('00002','cheese cake', '50.00', 'must try', 'dessert','88002'),
('00003','tiramisu cake', '85.00', null, 'dessert','88003'),
('00004','strawberry daifuku', '80.00', null, 'dessert','88004'),
('00005','brownie baby', '30.00', null, 'dessert','88005'),
('00006','sofa so good', '3200.00', null, 'furniture', '88006'),
('00007','wood', '700.00', null, 'furniture', '88007'),
('00008','keyboard', '159.00', null, 'electronic', '88008'),
('00009','minibag', '120.00', 'This is very good', 'bag', '88009'),
('00010','bomb doll', '290.00', null, 'toy', '88010'),
('00011','fuji film iso 200', '250.00', null, 'photo', '88011'),
('00012','mountain photo', '50.00', null, 'photo', '88012'),
('00013','baby crystal', '5.00', 'blue', 'plant', '88013'),
('00014','DYNAMITE', '490.00', 'prod by BTS', 'song', '88014'),
('00015','black sword', '1200.00', null, 'sword', '88015'),
('00016','RGB keyboard', '390.00', null, 'electronic', '88016'),
('00017','BE Album', '550.00', null, 'album', '88017'),
('00018','mini dress', '290.00', null, 'cloth', '88018'),
('00019','noodle', '15.00', null, 'food', '88019'),
('00020','iPad pro case', '150.00', '11 inches', 'case', '88020'),
('00021','headphone', '1000.00', null, 'electronic', '88021'),
('00022','messenger bag', '599.00', null, 'bag', '88022'),
('00023','tshirt', '150.00', 'pink', 'cloth', '88023'),
('00024','sport shoes', '299.00', 'sport', 'shoes', '88024'),
('00025','sport shoes', '100.00', 'sport', 'shoes', '88025'),
('00026','asus laptop', '29000.00', null, 'electronic', '88026'),
('00027','macbook laptop', '69000.00', '13 inches', 'electronic', '88027'),
('00028','lipstick', '290.00', 'pink', 'cosmetic', '88028'),
('00029','bath bomb', '120.00', null, 'bath', '88029'),
('00030','mouse gaming', '320.00', null, 'electronic', '88030'),
('00031','strawberry pie', '30.00', null, 'dessert','88001'),
('00032','cheese cake', '50.00', 'must try', 'dessert','88002'),
('00033','apple pie', '50.00', null, 'dessert','88002'),
('00034','Wardrobe', '3300.00', null, 'furniture', '88006'),
('00035','radio', '260.00', null, 'electronic', '88008'),
('00036','kodak film iso 200', '250.00', null, 'photo', '88011'),
('00037','kodak ultra film iso 400', '350.00', null, 'photo', '88011'),
('00038','beach photo', '50.00', null, 'photo', '88012'),
('00039','eugeo sword', '1400.00', 'Ice sword', 'sword', '88015'),
('00040','butterfly keyboard', '390.00', null, 'electronic', '88016'),
('00041','love yourself Album', '550.00', null, 'album', '88017'),
('00042','shirt', '290.00', 'white shirt', 'cloth', '88018'),
('00043','iPad pro case', '150.00', '12 inches', 'case', '88020'),
('00044','headphone wireless', '1500.00', null, 'electronic', '88021'),
('00045','freitag bag', '1599.00', null, 'bag', '88022'),
('00046','tshirt', '150.00', 'black', 'cloth', '88023'),
('00047','adidatt shoes', '299.00', 'sport', 'shoes', '88024'),
('00048','asus mouse', '800.00', null, 'electronic', '88026'),
('00049','macbook laptop', '79000.00', '15 inches', 'electronic', '88027'),
('00050','lipstick', '290.00', 'red', 'cosmetic', '88028'),
('00051','shower cream', '130.00', 'baby', 'bath', '88029'),
('00052','razor mouse', '1800.00', null, 'electronic', '88030'),
('00053','fuji film iso 100', '250.00', null, 'photo', '88011');

INSERT INTO `customer` (`customer_ID`, `customer_fname`, `customer_lname`) 
VALUES
('62001', 'Pranungfun', 'Prapaenee'),
('62002', 'Nopparat', 'Pengsuk'),
('62003', 'Pongsakorn', 'Piboonpongpun'),
('62004', 'Numjoon', 'Kim'),
('62005', 'Seokjin', 'Kim'),
('62006', 'Yoonki', 'Min'),
('62007', 'Hoseok', 'Jung'),
('62008', 'Jimin', 'Park'),
('62009', 'Taehyung', 'Kim'),
('62010', 'Jungkook', 'Jeon'),
('62011', 'Izuku', 'Midoriya'),
('62012', 'Shoto', 'Todoroki'),
('62013', 'Bakugo', 'Katsuki'),
('62014', 'Kirishima', 'Eijiro'),
('62015', 'Denki', 'Kaminari'),
('62016', 'Eren', 'Yeager'),
('62017', 'Mikasa', 'Ackerman'),
('62018', 'Levi', 'Ackerman'),
('62019', 'Shoyo', 'Hinata'),
('62020', 'Tooru', 'Oikawa'),
('62021', 'Tobio', 'Kageyama'),
('62022', 'Kazuto', 'Kirigaya'),
('62023', 'Tanjiro', 'Kamado'),
('62024', 'Nezuko', 'Kamado'),
('62025', 'Zenitsu', 'Agatsuma'),
('62026', 'Yuu', 'Nishinoya'),
('62027', 'Koshi', 'Sugawara'),
('62028', 'Kei', 'Tsukishima'),
('62029', 'Jipyeong', 'Han'),
('62030', 'Dalmi', 'Seo');

INSERT INTO `_order` (`order_ID`, `order_createDate`, `customer_ID`) 
VALUES
('1001', '2020-11-01', '62001'),
('1002', '2020-11-01', '62002'),
('1003', '2020-11-01', '62003'),
('1004', '2020-11-01', '62004'),
('1005', '2020-11-01', '62005'),
('1006', '2020-11-02', '62006'),
('1007', '2020-11-02', '62007'),
('1008', '2020-11-03', '62008'),
('1009', '2020-11-03', '62009'),
('1010', '2020-11-03', '62001'),
('1011', '2020-11-03', '62001'),
('1012', '2020-11-03', '62013'),
('1013', '2020-11-04', '62014'),
('1014', '2020-11-04', '62015'),
('1015', '2020-11-05', '62016'),
('1016', '2020-11-05', '62017'),
('1017', '2020-11-05', '62004'),
('1018', '2020-11-05', '62019'),
('1019', '2020-11-05', '62020'),
('1020', '2020-11-05', '62021'),
('1021', '2020-11-06', '62012'),
('1022', '2020-11-07', '62014'),
('1023', '2020-11-07', '62024'),
('1024', '2020-11-07', '62002'),
('1025', '2020-11-07', '62002'),
('1026', '2020-11-07', '62027'),
('1027', '2020-11-07', '62028'),
('1028', '2020-11-11', '62003'),
('1029', '2020-11-11', '62010'),
('1030', '2020-11-11', '62030');


INSERT INTO `_orderLine` (`OL_quantity`, `OL_no`, `OL_price`, `OL_productName`, `Pro_id`, `Or_id`) 
VALUES
(1, 1, 20.00, 'brownie', '00001', '1001'),
(1, 2, 80.00, 'strawberry daifuku', '00004', '1001'),
(2, 1, 60.00, 'strawberry pie', '00031', '1002'),
(1, 1, 50.00, 'cheese cake', '00002', '1003'),
(1, 2, 3200.00, 'tiramisu cake', '00006', '1003'),
(1, 3, 320.00, 'mouse gaming', '00030', '1003'),
(3, 1, 255.00, 'tiramisu cake', '00003', '1004'),
(3, 2, 2100.00, 'wood', '00007', '1004'),
(1, 1, 80.00, 'strawberry daifuku', '00004', '1005'),
(1, 1, 260.00, 'radio', '00035', '1006'),
(2, 1, 60.00, 'brownie baby', '00005', '1007'),
(3, 1, 477.00, 'keyboard', '00008', '1008'),
(1, 1, 120.00, 'minibag', '00009', '1009'),
(1, 2, 490.00, 'DYNAMITE', '00014', '1009'),
(2, 1, 580.00, 'bomb doll', '00010', '1010'),
(1, 1, 250.00, 'fuji film iso 200', '00011', '1011'),
(2, 2, 40.00, 'brownie', '00001', '1011'),
(1, 1, 50.00, 'mountain' 'photo', '00012', '1012'),
(2, 2, 60.00, 'strawberry pie', '00031', '1012'),
(4, 3, 20.00, 'baby crystal', '00013', '1013'),
(2, 1, 1100.00, 'BE album', '00017', '1014'),
(1, 1, 490.00, 'DYNAMITE', '00014', '1015'),
(1, 1, 390.00, 'butterfly keyboard', '00040', '1016'),
(1, 1, 390.00, 'RGB keyboard', '00016', '1017'),
(3, 2, 45.00, 'noodle', '00019', '1017'),
(1, 1, 290.00, 'mini dress', '00018', '1018'),
(3, 1, 45.00, 'noodle', '00019', '1019'),
(1, 1, 150.00, 'iPad pro case', '00020', '1020'),
(1, 1, 1000.00, 'headphone', '00021', '1021'),
(1, 1, 599.00, 'messenger bag', '00022', '1022'),
(1, 1, 1599.00, 'freitag bag', '00045', '1023'),
(2, 1, 598.00, 'sport shoes', '00024', '1024'),
(1, 1, 100.00, 'sport shoes', '00025', '1025'),
(1, 1, 29000.00, 'asus laptop', '00026', '1026'),
(1, 1, 69000.00, 'macbook air', '00027', '1027'),
(1, 1, 1400.00, 'eugeo sword', '00039', '1027'),
(1, 1, 79000.00, 'macbook pro', '00049', '1028'),
(2, 1, 240.00, 'bath bomb', '00029', '1029'),
(1, 2, 550.00, 'love yourself Album', '00041', '1029'),
(1, 1, 320.00, 'mouse gaming', '00030', '1030'),
(4, 2, 80.00, 'brownie', '00001', '1030');


INSERT INTO `Payment` (`pay_id`, `pay_datetime`, `pay_amount`, `Or_id`) 
VALUES
(1231, '2020-11-01 00:18:00', '100.00', '1001'),
(1232, '2020-11-01 07:34:00', '60.00', '1002'),
(1233, '2020-11-01 06:42:00', '3570.00', '1003'),
(1234, '2020-11-01 02:33:00', '2355.00', '1004'),
(1235, '2020-11-01 03:23:00', '80.00', '1005'),
(1236, '2020-11-02 05:31:00', '260.00', '1006'),
(1237, '2020-11-02 07:53:00', '60.00', '1007'),
(1238, '2020-11-03 02:50:00', '477.00', '1008'),
(1239, '2020-11-03 03:36:00', '610.00', '1009'),
(1240, '2020-11-03 01:23:00', '580.00', '1010'),
(1241, '2020-11-03 04:54:00', '290.00', '1011'),
(1242, '2020-11-03 05:12:00', '110.00', '1012'),
(1243, '2020-11-04 06:34:00', '20.00', '1013'),
(1244, '2020-11-04 03:12:00', '1100.00', '1014'),
(1245, '2020-11-05 04:56:00', '490.00', '1015'),
(1246, '2020-11-05 02:32:00', '390.00', '1016'),
(1247, '2020-11-05 01:01:00', '435.00', '1017'),
(1248, '2020-11-05 03:05:00', '290.00', '1018'),
(1249, '2020-11-05 04:08:00', '45.00', '1019'),
(1250, '2020-11-05 04:00:00', '150.00', '1020'),
(1251, '2020-11-06 05:56:00', '1000.00', '1021'),
(1252, '2020-11-07 06:01:00', '599.00', '1022'),
(1253, '2020-11-07 05:06:00', '1599.00', '1023'),
(1254, '2020-11-07 02:07:00', '598.00', '1024'),
(1255, '2020-11-07 06:45:00', '100.00', '1025'),
(1256, '2020-11-07 03:07:00', '29000.00', '1026'),
(1257, '2020-11-07 01:08:00', '70400.00', '1027'),
(1258, '2020-11-11 03:12:00', '79000.00', '1028'),
(1259, '2020-11-11 04:03:00', '550.00', '1029'),
(1260, '2020-11-11 04:03:00', '400.00', '1030');

INSERT INTO `Credit_card` (`pay_id`, `cc_id`, `pay_datetime`, `cc_type`, `serial_number`, `pay_amount`) 
VALUES
(1231, 121, '2020-11-01 00:18:00', 'VISA', '1212312121', '100.00'),
(1232, 122, '2020-11-01 07:34:00', 'MSTC', '1345670988', '60.00'),
(1232, 123, '2020-11-01 06:42:00', 'VISA', '3456789456', '3570.00'),
(1234, 124, '2020-11-01 02:33:00', 'MSTC', '6789076543', '2355.00'),
(1235, 125, '2020-11-01 03:23:00', 'MSTC', '1234598765', '80.00'),
(1236, 126, '2020-11-02 05:31:00', 'VISA', '6392774036', '260.00'),
(1237, 127, '2020-11-02 07:53:00', 'MSTC', '6402740334', '60.00'),
(1238, 128, '2020-11-03 02:50:00', 'VISA', '4235246490', '477.00'),
(1239, 129, '2020-11-03 03:36:00', 'MSTC', '5478785568', '610.00'),
(1240, 130, '2020-11-03 01:23:00', 'VISA', '0364763745', '580.00'),
(1241, 131, '2020-11-03 04:54:00', 'VISA', '5374563737', '290.00'),
(1242, 132, '2020-11-03 05:12:00', 'VISA', '2345123870', '110.00'),
(1243, 133, '2020-11-04 06:34:00', 'MSTC', '8694739271', '20.00'),
(1244, 134, '2020-11-04 03:12:00', 'VISA', '2349876534', '1100.00'),
(1245, 135, '2020-11-05 04:56:00', 'VISA', '2456374955', '490.00'),
(1246, 136, '2020-11-05 02:32:00', 'MSTC', '5645864926', '390.00'),
(1247, 137, '2020-11-05 01:01:00', 'VISA', '5649477432', '435.00'),
(1248, 138, '2020-11-05 03:05:00', 'VISA', '0987654234', '290.00'),
(1249, 139, '2020-11-05 04:08:00', 'MSTC', '5467380239', '45.00'),
(1250, 140, '2020-11-05 04:00:00', 'MSTC', '7357463467', '150.00'),
(1251, 141, '2020-11-06 05:56:00', 'VISA', '6573433466', '1000.00'),
(1252, 142, '2020-11-07 06:01:00', 'MSTC', '7396446383', '599.00'),
(1253, 143, '2020-11-07 05:06:00', 'VISA', '5474537353', '1599.00'),
(1254, 144, '2020-11-07 02:07:00', 'MSTC', '0982345987', '598.00'),
(1255, 145, '2020-11-07 06:45:00', 'MSTC', '6584773091', '100.00'),
(1256, 146, '2020-11-07 03:07:00', 'VISA', '6782349834', '29000.00'),
(1257, 147, '2020-11-07 01:08:00', 'MSTC', '7027344832', '70400.00'),
(1258, 148, '2020-11-07 03:12:00', 'VISA', '7895437448', '79000.00'),
(1259, 149, '2020-11-07 04:03:00', 'MSTC', '6372927493', '550.00'),
(1260, 150, '2020-11-07 04:03:00', 'MSTC', '6372927493', '400.00');
INSERT INTO `Receipt` (`rec_id`, `rec_createdDate`, `rec_deliveryDate`, `pay_id`) 
VALUES
(2349, '2020-10-21 00:18:00', '2020-11-04', 1231),
(3451, '2020-10-21 07:34:00', '2020-11-04', 1232),
(4567, '2020-10-22 06:42:00', '2020-11-04', 1233),
(8230, '2020-10-23 02:33:00', '2020-11-04', 1234),
(2345, '2020-10-23 03:23:00', '2020-11-04', 1235),
(7651, '2020-10-23 05:31:00', '2020-11-05', 1236),
(5432, '2020-10-24 07:53:00', '2020-11-05', 1237),
(3454, '2020-10-24 02:50:00', '2020-11-06', 1238),
(0987, '2020-10-25 03:36:00', '2020-11-06', 1239),
(4562, '2020-10-26 01:23:00', '2020-11-06', 1240),
(4254, '2020-10-27 04:54:00', '2020-11-06', 1241),
(6315, '2020-10-27 05:12:00', '2020-11-06', 1242),
(5476, '2020-10-28 06:34:00', '2020-11-07', 1243),
(4366, '2020-10-30 03:12:00', '2020-11-07', 1244),
(9305, '2020-10-30 04:56:00', '2020-11-08', 1245),
(9474, '2020-10-30 02:32:00', '2020-11-08', 1246),
(5353, '2020-10-30 01:01:00', '2020-11-08', 1247),
(6343, '2020-10-30 03:05:00', '2020-11-08', 1248),
(0847, '2020-11-01 04:08:00', '2020-11-08', 1249),
(5656, '2020-11-05 04:00:00', '2020-11-08', 1250),
(5282, '2020-11-06 05:56:00', '2020-11-09', 1251),
(4568, '2020-11-07 06:01:00', '2020-11-11', 1252),
(9373, '2020-11-11 05:06:00', '2020-11-11', 1253),
(6452, '2020-11-11 02:07:00', '2020-11-11', 1254),
(8440, '2020-11-11 06:45:00', '2020-11-11', 1255),
(0976, '2020-11-11 03:07:00', '2020-11-11', 1256),
(1658, '2020-11-11 01:08:00', '2020-11-11', 1257),
(9475, '2020-11-11 03:12:00', '2020-11-11', 1258),
(7303, '2020-11-11 04:03:00', '2020-11-11', 1259),
(7304, '2020-11-11 04:03:00', '2020-11-11', 1259),
(7340, '2020-11-11 05:01:00', '2020-11-11', 1260);




INSERT INTO `product` (`prod_ID`, `prod_name`, `prod_price`, `prod_des`, `prod_type`, `shop_id`) 
VALUES
('00054','Puff pastry', '290.00', null, 'cosmetic', '88028'),
('00055', 'chocolate cake', '100.00', null, 'dessert', '88002');

INSERT INTO `customer` (`customer_ID`, `customer_fname`, `customer_lname`) 
VALUES
('62031', 'Ake', 'Hrk');

UPDATE RECEIPT
SET rec_id = '9999'
WHERE pay_id = '1260';

UPDATE product
SET prod_des = 'It is so good'
WHERE prod_ID = '00054';

DELETE FROM product
WHERE prod_ID = '00054';

DELETE FROM customer
WHERE customer_ID = '62031';