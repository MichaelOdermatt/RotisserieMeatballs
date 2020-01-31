DROP TABLE review;
DROP TABLE shipment;
DROP TABLE productinventory;
DROP TABLE warehouse;
DROP TABLE orderproduct;
DROP TABLE incart;
DROP TABLE product;
DROP TABLE category;
DROP TABLE ordersummary;
DROP TABLE paymentmethod;
DROP TABLE customer;


CREATE TABLE customer (
    customerId          INT IDENTITY,
    firstName           VARCHAR(40),
    lastName            VARCHAR(40),
    email               VARCHAR(50),
    phonenum            VARCHAR(20),
    address             VARCHAR(50),
    city                VARCHAR(40),
    state               VARCHAR(20),
    postalCode          VARCHAR(20),
    country             VARCHAR(40),
    userid              VARCHAR(20),
    password            VARCHAR(30),
    PRIMARY KEY (customerId)
);

CREATE TABLE paymentmethod (
    paymentMethodId     INT IDENTITY,
    paymentType         VARCHAR(20),
    paymentNumber       VARCHAR(30),
    paymentExpiryDate   DATE,
    customerId          INT,
    PRIMARY KEY (paymentMethodId),
    FOREIGN KEY (customerId) REFERENCES customer(customerid)
        ON UPDATE CASCADE ON DELETE CASCADE 
);

CREATE TABLE ordersummary (
    orderId             INT IDENTITY,
    orderDate           DATETIME,
    totalAmount         DECIMAL(10,2),
    shiptoAddress       VARCHAR(50),
    shiptoCity          VARCHAR(40),
    shiptoState         VARCHAR(20),
    shiptoPostalCode    VARCHAR(20),
    shiptoCountry       VARCHAR(40),
    customerId          INT,
    PRIMARY KEY (orderId),
    FOREIGN KEY (customerId) REFERENCES customer(customerid)
        ON UPDATE CASCADE ON DELETE CASCADE 
);

CREATE TABLE category (
    categoryId          INT IDENTITY,
    categoryName        VARCHAR(50),    
    PRIMARY KEY (categoryId)
);

CREATE TABLE product (
    productId           INT IDENTITY,
    productName         VARCHAR(40),
    productPrice        DECIMAL(10,2),
    productImageURL     VARCHAR(100),
    productImage        VARBINARY(MAX),
    productDesc         VARCHAR(1000),
    categoryId          INT,
    PRIMARY KEY (productId),
    FOREIGN KEY (categoryId) REFERENCES category(categoryId)
);

