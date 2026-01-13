SHOW DATABASES;
USE chinook;
SHOW TABLES;
--Q1. List all customers and their invoices (even if none)--
SELECT Customer.CustomerId,Customer.FirstName,Customer.LastName,COUNT(Invoice.InvoiceId) AS total_invoices FROM Customer LEFT JOIN Invoice 
ON Customer.CustomerId = Invoice.CustomerId GROUP BY Customer.CustomerId,Customer.FirstName,Customer.LastName;

--Q2. Show invoice id, customer name, and total amount--
select invoice.invoiceid,customer.customerid,customer.firstname,customer.lastname,invoice.total from invoice join customer on invoice.invoiceid= customer.customerid;

--Q3. Show track name and artist name--
SELECT Track.Name AS track_name, Artist.Name AS artist_name FROM Track JOIN Album ON Track.AlbumId = Album.AlbumId JOIN Artist ON Album.ArtistId = Artist.ArtistId;

--1️⃣ Show customer name and total amount they have spent--
select customer.customerid,customer.firstname,customer.lastname ,sum(invoice.total) from customer join invoice on customer.customerid=invoice.customerid group by
Customer.CustomerId, Customer.FirstName,Customer.LastName;

--Find top 5 customers by spending--
select customer.customerid,customer.firstname,customer.lastname ,sum(invoice.total) as total_spent from customer join invoice on customer.customerid=invoice.customerid group by
Customer.CustomerId, Customer.FirstName,Customer.LastName order by total_spent desc limit 5;

--Show invoice id, track name, and unit price--
SELECT Invoice.InvoiceId, Track.Name AS track_name, InvoiceLine.UnitPrice FROM InvoiceLine JOIN Track ON InvoiceLine.TrackId = Track.TrackId 
JOIN Invoice ON InvoiceLine.InvoiceId = Invoice.InvoiceId;

--4️⃣ Show artist name and number of tracks they have--
SELECT Artist.Name,COUNT(Track.TrackId) AS total_tracks FROM Artist JOIN Album ON Artist.ArtistId = Album.ArtistId JOIN Track ON Album.AlbumId = Track.AlbumId
GROUP BY Artist.ArtistId, Artist.Name;

--5️⃣ Find artists who have more than 50 tracks--
SELECT Artist.Name, COUNT(Track.TrackId) AS total_tracks FROM Artist JOIN Album ON Artist.ArtistId = Album.ArtistId
JOIN Track ON Album.AlbumId = Track.AlbumId GROUP BY Artist.ArtistId, Artist.Name HAVING COUNT(Track.TrackId) > 50;

--Find total revenue per artist--
SELECT Artist.Name,SUM(InvoiceLine.UnitPrice * InvoiceLine.Quantity) AS revenue FROM Artist JOIN Album ON Artist.ArtistId = Album.ArtistId
JOIN Track ON Album.AlbumId = Track.AlbumId JOIN InvoiceLine ON Track.TrackId = InvoiceLine.TrackId GROUP BY Artist.ArtistId, Artist.Name;

Find top 5 artists by revenue
SELECT Artist.Name, SUM(InvoiceLine.UnitPrice * InvoiceLine.Quantity) AS revenue FROM Artist JOIN Album ON Artist.ArtistId = Album.ArtistId 
JOIN Track ON Album.AlbumId = Track.AlbumId JOIN InvoiceLine ON Track.TrackId = InvoiceLine.TrackId GROUP BY Artist.ArtistId, Artist.Name ORDER BY revenue DESC
LIMIT 5;

8️⃣ Show customer name and the artist they purchased from
SELECT Customer.FirstName, Customer.LastName,Artist.Name AS artist_name FROM Customer JOIN Invoice ON Customer.CustomerId = Invoice.CustomerId
JOIN InvoiceLine ON Invoice.InvoiceId = InvoiceLine.InvoiceId JOIN Track ON InvoiceLine.TrackId = Track.TrackId JOIN Album ON Track.AlbumId = Album.AlbumId
JOIN Artist ON Album.ArtistId = Artist.ArtistId;

9️⃣ Find countries and how much money they generated
SELECT Customer.Country,SUM(Invoice.Total) AS total_revenue FROM Customer JOIN Invoice ON Customer.CustomerId = Invoice.CustomerId GROUP BY Customer.Country;

🔟 Find most popular genre by number of tracks sold
SELECT Genre.Name,COUNT(InvoiceLine.TrackId) AS tracks_sold FROM InvoiceLine JOIN Track ON InvoiceLine.TrackId = Track.TrackId JOIN Genre ON Track.GenreId = Genre.GenreId
GROUP BY Genre.GenreId, Genre.Name ORDER BY tracks_sold DESC LIMIT 1;
