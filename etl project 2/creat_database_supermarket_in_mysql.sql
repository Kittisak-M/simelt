-- create db and use the db to create tables and schema
CREATE DATABASE supermarket;
USE supermarket;

-- branch
CREATE TABLE branch (
  branch_id INT PRIMARY KEY AUTO_INCREMENT,
  branch_type VARCHAR(50),
  city VARCHAR(50),
  country VARCHAR(50),
  phone_number VARCHAR(50),
  shop_open_date DATE
);

-- employees
CREATE TABLE employees (
  employee_id INT PRIMARY KEY AUTO_INCREMENT,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  position VARCHAR(50),
  branch_id INT,
  salary DECIMAL(10,2),
  hire_date DATE,
  termination_date DATE,
  email VARCHAR(100),
  phone VARCHAR(50),
  is_active INT,
  FOREIGN KEY (branch_id) REFERENCES branch(branch_id)
);

-- payments
CREATE TABLE payments (
  payment_id INT PRIMARY KEY AUTO_INCREMENT,
  payment_method VARCHAR(20),
  transaction_id VARCHAR(100),
  billing_address VARCHAR(200),
  billing_city VARCHAR(50),
  billing_country VARCHAR(50),
  payment_note VARCHAR(255)
);

-- customers
CREATE TABLE customers (
  customer_id INT PRIMARY KEY AUTO_INCREMENT,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  email VARCHAR(100),
  phone VARCHAR(20),
  address VARCHAR(200),
  city VARCHAR(50),
  country VARCHAR(50),
  registration_date DATE
);

-- orders
CREATE TABLE orders (
  order_id INT PRIMARY KEY AUTO_INCREMENT,
  customer_id INT,
  payment_id INT UNIQUE,
  employee_id INT,
  branch_id INT,
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
  FOREIGN KEY (payment_id) REFERENCES payments(payment_id),
  FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
  FOREIGN KEY (branch_id) REFERENCES branch(branch_id)
);

-- products
CREATE TABLE products (
  product_id INT PRIMARY KEY AUTO_INCREMENT,
  product_name VARCHAR(100),
  category_name VARCHAR(50)
);

-- products_in_customers_orders
CREATE TABLE products_in_customers_orders (
  order_id INT,
  product_id INT,
  order_date DATE,
  amount DECIMAL(15,2),
  quantities INT,
  PRIMARY KEY (order_id, product_id),
  FOREIGN KEY (order_id) REFERENCES orders(order_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- suppliers
CREATE TABLE suppliers (
  supplier_id INT PRIMARY KEY AUTO_INCREMENT,
  supplier_name VARCHAR(100),
  contact_name VARCHAR(50),
  contact_email VARCHAR(100),
  contact_phone VARCHAR(50),
  address VARCHAR(200),
  city VARCHAR(50),
  country VARCHAR(50)
);

-- product_orders
CREATE TABLE product_orders (
  supplier_purchase_order_id INT PRIMARY KEY AUTO_INCREMENT UNIQUE,
  employee_id INT,
  branch_id INT,
  order_date DATE,
  FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
  FOREIGN KEY (branch_id) REFERENCES branch(branch_id)
);

-- products_in_supplier_orders
CREATE TABLE products_in_supplier_orders (
  supplier_purchase_order_id INT,
  supplier_id INT,
  product_id INT,
  arrival_date DATE,
  quantity INT,
  unit_price DECIMAL(10,2),
  PRIMARY KEY (supplier_purchase_order_id, product_id),
  FOREIGN KEY (supplier_purchase_order_id) REFERENCES product_orders(supplier_purchase_order_id),
  FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- inventory
CREATE TABLE inventory (
  product_id INT,
  branch_id INT,
  quantity INT,
  last_updated DATE,
  PRIMARY KEY (product_id, branch_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id),
  FOREIGN KEY (branch_id) REFERENCES branch(branch_id)
);
