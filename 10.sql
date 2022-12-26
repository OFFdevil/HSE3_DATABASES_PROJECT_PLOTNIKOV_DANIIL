SET SEARCH_PATH = airport_db;

---1
----
----
----

-- Покупка билета. Проверка, что билет с данным номером ещё не занят
CREATE OR REPLACE PROCEDURE add_ticket_for_passenger(passenger_id__ integer, flight_id__ integer, number__ varchar(20), cost__ real)
    AS
$$
    declare
    begin
        if (select count(*) from flights where flight_id = flight_id__) = 0 then
            raise exception 'flight does not exist';
        end if;
        if (select count(*) from passengers where passenger_id = passenger_id__) = 0 then
            raise exception 'passenger does not exist';
        end if;
        if (select count(*) from tickets where flight_id = flight_id__ and number = number__) <> 0 then
            raise exception 'the place is already taken';
        end if;
        insert into tickets(passenger_id, flight_id, number, cost) values(passenger_id__, flight_id__, number__, cost__);
    end
$$ language plpgsql;

-- call add_ticket_for_passenger(1, 2, '12E', 200); -- okey
-- call add_ticket_for_passenger(1, 2, '12E', 200); -- not okey
-- call add_ticket_for_passenger(-1, 2, '133', 200); -- not okey
-- call add_ticket_for_passenger(1, -1, '12E', 200); -- not okay

----
----
----
---1


---2
----
----
----

-- Обновление информации о рейсе
CREATE OR REPLACE PROCEDURE update_information_about_flight(flight_id__ integer,
                                                            company_id__ integer,
                                                            airplane_id__ integer,
                                                            number__ varchar(20),
                                                            start_time__ timestamp,
                                                            end_time__ timestamp,
                                                            start_city__ varchar(20),
                                                            end_city__ varchar(20))
    AS
$$
    declare
        variable record;
    begin
        if (select count(*) from flights where flight_id = flight_id__) = 0 then
            raise exception 'flight does not exist';
        end if;

        FOR variable IN (SELECT f.start_time, f.end_time from airport_db.flights as f where f.airplane_id = airplane_id__)
            LOOP
                IF (variable.start_time <= start_time__ and start_time__ < variable.end_time)
                       OR (variable.start_time < end_time__ and end_time__ <= variable.end_time) THEN
                    RAISE EXCEPTION 'wrong airplane_id: in this time airplane will be in sky';
                END IF;
            END LOOP;
        
        INSERT INTO flights_history(flight_id, company_id, airplane_id, number, start_time, end_time, start_city, end_city)
        SELECT * FROM flights where flight_id = flight_id__;

        UPDATE flights set (company_id, airplane_id, number, start_time, end_time, start_city, end_city) =
                           (company_id__, airplane_id__, number__, start_time__, end_time__, start_city__, end_city__)
            where flight_id = flight_id__;
     end
$$ language plpgsql;


-- call update_information_about_flight(1,1,3,'SU-1234','2022-11-19 10:25:00.000000','2022-11-19 17:55:00.000000','Moscow','Vladivostok'); -- ok
-- call update_information_about_flight(1,1,3,'SU-1234','2022-11-19 10:25:00.000000','2022-11-19 17:55:00.000000','Moscow','Vladivostok'); -- not ok
-- call update_information_about_flight(-1,1,3,'SU-1234','2022-11-19 10:25:00.000000','2022-11-19 17:55:00.000000','Moscow','Vladivostok'); -- not ok

----
----
----
---2