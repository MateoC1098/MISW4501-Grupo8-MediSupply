DROP TABLE IF EXISTS role_permissions;
DROP TABLE IF EXISTS user_roles;
DROP TABLE IF EXISTS permissions;
DROP TABLE IF EXISTS roles;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS products;

CREATE TABLE users (
    id serial primary key,
    username varchar(50) unique not null,
    password varchar(255) not null,
    email varchar(200) unique not null,
    is_active boolean default true,
    attempt_login int default 0,
    role varchar(20) default 'user',
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp
);

INSERT INTO public.users (username, password, email, is_active, attempt_login, role)
VALUES ('admin', '$2b$10$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36c6Bq9V8zzmJ3VM0gW7rG', 'admin@example.com', true, 0, 'admin');
-- Password is 'password' hashed with bcrypt
INSERT INTO public.users (username, password, email, is_active, attempt_login, role)
VALUES ('worker1', '$2b$10$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36c6Bq9V8zzmJ3VM0gW7rG', 'worker1@example.com', true, 0, 'worker');
-- Password is 'password' hashed with bcrypt
INSERT INTO public.users (username, password, email, is_active, attempt_login, role)
VALUES ('user1', '$2b$10$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36c6Bq9V8zzmJ3VM0gW7rG', 'user1@example.com', true, 0, 'user');  
-- Password is 'password' hashed with bcrypt
INSERT INTO public.users (username, password, email, is_active, attempt_login, role)       
VALUES ('user2', '$2b$10$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36c6Bq9V8zzmJ3VM0gW7rG', 'user2@example.com', true, 0, 'user');
-- Password is 'password' hashed with bcrypt
INSERT INTO public.users (username, password, email, is_active, attempt_login, role)
VALUES ('guest1', '$2b$10$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36c6Bq9V8zzmJ3VM0gW7rG', 'guest1@example.com', true, 0, 'guest');
-- Password is 'password' hashed with bcrypt

CREATE TABLE roles (
    role varchar(20) primary key,
    description text,
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp
);

INSERT INTO roles (role, description) VALUES 
('admin', 'Administrator with full access'),
('worker', 'Worker with limited administrative access'),
('user', 'Regular user with limited access'),
('guest', 'Guest user with minimal access');

CREATE TABLE user_roles (
    user_id int references users(id) on delete cascade,
    role varchar(20) references roles(role) on delete cascade,
    primary key (user_id, role),
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp
);

CREATE TABLE permissions (
    id serial primary key,
    permission varchar(50) unique not null,
    description text,
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp
);

INSERT INTO permissions (permission, description) VALUES 
('create_user', 'Permission to create a new user'),
('read_user', 'Permission to read user information'),
('update_user', 'Permission to update user information'),
('delete_user', 'Permission to delete a user'),
('create_role', 'Permission to create a new role'),
('read_role', 'Permission to read role information'),
('update_role', 'Permission to update role information'),
('delete_role', 'Permission to delete a role'),
('create_permission', 'Permission to create a new permission'),
('read_permission', 'Permission to read permission information'),
('update_permission', 'Permission to update permission information'),
('delete_permission', 'Permission to delete a permission');

CREATE TABLE role_permissions (
    role varchar(20) references roles(role) on delete cascade,
    permission_id int references permissions(id) on delete cascade,
    primary key (role, permission_id),
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp
);

INSERT INTO role_permissions (role, permission_id) VALUES 
('admin', 1),
('admin', 2),
('admin', 3),
('admin', 4),
('admin', 5),
('admin', 6),
('admin', 7),
('admin', 8),
('admin', 9),
('admin', 10),
('admin', 11),
('admin', 12),
('worker', 2),
('worker', 3),
('worker', 5),
('worker', 6),
('worker', 9),
('worker', 10),
('user', 2),
('user', 5),
('user', 9),
('guest', 2);

CREATE TABLE products (
    id serial primary key,
    name varchar(100) not null,
    description text,
    type varchar(50),
    price numeric(10,2) not null,
    regulations text,
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp
);

INSERT INTO products (name, description, type, price, regulations) VALUES
('Product A', 'Description for Product A', 'Type 1', 19.99, 'Regulation A'),
('Product B', 'Description for Product B', 'Type 2', 29.99, 'Regulation B'),
('Product C', 'Description for Product C', 'Type 1', 39.99, 'Regulation C');

INSERT INTO permissions (permission, description) VALUES 
('create_product', 'Permission to create a new product'),
('read_product', 'Permission to read product information'),
('update_product', 'Permission to update product information'),
('delete_product', 'Permission to delete a product');

INSERT INTO role_permissions (role, permission_id) VALUES 
('admin', 13),
('admin', 14),
('admin', 15),
('admin', 16),
('worker', 14),
('worker', 15),
('user', 14);

