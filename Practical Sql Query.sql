


create database practical
use practical

--  Customers table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    PhoneNumber VARCHAR(20)
);
-- Insert Customers table
INSERT INTO Customers (CustomerID,FirstName,LastName,Email,PhoneNumber) VALUES

(1, 'John', 'Doe', 'john.doe@example.com', '03232567890'),
(2, 'Jane', 'Smith', 'jane.smith@example.com', '03486543210'),
(3, 'Bob', 'Johnson', 'bob.johnson@example.com', '0315234567'),
(4, 'Sunny', 'Deol', 'sunny.deol@example.com', '0355287567'),
(5, 'James', 'Vince', 'jameesvince@example.com', '0332456567');


--  Orders table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Insert Orders table
INSERT INTO Orders (OrderID,CustomerID,OrderDate,TotalAmount)VALUES
(101, 1, '2024-02-09', 45.97),
(102, 2, '2024-02-10', 35.50),
(103, 3, '2024-02-11', 74.97),
(104, 4, '2024-02-12', 85.99),
(105, 5, '2024-02-13', 60.39);


--  OrderDetails table
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    UnitPrice DECIMAL(8, 2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

--Insert  OrderDetails table
INSERT INTO OrderDetails(OrderDetailID,OrderID,ProductID,Quantity, UnitPrice) VALUES
(1, 101, 1, 3, 10.99),
(2, 101, 2, 2, 24.99),
(3, 102, 3, 5, 15.50),
(4, 103, 1, 2, 10.99),
(5, 103, 3, 3, 15.50);

drop table OrderDetails

--  Products table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    UnitPrice DECIMAL(8, 2),
    InStockQuantity INT
);
-- Insert Products table
INSERT INTO Products(ProductID,ProductName,UnitPrice,InStockQuantity) VALUES
(1, 'Product A', 10.99, 100),
(2, 'Product B', 24.99, 50),
(3, 'Product C', 15.50, 75),
(4, 'Product D', 14.40, 65),
(5, 'Product E', 13.48, 55);


Select * from Customers
Select * from Orders
Select * from OrderDetails
Select * from Products


--Query-Start
--Query 01
CREATE USER Order_Clerk;

GRANT INSERT ON Orders TO Order_Clerk;
GRANT UPDATE ON OrderDetails TO Order_Clerk;


--Query 02
CREATE TABLE Stock_Update_Audit (
    AuditID INT PRIMARY KEY,
    ProductID INT,
    OldQuantity INT,
    NewQuantity INT,
    UpdateTime TIMESTAMP
);

-- Create trigger
CREATE TRIGGER Update_Stock_Audit
ON Products
AFTER UPDATE 
As
BEGIN
    INSERT INTO Stock_Update_Audit (ProductID, OldQuantity, NewQuantity)
    VALUES (01, 50, 40);
END;
Select * from Stock_Update_Audit


--Query 03

SELECT FirstName, LastName,OrderDate,TotalAmount FROM Customers as C JOIN Orders as O ON C.CustomerID = O.CustomerID;


--Query 04
SELECT ProductName, Quantity, (Quantity*UnitPrice) as TotalPrice FROM Orders as O JOIN OrderDetails as Od ON O.OrderID = Od.OrderID
JOIN Products as P ON Od.ProductID = P.ProductID
WHERE O.TotalAmount > (SELECT AVG(TotalAmount) FROM Orders);


--Query 05
CREATE PROCEDURE GetOrdersByCustomer ( @InputCustomerID INT)
as
BEGIN
    SELECT *
    FROM Orders
    WHERE CustomerID = @InputCustomerID;
END;

--Query 06

CREATE VIEW Orderdetail
as
SELECT OrderID, OrderDate, CustomerID, TotalAmount
FROM Orders;


--Query 07

CREATE VIEW ProductMaterial 
AS
SELECT ProductName, InStockQuantity
FROM Products;


--Query 08
SELECT FirstName,LastName,OrderID, OrderDate,TotalAmount
FROM Customers as C JOIN OrderSummary as Os ON C.CustomerID = Os.CustomerID;













