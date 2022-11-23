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
