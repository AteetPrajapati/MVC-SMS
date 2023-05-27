CREATE TABLE customers
(
    customer_id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(250) NOT NULL,
    balance DECIMAL(38,2) DEFAULT 50000.00,
    address VARCHAR(250)
)
INSERT INTO customers
    (name, address)
VALUES
    ('Ateet', 'Surat'),
    ('Brad Guzan', 'Rajkot'),
    ('Nick Rimando', 'Surat'),
    ('Jozy Altidor', 'Rajkot'),
    ('Fabian Johnson', 'Surat'),
    ('Graham Zusi', 'Gandhinagar'),
    ('Brad Davis', 'Surat'),
    ('Julian Green', 'Rajkot'),
    ('Geoff Cameron', 'Surat'),
    ('Michale', 'Surat'),
    ('Jhon', 'Ahmedabad'),
    ('Joseph', 'Surat'),
    ('Carlos', 'Surat'),
    ('George', 'Surat'),
    ('Alex', 'Ahmedabad'),
    ('Alan', 'Surat'),
    ('Zanifer', 'Surat'),
    ('Mario', 'Rajkot'),
    ('Henrey', 'Surat'),
    ('Maria', 'Surat'),
    ('Enric', 'Ahmedabad'),
    ('Kuleswar', 'Surat'),
    ('Tanvi', 'Surat'),
    ('Ayush', 'Surat'),
    ('Max', 'Ahmedabad'),
    ('Mehul', 'Surat'),
    ('Nikki', 'Surat'),
    ('Pruthvi', 'Surat'),
    ('Akshay', 'Surat'),
    ('Hardik', 'Ahmedabad'),
    ('Rahi', 'Surat')



SELECT *
FROM customers


CREATE TABLE Products
(
    product_id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(250) NOT NULL
)
INSERT INTO Products
VALUES
    ('Magazines'),
    ('Toothpaste'),
    ('Food'),
    ('Candy'),
    ('Laundry detergent'),
    ('Shampoo'),
    ('High-end jewelry'),
    ('Perfume'),
    ('Luxury cars'),
    ('Designer clothes'),
    ('Televisions'),
    ('Furniture'),
    ('Clothing'),
    ('Phones'),
    ('Large appliances'),
    ('Cars'),
    ('Water'),
    ('Minerals'),
    ('Livestock'),
    ('Wheat'),
    ('Coal'),
    ('Natural gas'),
    ('Tractors'),
    ('Cars'),
    ('Engines'),
    ('Cash registers'),
    ('Tools'),
    ('Shelving'),
    ('Copiers'),
    ('Computers'),
    ('Typewriters')


SELECT *
FROM Products

CREATE TABLE a6_orders
(
    order_id INT PRIMARY KEY IDENTITY(1,1),
    product_id INT FOREIGN KEY REFERENCES Products(product_id),
    customer_id INT FOREIGN KEY REFERENCES customers(customer_id),
    order_date DATE DEFAULT getDate(),
    purchase_amount DECIMAL(38,2),
    paid BIT
)

-- DROP TaBLE a6_orders
-- DROP TaBLE customers
-- DROP TaBLE Products

INSERT INTO a6_orders
    (product_id, customer_id, purchase_amount, paid)
VALUES
    (1, 14, 150.99, 0),
    (2, 15, 150.99, 1),
    (3, 16, 850.00, 1),
    (4, 17, 850.00, 1),
    (5, 18, 850.00, 1),
    (6, 19, 850.00, 0),
    (7, 20, 150.00, 0),
    (8, 21, 150.00, 0),
    (9, 22, 150.99, 0),
    (10, 23, 2250.99, 1),
    (11, 24, 2250.99, 0),
    (12, 25, 2250.99, 1),
    (13, 26, 2250.99, 0),
    (14, 1, 150.99, 0),
    (15, 2, 6950.00, 1),
    (16, 3, 6950.00, 1),
    (17, 4, 6950.00, 0),
    (18, 5, 6950.00, 1),
    (19, 6, 6950.00, 1),
    (20, 7, 6950.00, 1),
    (21, 8, 6950.00, 1),
    (22, 9, 150.99, 0),
    (23, 10, 150.99, 0),
    (24, 11, 150.99, 1),
    (25, 12, 150.99, 0),
    (26, 13, 150.99, 1),
    (1, 14, 150.99, 0),
    (2, 15, 150.99, 1),
    (1, 15, 150.99, 0),
    (2, 15, 150.99, 1)


-- 1.Create a stored procedure called "get_customers" that returns all customers from the "customers" table.
GO
CREATE PROCEDURE get_customers
AS
BEGIN
    SELECT *
    FROM customers
END
EXECUTE get_customers

-- 2.Create a stored procedure called "get_orders" that returns all orders from the "orders" table.
GO
CREATE PROCEDURE get_orders
AS
BEGIN
    SELECT *
    FROM a6_orders
END
EXECUTE get_orders

