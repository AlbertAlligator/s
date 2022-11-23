-- Получить 1 колонку
SELECT CustomerId FROM Customer;

-- Получить конкретные колонки
SELECT FirstName, LastName, Email FROM Customer;

-- Вывести все колонки
SELECT * FROM Customer;

-- Вывести только те строки, где имя Марк
SELECT * FROM Customer WHERE FirstName = 'Mark';

-- Где компания не пустая Мар
SELECT * FROM Customer WHERE Company IS NOT NULL

-- Где ИД клиента не равен 50
SELECT * FROM Customer WHERE CustomerId != 50

-- Вывести клиентов. Сортировка по имени
SELECT * FROM Customer ORDER BY FirstName  

-- Сортировка по колонке Total. От большего к меньшему
SELECT * FROM Invoice ORDER BY Total DESC

-- Вывести две колонки из таблицы Invoice,
-- Где ИД клиента 7
-- Сортировка по колонке Total. От большего к меньшему
SELECT InvoiceId, Total FROM Invoice 
WHERE CustomerId = 7
ORDER BY Total DESC;

-- Вывести клиентов из города Прага ИЛИ Вена ИЛИ Сан-Пауло
SELECT * FROM Customer 
WHERE City  IN ("Prague","Vienne","São Paulo")

-- Вывести клиентов, где ИД от 10 до 15
SELECT * FROM Customer
WHERE CustomerId BETWEEN 10 AND 15

-- Вывести клиентов из Канады ИЛИ Бразилии
SELECT * FROM Customer
WHERE Country  = 'Canada' 
OR Country  = 'Brazil' 

-- Вывести клиентов из Канады И(!) штата ON
SELECT * FROM Customer
WHERE Country  = 'Canada' 
AND State  = 'ON' 

-- Вывести клиентов, где ИД = 7 или 10 или 12
SELECT * FROM Customer 
WHERE CustomerId in (7,10,12)

-- Тот же результат
SELECT * FROM Customer
WHERE CustomerId BETWEEN 7 AND 10
OR CustomerId BETWEEN 12 AND 15
OR CustomerId BETWEEN 17 AND 19;

-- Посчитать
SELECT COUNT(*) FROM Invoice
-- Максимальное
SELECT MAX(Total) FROM Invoice
-- Минимальное
SELECT MIN(Total) FROM Invoice 
-- Сумма 
SELECT SUM(Total) FROM Invoice 
-- Среднее
SELECT AVG(Total) FROM Invoice


-- Список уникальных стран
SELECT DISTINCT(Country) FROM Customer

-- Посчитать число уникальных стран
SELECT COUNT(DISTINCT(Country)) FROM Customer 


SELECT * FROM Genre g
-- INSERT (CREATE)
-- Добавить новый жанр
INSERT INTO Genre VALUES (99, 'Techno')
INSERT INTO Genre(Name) VALUES ('Techno')
INSERT INTO Genre(GenreId, Name) VALUES (98, 'Techno')
INSERT INTO Genre(Name, GenreId) VALUES ('Techno', 98)

-- DELETE
-- Удаление строк
SELECT * FROM Artist a 
DELETE FROM Artist WHERE ArtistId = 280
-- DANGER!
-- DELETE FROM Artist

-- UPDATE 
-- 
UPDATE Invoice SET 
BillingAddress = 'Игорь',
BillingCity = 'Орел',
BillingPostalCode = '8800555'
WHERE InvoiceId = 2
-- DANGER!
-- UPDATE Invoice SET BillingAddress = 'Игорь'

SELECT InvoiceId, Total 
FROM Invoice  
ORDER BY Total DESC
LIMIT 100

SELECT FirstName, LastName FROM (SELECT * FROM Customer c WHERE CustomerId < 10)


SELECT * FROM Track WHERE GenreId in 
(SELECT GenreId FROM Genre WHERE Name in ('Rock','Jazz'))


SELECT COUNT(*) as счетчик FROM Invoice WHERE Total >= (SELECT AVG(Total) FROM Invoice)

-- срденне 
SELECT * FROM Invoice WHERE Total > 5.6

SELECT DISTINCT(Country) FROM Customer

SELECT Country, COUNT(*) FROM Customer GROUP BY Country 

-- показать суммарный объем продаж по каждой стране
SELECT BillingCountry, SUM(Total)  FROM Invoice GROUP BY BillingCountry 

SELECT Total  FROM Invoice WHERE BillingCountry  = 'Czech Republic'


SELECT COUNT(DISTINCT(FirstName)) FROM Customer c

SELECT FirstName, COUNT(*)  FROM Customer GROUP BY FirstName 
HAVING COUNT(*) > 1

SELECT * FROM Customer WHERE FirstName in ('Frank', 'Mark')

select count(*), GenreId  from Track group by GenreId;

select max(total), CustomerId from Invoice group by CustomerId

select sum(Total) , CustomerId  from Invoice i group by CustomerId

SELECT GenreId as id, Name  FROM Genre
UNION
SELECT TrackId, Name  FROM Track 

-- Узнать, сколько песен входит в каждый плейлист
-- COUNT

SELECT PlaylistId, COUNT(TrackId) as n1 FROM PlaylistTrack GROUP BY PlaylistId 

SELECT COUNT(TrackId) FROM PlaylistTrack


BOOKS 
| id | title       | author     | url 						 | 
| 1  | 3 мушкетера | А.Дюма 	| https://storage.ru/books/1 | 


SELECT * FROM Track t 

SELECT Track.TrackId, Track.Name, Track.GenreId  FROM Track

SELECT GenreId, Name  FROM Genre g 

