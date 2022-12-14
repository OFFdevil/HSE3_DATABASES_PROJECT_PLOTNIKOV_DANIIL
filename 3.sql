DROP SCHEMA IF EXISTS airport_db CASCADE;
CREATE SCHEMA airport_db;

SET SEARCH_PATH = airport_db;

-- Создание таблиц

-- Создание таблицы с информацией о пользователях
DROP TABLE IF EXISTS passengers CASCADE;
CREATE TABLE passengers(
    passenger_id serial PRIMARY KEY NOT NULL,
    first_name varchar(20) CHECK (first_name != ''),
    last_name varchar(20) CHECK (last_name != ''),
    date_birth date,
    passport varchar(20) NOT NULL UNIQUE CHECK (passport like '____ ______'),
    phone varchar(20) UNIQUE,
    email text
);

insert into passengers
    (first_name,
     last_name,
     passport)
    values
    ('123',
     'hello',
     '1234 123456');

-- Создание таблицы с информацией о компаниях
DROP TABLE IF EXISTS companies CASCADE;
CREATE TABLE companies(
    company_id serial PRIMARY KEY NOT NULL,
    company_name text NOT NULL UNIQUE,
    headquarters text
);

-- Создание таблицы с информацией о сотрудниках
DROP TABLE IF EXISTS employees CASCADE;
CREATE TABLE employees(
    employee_id serial PRIMARY KEY NOT NULL,
    company_id integer REFERENCES companies (company_id),
    first_name varchar(20) CHECK (first_name != ''),
    last_name varchar(20) CHECK (last_name != ''),
    job_title text,
    gross integer CHECK (gross > 10000)
);

--Создание таблицы с информацией о самолётах
DROP TABLE IF EXISTS airplanes CASCADE;
CREATE TABLE airplanes(
    airplane_id serial PRIMARY KEY NOT NULL,
    company_id integer REFERENCES companies (company_id),
    manufacturer text NOT NULL,
    airplane_name text NOT NULL UNIQUE,
    date_of_create date
);

-- Создание таблицы с информацией о рейсах
DROP TABLE IF EXISTS flights CASCADE;
CREATE TABLE flights(
    flight_id serial PRIMARY KEY NOT NULL,
    company_id integer REFERENCES companies (company_id),
    airplane_id integer REFERENCES airplanes (airplane_id),
    number varchar(20),
    start_time timestamp NOT NULL,
    end_time timestamp NOT NULL,
    start_city varchar(20) NOT NULL,
    end_city varchar(20) NOT NULL
);

-- Создание таблицы с информацией о версиях рейсов
DROP TABLE IF EXISTS flights_history CASCADE;
CREATE TABLE flights_history(
    id serial PRIMARY KEY NOT NULL,
    flight_id integer REFERENCES flights (flight_id),
    company_id integer REFERENCES companies (company_id),
    airplane_id integer REFERENCES airplanes (airplane_id),
    number varchar(20),
    start_time timestamp NOT NULL,
    end_time timestamp NOT NULL,
    start_city varchar(20) NOT NULL,
    end_city varchar(20) NOT NULL,
    update_time timestamp DEFAULT current_timestamp
);

-- Создание таблицы с информацией о расписании
DROP TABLE IF EXISTS schedule CASCADE;
CREATE TABLE schedule(
    id integer REFERENCES  flights(flight_id),
    CONSTRAINT PI
);

-- Создание таблицы с информацией о билетах
DROP TABLE IF EXISTS tickets CASCADE;
CREATE TABLE tickets(
    ticket_id serial PRIMARY KEY NOT NULL,
    passenger_id integer REFERENCES passengers (passenger_id),
    flight_id integer REFERENCES flights (flight_id),
    number varchar(20)
);

--Создание таблицы с информацией о расписании работников
DROP TABLE IF EXISTS schedule_employees CASCADE;
CREATE TABLE schedule_employees(
    flight_id integer REFERENCES flights (flight_id),
    employee_id integer REFERENCES employees (employee_id),
    PRIMARY KEY (flight_id, employee_id)
);