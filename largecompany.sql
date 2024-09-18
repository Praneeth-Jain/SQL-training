
--logic to generate random salary
SELECT ROUND((RAND() * (100000 - 10000) + 10000), 2) AS random_decimal;


--logic to generate random id is identity(1,1)


--logic to generate first name and last name
select 'fn'+cast(1 as varchar(10))

--logic to generate loop 

create table employees(id int identity(1,1) primary key,
first_name varchar(50),last_name varchar(50),salary decimal(10,2));


create procedure add_no_of__employees 
@max int
as
begin
declare @counter int=1;
declare @maxCounter int= @max;
while @counter <= @maxCounter
begin
insert into employees(first_name,last_name,salary) values
(
'fn'+cast(@counter as varchar(10)),
'ln'+cast(@counter as varchar(50)),
ROUND((RAND() * (100000 - 10000) + 10000), 2)
);
set @counter=@counter+1;
end;
end;


exec add_no_of__employees 50000;


select * from employees;

select *  if exists(select * from employees where first_name='ln1' or last_name='ln1')

--to search employee detail using last_name or first_name without specifying which is what using sp output will be search result

create procedure filteredSearch
@fn varchar(50)='',@ln varchar(50)=''
as 
begin
if exists(select * from employees where first_name=@fn or last_name=@fn)
begin
select * from employees where first_name=@fn or last_name=@fn
end;
else
begin
if exists(select * from employees where first_name=@ln or last_name=@ln)
begin
select * from employees where first_name=@ln or last_name=@ln
end;
end;
end;


exec filteredSearch 'fn1' ;