-- 3.Create a stored procedure called "get_order_details" that accepts an order ID as a parameter and returns the details of that order (i.e., the products and quantities).
GO
CREATE PROCEDURE get_order_details
    @id INT
AS
BEGIN
    SELECT *
    FROM a6_orders
    WHERE order_id = @id
END
EXECUTE get_order_details 9

-- 4.Create a stored procedure called "get_customer_orders" that accepts a customer ID as a parameter and returns all orders for that customer.
GO
CREATE PROCEDURE get_customer_orders
    @id INT
AS
BEGIN
    SELECT *
    FROM a6_orders
    WHERE customer_id = @id
END
EXECUTE get_customer_orders 1


-- 5.Create a stored procedure called "get_order_total" that accepts an order ID as a parameter and returns the total amount of the order.
GO
CREATE PROCEDURE get_order_total
    @id INT
AS
BEGIN
    SELECT purchase_amount
    FROM a6_orders
    WHERE customer_id = @id
END
EXECUTE get_order_total 1

-- 6.Create a stored procedure called "get_product_list" that returns a list of all products from the "products" table.
GO
CREATE PROCEDURE get_product_list
AS
BEGIN
    SELECT *
    FROM Products
END
EXECUTE get_product_list

-- 7.Create a stored procedure called "get_product_info" that accepts a product ID as a parameter and returns the details of that product.
GO
CREATE PROCEDURE get_product_info
    @id INT
AS
BEGIN
    SELECT *
    FROM Products
    WHERE customer_id = @id
END
EXECUTE get_product_info 1

-- 8.Create a stored procedure called "get_customer_info" that accepts a customer ID as a parameter and returns the details of that customer.
GO
CREATE PROCEDURE get_customer_info
    @id INT
AS
BEGIN
    SELECT *
    FROM customers
    WHERE customer_id = @id
END
EXECUTE get_customer_info 1

-- 9.Create a stored procedure called "update_customer_info" that accepts a customer ID and new information as parameters and updates the customer's information in the "customers" table.
GO
CREATE PROCEDURE update_customer_info
    @id INT,
    @name VARCHAR(250)
AS
BEGIN
    UPDATE customers
 SET name = @name
 WHERE customer_id = @id
END
EXECUTE update_customer_info 32, 'Parnav'

-- 10.Create a stored procedure called "delete_customer" that accepts a customer ID as a parameter and deletes that customer from the "customers" table.
GO
CREATE PROCEDURE delete_customer
    @id INT
AS
BEGIN
    DELETE FROM customers
 WHERE customer_id = @id
END
EXECUTE delete_customer 32

-- 11.Create a stored procedure called "get_order_count" that accepts a customer ID as a parameter and returns the number of orders for that customer.
GO
CREATE PROCEDURE get_order_count
    @id INT
AS
BEGIN
    SELECT COUNT(*) as total_orders
    FROM a6_orders
    WHERE customer_id = @id
END
EXECUTE get_order_count 1


-- 12.Create a stored procedure called "get_customer_balance" that accepts a customer ID as a parameter and returns the customer's balance (i.e., the total amount of all orders minus the total amount of all payments).
GO
ALTER PROCEDURE get_customer_balance
    @id INT
AS 
BEGIN
    DECLARE @expenses DECIMAL(38,2);
    SET @expenses = (SELECT SUM(purchase_amount)
    FROM a6_orders O
        JOIN customers C ON C.customer_id = O.customer_id
    WHERE C.customer_id = @id AND O.paid = 1)

    DECLARE @bal DECIMAL(38,2);
    SET @bal = (SELECT SUM(purchase_amount)
    FROM a6_orders O
        JOIN customers C ON C.customer_id = O.customer_id
    WHERE C.customer_id = @id)

    DECLARE @avialable_bal DECIMAL(38,2);
    SET @avialable_bal = @bal - @expenses;
    SELECT @avialable_bal as avialable_balance
END
EXECUTE get_customer_balance 15

-- 13.Create a stored procedure called "get_customer_payments" that accepts a customer ID as a parameter and returns all payments made by that customer.
GO
ALTER PROCEDURE get_customer_payments
    @id INT
AS 
BEGIN
    SELECT *
    FROM a6_orders
    WHERE customer_id = @id AND paid = 1
END
EXECUTE get_customer_payments 15

-- 14.Create a stored procedure called "add_customer" that accepts a name and address as parameters and adds a new customer to the "customers" table.
GO
CREATE PROCEDURE add_customer
    @name VARCHAR(250),
    @address VARCHAR(250)
AS
BEGIN
    INSERT INTO customers
        (name, address)
    VALUES
        (@name, @address)
END
EXECUTE add_customer 'Nayanam', 'Delhi'

-- 15.Create a stored procedure called "get_top_products" that returns the top 10 products based on sales volume.
GO
CREATE PROCEDURE get_top_products
AS
BEGIN
    --SET @totalUnits = 
    --	SELECT * FROM a6_orders O JOIN Products P ON P.product_id = O.product_id
    SELECT TOP 10
        *
    FROM Products P
        JOIN (SELECT product_id, COUNT(product_id) as total
        FROM a6_orders
        GROUP BY product_id) as PS
        ON PS.product_id = P.product_id
    ORDER BY PS.total DESC
