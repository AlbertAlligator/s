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

