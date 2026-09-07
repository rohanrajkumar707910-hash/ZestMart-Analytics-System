create database zestmart_db;

use zestmart_db

CREATE TABLE products (
    product_id    VARCHAR(10)    PRIMARY KEY,
    product_name  VARCHAR(100)   NOT NULL,
    category      VARCHAR(50),
    sub_category  VARCHAR(50),
    brand         VARCHAR(50),
    unit_price    DECIMAL(10,2),
    cost_price    DECIMAL(10,2),
    supplier      VARCHAR(100)
);

CREATE TABLE stores (
    store_id    VARCHAR(10)   PRIMARY KEY,
    store_name  VARCHAR(100)  NOT NULL,
    city        VARCHAR(50),
    state       VARCHAR(50),
    zone        VARCHAR(20),
    store_type  VARCHAR(20),
    manager     VARCHAR(100),
    open_date   DATE,
    sqft        INT
);

CREATE TABLE customers (
    customer_id   VARCHAR(10)   PRIMARY KEY,
    customer_name VARCHAR(100)  NOT NULL,
    city          VARCHAR(50),
    state         VARCHAR(50),
    gender        VARCHAR(10),
    age_group     VARCHAR(10),
    segment       VARCHAR(20),
    join_date     DATE,
    email         VARCHAR(100)
);

CREATE TABLE employees (
    employee_id   VARCHAR(10)   PRIMARY KEY,
    employee_name VARCHAR(100)  NOT NULL,
    store_id      VARCHAR(10),
    role          VARCHAR(50),
    department    VARCHAR(50),
    salary        DECIMAL(10,2),
    join_date     DATE,
    status        VARCHAR(20),
    FOREIGN KEY (store_id) REFERENCES stores(store_id)
);

create table sales (
sale_id varchar(10) primary key,
sale_date date not null,
product_id varchar(10),
customer_id varchar(10),
Store_id varchar(10),
quantity int,
discount_pct decimal(5,2),
foreign key (product_id) references products(product_id),
foreign key (customer_id) references customers(customer_id),
foreign key (store_id) references stores(store_id)
);

CREATE TABLE returns (
    return_id   VARCHAR(10)   PRIMARY KEY,
    sale_id     VARCHAR(10),
    return_date DATE,
    reason      VARCHAR(100),
    refund_amt  DECIMAL(10,2),
    FOREIGN KEY (sale_id) REFERENCES sales(sale_id)
);

Select * from customers;
select * from employees;
select * from products;
select * from returns;
select * from sales;
select * from stores;

-- show all record from sales table
select * from sales;

-- Show only selected columns
select  sale_id, sale_date, product_id, quantity
from sales; 

-- show sales from store S01 only
select * from sales 
where Store_id = 'S01'; 

-- Show S01 store sales where discount is more than 10%
select * from sales
where Store_id = 'S01'
and discount_pct > 10;

-- sort all sales from oldest to newest
select * from sales
order by sale_date asc;


-- sort all sales from newest to oldest
select * from sales
order by sale_date desc;

-- Show only the 10 most recent sales 
select * from sales
order by sale_date desc limit 10;

-- count how many sales each store made
select Store_id, count(*) Total_orders
from sales
group by Store_id
order by Total_orders desc;

-- Total Quantity sold for each product
select product_id, sum(quantity) Total_qty_sold
from sales
group by product_id
order by Total_Qty_sold desc;

-- Average discount given by each store
select Store_id, round(avg(discount_pct), 2) Avg_Discount
from sales
group by Store_id
order by Avg_Discount desc;

-- Show only stores that made more than 20 orders
select Store_id, count(*) Total_orders
from sales
group by Store_id
having total_orders > 20
order by Total_orders desc;

-- Products sold more than 30 times total
select product_id, sum(quantity) Total_Qty
from sales
group by product_id
having Total_qty > 30
order by Total_Qty desc;

-- show sales with product names (only matching records)
select
s.sale_id, s.sale_date, p.product_name, p.category, s.quantity, s.discount_pct
from sales s
inner join products p
on s.product_id = p.product_id
order by s.sale_date desc;
 
 -- show all customer even  if they never ordered
 select
 c.customer_name,c.city, c.segment, count(s.sale_id) Total_orders
 from customers c
 left join sales s 
 on s.customer_id = c.customer_id
 group by c.customer_id, c.customer_name, c.city, c.segment
 order by total_orders desc;
 
 -- Show all stores even if they have no sales
select
st.Store_id,st.city, st.store_type,
count(s.sale_id) Total_orders
from sales s
right join stores st
on s.Store_id = st.store_id
group by st.store_id, st.city, st.store_type
order by Total_orders desc;

-- Sales with product name, customer name and city
select
s.sale_id, s.sale_date,
p.product_name, p.category,
c.customer_name, c.city,
st.store_name,
s.quantity, s.discount_pct
from sales s
inner join products p
on s.product_id = p.product_id
inner join customers c
on s.customer_id = c.customer_id
inner join stores st
on s.store_id = st. store_id
order by sale_date desc;

-- All customers and all sales (matched + unmatched both)
select
c.customer_name, s.sale_id, s.sale_date
from customers c
left join sales s
on c.customer_id = s.customer_id

union

