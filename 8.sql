SET SEARCH_PATH = view_airport;

--- Посчитать для каждого рейса, сколько раз его обновляли
DROP VIEW IF EXISTS view_difficult_1;
CREATE VIEW view_difficult_1 AS
    SELECT number as "number",
           count(*) as "count_updates"
    FROM airport_db.flights_history f
        INNER JOIN airport_db.companies c on f.company_id = c.company_id
        INNER JOIN airport_db.airplanes a on a.airplane_id = f.airplane_id
    GROUP BY number
    ORDER BY count_updates;

-- ---
-- DROP VIEW IF EXISTS view_difficult_2;
-- CREATE VIEW view_difficult_2 AS
--     SELECT p.first_name || ' ' || p.last_name as "full_name",
--            t.number as "seat",
--            f.number as "flight_name",
--            f.start_time as "start_time"
--     FROM airport_db.tickets t
--         inner join airport_db.passengers p on t.passenger_id = p.passenger_id
--         inner join airport_db.flights f on t.flight_id = f.flight_id;

-- Найти всех сотрудников, которые работали не на свою компанию и вывести количество рейсов,
-- которые они выполнили в компанией конкурентом
DROP VIEW IF EXISTS view_difficult_3;
CREATE VIEW view_difficult_3 AS
    SELECT  (first_name || ' ' || last_name) as full_name,
            e.employee_id,
            count(f.flight_id)
    FROM airport_db.employees as e
        inner join airport_db.schedule_employees se on e.employee_id = se.employee_id
        inner join airport_db.flights f on se.flight_id = f.flight_id and e.company_id <> f.company_id
    GROUP BY full_name, e.employee_id;;