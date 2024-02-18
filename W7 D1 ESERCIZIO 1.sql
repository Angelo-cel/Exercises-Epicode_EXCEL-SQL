use chinook;


SELECT 
    *
FROM
    artist;

SELECT 
    *
FROM
    album;
-- distinct track
SELECT 
    *
FROM
    track;
-- distinct genre
SELECT DISTINCT
    GenreId
FROM
    genre;
-- distinct invoice
SELECT DISTINCT
    BillingCity
FROM
    invoice;
    
 
    
    -- ESERCIZIO 2    METODO 1
SELECT
    (SELECT COUNT(*) FROM genre) AS num_genres,
    (SELECT COUNT(*) FROM track) AS num_tracks;
    
    
    SELECT  (SELECT COUNT(*) FROM track) AS row_count,
    track.Name, 
    genre.Name, genre.GenreId,
    album.Title, 
    mediaType.Name
FROM 
    track
JOIN 
    genre ON track.GenreId = genre.GenreId
JOIN 
    album ON track.AlbumId = album.AlbumId
JOIN 
    mediaType ON track.MediaTypeId = mediaType.MediaTypeId;
    
    -- METODO 2
    
SELECT 
    track.Name AS track_name, genre.name as genre_name
FROM
    track
    LEFT JOIN genre on track.GenreId = genre.GenreId
    order by genre.name;
    
    
    
    -- Recuperate il nome di tutti gli artisti che hanno almeno un album nel database. Esistono artisti senza album nel database?
	-- metodo 1
    SELECT DISTINCT
    artist.Name, album.Title
FROM
    artist
        JOIN
    album ON artist.ArtistId = album.ArtistId;
    
    -- esistono artista senza album?
SELECT 
    artist.Name, album.AlbumId from album
        right JOIN
    artist ON artist.ArtistId = album.ArtistId
WHERE
    album.ArtistId IS NULL;
    

     -- Recuperate il nome di tutte le tracce, del genere associato e della tipologia di media. Esiste un modo per recuperare il nome della tipologia di media?
     
     select track.Name as nome_traccia, genre.Name as nome_genere, mediatype.Name as nome_media 
     from track join genre on track.GenreId = genre.GenreId
     join mediatype on track.MediaTypeId = mediatype.MediaTypeId;
     
     
     -- elencate il nome di tutti gli artisti e dei loro album
     
     select artist.Name, album.Title from artist join album on
     artist.ArtistId = album.ArtistId where album.AlbumId is not null;