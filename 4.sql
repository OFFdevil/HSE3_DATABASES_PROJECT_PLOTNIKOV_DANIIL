SET SEARCH_PATH = airport_db;

-- Add to passengers
INSERT INTO passengers(first_name, last_name, date_birth, passport, phone)
                VALUES('Mike', 'Ivanov', '19990108', '1111111111', '+70123456789');

INSERT INTO passengers(first_name, last_name, date_birth, passport, phone, email)
                VALUES('Mark', 'Facebook', '19840514', '0000000000', '+71231231231', 'prosto@email.com');

INSERT INTO passengers(first_name, last_name, date_birth, passport, email)
                VALUES('Vlada', 'Makedonskay', '19350329', '3333222211', 'halyavapridi@hse.ru');

INSERT INTO passengers(first_name, last_name, date_birth, passport, email)
                VALUES('Tatyana', 'Petrova', '20030411', '2222222211', 'simpledimple@mipt.ex');

INSERT INTO passengers(first_name, last_name, passport)
                VALUES('Anton', 'Horoschevich', '9999222211');

INSERT INTO passengers(first_name, last_name, passport)
                VALUES('Anton', 'Mikailov', '9923222211');

INSERT INTO passengers(first_name, last_name, passport)
                VALUES('Genadiy', 'Plotnikov', '5823222211');

INSERT INTO passengers(first_name, last_name, passport)
                VALUES('David', 'Dava', '0923452211');

INSERT INTO passengers(first_name, last_name, passport)
                VALUES('Andrei', 'Malakhov', '0000000001');

INSERT INTO passengers(first_name, last_name, passport)
                VALUES('Eva', 'Elfie', '6969696969');

-- Add to companies
INSERT INTO companies(company_name, headquarters)
                VALUES('S7', 'Moskva');

INSERT INTO companies(company_name, headquarters)
                VALUES('Aeroflot', 'Moskva');

INSERT INTO companies(company_name)
                VALUES('Pobeda');

INSERT INTO companies(company_name)
                VALUES('Nordwind');

INSERT INTO companies(company_name, headquarters)
                VALUES('LetayushijKavkazec', 'Krasnodar');

-- Add to airplanes
INSERT INTO airplanes(company_id, manufacturer, airplane_name, date_of_create)
            VALUES ('1', 'Donetsk', 'RUSSIA-1', '20220224');

INSERT INTO airplanes(company_id, manufacturer, airplane_name, date_of_create)
            VALUES ('1', 'Moskva', 'RUSSIA-2', '20190305');

INSERT INTO airplanes(company_id, manufacturer, airplane_name, date_of_create)
            VALUES ('2', 'Rostov', 'RUSSIA-3', '20220802');

INSERT INTO airplanes(company_id, manufacturer, airplane_name, date_of_create)
            VALUES ('4', 'Ulyanovsk', 'Wind-1', '20100723');

INSERT INTO airplanes(company_id, manufacturer, airplane_name, date_of_create)
            VALUES ('4', 'Ulyanovsk', 'Wind-2', '20100927');

INSERT INTO airplanes(company_id, manufacturer, airplane_name, date_of_create)
            VALUES ('4', 'Ulyanovsk', 'Wind-3', '20101031');

INSERT INTO airplanes(company_id, manufacturer, airplane_name, date_of_create)
            VALUES ('5', 'Groznyj', 'UfUf', '20081224');

INSERT INTO airplanes(company_id, manufacturer, airplane_name, date_of_create)
            VALUES ('5', 'Groznyj', 'Priora', '20090909');

INSERT INTO airplanes(company_id, manufacturer, airplane_name, date_of_create)
            VALUES ('5', 'Groznyj', 'Gonec', '20000101');

-- Add to employees
INSERT INTO employees(company_id, first_name, last_name, job_title, gross)
            VALUES(1, 'Daniel', 'Zanovski', 'pilot', '100000');

INSERT INTO employees(company_id, first_name, last_name, job_title, gross)
            VALUES(2, 'Victor', 'Abrosimov', 'pilot', '200000');

INSERT INTO employees(company_id, first_name, last_name, job_title, gross)
            VALUES(3, 'Georgiy', 'Vorona', 'pilot', '250000');

INSERT INTO employees(company_id, first_name, last_name, job_title, gross)
            VALUES(4, 'Lev', 'Liveev', 'pilot', '130000');

INSERT INTO employees(company_id, first_name, last_name, job_title, gross)
            VALUES(5, 'Alex', 'Foreigner', 'pilot', '180000');

INSERT INTO employees(company_id, first_name, last_name, job_title, gross)
            VALUES(5, 'Magomed', 'Groznyi', 'pilot', '90000');

INSERT INTO employees(company_id, first_name, last_name, job_title, gross)
            VALUES(5, 'Maga', 'Velikiy', 'pilot', '1000000');

-- Add to flights
INSERT INTO flights(company_id, airplane_id, number, start_time, end_time, start_city, end_city)
            VALUES(1, 3, 'SU-1234', '2022-10-19 10:25:00', '2022-10-19 17:55:00', 'Moscow', 'Vladivostok');

INSERT INTO flights(company_id, airplane_id, number, start_time, end_time, start_city, end_city)
            VALUES(3, 5, 'SE-1111', '2022-09-20 10:25:00', '2022-09-20 11:55:00', 'Moscow', 'Krasnodar');

INSERT INTO flights(company_id, airplane_id, number, start_time, end_time, start_city, end_city)
            VALUES(2, 3, 'FK-1234', '2022-10-20 10:25:00', '2022-10-20 11:55:00', 'Moscow', 'Krasnodar');

