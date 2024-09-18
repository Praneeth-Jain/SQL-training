CREATE TABLE Supplier (
    id INT PRIMARY KEY identity(1,1),
    name VARCHAR(50) NOT NULL,
    profit DECIMAL(12, 2),
    phone_number VARCHAR(20),
    email VARCHAR(50) UNIQUE,
    region VARCHAR(50)
);

CREATE TABLE products (
    id INT PRIMARY KEY identity(1,1),
    vendorId INT,
    name VARCHAR(100) NOT NULL,
    stock INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    listing_date DATE,
    category VARCHAR(100),
    discount DECIMAL(5, 2),
    description TEXT,
    FOREIGN KEY (vendorId) REFERENCES supplier(id)
);

CREATE TABLE customer (
    id INT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    phone_number VARCHAR(20),
    customer_address VARCHAR(100),
    country VARCHAR(100),
    date_of_birth DATE,
    email VARCHAR(100) UNIQUE
);

CREATE TABLE orders (
    orderId INT PRIMARY KEY,
    customerId INT NOT NULL,
    productId INT NOT NULL,
    orderDate DATE NOT NULL,
    quantity INT NOT NULL,
    paymentStatus VARCHAR(50),
    deliveryStatus VARCHAR(50),
    FOREIGN KEY (customerId) REFERENCES customer(id),
    FOREIGN KEY (productId) REFERENCES products(id)
);


select * from orders;

INSERT INTO orders (orderId, customerId, productId, orderDate, quantity, paymentStatus, deliveryStatus)
VALUES
(1, 1, 1, '2024-09-01', 2, 'Paid', 'Delivered'),
(2, 2, 2, '2024-09-02', 1, 'Paid', 'Shipped'),
(3, 3, 3, '2024-09-05', 3, 'Pending', 'Processing'),
(4, 4, 4, '2024-09-07', 1, 'Paid', 'Delivered'),
(5, 5, 5, '2024-09-10', 2, 'Pending', 'Pending'),
(6, 6, 6, '2024-09-12', 1, 'Paid', 'Shipped'),
(7, 7, 7, '2024-09-15', 4, 'Paid', 'Delivered');



CREATE TABLE reviews (
    id INT PRIMARY KEY IDENTITY(1,1),
    description TEXT,
    productId INT NOT NULL,
    customerId INT NOT NULL,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    FOREIGN KEY (productId) REFERENCES products(id),
    FOREIGN KEY (customerId) REFERENCES customer(id)
);

create table staff (id int primary key identity(1,1),
first_name varchar(20),last_name varchar(20),
email_id varchar(50),dept_id int,contact_no varchar(20),
address text,is_active int default 0);

create table department(id int primary key identity(1,1),
name varchar(50));

create table product_supplier_map(id int identity(1,1) primary key,
product_id int,supplier_id int,
foreign key(product_id) references products(id) on
delete cascade,foreign key(supplier_id) references supplier(id));


ALTER TABLE product_supplier_map
ADD isExpired VARCHAR(1) 
CHECK (isExpired IN ('Y', 'N'));

select * from product_supplier_map

CREATE TRIGGER trg_UpdateIsExpired
ON product_supplier_map
AFTER INSERT
AS
BEGIN
    -- Update the isExpired column based on the product's listed date
    UPDATE ps
    SET ps.isExpired = CASE 
                          WHEN DATEDIFF(DAY, p.listing_date, GETDATE()) > 90 THEN 'Y'
                          ELSE 'N'
                       END
    FROM product_supplier_map ps
    JOIN Products p
        ON ps.product_id = p.id
    JOIN inserted i
        ON ps.supplier_id = i.supplier_id
       AND ps.product_id = i.product_id;
END;


select * from customer;

INSERT INTO CUSTOMER VALUES(1,'Vijay99','7564533456','Villa apartment ,3rd cross,Mangalore','India','2002-09-09','Vijayyy@gmail.com'),
(2,'Raju123','7564533456','Villa Apartment, 3rd Cross, Mangalore','India','2002-09-09','raju123@gmail.com'),
(3,'John434','7564533457','Rose Villa, 4th Cross, Bangalore','India','2002-08-19','Johmmmnn@gmail.com'),
(4,'PriyaK25','8547935634','Green Meadows, 2nd Street, Chennai','India','2001-07-15','priya.k25@gmail.com'),
(5,'Arun_M','9567843452','Sunshine Apartments, 1st Avenue, Hyderabad','India','1999-03-23','arun.m@gmail.com'),
(6,'Deepa32','7845962341','Ocean View, 5th Cross, Kochi','India','2000-12-11','deepa32@gmail.com');


select * from customer;

