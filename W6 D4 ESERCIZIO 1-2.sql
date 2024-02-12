use videogamestoredb;
select * from impiegato;

-- Seleziona tutti gli impiegati con una laurea in Economia.
SELECT 
    *
FROM
    impiegato
WHERE
    titolo_studio = 'Laurea in Economia';

-- Seleziona gli impiegati che lavorano come Cassiere o che hanno un Diploma di Informatica.
SELECT 
    *
FROM
    impiegato
        LEFT JOIN
    servizio_impiegato ON impiegato.codice_fiscale = servizio_impiegato.codice_fiscale
WHERE
    servizio_impiegato.carica = 'cassiere'
        OR impiegato.titolo_studio = 'Diploma di Informatica';


-- Seleziona i nomi e i titoli degli impiegati che hanno iniziato a lavorare dopo il 1 gennaio 2023
SELECT 
    nome, titolo_studio
FROM
    impiegato
        LEFT JOIN
    servizio_impiegato ON impiegato.codice_fiscale = servizio_impiegato.codice_fiscale
WHERE
    servizio_impiegato.data_inizio > '2023-01-01';


-- Seleziona i titoli di studio distinti tra gli impiegati.
SELECT DISTINCT
    titolo_studio
FROM
    impiegato;

 -- Seleziona gli impiegati con un titolo di studio diverso da "Laurea in Economia".
 select * from impiegato where titolo_studio not like 'Laurea in Economia';
 
 -- Seleziona gli impiegati che hanno iniziato a lavorare prima del 1 luglio 2023 e sono Commessi.
SELECT 
    *
FROM
    impiegato
        LEFT JOIN
    servizio_impiegato ON impiegato.codice_fiscale = servizio_impiegato.codice_fiscale
WHERE
    servizio_impiegato.data_inizio < '2023-07-01'
        AND servizio_impiegato.carica = 'Commesso';
        
    -- Seleziona i titoli e gli sviluppatori dei videogiochi distribuiti nel 2020. 
 SELECT 
    titolo, sviluppatore
FROM
    videogioco
WHERE
    anno_distribuzione BETWEEN '2020-01-01' AND '2020-12-31';
        
-- ESERCIZIO 2

-- Seleziona tutti i prodotti con un prezzo superiore a 50 euro dalla tabella Prodotti.
use gestionale;
SELECT 
    *
FROM
    prodotti
WHERE
    PREZZO > 50;
 
 -- Seleziona tutte le email dei clienti il cui nome inizia con la lettera 'A' dalla tabella Clienti.
SELECT 
    NOME, EMAIL
FROM
    clienti
WHERE
    NOME LIKE 'A%';

-- Seleziona tutti gli ordini con una quantità maggiore di 10 o con un importo totale inferiore a 100 euro dalla tabella Ordini.
SELECT 
    *
FROM
    ordini
        LEFT JOIN
    dettaglio_ordini ON ordini.ID_ORDINE = dettaglio_ordini.ID_ORDINE
WHERE
    ordini.QUANTITÀ > 10
        OR dettaglio_ordini.PREZZO_TOTALE < 100


-- Seleziona tutti i prezzi dei prodotti il cui nome contiene la parola 'tech' indipendentemente dalla posizione nella tabella Prodotti.

SELECT 
    PREZZO
FROM
    prodotti
WHERE
    NOME_PRODOTTO LIKE '%tech%';


-- Seleziona tutti i clienti che non hanno un indirizzo email nella tabella Clienti.
select * from clienti where EMAIL is  NULL;

-- Seleziona tutti i prodotti il cui nome inizia con 'M' e termina con 'e' indipendentemente dalla lunghezza della parola nella tabella Prodotti.
SELECT 
    *
FROM
    prodotti
WHERE
    NOME_PRODOTTO LIKE 'm%e';