CREATE DATABASE toysgroup1;
USE toysgroup1;

-- TASK 2: DESCRIVO LA STRUTTURA DELLE TABELLE UTILI X LO SCENARIO
-- 1 TABELLA CATEGORIA
CREATE TABLE Categoria (
ID INT AUTO_INCREMENT PRIMARY KEY,
TipologiaGioco VARCHAR (50),
Tema VARCHAR (100));

-- 2 TABELLA PRODOTTO
CREATE TABLE Prodotto (
ID INT AUTO_INCREMENT PRIMARY KEY,
Nome VARCHAR (70),
EtaRaccomandata VARCHAR (10),
PrezzoListino DECIMAL (10,2),
StandardCost DECIMAL (10,2),
CategoriaID INT,
FOREIGN KEY (CategoriaID) REFERENCES Categoria (ID));

-- 3 TABELLA VENDITE
CREATE TABLE Vendite (
ID INT AUTO_INCREMENT PRIMARY KEY,
ProdottoID INT,
DataOrdine DATE,
DataVendita DATE,
Quantita INT,
PrezzoUnitario DECIMAL (10,2),
FOREIGN KEY (ProdottoID) REFERENCES Prodotto (ID));

-- 4 TABELLA REGIONE
CREATE TABLE Regione (
ID INT AUTO_INCREMENT PRIMARY KEY,
Stato VARCHAR (50),
Regione VARCHAR (50),
VenditeID INT,
FOREIGN KEY (VenditeID) REFERENCES Vendite (ID));


-- TASK 3: POPOLO LE TABELLE CON I DATI
INSERT INTO Categoria (TipologiaGioco, Tema) VALUES
('Carte', 'Fantasy'),
('Da Tavolo', 'Strategia'),
('Videogioco', 'Avventura'),
('Puzzle', 'Logica'),
('Sportivo', 'Calcio'),
('Giochi di Ruolo', 'Medievale'),
('Giochi da Casinò', 'Poker'),
('Giochi Educativi', 'Matematica'),
('Escape Room', 'Mistero'),
('Giochi di Ruolo', 'Medievale'), 
('Carte', 'Fantasy'); 
SELECT * FROM Categoria;

INSERT INTO Prodotto (Nome, EtaRaccomandata, PrezzoListino, StandardCost, CategoriaID) VALUES
('Mazzo di carte Fantasy', '10+', 14.99, 7.00, 1),
('Scacchi Strategici', '8+', 24.99, 12.50, 2),
('Videogioco Avventura', '12+', 49.99, 25.00, 3),
('Puzzle Logico 3D', '6+', 19.99, 9.50, 4),
('Pallone da Calcio', '3+', 22.99, 11.00, 5),
('Set di Dadi per GdR', '14+', 12.99, 5.50, 6),
('Set Poker Professionale', '18+', 49.99, 20.00, 7),
('Gioco Educativo Matematica', '7+', 17.99, 8.00, 8),
('Escape Room da Tavolo', '16+', 34.99, 17.50, 9),
('Mazzo di carte Fantasy', '10+', 14.99, 7.00, 1); 
SELECT * FROM Prodotto;

INSERT INTO Vendite (ProdottoID, DataOrdine, DataVendita, Quantita, PrezzoUnitario) VALUES
(1, '2023-06-15', '2023-06-17', 3, 14.99),  
(2, '2023-03-10', '2023-03-12', 2, 24.99),  
(3, '2024-07-05', '2024-07-07', 5, 49.99),  
(4, '2022-09-20', '2022-09-22', 1, 19.99),  
(5, '2023-11-30', NULL, 0, 22.99),  
(6, '2024-05-18', '2024-05-20', 4, 12.99),  
(7, '2025-01-25', NULL, 0, 39.99),  
(8, '2022-12-05', '2022-12-07', 2, 17.99),  
(9, '2023-08-14', '2023-08-16', 3, 34.99),  
(10, '2025-02-10', NULL, 0, 14.99);  
SELECT * FROM Vendite;

