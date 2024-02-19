
use chinook;

/* Elencate il numero di tracce per ogni genere in ordine discendente,
 escludendo quei generi che hanno meno di 10 tracce. */


-- seleziona generi che hanno più di 10 tracce
select GenreId as genreTrack, count(*) as countTrack
from track
group by GenreId
having countTrack >= 10;

-- risposta esercizio
SELECT 
    genre.Name, COUNT(genre.Name) AS countTrack
FROM
    genre
        JOIN
    track ON genre.GenreId = track.GenreId
GROUP BY genre.Name
HAVING COUNT(genre.Name) >= 10;


-- Trovate le tre canzoni più costose.
SELECT 
    Name, UnitPrice
FROM
    track
ORDER BY UnitPrice DESC
LIMIT 3;

-- Elencate gli artisti che hanno canzoni più lunghe di 6 minuti.
SELECT DISTINCT artist.Name, track.Milliseconds /60000 as durata_in_minuti
FROM artist
JOIN album ON artist.ArtistId = album.ArtistId
JOIN track ON album.AlbumId = track.AlbumId
WHERE track.Milliseconds > 360000;


-- Individuate la durata media delle tracce per ogni genere.
SELECT genre.Name AS nome_genere, AVG(track.Milliseconds/60000) AS durata_media
FROM genre
JOIN track ON genre.GenreId = track.GenreId
JOIN album ON track.AlbumId = album.AlbumId
GROUP BY genre.Name;


-- Elencate tutte le canzoni con la parola “Love” nel titolo, 
/* ordinandole alfabeticamente prima per genere e poi per nome.*/

SELECT track.Name AS titolo, genre.Name AS genere
FROM genre
JOIN track ON track.GenreId = genre.GenreId
JOIN album ON track.AlbumId = Album.AlbumId
WHERE track.Name LIKE '%Love%'
ORDER BY genre.Name ASC, Track.Name ASC;

-- trovate il costo medio per ogni tipologia di media type

SELECT mediatype.Name AS tipo_media, AVG(track.UnitPrice) AS costo_medio
FROM track
JOIN mediatype ON track.MediaTypeId = mediatype.MediaTypeId
GROUP BY mediatype.Name;




-- Individuate il genere con più tracce.

SELECT genre.Name, COUNT(track.GenreId) AS numero_tracce
FROM track
JOIN genre ON track.GenreId = genre.GenreId
GROUP BY genre.Name
ORDER BY numero_tracce DESC
LIMIT 1;

-- Trovate gli artisti che hanno lo stesso numero di album dei Rolling Stones.
SELECT artist.Name AS artista, COUNT(DISTINCT album.AlbumId) AS num_album
FROM artist
JOIN album ON artist.ArtistId = album.ArtistId
WHERE artist.ArtistId != (
    SELECT artist.ArtistId
    FROM artist
    WHERE Name = 'The Rolling Stones'
)
GROUP BY artist.Name
HAVING num_album = (
    SELECT COUNT(DISTINCT album.AlbumId)
    FROM artist
    JOIN album ON artist.ArtistId = album.ArtistId
    WHERE artist.name = 'The Rolling Stones'
);

-- Trovate l’artista con l’album più costoso.

SELECT 
    artist.Name AS artista,
    album.Title AS album,
    MAX(Track.UnitPrice) AS prezzo_massimo
FROM
    artist
        JOIN
    album ON artist.ArtistId = album.ArtistId
        JOIN
    track ON album.AlbumId = track.AlbumId
GROUP BY artist.Name , album.Title
ORDER BY prezzo_massimo DESC
LIMIT 1;