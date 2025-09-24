drop table if exists users;

Create table users (
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
VALUES ('user1', '$2b$10$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36c6Bq9V8zzmJ3VM0gW7rG', 'user1@example.com', true, 0, 'user');  
-- Password is 'password' hashed with bcrypt
INSERT INTO public.users (username, password, email, is_active, attempt_login, role)       
VALUES ('user2', '$2b$10$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36c6Bq9V8zzmJ3VM0gW7rG', 'user2@example.com', true, 0, 'user');
-- Password is 'password' hashed with bcrypt