INSERT INTO Regione (Stato, Regione, VenditeID) VALUES
('Norvegia', 'Nord Europa', 1),  
('Italia', 'Sud Europa', 2),  
('Francia', 'Ovest Europa', 3),  
('Romania', 'Est Europa', 4),  
('Spagna', 'Sud Europa', 5),  
('Svezia', 'Nord Europa', 6),  
('Polonia', 'Est Europa', 7), 
('Germania', 'Ovest Europa', 8),  
('Portogallo', 'Sud Europa', 9),  
('Finlandia', 'Nord Europa', 10);
SELECT * FROM Regione;  

-- TASK 4: 
-- PUNTO 1) VERIFICO UNIVOCITA' DEI CAMPI DEFINITI COME PK
SELECT ID, COUNT(*) 
FROM Categoria 
GROUP BY ID
HAVING COUNT(*) > 1;

SELECT ID, COUNT(*) 
FROM Prodotto
GROUP BY ID
HAVING COUNT(*) > 1;

SELECT ID, COUNT(*) 
FROM Regione
GROUP BY ID
HAVING COUNT(*) > 1;

SELECT ID, COUNT(*) 
FROM Vendite
GROUP BY ID
HAVING COUNT(*) > 1;

-- PUNTO 2)
-- PRIMA DI ESEGUIRE QUANTO RICHIESTO, DEVO AGGIUNGERE IL 'CODICE DOCUMENTO' NELLA TABELLA VENDITE
ALTER TABLE Vendite
ADD COLUMN CodiceDocumento VARCHAR (5) AFTER ID;
UPDATE Vendite
SET CodiceDocumento = CASE ID
    WHEN 1 THEN 'AB001'
    WHEN 2 THEN 'CD002'
    WHEN 3 THEN 'EF003'
    WHEN 4 THEN 'GH004'
    WHEN 5 THEN 'IL005'
    WHEN 6 THEN 'MN006'
    WHEN 7 THEN 'OP007'
    WHEN 8 THEN 'QR008'
    WHEN 9 THEN 'ST009'
    WHEN 10 THEN 'UV010'
END WHERE ID BETWEEN 1 AND 10;
SELECT * FROM Vendite;
SELECT * FROM regione;
-- AGGIUNGO CAMPO BOOLEANO
SELECT v.CodiceDocumento, v.DataOrdine, v.DataVendita, p.Nome as NomeProdotto, c.TipologiaGioco as CategoriaProdotto, r.Stato, r.Regione, CASE 
WHEN DATEDIFF(CURRENT_DATE, v.DataVendita) > 180 THEN 'TRUE' ELSE 'FALSE' END AS Più180Giorni
FROM Vendite as v
JOIN Prodotto as p ON v.ProdottoID = p.ID
JOIN Categoria as c ON p.CategoriaID = c.ID
JOIN Regione as r ON v.ID = r.VenditeID;


ALTER TABLE Vendite
ADD COLUMN TotaleVenduto DECIMAL (10,2) AFTER PrezzoUnitario;
UPDATE Vendite SET TotaleVenduto = Quantita * PrezzoUnitario;
SELECT * FROM vendite;
-- modifico alcune date in 2025
UPDATE Vendite 
SET DataVendita = CASE 
    WHEN ID = 1 THEN '2023-06-17'
    WHEN ID = 2 THEN '2023-03-15'
    WHEN ID = 3 THEN '2025-01-06'
    WHEN ID = 4 THEN '2022-09-22'
    WHEN ID = 5 THEN NULL
    WHEN ID = 6 THEN '2024-05-20'
    WHEN ID = 7 THEN '2025-01-27'
    WHEN ID = 8 THEN '2022-12-07'
    WHEN ID = 9 THEN '2023-08-16'
    WHEN ID = 10 THEN NULL
END
WHERE ID BETWEEN 1 AND 10; 
UPDATE Vendite  
SET Quantita = 4,  
    TotaleVenduto = 4 * PrezzoUnitario  
WHERE ID = 7;

-- PUNTO 3) ESPONGO L'ELENCO DEI PRODOTTI CHE HANNO VENDUTO UNA QUANTITA' MAGGIORE DELLA MEDIA NELL'ULTIMO ANNO

