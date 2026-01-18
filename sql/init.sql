-- Drop existing objects if they exist
begin
   execute immediate 'DROP TABLE order_items CASCADE CONSTRAINTS';
exception
   when others then
      null;
end;
/
begin
   execute immediate 'DROP TABLE orders CASCADE CONSTRAINTS';
exception
   when others then
      null;
end;
/
begin
   execute immediate 'DROP TABLE designs CASCADE CONSTRAINTS';
exception
   when others then
      null;
end;
/
begin
   execute immediate 'DROP TABLE card_templates CASCADE CONSTRAINTS';
exception
   when others then
      null;
end;
/
begin
   execute immediate 'DROP TABLE materials CASCADE CONSTRAINTS';
exception
   when others then
      null;
end;
/
begin
   execute immediate 'DROP TABLE suppliers CASCADE CONSTRAINTS';
exception
   when others then
      null;
end;
/
begin
   execute immediate 'DROP TABLE customers CASCADE CONSTRAINTS';
exception
   when others then
      null;
end;
/
begin
   execute immediate 'DROP TABLE employees CASCADE CONSTRAINTS';
exception
   when others then
      null;
end;
/
begin
   execute immediate 'DROP SEQUENCE customer_seq';
exception
   when others then
      null;
end;
/
begin
   execute immediate 'DROP SEQUENCE supplier_seq';
exception
   when others then
      null;
end;
/
begin
   execute immediate 'DROP SEQUENCE material_seq';
exception
   when others then
      null;
end;
/
begin
   execute immediate 'DROP SEQUENCE template_seq';
exception
   when others then
      null;
end;
/
begin
   execute immediate 'DROP SEQUENCE design_seq';
exception
   when others then
      null;
end;
/
begin
   execute immediate 'DROP SEQUENCE order_seq';
exception
   when others then
      null;
end;
/
begin
   execute immediate 'DROP SEQUENCE item_seq';
exception
   when others then
      null;
end;
/
begin
   execute immediate 'DROP SEQUENCE employee_seq';
exception
   when others then
      null;
end;
/

-- Create database schema for Greeting Card Store Management System

-- Customers table
create table customers (
   customer_id number primary key,
   name        varchar2(100) not null,
   email       varchar2(100) unique,
   phone       varchar2(20),
   address     varchar2(200)
);

-- Suppliers table
create table suppliers (
   supplier_id number primary key,
   name        varchar2(100) not null,
   contact     varchar2(100)
);

-- Materials table
create table materials (
   material_id number primary key,
   name        varchar2(100) not null,
   supplier_id number
      references suppliers ( supplier_id ),
   cost        number(10,2)
);

-- Card Templates table
create table card_templates (
   template_id number primary key,
   name        varchar2(100) not null,
   description varchar2(500),
   base_price  number(10,2)
);

-- Designs table
create table designs (
   design_id   number primary key,
   customer_id number
      references customers ( customer_id ),
   template_id number
      references card_templates ( template_id ),
   custom_text varchar2(1000),
   image_path  varchar2(200),
   material_id number
      references materials ( material_id )
);

-- Orders table
create table orders (
   order_id     number primary key,
   customer_id  number
      references customers ( customer_id ),
   order_date   date default sysdate,
   total_amount number(10,2)
);

-- Order Items table
create table order_items (
   item_id   number primary key,
   order_id  number
      references orders ( order_id ),
   design_id number
      references designs ( design_id ),
   quantity  number,
   price     number(10,2)
);

-- Employees table
create table employees (
   employee_id number primary key,
   name        varchar2(100) not null,
   role        varchar2(50)
);

-- Sequences for auto-increment
create sequence customer_seq start with 1 increment by 1;
create sequence supplier_seq start with 1 increment by 1;
create sequence material_seq start with 1 increment by 1;
create sequence template_seq start with 1 increment by 1;
create sequence design_seq start with 1 increment by 1;
create sequence order_seq start with 1 increment by 1;
create sequence item_seq start with 1 increment by 1;
create sequence employee_seq start with 1 increment by 1;

