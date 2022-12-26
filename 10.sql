SET SEARCH_PATH = airport_db;

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

--