SELECT v.ProdottoID, SUM(v.TotaleVenduto) as TotaleVenduto
FROM Vendite as v
WHERE YEAR(v.DataVendita) = (SELECT MAX(YEAR(DataVendita)) FROM Vendite)
GROUP BY v.ProdottoID
HAVING SUM(v.TotaleVenduto) > (SELECT AVG(TotaleVenduto)
        FROM (
            SELECT SUM(v1.TotaleVenduto) AS TotaleVenduto
            FROM Vendite as v1
            WHERE YEAR(v1.DataVendita) = (SELECT MAX(YEAR(DataVendita)) FROM Vendite)
            GROUP BY v1.ProdottoID) AS VenditeProdotto);
            
-- PUNTO 4) ESPONGO L'ELENCO DEI SOLI PRODOTTI VENDUTI E PER OGNUNO IL FATTURATO TOTALE

SELECT p.ID AS CodiceProdotto, 
       YEAR(v.datavendita) AS Anno, 
       SUM(v.quantita * v.prezzounitario) AS FatturatoTotale
FROM vendite as v
JOIN prodotto as p ON v.prodottoID = p.ID
WHERE v.datavendita IS NOT NULL
GROUP BY p.ID, YEAR(v.datavendita)
ORDER BY CodiceProdotto, Anno;

-- PUNTO 5) ESPONGO FATTURATO TOT PER STATO PER ANNO E ORDINO PER FATT DECRESCENTE

SELECT * FROM Regione;
SELECT r.stato AS stato,
       YEAR(v.datavendita) AS anno, 
       SUM(v.quantita * v.prezzounitario) AS FatturatoTotale
FROM vendite as v
JOIN regione as r ON v.ID = r.venditeID
WHERE v.datavendita IS NOT NULL
GROUP BY r.stato, YEAR(v.datavendita)
ORDER BY FatturatoTotale DESC;

-- PUNTO 6) CATEGORIA MAGGIORMENTE RICHIESTA DAL MERCATO

SELECT * FROM categoria;
SELECT c.tipologiagioco AS categoria, 
       SUM(v.quantita) AS TotQuantitaVenduta
FROM vendite as v
JOIN prodotto as p ON v.prodottoID = p.ID
JOIN categoria as c ON p.categoriaID = c.ID
GROUP BY c.tipologiagioco
ORDER BY TotQuantitaVenduta DESC
LIMIT 1;

-- PUNTO 7) QUALI SONO I PRODOTTI INVENDUTI? 2 APPROCCI RISOLUTIVI
-- aggiungo prima una colonna prodottoinvenduto
ALTER TABLE vendite 
ADD COLUMN ProdottoInvenduto VARCHAR (10) AFTER DataVendita;        
SELECT * FROM vendite;
UPDATE vendite SET ProdottoInvenduto = CASE
WHEN ID IN (5,10) THEN 'TRUE'
ELSE 'FALSE'
END;

SELECT v.ProdottoID AS CodiceProdotto, 
       p.nome
FROM prodotto as p
JOIN vendite as v on p.ID = v.ProdottoID
WHERE V.prodottoinvenduto = 'TRUE';

SELECT p.ID AS CodiceProdotto, 
       p.nome
FROM prodotto as p
JOIN vendite as v ON p.ID = v.prodottoID
WHERE v.datavendita IS NULL;

-- PUNTO 8) CREO UNA VISTA SUI PRODOTTI
CREATE VIEW VistaProdotti AS (
SELECT p.ID as CodiceProdotto, p.Nome as Nomeprodotto, c.TipologiaGioco as Categoria
FROM Prodotto as p
JOIN Categoria as c ON p.CategoriaID = c.ID);
SELECT * FROM VistaProdotti;

-- PUNTO 9) CREO VISTA PER INFORMAZIONI GEORGRAFICHE
SELECT * FROM regione;
CREATE VIEW InfoGeografiche AS (
SELECT 
    r.ID AS CodiceRegione,
    r.Stato AS Stato,
    r.regione AS Regione,
    v.ID AS VenditeID,
    v.datavendita,
    v.quantita,
    v.prezzounitario
FROM regione as r
JOIN vendite as v ON r.venditeID = v.ID);
SELECT * FROM InfoGeografiche;