
CREATE DATABASE company;

USE company;


CREATE TABLE IF NOT EXISTS `employee` (
	`employee_id` int NOT NULL,
	`user_name` varchar(30) NOT NULL,
	`first_name` varchar(30) NOT NULL,
	`last_name` varchar(30) NOT NULL,
	`position` varchar(15) NOT NULL,
	`employment_date` date NOT NULL,
	`department_id` int,
	`manager_id` int,
	`rate` float NOT NULL,
	`bomus` float,
	PRIMARY KEY (`employee_id`)
);

CREATE TABLE IF NOT EXISTS `department` (
	`department_id` int NOT NULL,
	`department_name` varchar(30) NOT NULL,
	`city` varchar(30) NOT NULL,
	`street` varchar(40) NOT NULL,
	`building_no` int NOT NULL,
	PRIMARY KEY (`department_id`)
);

CREATE TABLE IF NOT EXISTS `product` (
	`product_id` int NOT NULL,
	`product_name` varchar(40) NOT NULL,
	`product_description` varchar(150) NOT NULL,
	`category` varchar(15) NOT NULL,
	`manufacture` varchar(30) NOT NULL,
	`product_type` varchar(15) NOT NULL,
	`amount` int NOT NULL,
	`price` float NOT NULL,
	PRIMARY KEY (`product_id`)
);

CREATE TABLE IF NOT EXISTS `customer` (
	`customer_id` int AUTO_INCREMENT NOT NULL,
	`first_name` varchar(30) NOT NULL,
	`last_name` varchar(30) NOT NULL,
	`genger` varchar(1) NOT NULL,
	`birth_date` date NOT NULL,
	`phone_number` int NOT NULL,
	`email` varchar(50) NOT NULL,
	`discount` int NOT NULL,
	PRIMARY KEY (`customer_id`)
);

CREATE TABLE IF NOT EXISTS `orders` (
	`orders_id` int AUTO_INCREMENT NOT NULL,
	`employee_id` int NOT NULL,
	`product_id` int NOT NULL,
	`customer_id` int NOT NULL,
	`transaction_type` int NOT NULL,
	`transaction_moment` datetime NOT NULL,
	`amount` int NOT NULL,
	`emplo` int NOT NULL,
	`employee` int NOT NULL,
	`employee_` int NOT NULL,
	PRIMARY KEY (`orders_id`)
);

ALTER TABLE `employee` ADD CONSTRAINT `employee_fk6` FOREIGN KEY (`department_id`) REFERENCES `department`(`department_id`);

ALTER TABLE `employee` ADD CONSTRAINT `employee_fk7` FOREIGN KEY (`manager_id`) REFERENCES `employee`(`employee_id`);



ALTER TABLE `orders` ADD CONSTRAINT `orders_fk1` FOREIGN KEY (`employee_id`) REFERENCES `employee`(`employee_id`);

ALTER TABLE `orders` ADD CONSTRAINT `orders_fk2` FOREIGN KEY (`product_id`) REFERENCES `product`(`product_id`);

ALTER TABLE `orders` ADD CONSTRAINT `orders_fk3` FOREIGN KEY (`customer_id`) REFERENCES `customer`(`customer_id`);

CREATE TABLE IF NOT EXISTS `invoice` (
  `invoice_id` bigint(15) NOT NULL,
  `employee_id` INT NOT NULL,
  `customer_id` INT,
  `payment_method` INT NOT NULL,
  `transaction_moment` DATETIME NOT NULL,
  `status`	varchar(10) NOT NULL
  );

-- ALTER TABLE - ADD Column
ALTER TABLE 
     orders
ADD 
     invoice_id bigint(15) NOT NULL;
ALTER TABLE
     orders
ADD
	order_datetime DATETIME NOT NULL;
ALTER TABLE 
    orders
ADD 
	quantity INT NOT NULL;
    
ALTER TABLE
    customer
ADD 
    invoice_id bigint(10) NOT NULL;
    
-- ALTER TABLE - DROP COLUMN
ALTER TABLE 
	orders
DROP COLUMN 
	transaction_type;
ALTER TABLE 
    orders
DROP COLUMN 
	transaction_moment;
ALTER TABLE 
    orders
DROP COLUMN 
	amount;
    
ALTER TABLE 
    customer
DROP COLUMN 
	invoice_id;
    
ALTER TABLE 
	orders
DROP COLUMN 
    employee_id;
    
ALTER TABLE 
	orders
DROP COLUMN
	emplo;
    
ALTER TABLE 
	orders
DROP COLUMN 
	employee;

ALTER TABLE 
	orders
DROP COLUMN 
	customer_id;
    
ALTER TABLE 
	orders
DROP COLUMN 
	employee_;    
-- ALTER TABLE - MODIFY COLUMN
ALTER TABLE 
    customer
MODIFY 
	phone_number BIGINT(15) NOT NULL;
ALTER TABLE 
    employee
MODIFY 
	position varchar(30) NOT NULL;
ALTER TABLE 
    department
MODIFY 
    street varchar(50) NOT NULL;
ALTER TABLE 
	department
MODIFY 
    building_no INT(4);

ALTER TABLE 
    invoice
ADD PRIMARY KEY 
    (invoice_id);
    
ALTER TABLE 
    orders
