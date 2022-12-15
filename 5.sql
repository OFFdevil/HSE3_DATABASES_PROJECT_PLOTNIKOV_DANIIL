SET SEARCH_PATH = airport_db;

-- CRUD for table tickets
---- INSERT
INSERT INTO tickets(passenger_id, flight_id, number)
            VALUES(3, 3, '01D');

---- SELECT
SELECT
    p.passenger_id
    ,COUNT(number)
FROM tickets as t
    RIGHT JOIN passengers p on t.passenger_id = p.passenger_id
GROUP BY p.passenger_id;

---- UPDATE
UPDATE tickets SET number = '15A' where passenger_id = 3 and flight_id = 3;

---- DELETE
DELETE FROM tickets where passenger_id = 3 and number = '15A';

-- CRUD for table flights
---- INSERT
INSERT INTO flights(company_id, airplane_id, number, start_time, end_time, start_city, end_city)
            VALUES(4, 8, 'UF-0000', '2022-09-11 09:25:00', '2022-10-19 10:55:00', 'Moscow', 'Saint-Petersburg');

---- SELECT
SELECT
    number
    , MIN(end_time)
FROM flights
    where number = 'UF-6666'
GROUP BY number;

---- UPDATE
------ start transaction
begin transaction isolation level serializable;

INSERT INTO flights_history(flight_id, company_id, airplane_id, number, start_time, end_time, start_city, end_city)
SELECT * FROM flights where number = 'UF-0000' and start_time = '2022-09-11 09:25:00';

UPDATE flights SET airplane_id = 4 where number = 'UF-0000' and start_time = '2022-09-11 09:25:00';

commit;
------ end transaction

---- DELETE
------ start transaction
begin transaction isolation level serializable;

INSERT INTO flights_history(flight_id, company_id, airplane_id, number, start_time, end_time, start_city, end_city)
SELECT * FROM flights where number = 'UF-0000' and start_time = '2022-09-11 09:25:00';

DELETE FROM flights where number = 'UF-0000' and start_time = '2022-09-11 09:25:00';

commit;
------ end transaction

