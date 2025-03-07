create database autohub;
use [autohub]
go

-- table structure for payment plan
create table payment_plan(
    id varchar(15) primary key,
    name varchar(100) not null,
    installments int not null,
    interest int not null
);

-- table structure for address
use [autohub]
go
create table address(
    id varchar(16) primary key,
    apartment_no int not null,
    street varchar(199) not null,
    city varchar(100) not null,
    state char(2) not null,
    country varchar(58) not null,
    zip char(5) not null check (len(zip)=5)
);

-- table structure for insurance
use [autohub]
go
create table insurance(
    id varchar(32) primary key,
    policy_type varchar(100) not null,
    provider varchar(100) not null,
    claim_percentage int not null
);

-- table structure for automotive retailer
use [autohub]
go
create table automotive_retailer(
    id varchar(16) primary key,
    business_hours varchar(20) not null,
    manager_id varchar(16) not null,
    address_id varchar(16) not null,
    phone varchar(20) not null unique,
    constraint FK_address foreign key (address_id) references [address](id)
);

-- table structure for ssn
use [autohub]
go
create table ssn(
    ssn char(9) not null primary key,
    first_name varchar(100) not null,
    last_name varchar(100) not null,
    dob datetime2 not null,
    phone varchar(20) not null
);

-- table structure for employee
use [autohub]
go
create table employee (
    id varchar(16) primary key,
    email varchar(255) not null unique,
    annual_salary int not null,
    hire_date datetime2 not null,
    ssn char(9) not null unique,
    automotive_retailer_id varchar(16) not null,
    address_id varchar(16) not null,
    foreign key (automotive_retailer_id) references [automotive_retailer](id),
    foreign key (address_id) references [address](id),
    foreign key (ssn) references [ssn](ssn)
);

-- table structure for inventory product
use [autohub]
go
create table inventory_product (
    id varchar(16) primary key,
    name varchar(100) not null,
    quantity int not null,
    price int not null,
    automotive_retailer_id varchar(16) not null,
    automobile_id varchar(15),
    address_id varchar(16) not null,
    foreign key (automotive_retailer_id) references [automotive_retailer](id),
    foreign key (address_id) references [address](id)
);

-- table structure for employee payroll
use [autohub]
go
create table employee_payroll(
    id varchar(16) primary key,
    hours_worked numeric not null,
    start_date datetime2 not null,
    end_date datetime2 not null,
    pay numeric not null,
    employee_id varchar(16) not null,
    constraint chk_hours_worked check (hours_worked <=100),
    foreign key (employee_id) references [employee](id)
);

-- table structure for customer_driverlicense
use [autohub]
go
create table customer_driverlicense (
    first_name varchar(20) not null,
    last_name varchar(20) not null,
    dob datetime2 not null,
    driver_license varchar(50) primary key
);

-- table structure for customer
use [autohub]
go
create table customer (
    id varchar(16) primary key,
    driver_license varchar(50) not null unique,
    phone varchar(20) not null unique,
    constraint ck_customer_phone check (phone like '(___)___-____'),
    address_id varchar(16) not null,
    foreign key (address_id) references [address](id),
    foreign key (driver_license) references customer_driverlicense(driver_license)
);

-- table structure for job
use [autohub]
go
create table job(
    id varchar(16) primary key,
    description varchar(255) not null,
    job_date datetime2 not null,
    automotive_retailer_id varchar(16) not null,
    vin_number varchar(100) not null check (len(vin_number) = 17),
    foreign key (automotive_retailer_id) references automotive_retailer(id)
);

-- table structure for part service
use [autohub]
go
create table part_service (
    id varchar(16) primary key,
    name varchar(100) not null,
    quantity int not null,
    job_id varchar(16) not null,
    inventory_product_id varchar(16) not null,
    type char(7) not null,
    constraint chk_part_type check (type in ('service','part')),
    foreign key (job_id) references [job](id),
    foreign key (inventory_product_id) references inventory_product(id)
);