commit;

-- Delete existing data in correct order
delete from order_items;
delete from orders;
delete from designs;
delete from card_templates;
delete from materials;
delete from suppliers;
delete from customers;
delete from employees;

-- Populate database with sample data

-- Insert Suppliers
insert into suppliers (
   supplier_id,
   name,
   contact
) values ( 1,
           'Paper Supplier Inc.',
           'contact@papersup.com' );
insert into suppliers (
   supplier_id,
   name,
   contact
) values ( 2,
           'Ink Corp.',
           'info@inkcorp.com' );
insert into suppliers (
   supplier_id,
   name,
   contact
) values ( 3,
           'Premium Cardstock Ltd.',
           'sales@premiumcard.com' );
insert into suppliers (
   supplier_id,
   name,
   contact
) values ( 4,
           'Digital Printing Services',
           'contact@digitalprintco.com' );

-- Insert Materials
insert into materials (
   material_id,
   name,
   supplier_id,
   cost
) values ( 1,
           'Glossy Paper',
           1,
           0.50 );
insert into materials (
   material_id,
   name,
   supplier_id,
   cost
) values ( 2,
           'Matte Paper',
           1,
           0.40 );
insert into materials (
   material_id,
   name,
   supplier_id,
   cost
) values ( 3,
           'Color Ink',
           2,
           0.20 );
insert into materials (
   material_id,
   name,
   supplier_id,
   cost
) values ( 4,
           'Premium Cardstock',
           3,
           0.75 );
insert into materials (
   material_id,
   name,
   supplier_id,
   cost
) values ( 5,
           'Textured Paper',
           3,
           0.85 );
insert into materials (
   material_id,
   name,
   supplier_id,
   cost
) values ( 6,
           'Metallic Ink',
           2,
           0.35 );
insert into materials (
   material_id,
   name,
   supplier_id,
   cost
) values ( 7,
           'Laminated Finish',
           4,
           0.60 );

-- Insert Card Templates
insert into card_templates (
   template_id,
   name,
   description,
   base_price
) values ( 1,
           'Birthday Card',
           'Standard birthday template',
           5.00 );
insert into card_templates (
   template_id,
   name,
   description,
   base_price
) values ( 2,
           'Wedding Card',
           'Elegant wedding template',
           7.00 );
insert into card_templates (
   template_id,
   name,
   description,
   base_price
) values ( 3,
           'Holiday Card',
           'Festive holiday template',
           6.00 );
insert into card_templates (
   template_id,
   name,
   description,
   base_price
) values ( 4,
           'Congratulations Card',
           'Professional success template',
           5.50 );
insert into card_templates (
   template_id,
   name,
   description,
   base_price
) values ( 5,
           'Thank You Card',
           'Gratitude and appreciation',
           4.50 );
insert into card_templates (
   template_id,
   name,
   description,
   base_price
) values ( 6,
           'Valentine Card',
           'Love and romance template',
           6.50 );

-- Insert Customers
insert into customers (
   customer_id,
   name,
   email,
   phone,
   address
) values ( 1,
           'John Doe',
           'john@example.com',
           '123-456-7890',
           '123 Main St' );
insert into customers (
   customer_id,
   name,
   email,
   phone,
   address
) values ( 2,
           'Jane Smith',
           'jane@example.com',
           '098-765-4321',
           '456 Elm St' );
insert into customers (
   customer_id,
   name,
   email,
   phone,
   address
) values ( 3,
           'Michael Johnson',
           'michael.j@example.com',
           '555-123-4567',
           '789 Oak Ave' );
insert into customers (
   customer_id,
   name,
   email,
   phone,
   address
) values ( 4,
           'Sarah Williams',
           'sarah.w@example.com',
           '555-987-6543',
           '321 Pine Rd' );
