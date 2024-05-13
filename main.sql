-- Afficher toutes les données des clients 
SELECT * FROM customer;

-- Afficher le nom_du_produit et la catégorie pour les produits dont le prix est compris entre 5000 et 10000
SELECT product_id, category, price FROM produits WHERE price BETWEEN 5000 AND 10000;

-- Affichez toutes les données des produits triés par ordre décroissant de prix.
SELECT * FROM product ORDER BY price DESC;

-- Afficher le nombre total de commandes, le montant moyen, le montant total le plus élevé et le montant total inférieur. Pour chaque product_id, afficher le nombre de commandes
SELECT COUNT(*) AS nombre_de_commandes,
       AVG(montant) AS montant_moyen,
       MAX(montant) AS montant_total_le_plus_elevé,
       MIN(montant) AS montant_total_le_plus_bas,
       product_id,
       COUNT(DISTINCT command_id) AS nombre_de_commandes_par_produit
FROM commandes
GROUP BY product_id;

-- Afficher le customer_id qui a plus de 2 commandes   
SELECT customer_id
FROM commandes
GROUP BY customer_id
HAVING COUNT(*) > 2;

-- Pour chaque mois de l'année 2020, affichez le nombre de commandes
SELECT MONTH(date_commande) AS mois, COUNT(*) AS nombre_de_commandes
FROM commandes
WHERE YEAR(date_commande) = 2020
GROUP BY MONTH(date_commande);

-- Pour chaque commande, affichez le nom_produit, le nom_client et la date de la commande
SELECT p.nom_du_produit, c.nom_client, co.date_commande
FROM commandes co
JOIN produits p ON co.product_id = p.product_id
JOIN clients c ON co.customer_id = c.customer_id;

-- Afficher toutes les commandes passées il y a trois mois 
SELECT *
FROM commandes
WHERE date_commande >= DATE_SUB(CURRENT_DATE(), INTERVAL 3 MONTH);

-- Afficher les clients (customer_id) qui n'ont jamais commandé de produit
SELECT c.customer_id
FROM customer
LEFT JOIN commandes co ON c.customer_id = co.customer_id
WHERE co.customer_id IS NULL;