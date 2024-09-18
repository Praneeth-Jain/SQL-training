create table Employee(emp_id int primary key,first_name varchar(25),last_name varchar(25),
birth_date date,sex varchar(10),salary int,super_id int,CONSTRAINT FK_Employee FOREIGN KEY (super_id)
    REFERENCES Employee(emp_id));

select * from employee;

insert into employee values(100,'David','Wallace','1967-11-17',
'M',250000,NULL);

insert into employee values(101,'Jan','Levinson','1961-05-11',
'F',110000,100);
insert into employee values(102,'Micheal','Scott','1964-03-15',
'M',75000,100);
insert into employee values(103,'Angela','Martin','1971-06-25',
'F',63000,102);
insert into employee values(104,'Kelly','Kapoor','1980-02-05',
'F',55000,102);
insert into employee values(105,'Stanley','Hudson','1958-02-19',
'M',69000,102);
insert into employee values(106,'Josh','Parter','1969-09-05',
'M',78000,100);
insert into employee values(107,'Andy','Bernad','1973-07-22',
'M',65000,106);
insert into employee values(108,'Jim','Halpert','1978-10-01',
'M',71000,106);



select * from employee;


create table branch (branch_id int primary key,branch_name varchar(20),
mgr_id int,mgr_start_date date,CONSTRAINT FK_BRANCH FOREIGN KEY 
(mgr_id) REFERENCES Employee(emp_id));

select * from branch;


insert into branch values(1,'Corporate',100,'2006-02-09');

insert into branch values(2,'Scranton',102,'1992-04-06');

insert into branch values(3,'Stamford',106,'1998-02-13');


alter table employee add branch_id int ,CONSTRAINT FK_EMP FOREIGN KEY
(branch_id) REFERENCES Branch(branch_id);

select * from employee;

update employee set branch_id = 1 where emp_id=100;

update employee set branch_id = 1 where emp_id=101;
update employee set branch_id = 2 where emp_id=102;
update employee set branch_id = 2 where emp_id=103;
update employee set branch_id = 2 where emp_id=104;
update employee set branch_id = 2 where emp_id=105;
update employee set branch_id = 3 where emp_id=106;
update employee set branch_id = 3 where emp_id=107;
update employee set branch_id = 3 where emp_id=108;

create table Client(client_id int primary key,client_name varchar(25),
branch_id int,CONSTRAINT FK_CLIENT FOREIGN KEY (branch_id) 
REFERENCES Branch(branch_id));

select * from client;

insert into client values
(400,'Dunmore Highschool',2),
(401,'Lackwana country',2),
(402,'FedEx',3),
(403,'Jhn Daly Law ,LLC',3),
(404,'Scranton Whitepages',2);

insert into client values(405,'Times Newspaper',3),
(406,'FedEx',2);


create table works_with(emp_id int,client_id int,total_sales
 int,PRIMARY KEY(emp_id,client_id),
 CONSTRAINT FK_WORKS FOREIGN KEY (emp_id) REFERENCES Employee(
 emp_id),CONSTRAINT FK_WORK FOREIGN KEY(client_id) REFERENCES
 Client(client_id));

 select * from works_with;

 insert into works_with values(105,400,55000),
 (102,401,267000),
 (108,402,22500),
 (107,403,5000),
 (108,403,12000);


 create table Branch_Supplier (branch_id int,supplier_name
  varchar(25),supply_type varchar(20),PRIMARY KEY(branch_id,
  supplier_name),CONSTRAINT FK_SUPPLY FOREIGN KEY (branch_id)
  references branch(branch_id));

  select * from branch_supplier;

  sp_help 'branch_supplier';

 --Query List

 --select all coloumns in employee table

 select * from employee;


 -- select only first name and salary in employee

 select first_name,salary from employee;

 --Find all employee salary whose salary greater than 70000

 select * from employee where salary>70000;

 -- Get the count of all employees

 select COUNT(*) from employee;

 --find all female employee in the table

 select * from  employee where sex='F';

 -- select average salary of employee
 select avg(salary) from employee;

 --min and max salary

 select max(salary) from employee;

 select min(salary) from employee;

 --sum of all salary
 select sum(salary) from employee;

 --count the no of male and female employee
 select sex,count(*)from employee group by sex;

 -- group employee by gender and find salary by each group

 select sex,avg(salary) from employee group by sex;

 --find the count f emp born b4 1975
 select count(*) from employee where birth_date <'1975-1-1';


 -- calculate sum of salaries group by gender

 select sex,sum(salary) from employee group by sex;

 -- select first and second name group by gender where abvg salary > 75000

SELECT first_name, last_name, sex 
FROM employee 
WHERE salary > (SELECT AVG(salary) FROM employee) 
GROUP BY sex, first_name, last_name;


--find the employee whose last name is scott
select count(*) from employee where last_name='Scott';


-- select all employees and order them by salaries 

select * from employee order by salary desc;

-- top 3 highest paid employee 

select top 3 * from employee order by salary desc;

-- 2nd highest salary

SELECT *
FROM Employee
ORDER BY salary desc
OFFSET 1 ROW 
FETCH NEXT 1 ROW ONLY;


-- find all employee first name starts with j

select * from employee where first_name like 'j%';

-- update salary of employee 102 to 80000
update employee set salary=80000 where emp_id=102;

select * from employee;

-- delete an employee whose emp id is 108
delete from employee where emp_id=108;

-- firts name starts with ja dn last name ends with n

select first_name,last_name from employee where first_name like 'j%' and last_name like '%n';

sp_help 'employee';

-- triggers : insert, update ,after update ,delete

-- stored procedures and functions


create table employee_log (emp_log_id int primary key IDENTITY(1,1),first_name varchar(30),last_name varchar(30),salary decimal(10,2),
sex varchar(10),branch_id int,inserted_at datetime default getdate());




sp_help 'employee_log'



create trigger employee_insert_trigger
on employee
after insert
as
begin
insert into employee_log(first_name,last_name,salary,sex,branch_id,inserted_at) 
select
i.first_name,i.last_name,i.salary,i.sex,i.branch_id,getdate() from inserted i;
end;

select * from Employee;

insert into employee values (116,'Raju','Gopal','1970-09-09','Male',65000,100,3);

select * from employee_log; 


create table deleted_employee(del_emp_id int identity(1,1),first_name varchar(30),last_name varchar(30),
salary decimal(10,2),sex varchar(10),branch_id int,deleted_at datetime default getdate());

select * from deleted_employee;

create trigger deleted_employee_trigger
on employee
after delete
as
begin
insert into deleted_employee(first_name,last_name,salary,sex,branch_id,deleted_at)
select d.first_name,d.last_name,d.salary,d.sex,d.branch_id,getdate() from deleted d;
end;

delete from employee where first_name='Rami';

select * from deleted_employee;


create table updated_employee_history(id int identity(1,1) primary key,emp_id int,first_name varchar(30),last_name varchar(30),
old_salary decimal(10,2) , new_salary decimal(10,2) , sex varchar(10),branch_id int,updated_at datetime 
default getdate());

select * from updated_employee_history;

drop trigger update_trigger


create trigger updated_employee_trigger
on employee
after update
as begin
insert into updated_employee_history(emp_id,first_name,last_name,old_salary,new_salary,sex,branch_id,updated_at)
select d.emp_id,d.first_name,d.last_name,d.salary as old_salary,i.salary as new_salary,d.sex,d.branch_id,getdate()
from deleted d
join inserted i on i.emp_id=d.emp_id;
end;

select * from employee;

update employee set salary=80000 where emp_id=116;

  
select * from branch;