INSERT INTO Supplier (name, profit, phone_number, email, region)
VALUES 
('Coastal Supplies', 125000.50, '9876543210', 'coastalsupplies@example.com', 'Karnataka'),
('City Distributors', 98000.75, '8765432109', 'citydistributors@example.com', 'Karnataka'),
('Agro Ventures', 45000.25, '7654321098', 'agroventures@example.com', 'Tamil Nadu'),
('Hydro Traders', 105000.60, '6543210987', 'hydrotraders@example.com', 'Telangana'),
('Southern Goods', 78000.45, '5432109876', 'southerngoods@example.com', 'Kerala'),
('Green Energy Co.', 200000.80, '4321098765', 'greenenergy@example.com', 'Andhra Pradesh'),
('Urban Skyline', 90000.55, '3210987654', 'urbanskyline@example.com', 'Karnataka');

select * from supplier;

select * from products;



INSERT INTO products (vendorId, name, stock, price, listing_date, category, discount, description)
VALUES
(1, 'Smartphone X1', 100, 299.99, '2024-01-15', 'Electronics', 20.00, 'Latest model with advanced features.'),
(1, 'Bluetooth Headphones', 150, 79.99, '2024-02-20', 'Electronics', 10.00, 'High-quality sound and noise cancellation.'),
(2, 'Coffee Maker', 200, 119.99, '2024-03-10', 'Home Appliances', 15.00, 'Easy-to-use coffee maker with programmable settings.'),
(3, 'Office Desk', 120, 249.99, '2024-04-05', 'Furniture', 30.00, 'Spacious and durable office desk.'),
(4, 'Non-Stick Cookware Set', 80, 89.99, '2024-05-12', 'Kitchenware', 12.00, 'Durable non-stick cookware for easy cooking.'),
(5, 'Camping Tent', 90, 149.99, '2024-06-18', 'Outdoor Gear', 20.00, 'Spacious and weather-resistant camping tent.'),
(6, 'Treadmill Pro', 60, 799.99, '2024-07-22', 'Sports Equipment', 50.00, 'High-performance treadmill for home use.'),
(7, 'Best-selling Novel', 150, 19.99, '2024-08-30', 'Books', 5.00, 'A captivating novel from a popular author.');


INSERT INTO orders (orderId, customerId, productId, orderDate, quantity, paymentStatus, deliveryStatus)
VALUES
(1, 1, 1, '2024-09-01', 2, 'Paid', 'Delivered'),      
(2, 2, 2, '2024-09-02', 1, 'Paid', 'Shipped'),        
(3, 3, 3, '2024-09-05', 4, 'Pending', 'Processing'),   
(4, 4, 4, '2024-09-07', 5, 'Paid', 'Delivered'),      
(5, 5, 1, '2024-09-10', 6, 'Pending', 'Pending'),      
(6, 6, 2, '2024-09-12', 3, 'Paid', 'Shipped');       

INSERT INTO orders (orderId, customerId, productId, orderDate, quantity, paymentStatus, deliveryStatus)
VALUES
(1001, 1, 1, '2024-09-16', 2, 'Paid', 'Shipped'), 
(1002, 2, 2, '2024-09-16', 1, 'Paid', 'Pending'), 
(1003, 3, 3, '2024-09-16', 3, 'Unpaid', 'Processing'); 



select * from customer;


select * from orders;


INSERT INTO reviews (description, productId, customerId, rating)
VALUES
('Great product, very satisfied with the quality!', 1, 1, 5), 
('Good value for money, but delivery was delayed.', 2, 2, 4),  
('The product did not meet my expectations.', 3, 3, 2),       
('Excellent build quality and features.', 4, 4, 5),          
('Product is okay, but the customer service was poor.', 5, 5, 3),
('Not worth the price, had better experiences with other brands.', 6, 6, 1);  



INSERT INTO department (name)
VALUES
('Accounts'),
('Delivery'),
('Order Processing'),
('Customer Service'),
('Inventory Management'),
('Human Resources'),
('IT Support');

select * from department;


INSERT INTO staff (first_name, last_name, email_id, dept_id, contact_no, address, is_active)
VALUES
('Amit', 'Sharma', 'amit.sharma@example.com', 1, '9123456789', '12, Patel Nagar, Delhi', 1),  
('Sita', 'Reddy', 'sita.reddy@example.com', 2, '9876543210', '45, MG Road, Bangalore', 1), 
('Rajesh', 'Kumar', 'rajesh.kumar@example.com', 3, '8765432109', '78, Green Park, Mumbai', 0), 
('Anita', 'Verma', 'anita.verma@example.com', 4, '7654321098', '23, Fort Area, Chennai', 1), 
('Vikram', 'Singh', 'vikram.singh@example.com', 5, '6543210987', '34, Jubilee Hills, Hyderabad', 1),
('Neha', 'Gupta', 'neha.gupta@example.com', 6, '5432109876', '56, Sector 17, Chandigarh', 0), 
('Ravi', 'Patel', 'ravi.patel@example.com', 7, '4321098765', '67, Vashi, Navi Mumbai', 1); 

