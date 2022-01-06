CREATE VIEW sup_orders AS  
SELECT suppliers.supplier_id, orders.quantity, orders.price  FROM suppliers  
