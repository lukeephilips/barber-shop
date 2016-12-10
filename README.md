

# Barber shop
==========================

#### _wait list app for barbershop, December 9, 2016_

#### By _**Luke Philips**_

## Description

_allows customers to sign in, assigns a barber based on matching their input to available barbers' specialties - assigning to next available if no hits. Also allows barber to clear their schedule and revert all appointments back to next available. allows barber to complete appointments by deleting customer objects. Also has wait time based on total customers minus total barbers_


## Instructions:

* clone from Github, bundle Gemfile, create DB (below), launch with sinatra

* db instructions:

CREATE DATABASE barber_shop;
\c barber_shop;
CREATE TABLE barbers (name varchar, specialty varchar, id serial PRIMARY KEY);
CREATE TABLE clients (name varchar, preference varchar, barber_id int, barber_name varchar, id serial PRIMARY KEY);
CREATE DATABASE barber_shop_test WITH TEMPLATE barber_shop;

## Support and contact details

Check my GitHub:
* _[Luke Philips](https://github.com/lukeephilips)_

## Technologies Used

_Made with Ruby on Sinatra, postgreSQL, unit testing with rspec, integration testing with Capybara._

### License

*Created under an MIT license.*

Copyright (c) 2016 **_Luke Philips_**
