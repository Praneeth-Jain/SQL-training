use Largecompany;

select * from employees where first_name='fn8989';
select * from employees where id=48000;

sp_help 'employees'

alter table employees
drop constraint PK__employee__3213E83F2436666C;

-- for 50000 records
-- with primary key searching with id = 0.0001581
-- with primary key  = 0.055157 non id
-- without primary key =  0.0550785
-- for 100000
-- with primary non key search = 0.110115
-- with primary key search=same as above




alter table employees
add  primary key (id);


create procedure add_no_of__employees2 
@max int
as
begin
declare @counter int=50001;
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


exec add_no_of__employees2 100000;  --o.ooooo1

create clustered index id
on employees(salary asc);

drop index id on employees

sp_help 'employees'
--with clustered salary
select * from employees;
-- 0.110157
select * from employees where id=3434;
-- 0.110157 without primary key
-- 0.0001581 with primary key + 0.0001581 with clustered



-- cluster 2

create clustered index fname
on employees(first_name asc);

select * from employees;
-- 0.100157 for no condition search 

select * from employees where first_name='fn9999';
-- 0.001581 for clustered index search


select * from employees where id=99999 or first_name='fn99999';
-- for multiple conditions
-- 0.001581 for primary key search + 0.00581 for name * 2 + 0.0056023 for merging both results

select * from employees where last_name = 'ln45454'
-- 0.100157 for non index search

