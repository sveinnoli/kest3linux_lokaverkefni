create table Employees 
(
  employeeID int PRIMARY KEY,
  firstname varchar(64) NOT NULL,
  lastname varchar(64) NOT NULL,
  email varchar(128),
  phoneNumber int,
  hire_date DATE,
  salary int
);

create table Departments 
(
  departmentID int auto_increment PRIMARY KEY,
  department_name varchar(64) NOT NULL,
  department_managerID int,
  constraint department_manager_FK foreign key(department_managerID) references Employees(employeeID),
  unique(department_name)
);

create table Locations
(
  locationID int auto_increment PRIMARY KEY,
  city varchar(128) NOT NULL,
  address varchar(256),
  zip_code int
);

create table Jobs 
(
  jobID int auto_increment PRIMARY KEY,
  job_title varchar(64) NOT NULL,
  min_salary int,
  max_salary int
);
