select * from emp_data;

sp_help 'emp_data';


create table Project(project_id int primary key,project_name varchar(50),emp_id varchar(10) ,CONSTRAINT FK_Project FOREIGN KEY (emp_id)
    REFERENCES Emp_data(empid));

select * from project;

insert into project values (1,'Development','E2');

select * from project;

insert into project values (2,'Unit Testing','E4');

insert into project values (3,'Web Application','E3');


-- Find out people who has existing project
select e.ename from emp_data e ,project p where e.empid=p.emp_id;

--Find out people who doesnt have project but having salary > 25000
select e.ename from emp_data e,project p where e.empid = p.emp_id and e.salary>25000;

select ename from emp_data MINUS select e.ename from emp_data e,project p where e.empid = p.emp_id and e.salary>25000;


