use chinook;

-- Recuperate tutte le tracce che abbiano come genere “Pop” o “Rock”.
SELECT 
    track.Name, genre.Name as Genre_name
FROM
    track
     JOIN
    genre ON genre.GenreId = track.GenreId
WHERE
      genre.Name in ('Pop', 'Rock');

-- Elencate tutti gli artisti e/o gli album che inizino con la lettera “A”

select artist.Name as Artista, album.Title as Album
from artist left join album on artist.ArtistId = album.ArtistId
WHERE artist.Name LIKE 'A%' or  album.Title LIKE 'A%';

-- Elencate tutte le tracce che hanno come genere “Jazz” o che durano meno di 3 minuti.

SELECT 
    track.Name as traccia,
    genre.Name as genere,
    concat(floor(Milliseconds / 60000),
    ':',
    lpad(floor((Milliseconds % 60000) / 1000),
    2,
    '0')) as durata
FROM
    track
        JOIN
    genre ON track.GenreId = genre.GenreId
WHERE
    genre.Name ='Jazz' or Milliseconds < 180000;
    
    -- Recuperate tutte le tracce più lunghe della durata media.
    
SELECT 
    track.Name as traccia,
    concat(floor(Milliseconds / 60000),
    ':',
    lpad(floor((Milliseconds % 60000) / 1000),
    2,
    '0')) as durata
    from track where Milliseconds > (select AVG(milliseconds) from track);
    
    -- Individuate i generi che hanno tracce con una durata media maggiore di 4 minuti.
SELECT 
    genre.Name AS genere
FROM
    track
        LEFT JOIN
    genre ON track.GenreId = genre.GenreId
    group by genre.GenreId
    having avg(Milliseconds) > 240000;
    
   -- Individuate gli artisti che hanno rilasciato più di un album.
SELECT 
    artist.Name AS artista, COUNT(album.AlbumId) AS album
FROM
    artist
        JOIN
    album ON artist.ArtistId = album.ArtistId
GROUP BY artist.Name
HAVING COUNT(album.AlbumId) > 1;

-- Trovate la traccia più lunga in ogni album.
SELECT 
    track.Name AS traccia,
    album.Title AS album,
    track.Milliseconds / 60000 AS durata
FROM
    album
        JOIN
    track ON album.AlbumId = track.AlbumId
    join
   (SELECT 
    AlbumId, MAX(Milliseconds) AS maxdurata
FROM
    track
GROUP BY AlbumId) 
as maxtrack on track.AlbumId = maxtrack.AlbumId and track.Milliseconds = maxtrack.maxdurata;


-- Individuate gli album che hanno più di 20 tracce e mostrate il nome dell’album e il numero di tracce in esso contenute.
SELECT 
album.Title, count(track.TrackId) n_track from album 
join track on album.AlbumId = track.AlbumId 
group by album.Title 
having count(track.TrackId) > 20