-- table structure for bill
use [autohub]
go
create table bill(
    id varchar(16) primary key,
    bill_date datetime2 not null,
    mode_of_payment char(4) not null,
    constraint chk_mode_of_payment check (mode_of_payment in ('CARD','CASH')),
    insurance_id varchar(32) not null,
    customer_id varchar(16) not null,
    job_id varchar(16) not null,
    employee_id varchar(16) not null,
    sale_type char(7) not null,
    constraint chk_sale_type check (sale_type in('ONLINE','OFFLINE')),
    payment_plan_id varchar(15) not null,
    foreign key (insurance_id) references insurance(id),
    foreign key (customer_id) references customer(id),
    foreign key (job_id) references job(id),
    foreign key (employee_id) references employee(id),
    foreign key (payment_plan_id) references payment_plan(id)
);

-- Insert data for the selected tables
use [autohub]
go
insert into payment_plan (id,name,installments,interest) values 
('1','Standard Plan',12,5),
('2','Gold Plan',24,4), 
('3','Silver Plan',18,6), 
('4','Basic Plan',6,7), 
('5','Platinum Plan',36,3), 
('6','Premium Plan',38,43), 
('7','Flex Plan',24,5), 
('8','VIP Plan',48,3), 
('9','Economy Plan',12,6), 
('10','Quick Plan',15,4);

use [autohub]
go
insert into address (id,apartment_no,street,city,state,country,zip) values
('1',110,'Main Street','New York','NY','USA','10001'),
('2',202,'Broadway Avenue','Los Angeles','CA','USA','90001'),
('3',30,'Elm Street','Chicago','IL','USA','60601'),
('4',484,'Maple Street','San Francisco','CA','USA','94101'),
('5',585,'Oak Road','Miami','FL','USA','33101'),
('6',606,'Pine Avenue','Houston','TX','USA','77001'),
('7',787,'Desert Drive','Las Vegas','NV','USA','89101'),
('8',800,'Willow Place','Dallas','TX','USA','75281'),
('9',1810,'Cherry Lane','Seattle','WA','USA','98101'),
('10',502,'Mangolia Street','Bostom','MA','USA','02101');

use [autohub]
go
insert into insurance (id,policy_type,provider,claim_percentage) values
('1', 'Life Insurance', 'ABC Insurance Company',98),
('2', 'Health Insurance', 'XYZ Insurance Company',80),
('3', 'Auto Insurance', '123 Insurance Company',85),
('4', 'Home Insurance', 'Shield Insurance Solutions',75),
('5', 'Travel Insurance', 'Global Insure',70),
('6', 'Pet Insurance', 'Pawsurance',95),
('7', 'Business Insurance', 'Corporate Insurers Inc',68),
('8', 'Dental Insurance', 'SeattleCare Insurance',85),
('9', 'Property Insurance', 'Secure Properties Insurance',78),
('10', 'Disability Insurance', 'AbilitySure Insurance',80);

use [autohub]
go
insert into automotive_retailer (id,phone,business_hours,manager_id,address_id) values
('1','(123)456-7890','9:00 AM - 6:00 PM','1','1'),
('2','(456)789-0123','8:00 AM - 5:00 PM','2','2'),
('3','(789)012-3456','10:00 AM - 7:00 PM','3','3'),
('4','(012)345-6789','10:00 AM - 6:00 PM','4','4'),
('5','(234)567-8901','9:00 AM - 5:00 PM','5','5'),
('6','(567)890-1234','8:30 AM - 6:30 PM','6','6'),
('7','(890)123-4567','9:30 AM - 6:30 PM','7','7'),
('8','(901)234-5678','10:00 AM - 7:00 PM','8','8'),
('9','(345)678-9012','8:00 AM - 5:30 PM','9','9'),
('10','(678)901-2345','9:00 AM - 6:00 PM','10','10');

use [autohub]
go
insert into ssn (ssn,first_name,last_name,dob,phone) values
('123456789','John','Doe','1990-05-15','(123)456-7890'),
('987654321','Jane','Smith','1992-08-22','(456)789-0123'),
('456123789','Michael','Johnson','1988-03-10','(789)012-3456'),
('789456123','Emily','Brown','1995-11-28','(012)345-6789'),
('147258369','William','Davis','1991-06-18','(234)567-8901'),
('369852147','Sarah','Wilson','1989-09-30','(567)890-1234'),
('258369147','David','Martinez','1993-02-14','(890)123-4567'),
('852147963','Olivia','Taylor','1994-07-05','(901)234-5678'),
('963852741','James','Anderson','1987-12-03','(345)678-9012'),
('741852963','Emma','Thomas','1990-10-20','(678)901-2345');

