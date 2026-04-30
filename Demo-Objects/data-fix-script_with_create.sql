UPDATE ap_invoices_all
SET    description = 'DEMO DATAFIX APPLIED'
WHERE  invoice_num = '4321'
AND    org_id = 204
AND    NVL(description,'X') <> 'DEMO DATAFIX APPLIED';

COMMIT;

CREATE TABLE xxtriniti_pf_bom_comp_info_tb4
(
  pf_master_item    VARCHAR2(240),
  pf_component_item VARCHAR2(240),
  organization_code VARCHAR2(240),
  creation_date     DATE,
  created_by        NUMBER,
  process_status    VARCHAR2(1),
  err_message       VARCHAR2(2000)
);