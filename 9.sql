SET SEARCH_PATH = airport_db;


---1
---
---
---
CREATE OR REPLACE FUNCTION trigger_add_to_scheduler()
    RETURNS TRIGGER
    AS
$$
    BEGIN
        IF (TG_OP = 'DELETE') THEN
            DELETE FROM airport_db.schedule where id = OLD.flight_id;
        ELSEIF (TG_OP = 'INSERT' OR TG_OP = 'UPDATE') THEN
            IF date_part('hour', age(NOW(), NEW.end_time)) < 24 AND date_part('hour', age(NOW(), NEW.end_time)) > -24 THEN
                IF (select count(*) from schedule where id = NEW.flight_id) = 0 THEN
                    INSERT INTO airport_db.schedule VALUES(NEW.flight_id);
                END IF;
            END IF;
        END IF;
        RETURN NEW;
    END
$$ LANGUAGE plpgsql;


--- Триггер, который записывает в расписание рейс, если конец рейса не раньше чем 24 часа от текущего времени
--- и не позже чем 24 часа от текущего времени. Или удаляет рейс из расписания, если оказалось, что рейс удалили 

DROP TRIGGER IF EXISTS trigger_scheduler on flights;
CREATE TRIGGER trigger_scheduler
    AFTER INSERT OR UPDATE OR DELETE
    ON flights
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_add_to_scheduler();


--- Добавляем новый рейс
insert into flights(company_id, airplane_id, number, start_time, end_time, start_city, end_city)
            values(2, 3, 'SU-5430', '2022-12-26 10:25:00', '2022-12-26 23:00:00', 'Krasnodar', 'Donetsk');

--- Удаляем рейс
delete from flights where flight_id = 18;

--- Проверка
select
    *
from schedule s
    left join flights f on s.id = f.flight_id;

----
----
----
----1


----2
----
----
----
CREATE OR REPLACE FUNCTION trigger_airplane_only_one_flights_in_one_time()
    RETURNS TRIGGER
    AS
$$
    DECLARE
        variable record;
    BEGIN
        FOR variable IN (SELECT f.start_time, f.end_time from airport_db.flights as f where f.airplane_id = NEW.airplane_id)
            LOOP
                IF (variable.start_time <= NEW.start_time and NEW.start_time < variable.end_time) OR (variable.start_time < NEW.end_time and NEW.end_time <= variable.end_time) THEN
                    RAISE EXCEPTION 'wrong airplane_id: in this time airplane will be in sky';
                END IF;
            END LOOP;
        RETURN NEW;
    END;
$$ LANGUAGE plpgsql;

--- Не даёт добавить рейс, если во время полёта нового рейса, самолёт уже выполняет другой рейс
DROP TRIGGER IF EXISTS trigger_flights on flights;
CREATE TRIGGER trigger_flights
    BEFORE INSERT
    ON flights
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_airplane_only_one_flights_in_one_time();

--- Проверка
insert into flights(company_id, airplane_id, number, start_time, end_time, start_city, end_city)
            values(2, 3, 'SU-5430', '2022-12-26 10:25:00', '2022-12-26 23:00:00', 'Krasnodar', 'Donetsk');

insert into flights(company_id, airplane_id, number, start_time, end_time, start_city, end_city)
            values(2, 3, 'SU-5430', '2022-12-27 10:25:00', '2022-12-27 23:00:00', 'Krasnodar', 'Donetsk');

----
----
----
----2