use [autohub]
go
insert into employee (id,email,annual_salary,hire_date,ssn,automotive_retailer_id,address_id) values
('1','john.doe@example.com',60000,'2020-01-15','123456789','1','1'),
('2','jane.smith@example.com',65000,'2019-11-20','987654321','2','2'),
('3','michael.johnson@example.com',70000,'2020-03-05','456123789','3','3'),
('4','emily.brown@example.com',62000,'2021-02-10','789456123','4','4'),
('5','william.davis@example.com',68000,'2018-09-15','147258369','5','5'),
('6','sarah.wilson@example.com',72000,'2020-05-20','369852147','6','6'),
('7','david.martinez@example.com',64000,'2019-07-10','258369147','7','7'),
('8','olivia.taylor@example.com',71000,'2021-01-02','852147963','8','8'),
('9','james.anderson@example.com',66000,'2018-04-25','963852741','9','9'),
('10','emma.thomas@example.com',73000,'2020-08-30','741852963','10','10');

use [autohub]
go
insert into inventory_product(id,name,quantity,price,automotive_retailer_id,address_id) values
('1','Tire',100,50,'1','1'),
('2','Battery',50,100,'2','2'),
('3','Brake Pads',75,80,'3','3'),
('4','Oil Fiter',200,10,'4','4'),
('5','Air Filter',150,15,'5','5'),
('6','Spark Plugs',120,5,'6','6'),
('7','Windshield Wipers',80,20,'7','7'),
('8','Headlights',60,30,'8','8'),
('9','Tail Lights',60,25,'9','9'),
('10','Engine Oil',100,40,'10','10');

use [autohub]
go
insert into employee_payroll (id,hours_worked,start_date,end_date,pay,employee_id) values
('1',40,'2024-04-01','2024-04-07',8800,'1'),
('2',38,'2024-04-01','2024-04-07',7460,'2'),
('3',42,'2024-04-01','2024-04-07',4840,'3'),
('4',35,'2024-04-01','2024-04-07',7400,'4'),
('5',37,'2024-04-01','2024-04-07',7450,'5'),
('6',40,'2024-04-01','2024-04-07',8800,'6'),
('7',38,'2024-04-01','2024-04-07',7060,'7'),
('8',42,'2024-04-01','2024-04-07',9000,'8'),
('9',35,'2024-04-01','2024-04-07',7600,'9'),
('10',37,'2024-04-01','2024-04-07',7540,'10');

use [autohub]
go
insert into customer_driverlicense (first_name,last_name,dob,driver_license) values
('John','Doe','1980-05-15','DL123456'),
('Jane','Smith','1985-08-22','DL789012'),
('Micheal','Johnson','1978-03-10','DL456789'),
('Emily','Brown','1990-11-28','DL012345'),
('Micheal','DavosWilliam','1983-06-18','DL234567'),
('Sarah','Wilson','1981-09-30','DL567890'),
('David','Martinez','1987-02-14','DL890123'),
('Olivia','Taylor','1989-07-05','DL901234'),
('James','Anderson','1975-12-03','DL345678'),
('Emma','Thomas','1982-10-20','DL678901');

use [autohub]
go
insert into customer (id,driver_license,phone,address_id) values
('1','DL123456','(123)456-7890','1'),
('2','DL789012','(456)789-0123','2'),
('3','DL456789','(789)012-3456','3'),
('4','DL012345','(012)345-6789','4'),
('5','DL234567','(234)567-8901','5'),
('6','DL567890','(567)890-1234','6'),
('7','DL890123','(890)123-4567','7'),
('8','DL901234','(901)234-5678','8'),
('9','DL345678','(345)678-9012','9'),
('10','DL678901','(678)901-2345','10');