-- Вывести айди трека, название и имя жанра
SELECT TrackId, Track.Name, Genre.Name 
FROM Track
JOIN Genre
ON Track.GenreId = Genre.GenreId

-- Вывести название жанра и количество песен в нем
SELECT Genre.Name, COUNT(*) FROM Track
JOIN Genre ON Track.GenreId = Genre.GenreId
GROUP BY Track.GenreId 

-- Вывести информативную таблицу о треках 
SELECT 
	Track.TrackId as "id", 
	Track.Name as "track", 
	Genre.Name as "genre", 
	Album.Title as "album", 
	MediaType.Name as "type"
FROM Track
JOIN Genre ON Track.GenreId = Genre.GenreId 
JOIN Album ON Track.AlbumId = Album.AlbumId 
JOIN MediaType ON Track.MediaTypeId = MediaType.MediaTypeId 

-- Дано: У нас есть таблицы Invoice, Customer, Employee
-- Задача: найти лучшего сотрудника месяца.
-- 1. кто сделал больше всех продаж
-- 2. кто принес больше всего денег по в компанию

SELECT * FROM Employee e 

SELECT SupportRepId, * FROM Customer 

SELECT * FROM Invoice i 

-- Шаг 1. Показать, какого клиента, какой сотрудник ведет
SELECT 
	c.CustomerId, c.FirstName, c.LastName, 
	e.EmployeeId, e.FirstName, e.LastName 
FROM Customer c 
JOIN Employee e ON c.SupportRepId = e.EmployeeId 

-- Шаг 2. Кому что продали
SELECT 
	i.InvoiceId, i.Total, 
	c.CustomerId, c.FirstName, c.LastName  
FROM Invoice i 
JOIN Customer c ON i.CustomerId = c.CustomerId 

-- Шаг 3. Сводим 3 таблицы
SELECT 
	e.EmployeeId, e.FirstName as empFristName, e.LastName as empLastName,
	COUNT(i.InvoiceId), SUM(i.Total), MAX(i.Total), AVG(i.Total) 
FROM Invoice i 
JOIN Customer c ON i.CustomerId = c.CustomerId 
JOIN Employee e ON e.EmployeeId = c.SupportRepId 
GROUP BY e.EmployeeId 


-- Написать, кто кому подчиняется
SELECT * FROM Employee e 

SELECT 
	e1.EmployeeId, e1.LastName as 'Фамилия', e1.FirstName as 'Имя', e1.Title as 'Должность', 
	e2.LastName as 'Фамилия руководителя', e2.FirstName as 'Имя руководителя', e2.Title as 'Должность руководителя'
FROM Employee e1 
LEFT JOIN Employee e2 
ON e1.ReportsTo = e2.EmployeeId 


SELECT * FROM "user" 

-- получить дату
SELECT now()

-- Добавить пользователя
INSERT INTO "user" (login, "password", display_name) VALUES ('test_login', 'test_pass', 'test_dn')

-- Создаем процедуру добавления пользователя (логин, пароль)
CREATE OR REPLACE procedure add_user(
	username varchar(20), 
	pass varchar(100)
) LANGUAGE SQL
AS $$
	INSERT INTO public."user" (login, "password", display_name)
	VALUES ($1, $2, $1)
$$;

-- Создаем процедуру добавления пользователя (логин, пароль, отображаемое имя)
CREATE OR REPLACE procedure add_user(
	username varchar(20), 
	pass varchar(100),
	display_name varchar(40)
) LANGUAGE SQL
AS $$
	INSERT INTO public."user" (login, "password", display_name)
	VALUES ($1, $2, $3)
$$;

-- примеры использования
CALL add_user('tester', 'testpass') 

CALL add_user('myLogin', 'myPass', 'myDispName') 

-- Задача: реализовать механизм добавления сотрудника только с Id компании
-- Если такой компании нет, создать ее

CREATE UNIQUE INDEX comp_name_idx ON public.company (comp_name)

CREATE OR REPLACE procedure add_emp(first_name varchar(20), last_name varchar(20), phone varchar(15), company_name varchar(100)) 
LANGUAGE plpgsql AS 
$$
	declare 
		compId int;
	begin 
		INSERT INTO company (comp_name) VALUES ($4)
		ON CONFLICT (comp_name) DO nothing;
	
		SELECT id from company where comp_name = $4 INTO compId;
	
		INSERT INTO employee (first_name, last_name, phone, "companyId")
		VALUES ($1, $2, $3, compId);
	
		CALL add_user($1, $4);
	end	
$$;

CALL add_emp('Nat', 'Romanov', '+46473458765', 'Avengers') 

CALL add_emp('Tony', 'Stark', '+4985123443', 'Avengers') 

CALL add_emp('Chris', 'Rogers', '+4985125678', 'Avengers') 

SELECT * FROM employee e 

SELECT * FROM "user" u 

SELECT * FROM company c 



-- Задача ставить поле isActive = false при попытке удаления пользователя
select * from "user" u 

UPDATE "user" 
SET "isActive" = false 
where id = 34

CREATE TRIGGER dlt_usr_trg 
BEFORE DELETE ON public."user"
FOR EACH ROW
EXECUTE PROCEDURE dlt_usr();

CREATE OR REPLACE FUNCTION dlt_usr()
  RETURNS trigger AS '
	BEGIN
  		UPDATE public."user" SET "isActive"=false WHERE id=OLD.id;
  		RETURN NULL;
	END; ' 
language plpgsql;

SELECT * FROM "user"

DELETE FROM "user" WHERE id = 41

UPDATE "user" SET "isActive" = true

			
call add_user('test', 'test')


SELECT * FROM "user"
