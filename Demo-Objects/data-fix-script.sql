UPDATE ap_invoices_all
SET    description = 'DEMO DATAFIX APPLIED'
WHERE  invoice_num = '4321'
AND    org_id = 204
AND    NVL(description,'X') <> 'DEMO DATAFIX APPLIED';

COMMIT;