INSERT INTO flights(company_id, airplane_id, number, start_time, end_time, start_city, end_city)
            VALUES(5, 8, 'EE-1234', '2022-11-20 10:25:00', '2022-11-22 11:55:00', 'Groznyj', 'Krasnodar');

INSERT INTO flights(company_id, airplane_id, number, start_time, end_time, start_city, end_city)
            VALUES(5, 9, 'UF-6666', '2022-11-27 21:10:00', '2022-11-29 21:05:00', 'Groznyj', 'Sochi');

INSERT INTO flights(company_id, airplane_id, number, start_time, end_time, start_city, end_city)
            VALUES(1, 3, 'PO-9999', '2022-10-20 10:25:00', '2022-10-20 17:55:00', 'Krasnodar', 'Vladivostok');

INSERT INTO flights(company_id, airplane_id, number, start_time, end_time, start_city, end_city)
            VALUES(1, 3, 'FE-3423', '2022-10-21 10:25:00', '2022-10-21 17:55:00', 'Rostov', 'Belgorod');

INSERT INTO flights(company_id, airplane_id, number, start_time, end_time, start_city, end_city)
            VALUES(3, 5, 'FU-1523', '2022-08-21 10:25:00', '2022-08-21 14:55:00', 'Moscow', 'Sochi');

INSERT INTO flights(company_id, airplane_id, number, start_time, end_time, start_city, end_city)
            VALUES(3, 7, 'KE-7345', '2022-10-21 10:25:00', '2022-10-21 17:55:00', 'Sochi', 'Krasnodar');

INSERT INTO flights(company_id, airplane_id, number, start_time, end_time, start_city, end_city)
            VALUES(3, 2, 'ZU-6345', '2022-08-19 23:25:00', '2022-08-20 00:55:00', 'Rostov', 'Krasnodar');

-- Add to schedule
INSERT INTO schedule(id) VALUES (1);
INSERT INTO schedule(id) VALUES (2);
INSERT INTO schedule(id) VALUES (3);
INSERT INTO schedule(id) VALUES (4);
INSERT INTO schedule(id) VALUES (5);
INSERT INTO schedule(id) VALUES (6);
INSERT INTO schedule(id) VALUES (7);
INSERT INTO schedule(id) VALUES (8);
INSERT INTO schedule(id) VALUES (9);
INSERT INTO schedule(id) VALUES (10);

-- Add to flights_history
INSERT INTO flights_history(flight_id, company_id, airplane_id, number, start_time, end_time, start_city, end_city)
            VALUES(4, 5, 8, 'EE-1234', '2022-11-20 10:25:00', '2022-11-21 11:55:00', 'Groznyj', 'Krasnodar');

INSERT INTO flights_history(flight_id, company_id, airplane_id, number, start_time, end_time, start_city, end_city)
            VALUES(7, 1, 3, 'FE-3423', '2022-10-21 10:25:00', '2022-10-21 17:55:00', 'Rostov', 'Belgorod');

INSERT INTO flights_history(flight_id, company_id, airplane_id, number, start_time, end_time, start_city, end_city)
            VALUES(7, 1, 3, 'FE-3423', '2022-10-21 10:30:00', '2022-10-21 18:00:00', 'Rostov', 'Belgorod');

INSERT INTO flights_history(flight_id, company_id, airplane_id, number, start_time, end_time, start_city, end_city)
            VALUES(7, 1, 3, 'FE-3423', '2022-10-21 10:50:00', '2022-10-21 18:30:00', 'Rostov', 'Belgorod');

INSERT INTO flights_history(flight_id, company_id, airplane_id, number, start_time, end_time, start_city, end_city)
            VALUES(10, 3, 4, 'ZU-6345', '2022-08-19 23:45:00', '2022-08-20 01:15:00', 'Rostov', 'Krasnodar');

INSERT INTO flights_history(flight_id, company_id, airplane_id, number, start_time, end_time, start_city, end_city)
            VALUES(10, 3, 2, 'ZU-6345', '2022-08-19 23:45:00', '2022-08-20 01:15:00', 'Rostov', 'Krasnodar');

-- Add to tickets
INSERT INTO tickets(passenger_id, flight_id, number)
            VALUES(1, 2, '21D');

INSERT INTO tickets(passenger_id, flight_id, number)
            VALUES(8, 6, '19E');

INSERT INTO tickets(passenger_id, flight_id, number)
            VALUES(3, 5, '09A');

INSERT INTO tickets(passenger_id, flight_id, number)
            VALUES(4, 5, '05B');

INSERT INTO tickets(passenger_id, flight_id, number)
            VALUES(7, 8, '08C');

INSERT INTO tickets(passenger_id, flight_id, number)
            VALUES(10, 4, '14A');

INSERT INTO tickets(passenger_id, flight_id, number)
            VALUES(4, 8, '17E');

INSERT INTO tickets(passenger_id, flight_id, number)
            VALUES(8, 5, '08D');

-- Add to schedule_employees
INSERT INTO schedule_employees(flight_id, employee_id)
            VALUES(1, 1);

INSERT INTO schedule_employees(flight_id, employee_id)
            VALUES(4, 7);

INSERT INTO schedule_employees(flight_id, employee_id)
            VALUES(5, 6);

INSERT INTO schedule_employees(flight_id, employee_id)
            VALUES(5, 7);

INSERT INTO schedule_employees(flight_id, employee_id)
            VALUES(3, 2);

INSERT INTO schedule_employees(flight_id, employee_id)
            VALUES(2, 3);

INSERT INTO schedule_employees(flight_id, employee_id)
            VALUES(9, 3);

INSERT INTO schedule_employees(flight_id, employee_id)
            VALUES(10, 3);
