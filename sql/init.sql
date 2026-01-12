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

-- Insert Orders
insert into orders (
   order_id,
   customer_id,
   order_date,
   total_amount
) values ( 1,
           1,
           sysdate,
           10.00 );
insert into orders (
   order_id,
   customer_id,
   order_date,
   total_amount
) values ( 2,
           2,
           sysdate,
           14.00 );

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

commit;

-- Stored procedures for reports

-- Report 1: Customer order summary (complexity 4: JOIN, WHERE, GROUP BY, HAVING)
create or replace procedure get_customer_order_summary (
   p_cursor out sys_refcursor
) as
begin
   open p_cursor for select c.name,
                            count(o.order_id) as order_count,
                            sum(o.total_amount) as total_spent
                                         from customers c
                                         join orders o
                                       on c.customer_id = o.customer_id
                      where o.order_date >= add_months(
                        sysdate,
                        -12
                     )
                      group by c.customer_id,
                               c.name
                     having sum(o.total_amount) > 0;
end;
/

-- Report 2: Popular templates (complexity 5: JOIN, JOIN, WHERE, GROUP BY, HAVING)
create or replace procedure get_popular_templates (
   p_cursor out sys_refcursor
) as
begin
   open p_cursor for select ct.name,
                            count(oi.item_id) as items_sold
                                         from card_templates ct
                                         join designs d
                                       on ct.template_id = d.template_id
                                         join order_items oi
                                       on d.design_id = oi.design_id
                      where oi.quantity > 0
                      group by ct.template_id,
                               ct.name
                     having count(oi.item_id) > 0;
end;
/

-- Report 3: Supplier material usage (complexity 6: JOIN, JOIN, JOIN, WHERE, GROUP BY, HAVING)
create or replace procedure get_supplier_material_usage (
   p_cursor out sys_refcursor
) as
begin
   open p_cursor for select s.name as supplier_name,
                            m.name as material_name,
                            sum(oi.quantity) as total_used
                                         from suppliers s
                                         join materials m
                                       on s.supplier_id = m.supplier_id
                                         join designs d
                                       on m.material_id = d.material_id
                                         join order_items oi
                                       on d.design_id = oi.design_id
                      where oi.price > 0
                      group by s.supplier_id,
                               s.name,
                               m.material_id,
                               m.name
                     having sum(oi.quantity) > 0;
end;
/

-- Report 4: Revenue by template (complexity 7: JOIN, JOIN, JOIN, JOIN, WHERE, GROUP BY, HAVING)
create or replace procedure get_revenue_by_template (
   p_cursor out sys_refcursor
) as
begin
   open p_cursor for select ct.name as template_name,
                            ct.base_price,
                            count(distinct o.order_id) as order_count,
                            sum(oi.quantity) as total_quantity,
                            sum(oi.price * oi.quantity) as total_revenue
                                         from card_templates ct
                                         join designs d
                                       on ct.template_id = d.template_id
                                         join order_items oi
                                       on d.design_id = oi.design_id
                                         join orders o
                                       on oi.order_id = o.order_id
                                         join customers c
                                       on o.customer_id = c.customer_id
                      where o.order_date >= add_months(
                        sysdate,
                        -12
                     )
                      group by ct.template_id,
                               ct.name,
                               ct.base_price
                     having sum(oi.price * oi.quantity) > 0
                      order by total_revenue desc;
end;
/