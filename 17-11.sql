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
