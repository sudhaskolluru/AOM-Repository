CREATE VIEW sup_orders AS  
SELECT suppliers.supplier_id, orders.quantity, orders.price  
FROM suppliers  
INNER JOIN orders  
ON suppliers.supplier_id = supplier_id  
WHERE suppliers.supplier_name = 'VOJO';  