insert into customers (
   customer_id,
   name,
   email,
   phone,
   address
) values ( 5,
           'Robert Brown',
           'rbrown@example.com',
           '555-456-7890',
           '654 Maple Lane' );
insert into customers (
   customer_id,
   name,
   email,
   phone,
   address
) values ( 6,
           'Emily Davis',
           'emily.d@example.com',
           '555-321-9876',
           '987 Birch St' );

-- Insert Designs
insert into designs (
   design_id,
   customer_id,
   template_id,
   custom_text,
   image_path,
   material_id
) values ( 1,
           1,
           1,
           'Happy Birthday!',
           '/images/birthday.jpg',
           1 );
insert into designs (
   design_id,
   customer_id,
   template_id,
   custom_text,
   image_path,
   material_id
) values ( 2,
           2,
           2,
           'Congratulations!',
           '/images/wedding.jpg',
           2 );
insert into designs (
   design_id,
   customer_id,
   template_id,
   custom_text,
   image_path,
   material_id
) values ( 3,
           3,
           3,
           'Happy Holidays',
           '/images/holiday.jpg',
           4 );
insert into designs (
   design_id,
   customer_id,
   template_id,
   custom_text,
   image_path,
   material_id
) values ( 4,
           4,
           4,
           'Well Done!',
           '/images/congrats.jpg',
           5 );
insert into designs (
   design_id,
   customer_id,
   template_id,
   custom_text,
   image_path,
   material_id
) values ( 5,
           5,
           5,
           'Thank You!',
           '/images/thankyou.jpg',
           3 );
insert into designs (
   design_id,
   customer_id,
   template_id,
   custom_text,
   image_path,
   material_id
) values ( 6,
           6,
           6,
           'With Love',
           '/images/valentine.jpg',
           6 );
insert into designs (
   design_id,
   customer_id,
   template_id,
   custom_text,
   image_path,
   material_id
) values ( 7,
           1,
           2,
           'Happy Anniversary',
           '/images/anniversary.jpg',
           7 );

-- Insert Orders
insert into orders (
   order_id,
   customer_id,
   order_date,
   total_amount
) values ( 1,
           1,
           sysdate - 30,
           10.00 );
insert into orders (
   order_id,
   customer_id,
   order_date,
   total_amount
) values ( 2,
           2,
           sysdate - 20,
           14.00 );
insert into orders (
   order_id,
   customer_id,
   order_date,
   total_amount
) values ( 3,
           3,
           sysdate - 15,
           12.50 );
insert into orders (
   order_id,
   customer_id,
   order_date,
   total_amount
) values ( 4,
           4,
           sysdate - 10,
           11.00 );
insert into orders (
   order_id,
   customer_id,
   order_date,
   total_amount
) values ( 5,
           5,
           sysdate - 5,
           9.00 );
insert into orders (
   order_id,
   customer_id,
   order_date,
   total_amount
) values ( 6,
           6,
           sysdate - 3,
           13.00 );
insert into orders (
   order_id,
   customer_id,
   order_date,
   total_amount
) values ( 7,
           1,
           sysdate,
           7.00 );

-- Insert Order Items
insert into order_items (
   item_id,
   order_id,
   design_id,
   quantity,
   price
) values ( 1,
           1,
           1,
           2,
           5.00 );
insert into order_items (
   item_id,
   order_id,
   design_id,
   quantity,
   price
) values ( 2,
           2,
           2,
           2,
           7.00 );
insert into order_items (
   item_id,
   order_id,
   design_id,
   quantity,
   price
) values ( 3,
           3,
           3,
           1,
           6.00 );
insert into order_items (
   item_id,
   order_id,
   design_id,
   quantity,
   price
) values ( 4,
           4,
           4,
           3,
           5.50 );
insert into order_items (
   item_id,
   order_id,
   design_id,
   quantity,
   price
) values ( 5,
           5,
           5,
           2,
           4.50 );