DROP FOREIGN KEY  orders_fk3;

ALTER TABLE 
    orders
DROP FOREIGN KEY  orders_fk2;

ALTER TABLE 
    customer
DROP FOREIGN KEY 
	customer_fk5;

ALTER TABLE 
    orders
ADD CONSTRAINT 
    orders_fk4
FOREIGN KEY 
    (invoice_id)
REFERENCES 
	invoice(invoice_id);
    
ALTER TABLE 
    invoice
ADD CONSTRAINT 
    invoice_fk0
FOREIGN KEY 
	(employee_id)
REFERENCES 
     employee(employee_id);
     
ALTER TABLE 
     invoice
ADD CONSTRAINT 
	 invoice_fk5
FOREIGN KEY
     (customer_id)
REFERENCES 
     customer(customer_id);
     
ALTER TABLE 
     orders
ADD CONSTRAINT 
	 orders_fk6
FOREIGN KEY 
     (product_id)
REFERENCES 
	 product(product_id);
     
ALTER TABLE 
	 department
ALTER 
     city
SET DEFAULT 
     'Lviv';

ALTER TABLE 
      employee
ADD UNIQUE 
      (user_name);
      
ALTER TABLE 
	  invoice    
RENAME COLUMN 
       customer
TO 
       customer_id;

ALTER TABLE 
	employee
RENAME COLUMN 
	bomus
TO 
	bonus;
    
SELECT * FROM orders;

SELECT * FROM customer;

SELECT * FROM department;

SELECT * FROM employee;

SELECT * FROM product;

SELECT 
	*
FROM 
	employee;
SELECT
	employee_id,
    first_name,
    last_name,
    position
FROM
	employee;
    
    -- RIZNI RYADKU --

SELECT
	employee_id,
    first_name,
    last_name,
    position
FROM
	employee
LIMIT 7;

-- LIMITOVANA KILKIST RYADKIV --

SELECT DISTINCT
	position
FROM
	employee;
    
SELECT DISTINCT
	position
FROM
	employee
ORDER By
	position ASC;
    -- ALPHAVIT PORYADOK --
    
SELECT DISTINCT
	position
FROM
	employee
ORDER By
	position DESC;

-- OBERNENUY SPOSIB --

SELECT
	employee_id,
    first_name,
    last_name,
    position,
    employment_date
FROM
	employee
WHERE
	position = 'Seller'
ORDER By
	employment_date ASC;
    
-- poshyk po position v alphavitnomy raxynky --

SELECT
	employee_id,
    first_name,
    last_name,
    position,
    employment_date
FROM
	employee
WHERE
(
	position = 'Seller'
    OR
    position = 'Consultant'
    )
AND
	employmeNt_date > '2013-01-01'
ORDER By
	employment_date DESC;
    
    -- SORTYROVKA TA PEVNA DATA --
  
-- Solution 1  
SELECT
	employee_id,
    first_name,
    last_name,
    position,
    employment_date
FROM
	employee
WHERE
(
	position LIKE 'Seller'
    OR
    position IN ('Senior Consultant','Consultant')
)
AND
	employment_date > '2013-01-01'
ORDER By
	employment_date DESC;

-- Solution 2

SELECT
	employee_id,
    first_name,
    last_name,
    position,
    employment_date
FROM
	employee
WHERE
(
	position LIKE 'S_____'
OR
(	position LIKE '%Consultant'
AND
    position NOT LIKE 'A%'
))
AND
	employment_date > '2013-01-01'
ORDER By
	employment_date DESC;
    
-- DVI POSADU ODRAZY --

SELECT
	employee_id,
    first_name,
    last_name,
    position,
    manager_id,
    department_id
FROM
	employee
WHERE
	manager_id IS NULL
OR
	department_id IS NOT NULL
ORDER By
	manager_id ASC;
    
-- Pokaz departamenty ta pratsivnukiv bez manager --

-- Solution 1

SELECT
	last_name,
    first_name,
    position,
    employment_date,
    bonus
FROM
	employee
WHERE
	bonus IS NOT NULL
AND
(
	employment_date > '2015-12-31'
and
	employment_date > '2020-12-31'
)
ORDER By
	last_name ASC;
    
-- Solution 2

SELECT
	last_name,
    first_name,
    position,
    employment_date,
    bonus
FROM
	employee
WHERE
	bonus IS NOT NULL
AND
	employment_date
    BETWEEN '2015-12-31'
    AND '2016-12-31'
ORDER By
	last_name ASC;
    
-- bonusu premiya za datoy --

SELECT
	-- employee_id,
    last_name,
    first_name,
    position,
CASE
	WHEN position = 'Senior Consultant' THEN 'Can Seles, Consulting and Lead'
    WHEN position IN ('Senior Consultant','Consultant') THEN 'Can Seles and Consulting'
    WHEN position like 'Assistant Consultant' THEN 'Can only Consulting'
    WHEN position LIKE 'Seller' THEN 'Can only Sale'
    ELSE 'Service Roles'
    END AS 'Relation to Customer'
FROM
	employee
ORDER By
	last_name;
    
-- zaluchenist do prodazhi za posadoy --

SELECT
	-- employee_id,
    last_name "LAST NAME",
    first_name 'FIRST_NAME',
    position Title,
    employment_date AS 'Hire Date'
FROM
	employee;