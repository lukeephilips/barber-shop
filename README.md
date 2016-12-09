CREATE DATABASE barber_shop;
\c barber_shop;
CREATE TABLE barbers (name varchar, specialty varchar, id serial PRIMARY KEY);
CREATE TABLE clients (name varchar, barber_id int, id serial PRIMARY KEY);
CREATE DATABASE barber_shop_test WITH TEMPLATE barber_shop;
