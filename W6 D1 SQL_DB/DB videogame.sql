CREATE DATABASE videogamestoredb;

USE videogamestoredb;
/*Create table store*/
CREATE TABLE store (
    codice_store INT PRIMARY KEY,
    indirizzo_fisico VARCHAR(50),
    numero_di_telefono VARCHAR(15)
);

/*Create table impiegato*/
CREATE TABLE impiegato (
    codice_fiscale VARCHAR(20) PRIMARY KEY,
    nome VARCHAR(20),
    titolo_di_studio VARCHAR(50),
    recapito VARCHAR(30)
);

/*Create table servizio_impiegato*/
CREATE TABLE servizio_impiegato (
    servizio_id INT PRIMARY KEY AUTO_INCREMENT,
    codice_fiscale VARCHAR(20),
    codice_store INT,
    data_inizio DATE,
    data_fine DATE,
    carica VARCHAR(20),
    FOREIGN KEY (codice_fiscale)
        REFERENCES impiegato (codice_fiscale)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (codice_store)
        REFERENCES store (codice_store)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

/*Create table videogioco*/
CREATE TABLE videogioco (
    videogioco_id INT PRIMARY KEY AUTO_INCREMENT,
    titolo VARCHAR(50),
    sviluppatore VARCHAR(30),
    anno_distribuzione INT,
    costoAcquisto FLOAT,
    genere VARCHAR(30),
    remake_id INT
);

/*Create table videogioco*/
CREATE TABLE magazzino_line (
    magazzino_id INT PRIMARY KEY AUTO_INCREMENT,
    videogioco_id int,
    codice_store int,
    quantità int,
    FOREIGN KEY (videogioco_id)
        REFERENCES videogioco (videogioco_id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (codice_store)
        REFERENCES store (codice_store)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

/*Insert into store table*/
INSERT into store (codice_store, indirizzo_fisico, numero_di_telefono)
values (10,'Corso Cavour 101, Palermo','+39 091 2345678');

/*Insert into impiegato table*/
INSERT into impiegato (codice_fiscale, nome, titolo_di_studio, recapito)
values ('ABC12345XYZ67890','Mario Rossi','Laurea in Economia','mario.rossi@email.com'),
 ('DEF67890XYZ12345','Anna Verdi','Diploma di Ragioneria','anna.verdi@email.com'),
 ('GHI12345XYZ67890','Luigi Bianchi','Laurea in Informatica','luigi.bianchi@email.com'),
 ('JKL67890XYZ12345','Laura Neri','Laurea in Lingue','laura.neri@email.com'),
 ('MNO12345XYZ67890','Andrea Moretti','Diploma di Geometra','andrea.moretti@email.com'),
 ('PQR67890XYZ12345','Giulia Ferrara','Laurea in Psicologia','giulia.ferrara@email.com'),
 ('STU12345XYZ67890','Marco Esposito','Diploma di Elettronica','marco.esposito@email.com'),
 ('VWX67890XYZ12345','Sara Romano','Laurea in Giurisprudenza','sara.romano@email.com'),
 ('YZA12345XYZ67890','Roberto De Luca','Diploma di Informatica','roberto.deluca@email.com'),
 ('BCD67890XYZ12345','Elena Santoro','Laurea in Lettere','elena.santoro@email.com');
 
 /*Insert into servizio_impiegato table*/
INSERT INTO servizio_impiegato (codice_fiscale, codice_store, data_inizio, data_fine, carica)
VALUES 
('ABC12345XYZ67890', 1, '2023-01-01', '2023-12-31', 'Cassiere'),
('DEF67890XYZ12345', 2, '2023-02-01', '2023-11-30', 'Commesso'),
('GHI12345XYZ67890', 3, '2023-03-01', '2023-10-31', 'Magazziniere'),
('JKL67890XYZ12345', 4, '2023-04-01', '2023-09-30', 'Addetto alle vendite'),
('MNO12345XYZ67890', 5, '2023-05-01', '2023-08-31', 'Addetto alle pulizie'),
('PQR67890XYZ12345', 6, '2023-06-01', '2023-07-31', 'Commesso'),
('STU12345XYZ67890', 7, '2023-07-01', '2023-06-30', 'Commesso'),
('VWX67890XYZ12345', 8, '2023-08-01', '2023-05-31', 'Cassiere'),
('YZA12345XYZ67890', 9, '2023-09-01', '2023-04-30', 'Cassiere'),
('BCD67890XYZ12345', 10, '2023-10-01', '2023-03-31', 'Cassiere');

 /*Insert into videogioco table*/
INSERT INTO videogioco (titolo, sviluppatore, anno_distribuzione, costo_acquisto, genere, remake_id)
VALUES 
    ('Fifa 2023', 'EA Sports', 2023-01-01, 49.99, 'Calcio', NULL),
    ('Assassin''s Creed: Valhalla', 'Ubisoft', 2020-01-01, 59.99, 'Action', NULL),
    ('Super Mario Odyssey', 'Nintendo', 2017-01-01, 39.99, 'Platform', NULL),
    ('The Last of Us Part II', 'Naughty Dog', 2020-01-01, 69.99, 'Action', NULL),
    ('Cyberpunk 2077', 'CD Projekt Red', 2020-01-01, 49.99, 'RPG', NULL),
    ('Animal Crossing: New Horizons', 'Nintendo', 2020-01-01, 54.99, 'Simulation', NULL),
    ('Call of Duty: Warzone', 'Infinity Ward', 2020-01-01, 0.00, 'FPS', NULL),
    ('The Legend of Zelda: Breath of the Wild', 'Nintendo', 2017-01-01, 59.99, 'Action-Adventure', NULL),
    ('Fortnite', 'Epic Games', 2017-01-01, 0.00, 'Battle Royale', NULL),
    ('Red Dead Redemption 2', 'Rockstar Games', 2018-01-01, 39.99, 'Action-Adventure', NULL);
    
INSERT INTO magazzino_line (videogioco_id, codice_store, quantità)
SELECT
    vg.videogioco_id,
    s.codice_store,
    FLOOR(RAND() * 20) + 1 AS quantità
FROM
    videogioco vg
CROSS JOIN
    store s;
