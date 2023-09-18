--DDL
CREATE TABLE dim_customers (
  customer_id varchar(50) NOT NULL, 
  customer_city varchar(255), 
  customer_state varchar(255), 
  PRIMARY KEY (customer_id)
);
CREATE TABLE dim_delivery (
  delivery_id varchar(50) NOT NULL, 
  customer_id varchar(50) NOT NULL, 
  order_status varchar(20), 
  order_delivered_carrier_date timestamp NULL, 
  order_delivered_customer_date timestamp NULL, 
  order_estimated_delivery_date date, 
  PRIMARY KEY (delivery_id)
);
CREATE TABLE dim_products (
  product_id varchar(50) NOT NULL, 
  product_weight_g int(10), 
  product_length_cm int(10), 
  product_height_cm int(10), 
  product_width_cm int(10), 
  PRIMARY KEY (product_id)
);
CREATE TABLE dim_sellers (
  seller_id varchar(50) NOT NULL, 
  seller_city varchar(255), 
  seller_state varchar(255), 
  PRIMARY KEY (seller_id)
);
CREATE TABLE fact_orders (
  order_id varchar(50) NOT NULL, 
  product_id varchar(50) NOT NULL, 
  seller_id varchar(50) NOT NULL, 
  shipping_limit_date timestamp NULL, 
  price numeric(19, 2), 
  freight_value numeric(19, 2)
);
ALTER TABLE 
  fact_orders 
ADD 
  CONSTRAINT FKfact_order196753 FOREIGN KEY (product_id) REFERENCES dim_products (product_id);
ALTER TABLE 
  fact_orders 
ADD 
  CONSTRAINT FKfact_order856256 FOREIGN KEY (seller_id) REFERENCES dim_sellers (seller_id);
ALTER TABLE 
  fact_orders 
ADD 
  CONSTRAINT FKfact_order888844 FOREIGN KEY (order_id) REFERENCES dim_delivery (delivery_id);
ALTER TABLE 
  dim_delivery 
ADD 
  CONSTRAINT FKdim_delive465508 FOREIGN KEY (customer_id) REFERENCES dim_customers (customer_id);


--DML
INSERT INTO dim_customers 
SELECT DISTINCT 
	customer_id, 
	customer_city, 
	customer_state  
FROM customers;

INSERT INTO dim_sellers 
SELECT DISTINCT 
	seller_id, 
	seller_city, 
	seller_state  
FROM sellers;

INSERT INTO dim_products
SELECT DISTINCT 
	product_id, 
	product_weight_g, 
	product_length_cm, 
	product_height_cm, 
	product_width_cm  
FROM products 

INSERT INTO dim_delivery
SELECT
	order_id,
	customer_id,
	order_status, 
	order_delivered_carrier_date, 
	order_delivered_customer_date, 
	order_estimated_delivery_date 
FROM orders;

INSERT INTO fact_orders
SELECT 
	order_id, 
  	product_id, 
  	seller_id, 
  	shipping_limit_date,
  	price, 
  	freight_value
FROM order_items;


