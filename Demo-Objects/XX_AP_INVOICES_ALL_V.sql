CREATE OR REPLACE VIEW XX_AP_INVOICES_ALL_V AS
SELECT invoice_id,
       invoice_num,
       invoice_amount
FROM   ap_invoices_all;