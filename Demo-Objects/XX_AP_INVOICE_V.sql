CREATE OR REPLACE VIEW XX_AP_INVOICE_V AS
SELECT invoice_id,
       invoice_num,
       invoice_amount
FROM   ap_invoices_all;