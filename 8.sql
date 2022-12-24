SET SEARCH_PATH = view_airport;

--- Посчитать для каждого рейса, сколько раз его обновляли
DROP VIEW IF EXISTS view_difficult_1;
CREATE VIEW view_flights_history AS
    SELECT number as "number",
           count(*) as "count_updates"
    FROM airport_db.flights_history f
        INNER JOIN airport_db.companies c on f.company_id = c.company_id
        INNER JOIN airport_db.airplanes a on a.airplane_id = f.airplane_id
    GROUP BY number
    ORDER BY count_updates;

---
DROP VIEW IF EXISTS view_tickets_difficult;
CREATE VIEW view_tickets AS
    SELECT p.first_name || ' ' || p.last_name as "full_name",
           t.number as "seat",
           f.number as "flight_name",
           f.start_time as "start_time"
    FROM airport_db.tickets t
        inner join airport_db.passengers p on t.passenger_id = p.passenger_id
        inner join airport_db.flights f on t.flight_id = f.flight_id;

---