insert into order_items (
   item_id,
   order_id,
   design_id,
   quantity,
   price
) values ( 6,
           6,
           6,
           1,
           6.50 );
insert into order_items (
   item_id,
   order_id,
   design_id,
   quantity,
   price
) values ( 7,
           1,
           1,
           1,
           5.00 );
insert into order_items (
   item_id,
   order_id,
   design_id,
   quantity,
   price
) values ( 8,
           2,
           2,
           1,
           7.00 );
insert into order_items (
   item_id,
   order_id,
   design_id,
   quantity,
   price
) values ( 9,
           3,
           6,
           2,
           6.50 );
insert into order_items (
   item_id,
   order_id,
   design_id,
   quantity,
   price
) values ( 10,
           7,
           7,
           1,
           7.00 );

-- Insert Employees
insert into employees (
   employee_id,
   name,
   role
) values ( 1,
           'Alice Manager',
           'Manager' );
insert into employees (
   employee_id,
   name,
   role
) values ( 2,
           'Bob Designer',
           'Designer' );
insert into employees (
   employee_id,
   name,
   role
) values ( 3,
           'Carol Sales',
           'Sales Representative' );
insert into employees (
   employee_id,
   name,
   role
) values ( 4,
           'David Production',
           'Production Specialist' );
insert into employees (
   employee_id,
   name,
   role
) values ( 5,
           'Emma Quality',
           'Quality Assurance' );

commit;

-- ============================================================================
-- STORED PROCEDURES FOR REPORTS
-- ============================================================================
-- These procedures are designed to analyze different aspects of the greeting
-- card store business by aggregating data from multiple tables using complex
-- joins and grouping operations.
-- ============================================================================

-- ============================================================================
-- REPORT 1: Customer Order Summary
-- ============================================================================
-- PURPOSE: Analyze customer purchasing behavior over the last 12 months
-- 
-- PARAMETERS:
--   p_cursor OUT - Returns a cursor with customer order statistics
--
-- RETURNS:
--   - Customer name
--   - Number of orders placed by the customer
--   - Total amount spent by the customer
--
-- LOGIC:
--   1. JOINs customers table with orders table
--   2. Filters orders from the last 12 months (using ADD_MONTHS)
--   3. Groups results by customer (customer_id and name)
--   4. Filters out customers with zero total spending (HAVING clause)
--   5. Useful for identifying top customers and customer segments
-- ============================================================================
create or replace procedure get_customer_order_summary (
   p_cursor out sys_refcursor
) as
begin
   open p_cursor for 
   -- Select customer name and aggregate order statistics
    select c.name,
                            count(o.order_id) as order_count,      -- Number of orders
                            sum(o.total_amount) as total_spent     -- Total amount spent
                                         from customers c
                                         join orders o
                                       on c.customer_id = o.customer_id
                      where o.order_date >= add_months(
                        sysdate,
                        -12
                     )  -- Last 12 months
                      group by c.customer_id,
                               c.name
                     having sum(o.total_amount) > 0;  -- Only customers with purchases
end;
/

-- ============================================================================
-- REPORT 2: Popular Card Templates
-- ============================================================================
-- PURPOSE: Identify which card templates are most frequently ordered
--
-- PARAMETERS:
--   p_cursor OUT - Returns a cursor with template popularity data
--
-- RETURNS:
--   - Template name
--   - Number of items sold from that template
--
-- LOGIC:
--   1. JOINs card_templates -> designs -> order_items
--   2. Filters out items with zero quantity
--   3. Groups by template and counts sold items
--   4. Useful for inventory planning and marketing decisions
-- ============================================================================
create or replace procedure get_popular_templates (
   p_cursor out sys_refcursor
) as
begin
   open p_cursor for
   -- Select template popularity metrics
    select ct.name,
                            count(oi.item_id) as items_sold  -- Total items sold from template
                                         from card_templates ct
                                         join designs d
                                       on ct.template_id = d.template_id       -- Link templates to designs
                                         join order_items oi
                                       on d.design_id = oi.design_id      -- Link to actual orders
                      where oi.quantity > 0  -- Only items with valid quantities
                      group by ct.template_id,
                               ct.name
                     having count(oi.item_id) > 0;  -- Only templates with sales
