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
| id | title       | author     | url 						| 
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

