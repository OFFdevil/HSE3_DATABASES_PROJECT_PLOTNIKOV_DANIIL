SET SEARCH_PATH = airport_db;

-- 1) Вывести рейсы в убывающем порядке максимального опоздания начала рейса
-- (посчитаем для каждого рейса его первоначальное время + возьмём текущее и вычтем)
-- Должно вывести: для ZU-6345 10 минут, для других 0 минут

select
    number,
    max((start_time - coalesce(start_time_min, start_time))) as lateness
from flights
    left join
        (select flight_id, min(start_time) as start_time_min from flights_history group by flight_id) as tmp_1
        on flights.flight_id = tmp_1.flight_id
group by number
order by lateness desc;

-- 2) Для каждого человека найти какую процентную долю от потраченных денег на билеты
-- составляет затраты на билеты в конкретный город и отсортировать каждого человека по количество потраченных суммарно
-- сбережений на перелеты

select
    (first_name || ' ' || last_name) as full_name,
    f.end_city,
    t.cost,
    (sum(t.cost) over (partition by first_name, last_name, f.end_city))
     / (sum (t.cost) over(partition by first_name, last_name)) * 100 as share
from passengers p
    inner join tickets t on p.passenger_id = t.passenger_id
    inner join flights f on t.flight_id = f.flight_id;

-- 3) Вывести для самолётов, которые были хотя бы 2 раза сданы в 2022 году другой компании, количество сдач в 2022 году

select
    a.airplane_id,
    a.airplane_name,
    count(a.airplane_id)
from airplanes a
    inner join flights f on a.airplane_id = f.airplane_id and a.company_id <> f.company_id
where f.start_time between '2022-01-01 00:00:00' and '2022-12-31 23:59:59'
group by a.airplane_id, a.airplane_name
having 1 < count(a.airplane_id)
order by airplane_id;

-- 4) Вывести количество денег, которые человек потратил, купив несколько билетов на один и тот же рейс(считаем, что
-- покупатель изначально хотел купить первый купленный им билет)

select
    tmp2.full_name,
    sum(tmp2.max_mistake)
from
    (select
        tmp1.full_name,
        tmp1.passenger_id,
        max(max_mistake) as max_mistake
    from
        (
        select
            (first_name || ' ' || last_name) as full_name,
            p.passenger_id,
            t.flight_id,
            (sum(t.cost) over (partition by p.passenger_id, flight_id order by t.ticket_id RANGE BETWEEN CURRENT ROW AND 10000 FOLLOWING) - t.cost) as max_mistake
        from passengers p
            inner join tickets t on p.passenger_id = t.passenger_id
        ) as tmp1
    group by tmp1.full_name, tmp1.passenger_id, flight_id) as tmp2
group by tmp2.full_name, tmp2.passenger_id;


select
    tmp2.full_name,
    tmp2.passenger_id,
    sum(tmp2.max_mistake)
from
    (
        select
            tmp1.full_name,
            tmp1.passenger_id,
            max(max_mistake) as max_mistake
        from
            (
            select
                (first_name || ' ' || last_name) as full_name,
                p.passenger_id,
                t.flight_id,
                (sum(t.cost) over (partition by p.passenger_id, flight_id)
                    - first_value(t.cost) over (partition by p.passenger_id, flight_id order by t.ticket_id)) as max_mistake
            from passengers p
                     inner join tickets t on p.passenger_id = t.passenger_id) as tmp1
        group by tmp1.full_name, tmp1.passenger_id, flight_id
    ) as tmp2
group by tmp2.full_name, tmp2.passenger_id
order by tmp2.full_name, tmp2.passenger_id;

-- 5) Найти всех сотрудников, которые работали не на свою компанию и вывести количество рейсов,
-- которые они выполнили в компанией конкурентом
-- Вывод: у нас добросовестные граждане, поэтому никто не работает на 2 фронта

select
    (first_name || ' ' || last_name) as full_name,
    e.employee_id,
    count(f.flight_id)
from employees as e
    inner join schedule_employees se on e.employee_id = se.employee_id
    inner join flights f on se.flight_id = f.flight_id and e.company_id <> f.company_id
group by full_name, e.employee_id;


-- 6) Выведите количество самолётов, которыми обладает каждая компания

select
    c.company_id,
    c.company_name,
    count(a.airplane_id)
from companies c
    inner join airplanes a on c.company_id = a.company_id
group by c.company_id, c.company_name
order by c.company_id;



