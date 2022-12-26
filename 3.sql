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
    passport varchar(20) NOT NULL UNIQUE CHECK (passport ~ '^[0-9]{10}$'),
    phone varchar(20) UNIQUE CHECK (phone ~ '^\+7[0-9]{10}$'),
    email text CHECK (email ~ '^[a-z0-9]+@[a-z0-9]+\.[a-z0-9]+$')
);

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
    company_id integer REFERENCES companies (company_id)  ON DELETE CASCADE,
    first_name varchar(20) CHECK (first_name != ''),
    last_name varchar(20) CHECK (last_name != ''),
    job_title text,
    gross integer CHECK (gross > 10000)
);

--Создание таблицы с информацией о самолётах
DROP TABLE IF EXISTS airplanes CASCADE;
CREATE TABLE airplanes(
    airplane_id serial PRIMARY KEY NOT NULL,
    company_id integer REFERENCES companies (company_id) ON DELETE CASCADE,
    manufacturer text NOT NULL,
    airplane_name text NOT NULL UNIQUE,
    date_of_create date NOT NULL
);

-- Создание таблицы с информацией о рейсах
DROP TABLE IF EXISTS flights CASCADE;
CREATE TABLE flights(
    flight_id serial PRIMARY KEY NOT NULL,
    company_id integer REFERENCES companies (company_id) ON DELETE CASCADE,
    airplane_id integer REFERENCES airplanes (airplane_id) ON DELETE CASCADE,
    number varchar(20),
    start_time timestamp NOT NULL,
    end_time timestamp NOT NULL CHECK(end_time > start_time),
    start_city varchar(20) NOT NULL,
    end_city varchar(20) NOT NULL
);

-- Хотелось бы такие проверки добавить, но нельзя(
-- ALTER TABLE flights
--     ADD CONSTRAINT start_time_check CHECK(flights.start_time > (SELECT planes.date_of_create FROM airplanes as planes where planes.airplane_id = flights.airplane_id));

-- Создание таблицы с информацией о версиях рейсов
DROP TABLE IF EXISTS flights_history;
CREATE TABLE flights_history(
    id serial PRIMARY KEY NOT NULL,
    flight_id integer REFERENCES flights (flight_id) ON DELETE CASCADE,
    company_id integer REFERENCES companies (company_id) ON DELETE CASCADE,
    airplane_id integer REFERENCES airplanes (airplane_id) ON DELETE CASCADE,
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
    id integer REFERENCES  flights(flight_id) ON DELETE CASCADE
);

-- Создание таблицы с информацией о билетах
DROP TABLE IF EXISTS tickets CASCADE;
CREATE TABLE tickets(
    ticket_id serial PRIMARY KEY NOT NULL,
    passenger_id integer REFERENCES passengers (passenger_id) ON DELETE CASCADE,
    flight_id integer REFERENCES flights (flight_id) ON DELETE CASCADE,
    number varchar(20) CHECK (number ~ '^[0-9]{1}[0-9]{1}[A-Z]{1}$'),
    cost real DEFAULT 100
);

--Создание таблицы с информацией о расписании работников
DROP TABLE IF EXISTS schedule_employees;
CREATE TABLE schedule_employees(
    flight_id integer REFERENCES flights (flight_id) ON DELETE CASCADE,
    employee_id integer REFERENCES employees (employee_id) ON DELETE CASCADE,
    PRIMARY KEY (flight_id, employee_id)
);