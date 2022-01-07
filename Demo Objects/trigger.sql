
-- BEGIN BEGIN BEGIN
CREATE OR REPLACE TRIGGER xxspwr_ap_lines_intf_trg
BEFORE INSERT ON  ap_invoice_lines_interface
FOR EACH ROW
DECLARE
  l_inv_accrual_act gl_code_combinations.segment5%TYPE;
  l_ap_accrual_act  gl_code_combinations.segment5%TYPE;
  l_from_org_id     NUMBER;
  --l_to_org_id              NUMBER;
  l_from_ou      NUMBER;
  l_to_ou        NUMBER;
  l_code_combination_id number;
  l_segment1     gl_code_combinations.segment1%TYPE;
  l_segment2     gl_code_combinations.segment2%TYPE;
  l_segment3     gl_code_combinations.segment3%TYPE;
  l_segment4     gl_code_combinations.segment4%TYPE;
  l_segment5     gl_code_combinations.segment5%TYPE;
  l_segment6     gl_code_combinations.segment6%TYPE;
  l_segment7     gl_code_combinations.segment7%TYPE;
  l_segment8     gl_code_combinations.segment8%TYPE;
  l_new_id       gl_code_combinations.code_combination_id%TYPE;
  l_source       VARCHAR2(100);
  l_non_ship_acct_segment varchar2(50);
  l_invoice_num  ap_invoices_all.invoice_num%TYPE;
  ic_non_trx_acf number;
  CURSOR cr_trx(p_trx_id IN NUMBER) IS
    SELECT interface_header_attribute3 from_org_id,
           interface_header_attribute5 from_ou,
           interface_header_attribute4 to_ou
      FROM ra_customer_trx_all
     WHERE customer_trx_id = p_trx_id;
  CURSOR cr_trx1(p_inv_num IN VARCHAR2) IS
    SELECT interface_header_attribute3 from_org_id,
           interface_header_attribute5 from_ou,
           interface_header_attribute4 to_ou
      FROM ra_customer_trx_all
     WHERE trx_number || '-' || org_id = p_inv_num;
  CURSOR cr_act1(p_from_ou IN number, p_to_ou IN NUMBER) IS
    SELECT gcc.segment5
      FROM MTL_INTERCOMPANY_PARAMETERS_V, gl_code_combinations gcc
     WHERE ship_organization_id = p_from_ou
       AND sell_organizatioN_id = p_to_ou
       AND gcc.code_combinatioN_id = inventory_accrual_account_id
       AND gcc.chart_of_accounts_id = 50308;
  CURSOR cr_act(p_inv_org_id IN NUMBER) IS
    SELECT gcc.segment5
      FROM mtl_parameters mpv, gl_code_combinations gcc
     WHERE organization_id = p_inv_org_id
       AND gcc.code_combinatioN_id = ap_accrual_account
       AND gcc.chart_of_accounts_id = 50308;
  CURSOR cr_act2(p_cc_id IN NUMBER) IS
    SELECT segment1,
           segment2,
           segment3,
           segment4,
           segment5,
           segment6,
           segment7,
           segment8
      FROM gl_code_combinations gcc
     WHERE code_combinatioN_id = p_cc_id
       AND gcc.chart_of_accounts_id = 50308;
  CURSOR cr_source(p_inv_id NUMBER) IS
    SELECT decode(upper(SOURCE), 'INTERCOMPANY', 'INTERCOMPANY_TRX', NULL),
           invoice_num
      FROM ap_invoices_interface
     WHERE invoice_id = p_inv_id;
BEGIN
  OPEN cr_source(:new.invoice_id);
  FETCH cr_source
    INTO l_source, l_invoice_num;
  CLOSE cr_source;
  IF /*:new.TRX_BUSINESS_CATEGORY='INTERCOMPANY_TRANSACTION' AND*/
   nvl(:new.source_event_class_code, l_source) = 'INTERCOMPANY_TRX' THEN
    IF :new.source_trx_id IS NOT NULL THEN
      OPEN cr_trx(:new.source_trx_id);
      FETCH cr_trx
        INTO l_from_org_id, l_from_ou, l_to_ou;
      CLOSE cr_trx;
    ELSE
      OPEN cr_trx1(l_invoice_num);
      FETCH cr_trx1
        INTO l_from_org_id, l_from_ou, l_to_ou;
      CLOSE cr_trx1;
    END IF;
    OPEN cr_act(l_from_org_id);
    FETCH cr_act
      INTO l_ap_accrual_act;
    CLOSE cr_act;
    OPEN cr_act2(:NEW.dist_code_combination_id);
    FETCH cr_act2
      INTO l_segment1,
           l_segment2,
           l_segment3,
           l_segment4,
           l_segment5,
           l_segment6,
           l_segment7,
           l_segment8;
    CLOSE cr_act2;
    IF l_segment5 = l_ap_accrual_act THEN
      OPEN cr_act1(l_from_ou, l_to_ou);
      FETCH cr_act1
        INTO l_inv_accrual_act;
      CLOSE cr_act1;
      l_new_id := fnd_flex_ext.get_ccid('SQLGL',
                                        'GL#',
                                        50308,
                                        to_char(sysdate,
                                                'YYYY/MM/DD HH24:MI:SS'),
                                        l_segment1 || '-' || l_segment2 || '-' ||
                                        l_segment3 || '-' || l_segment4 || '-' ||
                                        l_inv_accrual_act || '-' ||
                                        l_segment6 || '-' || l_segment7 || '-' ||
                                        l_segment8);
      IF nvl(l_new_id, 0) <> 0 THEN
        :new.dist_code_combination_id := l_new_id;
      END IF;
    END IF;
  END IF;
   begin
    select 1
      into ic_non_trx_acf
      from apps.t_cf_keys tck, apps.xxspwr_rma_pattern_header xrph
     where xrph.non_ship_trx_id = tck.erp_transaction_id
       and to_char(tck.cf_transaction_id) = :new.attribute10;
       --insert into temp_tab values (:new.attribute10,:new.org_id,:new.dist_code_combination_id,1);
  exception
    when others then
      ic_non_trx_acf := 0;
  end;
  if ic_non_trx_acf = 1 then
    begin
      select flv.TAG
        into l_non_ship_acct_segment
        from apps.hr_operating_units hou, apps.fnd_lookup_values flv
       where hou.organization_id = :new.org_id --1196
         and hou.name = flv.meaning
         and flv.lookup_type = 'XXSPWR_RMA_JV_ACCOUNTS';
      -- insert into temp_tab values (:new.attribute10,:new.org_id,:new.dist_code_combination_id,2);         
    exception
      when others then
        l_non_ship_acct_segment := null;
    end;
    if l_non_ship_acct_segment is not null then
      begin
        select code_combination_id
          into l_code_combination_id
          from apps.gl_code_combinations_kfv
         where concatenated_segments =
               l_non_ship_acct_segment
           and rownum = 1;
      -- insert into temp_tab values (:new.attribute10,:new.org_id,:new.dist_code_combination_id,3);           
      exception
        when others then
          l_code_combination_id := null;
      end;
      if l_code_combination_id is not null then
             --  insert into temp_tab values (:new.attribute10,:new.org_id,:new.dist_code_combination_id,4);
        :new.dist_code_combination_id := l_code_combination_id;
      end if;
    end if;
  end if;
EXCEPTION
  WHEN OTHERS THEN
    NULL;
END xxspwr_ap_lines_intf_trg;
/