end;
/

-- ============================================================================
-- REPORT 3: Supplier Material Usage
-- ============================================================================
-- PURPOSE: Track how much of each material from each supplier is used in orders
--
-- PARAMETERS:
--   p_cursor OUT - Returns a cursor with supplier and material usage data
--
-- RETURNS:
--   - Supplier name
--   - Material name
--   - Total quantity of that material used in all orders
--
-- LOGIC:
--   1. JOINs suppliers -> materials -> designs -> order_items
--   2. Follows supply chain: supplier provides material -> material used in design -> design in order
--   3. Filters out items with zero price (invalid entries)
--   4. Groups by supplier and material, sums quantities
--   5. Useful for vendor management and procurement decisions
-- ============================================================================
create or replace procedure get_supplier_material_usage (
   p_cursor out sys_refcursor
) as
begin
   open p_cursor for
   -- Select supplier and material consumption metrics
    select s.name as supplier_name,
                            m.name as material_name,
                            sum(oi.quantity) as total_used  -- Total quantity used across all orders
                                         from suppliers s
                                         join materials m
                                       on s.supplier_id = m.supplier_id         -- Supplier provides material
                                         join designs d
                                       on m.material_id = d.material_id            -- Material used in design
                                         join order_items oi
                                       on d.design_id = oi.design_id         -- Design ordered as items
                      where oi.price > 0  -- Only valid order items
                      group by s.supplier_id,
                               s.name,
                               m.material_id,
                               m.name
                     having sum(oi.quantity) > 0;  -- Only materials actually used
end;
/

-- ============================================================================
-- REPORT 4: Revenue by Template
-- ============================================================================
-- PURPOSE: Comprehensive revenue analysis by card template
--
-- PARAMETERS:
--   p_cursor OUT - Returns a cursor with detailed revenue metrics per template
--
-- RETURNS:
--   - Template name
--   - Base price of template
--   - Number of distinct orders containing this template
--   - Total quantity of items sold
--   - Total revenue generated (price * quantity for all items)
--
-- LOGIC:
--   1. JOINs card_templates -> designs -> order_items -> orders -> customers
--   2. Uses DISTINCT to count unique orders (not duplicate items)
--   3. Filters to last 12 months of orders
--   4. Groups by template and calculates aggregate revenue
--   5. Orders by total revenue descending (highest revenue first)
--   6. Useful for financial analysis and business performance tracking
-- ============================================================================
create or replace procedure get_revenue_by_template (
   p_cursor out sys_refcursor
) as
begin
   open p_cursor for
   -- Select comprehensive revenue metrics per template
    select ct.name as template_name,
                            ct.base_price,
                            count(distinct o.order_id) as order_count,          -- Unique orders
                            sum(oi.quantity) as total_quantity,                  -- Total items sold
                            sum(oi.price * oi.quantity) as total_revenue        -- Total revenue
                                         from card_templates ct
                                         join designs d
                                       on ct.template_id = d.template_id          -- Template -> Design
                                         join order_items oi
                                       on d.design_id = oi.design_id         -- Design -> Order Item
                                         join orders o
                                       on oi.order_id = o.order_id                 -- Order Item -> Order
                                         join customers c
                                       on o.customer_id = c.customer_id         -- Order -> Customer
                      where o.order_date >= add_months(
                        sysdate,
                        -12
                     )  -- Last 12 months only
                      group by ct.template_id,
                               ct.name,
                               ct.base_price
                     having sum(oi.price * oi.quantity) > 0  -- Only templates with revenue
                      order by total_revenue desc;  -- Sorted by revenue (highest first)
end;
/