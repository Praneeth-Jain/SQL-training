-- E-Commerce  

-- Admin , User, Product , Order, payment

-- Admin : id (key) , mail,username,passwrd

create table Admin(id int primary key,mail varchar(50) unique,username varchar(50),password varchar(20),role 
varchar(30));

select * from admin;


-- user : id (key) ,mail,username,password

create table Users(id int primary key,mail varchar(50) NOT NULL UNIQUE,username
varchar(50),password varchar(50) not null,address varchar(50),city varchar(30),state varchar(20),country varchar(40),zipcode varchar(10));


-- category : id (key) , category_name , desc ;

create table Category(id int primary key,category_name varchar(30) UNIQUE,Description text);

-- product : id, name, price , desc , category id , quantity

create table Product(id int primary key,Product_name varchar(30) not null unique,price decimal(10,2) not null,
description text,product_quantity int ,category_id int ,CONSTRAINT FK_CATID FOREIGN KEY (category_id) references
category(id));



-- order : id (key),user id,date,status,total amount, product_id

create table Orders(id int primary key,user_idno int,order_date timestamp,status varchar(30) not null,total_amount decimal(10,2),product_id int,
CONSTRAINT FK_USERORDER FOREIGN KEY (user_idno) references users(id),CONSTRAINT FK_PRODORDER FOREIGN KEY (product_id) references product(id)); 

select * from orders;



-- payment : id,order_id,payment_date,amount,method,status,transid

create table Payments(id int primary key,order_id int,payment_date timestamp,amount decimal(10,2),payment_method varchar(20),status varchar(20) not null,trans_id int,
CONSTRAINT FK_PAYORDER FOREIGN KEY (order_id) REFERENCES orders(id));

select * from payments;

ALTER TABLE Orders
DROP COLUMN order_date;

ALTER TABLE Orders
ADD order_date DATETIME DEFAULT GETDATE();

sp_help 'Orders';





