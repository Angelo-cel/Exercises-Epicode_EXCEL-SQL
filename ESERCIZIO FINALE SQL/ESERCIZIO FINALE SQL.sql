-- Creazione del database
CREATE DATABASE IF NOT EXISTS SalesDatabase;
USE SalesDatabase;

-- Creazione della tabella Product_Category
CREATE TABLE Product_Category (
    Category_ID INT AUTO_INCREMENT PRIMARY KEY,
    Category_Name VARCHAR(255)
);

-- Inserimento dei dati nella tabella Product_Category
INSERT INTO Product_Category (Category_Name) VALUES
('Electronics'),
('Books'),
('Clothing');

-- Creazione della tabella Product
CREATE TABLE Product (
    Product_ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255),
    Category_ID INT,
    FOREIGN KEY (Category_ID) REFERENCES Product_Category(Category_ID)
);

-- Inserimento dei dati nella tabella Product
INSERT INTO Product (Name, Category_ID) VALUES
('Laptop', 1),
('Smartphone', 1),
('Novel', 2),
('T-Shirt', 3);

-- Creazione della tabella Region
CREATE TABLE Region (
    Region_ID INT AUTO_INCREMENT PRIMARY KEY,
    Region_Name VARCHAR(255)
);

-- Inserimento dei dati nella tabella Region
INSERT INTO Region (Region_Name) VALUES
('West Europe'),
('South Europe'),
('North Europe');

-- Creazione della tabella States
CREATE TABLE States (
    State_ID INT AUTO_INCREMENT PRIMARY KEY,
    State_Name VARCHAR(255),
    Region_ID INT,
    FOREIGN KEY (Region_ID) REFERENCES Region(Region_ID)
);

-- Inserimento dei dati nella tabella States
INSERT INTO States (State_Name, Region_ID) VALUES
('Germany', 1),
('France', 1),
('Italy', 2),
('Greece', 2),
('Sweden', 3);

-- Creazione della tabella Sales
CREATE TABLE Sales (
    Sale_ID INT AUTO_INCREMENT PRIMARY KEY,
    Date DATE,
    Amount DECIMAL(10, 2),
    Product_ID INT,
    Region_ID INT,
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID),
    FOREIGN KEY (Region_ID) REFERENCES Region(Region_ID)
);

-- Inserimento dei dati nella tabella Sales
INSERT INTO Sales (Date, Amount, Product_ID, Region_ID) VALUES
('2023-01-01', 1000.00, 1, 1),
('2023-01-02', 500.00, 2, 1),
('2023-01-03', 750.00, 3, 2),
('2023-01-04', 200.00, 4, 2),
('2023-01-05', 900.00, 1, 3),
('2023-01-06', 300.00, 2, 3),
('2023-01-07', 600.00, 3, 1),
('2023-01-08', 450.00, 4, 1),
('2023-01-09', 1200.00, 1, 2),
('2023-01-10', 700.00, 2, 2),
('2023-01-11', 800.00, 3, 3),
('2023-01-12', 650.00, 4, 3),
('2023-01-13', 550.00, 1, 1),
('2023-01-14', 400.00, 2, 1),
('2023-01-15', 950.00, 3, 2),
('2023-01-16', 350.00, 4, 2),
('2023-01-17', 700.00, 1, 3),
('2023-01-18', 300.00, 2, 3),
('2023-01-19', 1100.00, 3, 1),
('2023-01-20', 600.00, 4, 1);

/* BONUS: Esporre l’elenco delle transazioni indicando nel result set il codice documento,
 la data, il nome del prodotto, la categoria del prodotto, il nome dello stato,
 il nome della regione di vendita e un campo booleano valorizzato in base alla condizione
 che siano passati più di 180 giorni dalla data vendita o meno (>180 -> True, <= 180 -> False)*/

SELECT 
    Sales.Sale_ID AS Codice_Documento,
    Sales.Date AS Data,
    Product.Name AS Nome_Prodotto,
    Product_Category.Category_Name AS Categoria_Prodotto,
    States.State_Name AS Nome_Stato,
    Region.Region_Name AS Nome_Regione,
    CASE 
        WHEN TIMESTAMPDIFF(DAY, Sales.Date, CURRENT_DATE()) > 180 THEN 'True'
        ELSE 'False'
    END AS Passati_180_Giorni
FROM 
    Sales
JOIN 
    Product ON Sales.Product_ID = Product.Product_ID
JOIN 
    Product_Category ON Product.Category_ID = Product_Category.Category_ID
JOIN 
    States ON Sales.Region_ID = States.State_ID
JOIN 
    Region ON States.Region_ID = Region.Region_ID;
    
