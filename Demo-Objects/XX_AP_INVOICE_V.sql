CREATE OR REPLACE VIEW xx_ap_invoice_v AS
SELECT invoice_id,
       invoice_num,
       invoice_amount,
       invoice_date   -- added column
FROM   ap_invoices_all;