CREATE TABLE orderproduct (
    orderId             INT,
    productId           INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (orderId, productId),
    FOREIGN KEY (orderId) REFERENCES ordersummary(orderId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE incart (
    orderId             INT,
    productId           INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (orderId, productId),
    FOREIGN KEY (orderId) REFERENCES ordersummary(orderId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE warehouse (
    warehouseId         INT IDENTITY,
    warehouseName       VARCHAR(30),    
    PRIMARY KEY (warehouseId)
);

CREATE TABLE shipment (
    shipmentId          INT IDENTITY,
    shipmentDate        DATETIME,   
    shipmentDesc        VARCHAR(100),   
    warehouseId         INT, 
    PRIMARY KEY (shipmentId),
    FOREIGN KEY (warehouseId) REFERENCES warehouse(warehouseId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE productinventory ( 
    productId           INT,
    warehouseId         INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (productId, warehouseId),   
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (warehouseId) REFERENCES warehouse(warehouseId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE review (
    reviewId            INT IDENTITY,
    reviewRating        INT,
    reviewDate          DATETIME,   
    customerId          INT,
    productId           INT,
    reviewComment       VARCHAR(1000),          
    PRIMARY KEY (reviewId),
    FOREIGN KEY (customerId) REFERENCES customer(customerId)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO category (categoryName) VALUES ('Vegan');
INSERT INTO category (categoryName) VALUES ('Vegetarian');
INSERT INTO category (categoryName) VALUES ('Organic');
INSERT INTO category (categoryName) VALUES ('Keto');
INSERT INTO category (categoryName) VALUES ('Lowfat');
INSERT INTO category (categoryName) VALUES ('LowSodium');
INSERT INTO category (categoryName) VALUES ('AllMeat');
INSERT INTO category (categoryName) VALUES ('SugarFree');


INSERT INTO product(productId, productName, categoryId, productDesc, productPrice) VALUES (1, 'Grandmas Meatball', 7, '20 Inch Diameter, Classic meatball.',18.00);
INSERT INTO product(productId, productName, categoryId, productDesc, productPrice) VALUES (2, 'Kung Pao Meatball', 7,'20 Inch Diameter, Meatball with oriental flair.',22.00);
INSERT INTO product(productId, productName, categoryId, productDesc, productPrice) VALUES (3, 'Vegan Pulled Pork Meatball', 1,'25 Inch Diameter, Classic meatball made from jackfruit.',35.00);
INSERT INTO product(productId, productName, categoryId, productDesc, productPrice) VALUES (4, 'Cheese Supreme Meatball', 7,'22 Inch Diameter, Classic meatball loaded with mozzarella',20.00);
INSERT INTO product(productId, productName, categoryId, productDesc, productPrice) VALUES (5, 'Cheese Supreme Meatball (Vegan)', 1,'22 Inch Diameter, Classic meatball made from jackfruit loaded with dairy free mozzarella', 25.00);
INSERT INTO product(productId, productName, categoryId, productDesc, productPrice) VALUES (6, 'Grandmas Meatball (Vegetarian)', 2, '20 Inch Diameter, Classic meatball made from various veggies.',25.00);
INSERT INTO product(productId, productName, categoryId, productDesc, productPrice) VALUES (7, 'Organic Large BBQ Chicken Meatball',3,'30 Inch Diameter, Large meatball made from free range organic chickens slathered in southwestern style BBQ sauce.',45.00);
INSERT INTO product(productId, productName, categoryId, productDesc, productPrice) VALUES (8, 'Organic Thanksgiving Meatball Feast',3,'92 Inch Diameter, Turky meatbal perfect for the whole family', 120.00);
INSERT INTO product(productId, productName, categoryId, productDesc, productPrice) VALUES (9, 'Avocado Cheese Meatball',4,'15 Inch Diameter, Delicous avocado meatball with cheesy shell (yum).',12.00);
INSERT INTO product(productId, productName, categoryId, productDesc, productPrice) VALUES (10, 'Hurricane Meatball',4,'12 Inch Diameter, Thick and dense. Steak meatball loaded with cheese, aparagus, and pork rinds',35.00);
INSERT INTO product(productId, productName, categoryId, productDesc, productPrice) VALUES (11, 'Supreme Lean Meatball',5,'22 Inch Diameter, Super delicious lowfat meatball.',55.00);
INSERT INTO product(productId, productName, categoryId, productDesc, productPrice) VALUES (12, 'Pure Beef Meatball',5,'25 Inch Diameter, Contains no fat content since all the fat has been simmered out.',50.00);
INSERT INTO product(productId, productName, categoryId, productDesc, productPrice) VALUES (13, 'Salt-free Meatball',5,'20 Inch Diameter, Simple meatball with no salt.',20.25);
INSERT INTO product(productId, productName, categoryId, productDesc, productPrice) VALUES (14, 'Mega Meatball',5,'60 Inch Diameter, Bold and Beautiful',20.00);
INSERT INTO product(productId, productName, categoryId, productDesc, productPrice) VALUES (15, 'Meatlovers Meatball',6, '20 Inch Diameter, A meaty mess made from chicken, beef, pork, elk, bear, and turtle meat.',67.99);
INSERT INTO product(productId, productName, categoryId, productDesc, productPrice) VALUES (16, 'Carnivore Meatball',6,'22 Inch Diameter, Nothing but beef, desigend to be eaten raw.',39.00);
INSERT INTO product(productId, productName, categoryId, productDesc, productPrice) VALUES (17, 'Diabetic Meatball',7,'20 Inch Diameter, Just like Grandmas Meatball but with no added sugar.',40.50);

    
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Arnold', 'Anderson', 'a.anderson@gmail.com', '204-111-2222', '103 AnyWhere Street', 'Winnipeg', 'MB', 'R3X 45T', 'Canada', 'arnold' , 'test');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Bobby', 'Brown', 'bobby.brown@hotmail.ca', '572-342-8911', '222 Bush Avenue', 'Boston', 'MA', '22222', 'United States', 'bobby' , 'bobby');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Candace', 'Cole', 'cole@charity.org', '333-444-5555', '333 Central Crescent', 'Chicago', 'IL', '33333', 'United States', 'candace' , 'password');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Darren', 'Doe', 'oe@doe.com', '250-807-2222', '444 Dover Lane', 'Kelowna', 'BC', 'V1V 2X9', 'Canada', 'darren' , 'pw');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Elizabeth', 'Elliott', 'engel@uiowa.edu', '555-666-7777', '555 Everwood Street', 'Iowa City', 'IA', '52241', 'United States', 'beth' , 'test');


DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (1, '2019-10-15 10:25:55', 91.70)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 1, 1, 18)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 5, 2, 21.35)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 10, 1, 31);

DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (2, '2019-10-16 18:00:00', 106.75)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 5, 5, 21.35);

DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (3, '2019-10-15 3:30:22', 140)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 6, 2, 25)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 7, 3, 30);

DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (2, '2019-10-17 05:45:11', 327.85)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 3, 4, 10)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 8, 3, 40)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 13, 3, 23.25)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 28, 2, 21.05)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 29, 4, 14);

DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (5, '2019-10-15 10:25:55', 277.40)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 5, 4, 21.35)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 19, 2, 81)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 20, 3, 10);

UPDATE Product SET productImageURL = 'grandmas meatball.jpg' WHERE ProductId = 1;
UPDATE Product SET productImageURL = 'kung poa meatball.jpg' WHERE ProductId = 2;
UPDATE Product SET productImageURL = 'vegan pulled pork meatball.jpg' WHERE ProductId = 3;
UPDATE Product SET productImageURL = 'cheese supreme.jpg' WHERE ProductId = 4;
UPDATE Product SET productImageURL = 'grandmas meatball (vegan).jpg' WHERE ProductId = 5;
UPDATE Product SET productImageURL = 'organic large bbq chicken meatball.jpg' WHERE ProductId = 6;
UPDATE Product SET productImageURL = 'organic thanksgiving meatball.jpg' WHERE ProductId = 7;
UPDATE Product SET productImageURL = 'avocado cheese meatball.jpg' WHERE ProductId = 8;
UPDATE Product SET productImageURL = 'hurricane meatball.jpg' WHERE ProductId = 9;
UPDATE Product SET productImageURL = 'supreme lean meatball.jpg' WHERE ProductId = 10;
UPDATE Product SET productImageURL = 'pure beef meatball.jpg' WHERE ProductId = 11;
UPDATE Product SET productImageURL = 'salt free meatball.jpg' WHERE ProductId = 12;
UPDATE Product SET productImageURL = 'mega meatball.jpg' WHERE ProductId = 13;
UPDATE Product SET productImageURL = 'meatlovers meatball.jpg' WHERE ProductId = 14;
UPDATE Product SET productImageURL = 'carnivore meatball.jpg' WHERE ProductId = 15;
UPDATE Product SET productImageURL = 'diabetic meatball.jpg' WHERE ProductId = 16;