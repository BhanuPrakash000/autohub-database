# autohub-database
## Project Description
AutoHub is a comprehensive automotive service management system that streamlines operations for automotive retailers. The database manages everything from inventory tracking and employee management to customer service records and billing. It features complete business workflows including payment plans, insurance processing, and service tracking, helping automotive retailers optimize their operations and enhance customer experience.
## Conceptual Data Model
![Database ER diagram (crow's foot)](https://github.com/user-attachments/assets/44a83bc5-7c28-450f-beca-07e5ac660d4e)

## Mapping Conceptual Model to Relational Model
* Primary key Attributes are indicated by underline    -     ________
* Primary key Attributes are indicated by dashed underline   -     --------
* Payment_plan (id, name, installments, interest)

   
* Address (id, apartment_no, street, city, state, country, zip)
* Insurance (id, policy_type, provider, claim_percentage)
* Automotive_retailer (id, phone, business_hours, manager_id, address_id)

    Address_id foreign key refers to id in Address table.
* Ssn (ssn, first_name, last_name, dob, phone)
* Employee (id, email, annual_salary, hire_date, ssn, automotive_retailer_id, address_id)

    Automotive_retailer_id foreign key refers to id in Automotive_retailer table.

    Address_id foreign key refers to id in Address table.

    Ssn foreign key refers to ssn in Ssn table.
  
* Inventory_product(id, name, quantity, price, automotive_retailer_id, address_id)

    Automotive_retailer_id foreign key refers to id in Automotive_retailer table.

     Address_id foreign key refers to id in Address table.
    
* Employee_payroll (id, hours_worked, start_date, end_date, pay, employee_id)

    Employee_id foreign key refers to id in Employee table.
* Customer_driverlicense (first_name, last_name, dob, driver_license)
* Customer (id, driver_license, phone, address_id)

    Address_id foreign key refers to id in Address table.

    Driver_license foreign key refers to driver_license in Customer_driverlicense.
* Job (id, description, job_date, automotive_retailer_id, vin_number)

    Automotive_retailer_id foreign key refers to id in automotive_retailer table.
* Part_service (id, name, quantity, job_id, inventory_product_id, type)

    Job_id foreign key refers to id in job table.

    Inventory_product_id foreign key refers to id in inventory_product table.
* Bill (id, bill_date, mode_of_payment, insurance_id, customer_id, job_id, employee_id, sale_type, payment_plan_id)

    Insurance_id foreign key refers to id in insurance table.

    Customer_id foreign key refers to id in customer table.

    Job_id foreign key refers to id in job table.

    Employee_id foreign key refers to id in Employee table.

    Payment_plan_id foreign key refers to id in payment_plan table.

## Problem Statement

The automotive service industry often struggles with fragmented data across departments, leading to inefficiencies in service delivery and inventory management. AutoHub addresses this by providing a unified database solution that connects customer information, inventory, services, and billing into a cohesive system that enables automotive retailers to operate more efficiently and provide better customer service.
## Results
* bullet Successfully implemented top services by revenue.
* Implemented the number of jobs done by employee in terms of revenue.
