-- Databricks notebook source
select * from client

-- COMMAND ----------

drop table if exists commande_up;
 
create table commande_up as
select 
numcde
, datecde
, idcli
, numpce
, qtecde
-- , mtcde
--, replace(mtcde, ",", ".") as op1
--, replace(mtcde, " ", "") as op2
--, replace(replace(mtcde, ",", ".") , " ", "") as op3
, cast(replace(replace(mtcde, ",", ".") , " ", "")  as float) as mtcde -- La variable mtcde recodée
-- Opération 1: remplacer les , par .
-- Opération 2: Remplacer les espaces par une abscence de valeur
-- Opération 3: Casting en float
from commande

-- COMMAND ----------

Select * from commande_up
--Je n'ai pas reussi a comprendre pourquoi la colonne mtcde ne m'affiche aucunes valeurs

-- COMMAND ----------

--jointure cmd et piece
select * from commande_up inner join piece on commande_up.numpce = piece.numpce

-- COMMAND ----------

select * from fournisseur

-- COMMAND ----------

select * from piece

-- COMMAND ----------

--Requête 1 : Donner les caractéristiques des clients
select * from client

-- COMMAND ----------

--Requête 2 : Donner toutes les villes des fournisseurs
select vilfour from fournisseur

-- COMMAND ----------

--Requête 3 : Donner les villes et code postaux des clients
select vilcli, cpcli from client

-- COMMAND ----------

--Requête 4 : Donner, pour chaque pièce, son prix TTC
select * from piece

-- COMMAND ----------

--Requête 5 : Donner les caractéristiques des fournisseurs de Dijon
select * from fournisseur where vilfour like 'dijon'

-- COMMAND ----------

--Requête 6 : Donner les caractéristiques des commandes de plus de 1000 euros
select * from commande_up 

-- COMMAND ----------

--Requête 7 : Donner la liste des clients habitant Dijon et des clients habitant Lyon
select * from client where vilcli like 'Lyon' 


-- COMMAND ----------

select * from client where vilcli like 'Dijon' 

-- COMMAND ----------

--Requête 8 : Donner la liste des clients habitant Lyon, Dijon, Marseille, Paris
select * from client where vilcli like 'Lyon' 

-- COMMAND ----------

--Requête 9 : Donner la liste des pièces dont le prix est supérieur à 800 et inférieur à 1000


-- COMMAND ----------

--Requête 10 : Donner la liste des clients dont le nom commence par M (pas de % dans Access
--remplacer par *)
select * from client where nomcli like 'm%' 

-- COMMAND ----------

--Requête 11 : Donner la liste des clients dont on ignore le téléphone
select * from client --where tecli = 'null'

-- COMMAND ----------

--Requête 12 : Donner le nom des fournisseurs habitant Lyon
select nomfour from fournisseur where vilfour like 'lyon' 

-- COMMAND ----------

--Requête 14 : Dénombrer les clients ayant déjà passé commandes.
--jointure cmd et client
select * from client inner join commande_up on client.idcli= commande_up.idcli where qtecde > 0

-- COMMAND ----------

--Requête 15 : Donner le nombre de commandes dont le montant dépasse 1000 euros.
select count(mtcde) from commande where mtcde >1000


-- COMMAND ----------

--Requête 16 : Donner la moyenne des prix des pièces, le prix mini, le prix maxi.
select MAX(pupce), MIN(pupce), ROUND(AVG(pupce),2) as moyenne
from piece

-- COMMAND ----------

--Requête 17 : Donner le nombre total de pièces commandées par le client n° 9002.
select count(qtecde) from client inner join commande_up on client.idcli= commande_up.idcli where nomcli like 'rossi' 

-- COMMAND ----------

--Requête 18 : Donner, pour chaque client ayant commandé, son numéro et le montant cumulé
--de ses commandes.
select telcli, mtcde from client inner join commande_up on client.idcli= commande_up.idcli where qtecde>0

-- COMMAND ----------

--Requête 19 : Donner, pour chaque ville de fournisseur, le nombre de fournisseurs y résidant.
select count(nomfour) from fournisseur 

-- COMMAND ----------

--Requête 20 : Donner, pour chaque pièce en stock, son numéro, son nom, son prix et le
--nombre moyen de quantité commandée.
select numpiece, nompiece, from piece

-- COMMAND ----------

--Requête 21 : Donner, pour chaque pièce en stock, son numéro, son nom, son prix et le
--nombre moyen de quantité commandée, seulement si le prix est inférieur à 500 euros.


-- COMMAND ----------

--Requête 22 : Donner, pour chaque client ayant commandé, son numéro et le montant cumulé
--de ses commandes et seulement si ce montant cumulé dépasse 2000 euros.
select telcli, mtcde from client inner join commande_up on client.idcli=commande_up.idcli where mtcde > 2000

-- COMMAND ----------

--Requête 23 : Donner la liste des produits (libellé et quantité en stock) par ordre alphabétique
--croissant.
select nompce, qtestpce from piece order by nompce asc

-- COMMAND ----------

--Requête 24 : Donner la liste des produits (quantité en stock, libellé, prix en euro), triée par
--quantité en stock décroissante et par prix croissant.
select qtestpce, nompce, pupce from piece order by qtestpce desc, pupce asc

-- COMMAND ----------


