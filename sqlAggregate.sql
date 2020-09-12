# Find the revenue of 2013
pd.read_sql_query('''select sum(Total) from invoices where InvoiceDate like "%2013%"''', conn)

# Find the number of tracks belong to the genre Rock
pd.read_sql_query('''select count(*) from tracks where GenreId = (select GenreId from genres where Name = "Rock")''', conn)

# Find the number of customers each employee has supported
pd.read_sql_query('''select count(*), SupportRepid from customers group by SupportRepId''', conn)

# Find the customer who paid the most
pd.read_sql_query('''select * from customers where CustomerId = (select CustomerId from invoices group by CustomerId order by sum(Total) desc limit 1) ''', conn)

# Find the richest artist
pd.read_sql_query('''select artists.*, sum(trackRevenue.totalTrackRevenue) as totalAlbumRevenue from albums 
join (select tracks.TrackId, tracks.AlbumId, sum(ic.UnitPrice * ic.Quantity) as totalTrackRevenue from tracks
join invoice_items ic on ic.TrackId = tracks.TrackId group by tracks.TrackId) trackRevenue 
on albums.AlbumId = trackRevenue.AlbumId
join artists on artists.ArtistId = albums.ArtistId
group by albums.ArtistId order by totalAlbumRevenue desc limit 1''', conn)