INSERT INTO staff (first_name, last_name, email_id, dept_id, contact_no, address, is_active, salary)
VALUES
('Ravi', 'Mehta', 'ravi.mehta@example.com', 2, '9112233445', '101, New Delivery Lane, Bangalore', 1, 40000.00),  -- Active staff in Delivery
('Pooja', 'Kumar', 'pooja.kumar@example.com', 2, '9223344556', '202, Old Delivery Road, Bangalore', 1, 42000.00),  -- Active staff in Delivery
('Arjun', 'Rao', 'arjun.rao@example.com', 2, '9334455667', '303, Delivery Street, Bangalore', 1, 45000.00),  -- Active staff in Delivery
('Sneha', 'Sharma', 'sneha.sharma@example.com', 2, '9445566778', '404, Delivery Avenue, Bangalore', 1, 43000.00);  -- Active staff in Delivery


select * from staff;


INSERT INTO product_supplier_map (product_id, supplier_id)
VALUES
(1, 1),  
(2, 2),  
(3, 3),  
(4, 1),  
(5, 2),  
(6, 3),  
(1, 2);  

select * from product_supplier_map;


--Queries assignment

-- get the list of suppliers who supplies smartphones

select s.name,p.name from supplier s join products p on s.id=p.vendorId where p.name='Smartphone X1';   


--select list of suppliers  in karnataka

select name from supplier where region='Karnataka';


-- display total no of products supplied by coastal suppliers

select count(*) as Total_products from products p join supplier s on s.id=p.vendorId where s.name='Coastal Supplies'; 



-- get the name and contact no of active staffs

select first_name,last_name,contact_no from staff where is_active=1; 

select * from staff;

alter table staff add salary decimal(10,2)

update staff set salary=20000.00 where id=3 
update staff set salary=40000.00 where id=4 
update staff set salary=55000.00 where id=5 
update staff set salary=77000.00 where id=6
update staff set salary=12000.00 where id=7

-- select total of delivery staff salary

select sum(s.salary) as total_salary from staff s join department d on d.id=s.dept_id where d.name='Delivery';


-- display total salary and count of each dept by dept

select sum(s.salary) as total_salary,count(*) as count from staff s join department d on d.id=s.dept_id group by dept_id;

-- display the details of expired products and suppliers

select p.name,s.name from products p join product_supplier_map ps on p.id=ps.product_id join Supplier s on ps.supplier_id=s.id where ps.isExpired='Y';


-- display best products availble along with its supplier details

select p.name,s.name,s.email,r.rating from products p join reviews r on p.id=r.productId join Supplier s on p.vendorId=s.id where r.rating>4;

-- display list of orders in a day orders

select orderDate,count(*) as no_of_orders from orders group by orderDate; 

-- display the user who has maximum orders and product details

select c.username,p.name,p.price from customer c join orders o on o.customerId=c.id join products p on p.id=o.productId
group by o.customerId order by count(*) desc;



-- Find the user with the maximum number of orders
WITH MaxOrders AS (
    SELECT c.id AS customerId, c.username, COUNT(*) AS orderCount
    FROM customer c
    JOIN orders o ON o.customerId = c.id
    GROUP BY c.id, c.username
),
MaxCustomer AS (
    SELECT TOP 1 customerId, username
    FROM MaxOrders
    ORDER BY orderCount DESC
)

-- Display user details and product details for the user with the maximum orders
SELECT mc.username, p.name AS product_name, p.price
FROM MaxCustomer mc
JOIN orders o ON o.customerId = mc.customerId
JOIN products p ON p.id = o.productId;


-- list diffrent built in functions 
-- sum,count,max,min,limit,top,getdate,avg;

-- scalaar function are the functions which returns single values
select * from staff;

create function getDetailsbyPhone(@phone varchar(20))
returns table 
as 
return(
select * from staff where contact_no=@phone
);

select * from getDetailsbyPhone('7654321098');

select * from department;

-- method to get the total salaries of any two employees


create function get_two_salaries(@id1 int,@id2 int)
returns table
as
return
(select salary from staff where id=@id1 or id=@id2); 

select * from get_two_salaries(1,2);

select * from staff;

-- total employee count for given dept
create function deptemployeecount(@dept_name varchar(50))
returns int
as 
begin
declare @count int;
set @count=(select count(*) from department d join staff s on s.dept_id=d.id where name=@dept_name)
return @count
end;

select dbo.deptemployeecount('Delivery') as counts;

-- get employee details based on location

select * from staff;


-- functions ccannot have statements which changes the database state like insert delete and update


-- get list of products by a given supplier
create function getProductList(@supplier_name varchar(50))
returns table 
as 
return(select count(*) as Total_products from products p join supplier s on s.id=p.vendorId where s.name=






--Execption Handling in sql 
 
 create procedure getEmployeDetails 
 @dept_id int
 as
 begin
 select * from staff where id=@dept_id 
 end;


 exec getEmployeDetails 1;



 -- ceate a view for 

  select * from staff;


  use [E-COMMERCE-DB];

  create view User_list as
  select first_name,last_name from staff

  select * from user_list;


-- VIEWS 
-- display employees details with its name , total employeee who works in some dept


create view emp_dept as 
select first_name,last_name,namew,contact_no from staff s join department d on s.dept_id=d.id;

select * from emp_dept;

select * from emp_dept where name='Delivery';

select count(*) from emp_dept;

== indexing

use Largecompany;


select * from employees where id=30;