select
c.customer_name, s.sale_id, s.sale_date
from customers c
right join sales s
on c.customer_id = s.customer_id;

-- add a new product
insert into products
(product_id, product_name, category, sub_category, brand, unit_price, Cost_price, supplier)
values
('P021', 'Tata Salt 1kg', 'Grocery', 'Staples', 'Tata', 25, 15, 'Tata consumer');

SELECT * FROM products WHERE product_id = 'P021';

-- add multiple returns at once
insert into returns 
(return_id, sale_id, return_date, reason, refund_amt)
values
('RT021', 'SL0050', '2023-06-15', 'Defective product', 1499.00 ),
('RT022', 'SL0075', '2023-08-15', 'Wrong item delivered', 275.00 ),
('RT023','SL0100', '2023-09-10', 'Changed mind', 3499.00);

select * from returns order by return_id desc limit 5;

-- Update tata salt price
update products
set unit_price = 28,
cost_price = 17
where product_id = 'P021';

select * from products where product_id = 'P021' ;

-- give 10% salary hike to all sales department employees
update employees
set salary = salary *1.10
where department = 'Sales';

select * from employees where department = 'Sales';

-- Delete the product we just added
delete from products
where product_id = 'P021';

select * from products where product_id = 'P021';

-- Customers who ordered more then average orders
select customer_id, count(*) as total_orders
from sales 
group by customer_id
having total_orders > (
select avg(order_count) 
from (select customer_id, count(*) as order_count
from sales 
group by customer_id) as avg_table)
order by Total_orders desc;

-- Show products that have been sold at least done
select product_id, product_name, category, unit_price
from products
where product_id in (
select distinct product_id
from sales
)
order by category;

-- Product that were never sold
select product_id, product_name, category
from products
where product_id not in (
select distinct product_id
from sales
)
order by category;

-- Monthly revenue using CTE
with monthly_revenue as (
select 
month(sale_date) as month_num,
monthname(sale_date) as Month_name,
count(*) as Total_orders,
sum(quantity) as Total_qty
from sales
group by month(sale_date), monthname(sale_date)
)

select * from monthly_revenue
order by month_num;

-- Chain 2 CTEs together
with store_revenue as (
select
Store_id, count(*) Total_orders,
sum(quantity) Total_qty
from sales
group by Store_id
),
store_details as ( select
sr.store_id, st.city, st.store_type,
sr.Total_orders, sr.total_qty
from store_revenue sr
inner join stores st 
on sr.store_id = st.store_id
)
select * from store_details
order by total_orders desc;

-- Give a unique row number to each sale ordered by date
select 
row_number() over (order by sale_date desc) as row_num,
sale_id, sale_date, product_id, quantity
from sales;

-- Rank product by total quantity sold
select 
product_id,
sum(quantity) as Total_qty,
rank() over (order by sum(quantity) desc) as Rank_By_Qty
from sales
group by product_id;

-- Rank Customers by orders within each store
select
Store_id, customer_id, 
count(*) as Total_orders,
rank() over (
partition by Store_id
order by count(*) desc
) as store_rank
from sales
group by Store_id, customer_id
order by Store_id, store_rank;

-- Compare each sale quantity with previous sale 
select
sale_id, sale_date, quantity,
lag(quantity) over (order by sale_date) as prev_quantity,
quantity - lag(quantity) over (order by sale_date) as difference
from sales
order by sale_date;

-- compare each sale with next sale
select 
sale_id, sale_date, quantity,
lead(quantity) over (order by sale_date) as next_quantity,
lead(quantity) over (order by sale_date) - quantity as difference
from sales
order by sale_date;

-- Running total of quantity sold day by day
select
sale_date,
sum(quantity) as daily_qty,
sum(sum(quantity)) over (
order by sale_date
) as running_total
from sales
group by sale_date 
order by sale_date;

-- Check query performance BEFORE index
explain select * from sales
where Store_id = 'S01';

-- Create index on store_id
create index idx_store_id
on sales(store_id);

-- Check query performance AFTER index
explain select * from sales
where Store_id = 'S01';

-- Index on sale_date for data-based queries
create index idx_sale_date
on sales(sale_date);

-- index on product_id for join queries
create index idx_product_id
on sales(product_id);

-- composite index: store + data combo queries
create index idx_store_data
on sales(store_id, sale_date);

show indexes from sales;

-- This query will now use indexes automatically
SELECT s.sale_id, s.sale_date,
       p.product_name, p.category,
       c.customer_name, c.city,
       s.quantity
FROM sales s
INNER JOIN products p  ON s.product_id  = p.product_id
INNER JOIN customers c ON s.customer_id = c.customer_id
WHERE s.store_id = 'S01'
AND s.sale_date BETWEEN '2023-01-01' AND '2023-06-30'
ORDER BY s.sale_date DESC;

EXPLAIN SELECT s.sale_id, s.sale_date,
       p.product_name, p.category,
       c.customer_name, c.city,
       s.quantity
FROM sales s
INNER JOIN products p  ON s.product_id  = p.product_id
INNER JOIN customers c ON s.customer_id = c.customer_id
WHERE s.store_id = 'S01'
AND s.sale_date BETWEEN '2023-01-01' AND '2023-06-30'
ORDER BY s.sale_date DESC;