END
EXECUTE get_top_products

-- 16.Create a stored procedure called "get_product_sales" that accepts a product ID as a parameter and returns the total sales volume for that product.
GO
ALTER PROCEDURE get_product_sales
    @id INT
AS
BEGIN
    SELECT PS.total
    FROM Products P
        JOIN (SELECT product_id, COUNT(product_id) as total
        FROM a6_orders
        GROUP BY product_id) as PS
        ON PS.product_id = P.product_id
    WHERE P.product_id = @id
    ORDER BY PS.total DESC
END
EXECUTE get_product_sales 2

-- 17.Create a stored procedure called "get_customer_orders_by_date" that accepts a customer ID and date range as parameters and returns all orders for that customer within the specified date range.
GO
CREATE PROCEDURE get_customer_orders_by_date
    @id INT,
    @from_date DATE,
    @to_date DATE
AS
BEGIN
    SELECT *
    FROM a6_orders
    WHERE customer_id = @id AND order_date BETWEEN @from_date AND @to_date
END
EXECUTE get_customer_orders_by_date 15, '2023-03-01','2023-03-20'

-- 18.Create a stored procedure called "get_order_details_by_date" that accepts an order ID and date range as parameters and returns the details of that order within the specified date range.
GO
CREATE PROCEDURE get_order_details_by_date
    @id INT,
    @from_date DATE,
    @to_date DATE
AS
BEGIN
    SELECT *
    FROM a6_orders
    WHERE order_id = @id AND order_date BETWEEN @from_date AND @to_date
END
EXECUTE get_order_details_by_date 15, '2023-03-01','2023-03-20'


-- 19.Create a stored procedure called "get_product_sales_by_date" that accepts a product ID and date range as parameters and returns the total sales volume for that product within the specified date range.
GO
ALTER PROCEDURE get_product_sales_by_date
    @id INT,
    @from_date DATE,
    @to_date DATE
AS
BEGIN
    SELECT DISTINCT PS.total, O.product_id
    FROM a6_orders O
        JOIN (SELECT product_id, COUNT(product_id) as total
        FROM a6_orders
        GROUP BY product_id) as PS
        ON PS.product_id = O.product_id
    WHERE O.product_id = @id AND O.order_date BETWEEN @from_date AND @to_date
    ORDER BY PS.total DESC
END
EXECUTE get_product_sales_by_date 2, '2023-03-01','2023-03-20'

-- 20.Create a stored procedure called "get_customer_balance_by_date" that accepts a customer ID and date range as parameters and returns the customer's balance within the specified date range.
GO
CREATE PROCEDURE get_customer_balance_by_date
    @id INT,
    @from_date DATE,
    @to_date DATE
AS
BEGIN
    DECLARE @expenses DECIMAL(38,2);
    SET @expenses = (SELECT SUM(purchase_amount)
    FROM a6_orders O
        JOIN customers C ON C.customer_id = O.customer_id
    WHERE C.customer_id = @id AND O.paid = 1 AND O.order_date BETWEEN @from_date AND @to_date)

    DECLARE @bal DECIMAL(38,2);
    SET @bal = (SELECT SUM(purchase_amount)
    FROM a6_orders O
        JOIN customers C ON C.customer_id = O.customer_id
    WHERE C.customer_id = @id)

    DECLARE @avialable_bal DECIMAL(38,2);
    SET @avialable_bal = @bal - @expenses;
    SELECT @avialable_bal as avialable_balance
END
EXECUTE get_customer_balance_by_date 15, '2023-03-01','2023-03-20'

-- 21.Create a stored procedure called "add_order" that accepts a customer ID, order date, and total amount as parameters and adds a new order to the "orders" table.
GO
CREATE PROCEDURE add_order
    @product_id INT,
    @customer_id INT,
    @purchase_amount DECIMAL(38, 2)
AS
BEGIN
    INSERT INTO a6_orders
        (product_id, customer_id, purchase_amount, paid)
    VALUES
        (@product_id, @customer_id, @purchase_amount, 0)
END
EXECUTE add_order 2, 5, 450.00

-- 22.Create a stored procedure called "update_order_total" that accepts an order ID and a new total amount as parameters and updates the total amount of the order in the "orders" table.
GO
CREATE PROCEDURE update_order_total
    @id INT,
    @purchase_amount DECIMAL(38, 2)
AS
BEGIN
    UPDATE a6_orders
 SET purchase_amount = @purchase_amount
 WHERE order_id = @id
END
EXECUTE update_order_total 2, 699.00

-- 23.Create a stored procedure called "delete_order" that accepts an order ID as a parameter and deletes that order from the "orders" table.
GO
CREATE PROCEDURE delete_order
    @id INT
AS
BEGIN
    DELETE FROM a6_orders
 WHERE order_id = @id
END
EXECUTE delete_order 30






