-- create schema
DROP SCHEMA IF EXISTS view_airport CASCADE;
CREATE SCHEMA view_airport;

SET SEARCH_PATH = view_airport;

-- create views
--- airplane
DROP VIEW IF EXISTS view_airplane;
CREATE VIEW view_airplane AS
    SELECT  airplane_name  as "name",
            manufacturer   as "manufacturer",
            date_of_create as "date"
    FROM airport_db.airplanes
    WHERE company_id < 10;

--- companies
DROP VIEW IF EXISTS view_companies;
CREATE VIEW view_companies AS
    SELECT  company_name  as "name"
    FROM airport_db.companies;

--- employees
DROP VIEW IF EXISTS view_employees;
CREATE VIEW view_employees AS
    SELECT  first_name || ' ' || last_name as "full_name",
            job_title as "job_title",
            gross as "gross"
    FROM airport_db.employees;

--- flights
DROP VIEW IF EXISTS view_flights;
CREATE VIEW view_flights AS
    SELECT f.number as "number",
           c.company_name as "company_name",
           a.airplane_name as "airplane_name",
           f.start_time as "start_time",
           f.end_time as "end_time",
           f.start_city as "start_city",
           f.end_city as "end_city"
    FROM airport_db.flights f
        INNER JOIN airport_db.companies c on f.company_id = c.company_id
        INNER JOIN airport_db.airplanes a on a.airplane_id = f.airplane_id;

--- flights_history
DROP VIEW IF EXISTS view_flights_history;
CREATE VIEW view_flights_history AS
    SELECT number as "number",
           start_time as "start_time",
           end_time as "end_time",
           start_city as "start_city",
           end_city as "end_city",
           update_time as "update_time"
    FROM airport_db.flights_history;

--- passengers
DROP VIEW IF EXISTS view_passengers;
CREATE VIEW view_passengers AS
    SELECT first_name || ' ' || last_name as "full_name",
           REGEXP_REPLACE(passport::text, '..........', '**********', 'g'),
           phone as "phone",
           email as "email"
    FROM airport_db.passengers;

--- schedule
DROP VIEW IF EXISTS view_schedule;
CREATE VIEW view_schedule AS
    SELECT *
    FROM airport_db.schedule;

--- schedule_employees
DROP VIEW IF EXISTS view_schedule_employees;
CREATE VIEW view_schedule_employees AS
    SELECT e.first_name || ' ' || e.last_name as "full_name",
           a.airplane_name as "airplane_name",
           f.number as "number_flight"
    FROM airport_db.schedule_employees se
        inner join airport_db.flights f on se.flight_id = f.flight_id
        inner join airport_db.airplanes a on a.airplane_id = f.airplane_id
        inner join airport_db.employees e on se.employee_id = e.employee_id;

--- tickets
DROP VIEW IF EXISTS view_tickets;
CREATE VIEW view_tickets AS
    SELECT p.first_name || ' ' || p.last_name as "full_name",
           t.number as "seat"
    FROM airport_db.tickets t
        inner join airport_db.passengers p on t.passenger_id = p.passenger_id;