use [autohub]
go
insert into job (id,description,job_date,automotive_retailer_id,vin_number) values
('1','Oil Change','2024-04-01','1','ABC123456789DEF01'),
('2','Brake Replacement','2024-04-02','2','DEF234567890GHI02'),
('3','Tire Rotation','2024-04-03','3','GHI345678901JKL03'),
('4','Engine Tune-up','2024-04-04','4','JKL456789012MNO04'),
('5','Diagnostic Test','2024-04-05','5','MNO567890123PQR05'),
('6','Electrical Repair','2024-04-06','6','PQR678901234STU06'),
('7','Transmission Service','2024-04-07','7','STU789012345VWX07'),
('8','Suspension Inspection','2024-04-08','8','VWX890123456YZA08'),
('9','Cooling System Flush','2024-04-09','9','YZA901234567BCD09'),
('10','Wheel Alignment','2024-04-10','10','BCD012345678EFG10');

use [autohub]
go
insert into part_service (id,name,quantity,job_id,inventory_product_id,type) values
('1','Oil Change',1,'1','1','SERVICE'),
('2','Brake Replacement',2,'2','2','PART'),
('3','Tire Rotation',1,'3','3','SERVICE'),
('4','Engine Tune-up',1,'4','4','PART'),
('5','Diagnostic Test',1,'5','5','SERVICE'),
('6','Electrical Repair',2,'6','6','PART'),
('7','Transmission Service',1,'7','7','SERVICE'),
('8','Suspension Inspection',1,'8','8','PART'),
('9','Cooling System Flush',1,'9','9','SERVICE'),
('10','Wheel Alignment',2,'10','10','PART');

use [autohub]
go
insert into bill(id,bill_date,mode_of_payment,insurance_id,customer_id,job_id,employee_id,sale_type,payment_plan_id) values
('1','2024-04-01','CASH','1','1','1','1','ONLINE','1'),
('2','2024-04-02','CARD','2','2','2','2','OFFLINE','2'),
('3','2024-04-03','CASH','3','3','3','3','ONLINE','3'),
('4','2024-04-04','CARD','4','4','4','4','OFFLINE','4'),
('5','2024-04-05','CASH','5','5','5','5','ONLINE','5'),
('6','2024-04-06','CARD','6','6','6','6','OFFLINE','6'),
('7','2024-04-07','CASH','7','7','7','7','ONLINE','7'),
('8','2024-04-08','CARD','8','8','8','8','OFFLINE','8'),
('9','2024-04-09','CASH','9','9','9','9','ONLINE','9'),
('10','2024-04-10','CARD','10','10','10','10','OFFLINE','10');

-- queries
-- Find top services by revenue
SELECT 
    ps.name AS ServiceName,
    COUNT(b.id) AS TotalBills,
    SUM(ip.price * ps.quantity) AS TotalRevenue
FROM 
    part_service ps
JOIN 
    bill b ON ps.job_id = b.job_id
JOIN 
    inventory_product ip ON ps.inventory_product_id = ip.id
GROUP BY 
    ps.name
ORDER BY 
    TotalRevenue DESC;


-- Customer service history with payment details
SELECT 
    c.id AS CustomerID,
    cd.first_name + ' ' + cd.last_name AS CustomerName,
    j.description AS ServiceDescription,
    b.bill_date AS ServiceDate,
    ip.price * ps.quantity AS ServiceCost,
    b.mode_of_payment AS PaymentMethod,
    pp.name AS PaymentPlan,
    i.policy_type AS InsuranceType,
    i.provider AS InsuranceProvider
FROM 
    customer c
JOIN 
    customer_driverlicense cd ON c.driver_license = cd.driver_license
JOIN 
    bill b ON c.id = b.customer_id
JOIN 
    job j ON b.job_id = j.id
JOIN 
    part_service ps ON j.id = ps.job_id
JOIN 
    inventory_product ip ON ps.inventory_product_id = ip.id
JOIN 
    payment_plan pp ON b.payment_plan_id = pp.id
JOIN 
    insurance i ON b.insurance_id = i.id
WHERE 
    c.id = '3';

--list of customers with their address
SELECT c.id, c.driver_license, c.phone, a.street, a.city, a.state
FROM customer c
JOIN address a ON c.address_id = a.id;


-- list of all bills along with customer details
SELECT b.id, b.bill_date, b.mode_of_payment, c.id AS customer_id, c.driver_license, p.name AS payment_plan
FROM bill b
JOIN customer c ON b.customer_id = c.id
JOIN payment_plan p ON b.payment_plan_id = p.id;

