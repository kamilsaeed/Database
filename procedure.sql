/* Switch to the classicmodels database */
USE classicmodels;

#Task 1

DELIMITER &&

CREATE PROCEDURE sp_customers_by_country(IN p_country VARCHAR(50))
BEGIN
	SELECT customerNumber, customerName, city, country
    FROM customers
    WHERE country = p_country;
END &&

DELIMITER ;
CALL sp_customers_by_country('USA');


#Task 2

DELIMITER &&

CREATE PROCEDURE sp_order_count_for_customer( IN p_customerNumber INT, OUT p_orderCount INT)
BEGIN
	SELECT COUNT(*) INTO p_orderCount
    FROM orders
    WHERE customerNumber = p_customerNumber;
END &&

DELIMITER ;
CALL sp_order_count_for_customer(103, @count);
SELECT @count;

#Task 3

DELIMITER &&

CREATE PROCEDURE sp_bump_credit_limit(IN p_customerNumber INT, INOUT p_increment DECIMAL(10,2))
BEGIN
	UPDATE customers
    SET creditLimit = creditLimit + p_increment
    WHERE customerNumber = p_customerNumber;
    
    SELECT creditLimit INTO p_increment
    FROM customers
    WHERE customerNumber = p_customerNumber;
END &&

DELIMITER ;

SET @inc = 1000;
CALL sp_bump_credit_limit(103, @inc);
SELECT @inc;


#Task 4

DELIMITER &&

CREATE PROCEDURE sp_status_category(IN p_from DATE, IN p_to DATE)
BEGIN
    SELECT orderNumber orderDate, status,
	CASE 
		WHEN status = 'Shipped' THEN 'Fulfilled'
		WHEN status = 'Cancelled' THEN 'Lost'
		WHEN status = 'Resolved' THEN 'Resolved'
		ELSE 'Pending/Other'
	END AS statusCategory
    FROM orders
    WHERE orderDate BETWEEN p_from AND p_to;
END &&

DELIMITER ;
CALL sp_status_category('2003-01-01', '2004-12-31');
    

#Task 5

DELIMITER &&

CREATE FUNCTION fn_order_total(p_orderNumber INT)
RETURNS DECIMAL(10, 2)
DETERMINISTIC

BEGIN
	DECLARE total DECIMAL(10,2);

    SELECT IFNULL(SUM(quantityOrdered * priceEach), 0)
    INTO total
    FROM orderdetails
    WHERE orderNumber = p_orderNumber;

    RETURN total;
END &&

DELIMITER ;
SELECT fn_order_total(10100) AS OrderTotal;


#Task 6

DELIMITER &&

CREATE FUNCTION fn_total_payments(p_customerNumber INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC

BEGIN
    DECLARE totalPayments DECIMAL(10,2);

    SELECT IFNULL(SUM(amount), 0)
    INTO totalPayments
    FROM payments
    WHERE customerNumber = p_customerNumber;

    RETURN totalPayments;
END &&

DELIMITER ;
SELECT fn_total_payments(103) AS TotalPayments;


#Task 7

DELIMITER &&

CREATE FUNCTION fn_customer_balance(p_customerNumber INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC

BEGIN
	 DECLARE totalOrders DECIMAL(10,2);
    DECLARE totalPayments DECIMAL(10,2);

    SELECT IFNULL(SUM(od.quantityOrdered * od.priceEach), 0)
    INTO totalOrders
    FROM orders o
    JOIN orderdetails od USING(orderNumber)
    WHERE o.customerNumber = p_customerNumber;

    SELECT IFNULL(SUM(amount), 0)
    INTO totalPayments
    FROM payments
    WHERE customerNumber = p_customerNumber;

    RETURN totalOrders - totalPayments;
END &&

DELIMITER ;
SELECT fn_customer_balance(103);

#Task 8

DELIMITER &&

CREATE FUNCTION fn_stock_value(p_productCode VARCHAR(15))
RETURNS DECIMAL(10,2)
DETERMINISTIC

BEGIN
    DECLARE stockValue DECIMAL(10,2);

    SELECT IFNULL(quantityInStock * buyPrice, 0)
    INTO stockValue
    FROM products
    WHERE productCode = p_productCode;

    RETURN stockValue;
END &&

DELIMITER ;
SELECT fn_stock_value('S10_1678');