/*   Verificare che i campi definiti come PK siano univoci */
  
-- Verifica univocità dei campi PK nella tabella Sales
SELECT 
    COUNT(*) = COUNT(DISTINCT Sale_ID) AS Sales_PK_Univoci
FROM 
    Sales;

-- Verifica univocità dei campi PK nella tabella Product
SELECT 
    COUNT(*) = COUNT(DISTINCT Product_ID) AS Product_PK_Univoci
FROM 
    Product;

-- Verifica univocità dei campi PK nella tabella Region
SELECT 
    COUNT(*) = COUNT(DISTINCT Region_ID) AS Region_PK_Univoci
FROM 
    Region;

-- Verifica univocità dei campi PK nella tabella States
SELECT 
    COUNT(*) = COUNT(DISTINCT State_ID) AS States_PK_Univoci
FROM 
    States;

-- Verifica univocità dei campi PK nella tabella Product_Category
SELECT 
    COUNT(*) = COUNT(DISTINCT Category_ID) AS Product_Category_PK_Univoci
FROM 
    Product_Category;  
  
  -- Verifica univocità dei campi PK in tutte le tabelle
SELECT 'Sales' AS Tabella, COUNT(*) = COUNT(DISTINCT Sale_ID) AS PK_Univoci FROM Sales
UNION ALL
SELECT 'Product' AS Tabella, COUNT(*) = COUNT(DISTINCT Product_ID) AS PK_Univoci FROM Product
UNION ALL
SELECT 'Region' AS Tabella, COUNT(*) = COUNT(DISTINCT Region_ID) AS PK_Univoci FROM Region
UNION ALL
SELECT 'States' AS Tabella, COUNT(*) = COUNT(DISTINCT State_ID) AS PK_Univoci FROM States
UNION ALL
SELECT 'Product_Category' AS Tabella, COUNT(*) = COUNT(DISTINCT Category_ID) AS PK_Univoci FROM Product_Category;
  
  
   --  Esporre l’elenco dei soli prodotti venduti e per ognuno di questi il fatturato totale per anno
  SELECT 
    YEAR(s.Date) AS Anno,
    p.Name AS Prodotto,
    SUM(s.Amount) AS Fatturato_Totale
FROM 
    Sales s
JOIN 
    Product p ON s.Product_ID = p.Product_ID
GROUP BY 
    Anno, p.Product_ID;
    
    
    -- Esporre il fatturato totale per stato per anno. Ordina il risultato per data e per fatturato decrescente
    SELECT 
    YEAR(s.Date) AS Anno,
    st.State_Name AS Stato,
    SUM(s.Amount) AS Fatturato_Totale
FROM 
    Sales s
JOIN 
    States st ON s.Region_ID = st.State_ID
GROUP BY 
    Anno, st.State_ID
ORDER BY 
    Anno, Fatturato_Totale DESC;
    
    
    -- Per determinare la categoria di articoli maggiormente richiesta dal mercato, possiamo usare questa query
    SELECT 
    pc.Category_Name,
    COUNT(s.Product_ID) AS Numero_Vendite
FROM 
    Product p
JOIN 
    Product_Category pc ON p.Category_ID = pc.Category_ID
LEFT JOIN 
    Sales s ON p.Product_ID = s.Product_ID
GROUP BY 
    pc.Category_Name
ORDER BY 
    Numero_Vendite DESC
LIMIT 1;


/* Per trovare i prodotti invenduti, possiamo utilizzare due approcci differenti. 
Uno potrebbe essere trovare i prodotti che non compaiono nelle vendite,
 l'altro potrebbe essere trovare i prodotti presenti ma senza corrispondente fatturato
 (quantità venduta pari a 0) */
 
 -- Approccio 1: Prodotti non venduti
SELECT 
    p.Name AS Prodotto
FROM 
    Product p
LEFT JOIN 
    Sales s ON p.Product_ID = s.Product_ID
WHERE 
    s.Product_ID IS NULL;

-- Approccio 2: Prodotti senza fatturato
SELECT 
    p.Name AS Prodotto
FROM 
    Product p
LEFT JOIN 
    Sales s ON p.Product_ID = s.Product_ID
GROUP BY 
    p.Product_ID
HAVING 
    SUM(s.Amount) IS NULL;
    
    -- Esporre l’elenco dei prodotti con la rispettiva ultima data di vendita (la data di vendita più recente)
    SELECT 
    p.Name AS Prodotto,
    MAX(s.Date) AS Ultima_Data_Vendita
FROM 
    Product p
JOIN 
    Sales s ON p.Product_ID = s.Product_ID
GROUP BY 
    p.Product_ID;