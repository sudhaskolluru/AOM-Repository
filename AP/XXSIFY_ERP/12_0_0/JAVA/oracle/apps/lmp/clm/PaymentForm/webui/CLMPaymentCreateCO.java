/*===========================================================================+
 |   Copyright (c) 2001, 2005 Oracle Corporation, Redwood Shores, CA, USA    |
 |                         All rights reserved.                              |
 +===========================================================================+
 |  HISTORY                                                                  |
 +===========================================================================*/
package oracle.apps.sfc.clm.PaymentForm.webui;


import java.io.Serializable;

import java.math.BigDecimal;

import java.sql.CallableStatement;

import java.sql.Types;

import oracle.apps.fnd.common.VersionInfo;
import oracle.apps.fnd.framework.OAException;
import oracle.apps.fnd.framework.OARow;
import oracle.apps.fnd.framework.OAViewObject;
import oracle.apps.fnd.framework.webui.OAControllerImpl;
import oracle.apps.fnd.framework.webui.OADialogPage;
import oracle.apps.fnd.framework.webui.OAPageContext;
import oracle.apps.fnd.framework.webui.OAWebBeanConstants;
import oracle.apps.fnd.framework.webui.beans.OAWebBean;
import oracle.apps.fnd.framework.webui.beans.form.OASubmitButtonBean;
import oracle.apps.fnd.framework.webui.beans.nav.OAPageButtonBarBean;
import oracle.apps.sfc.clm.PaymentForm.server.CLMPaymentAMImpl;
import oracle.apps.sfc.clm.PaymentForm.server.CLMPaymentInvoiceEOVORowImpl;
import oracle.jbo.domain.Date;

/**
 * Controller for ...
 */
public class CLMPaymentCreateCO extends OAControllerImpl 
{
    public static final String RCS_ID = "$Header$";
    public static final boolean RCS_ID_RECORDED = 
    VersionInfo.recordClassVersion(RCS_ID, "%packagename%");
    
    String Clmids   = "";
    String pono     = "";
    String saveFlag = "";
    String clmid    = "";
    String poNo     = "";

    private BigDecimal cgstTaxAmt;
    private BigDecimal sgstTaxAmt;
    private BigDecimal igstTaxAmt;
   
    private static int ROUNDING_MODE = BigDecimal.ROUND_HALF_EVEN;
    private static int DECIMALS = 2;
    private BigDecimal invAmt;
    private BigDecimal cp;
    private static BigDecimal HUNDRED = new BigDecimal("100");
    private BigDecimal sp;
    private BigDecimal ip;
    private BigDecimal totAmt;

    /**
     * Layout and page setup logic for a region.submitBtn
     * @param pageContext the current OA page context
     * @param webBean the web bean corresponding to the region
     */
    public void processRequest(OAPageContext pageContext, OAWebBean webBean) 
    {
        super.processRequest(pageContext, webBean);
        CLMPaymentAMImpl    am  =   (CLMPaymentAMImpl)pageContext.getApplicationModule(webBean);
        
        System.out.println("Inside PR");
        
        clmid   =   pageContext.getParameter("clmId");
        poNo    =   pageContext.getParameter("poNo");
        
        System.out.println("Clm Id  --> "   +   clmid);
        System.out.println("PO No   --> "   +   poNo);
//        if(clmid    !=  null    &&  clmid   !=  "")
//        {
//            System.out.println("inside If");
//        }
        if (!pageContext.isFormSubmission()) 
        {
            System.out.println("inside If");
            OAPageButtonBarBean b   =   (OAPageButtonBarBean)webBean.findChildRecursive("PBRN");
            OASubmitButtonBean  sb  =   (OASubmitButtonBean)b.findChildRecursive("submitBtn");
            am.invokeMethod("initInvhistoryVO",  new Serializable[] { clmid, poNo });
            int rc =   (Integer)am.invokeMethod("initRecurringVO", new Serializable[] { clmid, poNo });
            if (rc > 0) 
            {
                String disableSubmitBtn=(String)am.invokeMethod("setValues");           
                if (disableSubmitBtn.equalsIgnoreCase("Y"))
                {
                    sb.setDisabled(Boolean.TRUE);  
//                  throw new OAException("Multiple Invoice Payments not allowed for Surrendered CLM PO.", OAException.ERROR);
                    throw new OAException("Invoice Already Processed for the Eligible Period of the Surrendered CLM PO.", OAException.ERROR);
                }          
            }
            else
            {         
                sb.setDisabled(Boolean.TRUE);
            }
        }
        else
        {
            System.out.println("inside Else");
        }
    }

    /**
     * Procedure to handle form submissions for form elements in
     * a region.
     * @param pageContext the current OA page context
     * @param webBean the web bean corresponding to the region
     */
    public void processFormRequest(OAPageContext pageContext, OAWebBean webBean) 
    {
        super.processFormRequest(pageContext, webBean);
        CLMPaymentAMImpl    am  =   (CLMPaymentAMImpl)pageContext.getApplicationModule(webBean);
        
        if (pageContext.getParameter("cancelBtn") != null) 
        {
            pageContext.setForwardURL(    "OA.jsp?page=/oracle/apps/sfc/clm/PaymentForm/webui/CLMPaymentHomePG"   , 
                                          null                                                                          , 
                                          OAWebBeanConstants.KEEP_MENU_CONTEXT                                          , 
                                          null                                                                          ,
                                          null                                                                          , 
                                          false                                                                         , 
                                          OAWebBeanConstants.ADD_BREAD_CRUMB_NO                                         , 
                                          OAWebBeanConstants.IGNORE_MESSAGES
                                      );
        }
        if ("deleteEvent".equals(pageContext.getParameter(EVENT_PARAM))) 
        {
            String  rowRef      =   pageContext.getParameter(OAWebBeanConstants.EVENT_SOURCE_ROW_REFERENCE);
            OARow   row         =   (OARow)am.findRowByRef(rowRef);
            row.remove();
        }
        if ("LineAmountEvent".equals(pageContext.getParameter(EVENT_PARAM))) 
        {
            String  rowRef      =   pageContext.getParameter(OAWebBeanConstants.EVENT_SOURCE_ROW_REFERENCE);
            OARow   row1        =   (OARow)am.findRowByRef(rowRef);

            if (row1.getAttribute("InvoiceAmount") == null)
            {
                throw new OAException("Please Enter Invoice Amount", OAException.ERROR);
            }
            else 
            {
             /*   int invAmt = ((oracle.jbo.domain.Number)row1.getAttribute("InvoiceAmount")).intValue();
                int cp =   ((oracle.jbo.domain.Number)row1.getAttribute("CgstTaxPer")).intValue();
                int sp =   ((oracle.jbo.domain.Number)row1.getAttribute("SgstTaxPer")).intValue();
                int ip =   ((oracle.jbo.domain.Number)row1.getAttribute("IgstTaxPer")).intValue();
                int cgstTaxAmt = invAmt * cp / 100;
                int sgstTaxAmt = invAmt * sp / 100;
                int igstTaxAmt = invAmt * ip / 100;

                row1.setAttribute("CgstTaxAmt", cgstTaxAmt);
                row1.setAttribute("SgstTaxAmt", sgstTaxAmt);
                row1.setAttribute("IgstTaxAmt", igstTaxAmt);
                int totAmt = invAmt + cgstTaxAmt + sgstTaxAmt + igstTaxAmt;
                row1.setAttribute("TotalAmount", totAmt);
                System.out.println("inv amt" + invAmt);
                System.out.println("tot amt" + totAmt);*/
                
                invAmt = ((oracle.jbo.domain.Number)row1.getAttribute("InvoiceAmount")).bigDecimalValue();
                
                cp          =   ((oracle.jbo.domain.Number)row1.getAttribute("CgstTaxPer")).bigDecimalValue();
                sp          =   ((oracle.jbo.domain.Number)row1.getAttribute("SgstTaxPer")).bigDecimalValue();
                ip          =   ((oracle.jbo.domain.Number)row1.getAttribute("IgstTaxPer")).bigDecimalValue();
                cgstTaxAmt  =   rounded((invAmt.multiply(cp)).divide(HUNDRED, ROUNDING_MODE));
                sgstTaxAmt  =   rounded((invAmt.multiply(sp)).divide(HUNDRED, ROUNDING_MODE));
                igstTaxAmt  =   rounded((invAmt.multiply(ip)).divide(HUNDRED, ROUNDING_MODE));

                row1.setAttribute("CgstTaxAmt", cgstTaxAmt);
                row1.setAttribute("SgstTaxAmt", sgstTaxAmt);                
                row1.setAttribute("IgstTaxAmt", igstTaxAmt);                
                totAmt = invAmt.add(cgstTaxAmt).add(sgstTaxAmt).add(igstTaxAmt);                
                row1.setAttribute("TotalAmount", totAmt);                
                System.out.println("inv amt" + invAmt);                
                System.out.println("tot amt" + totAmt);
            }
        }
        if ("InvToDateEvent".equals(pageContext.getParameter(EVENT_PARAM))) 
        {
             // BigDecimal invAmt1;
              String                        rowRef  =   pageContext.getParameter(OAWebBeanConstants.EVENT_SOURCE_ROW_REFERENCE);
              OARow                         row     =   (OARow)am.findRowByRef(rowRef);
              CLMPaymentInvoiceEOVORowImpl  rowi    =   (CLMPaymentInvoiceEOVORowImpl)row;
              
              if (rowi.getInvPeriodFromDate() != null && rowi.getInvPeriodToDate() != null) 
              {
//                  int                 invAmt  =   0;
                    String              stmt2   =   "BEGIN xxsify_clm_pay_wf_valid_pkg.get_inv_amount(:1,:2,:3,:4); end;";
                    CallableStatement   cs2     =   am.getOADBTransaction().createCallableStatement(stmt2, 1);               
                    try 
                    {
                        cs2.setDate(1, rowi.getInvPeriodFromDate().dateValue());
                        cs2.setDate(2, rowi.getInvPeriodToDate().dateValue());
                        cs2.setDouble(3, rowi.getPoLineAmount().intValue());
                        cs2.registerOutParameter(4, Types.VARCHAR );
                        //   System.out.println("double value1"+ rowi.getPoLineAmount().doubleValue());
                        //   System.out.println("int value2"+ rowi.getPoLineAmount().intValue());
                        //   System.out.println("long value2"+ rowi.getPoLineAmount().longValue()) ;
                        cs2.execute();
                        invAmt = new BigDecimal(cs2.getString(4));
                        //   invAmt1 = new BigDecimal(cs2.getLong(4));
                        cs2.close();
                    } 
                    catch (Exception e) 
                    {
                        throw new OAException("Error while calling xxsify_clm_pay_wf_valid_pkg.get_inv_amount" +  e.getMessage());
                    }
                    //    rowi.setInvoiceAmount(new oracle.jbo.domain.Number(invAmt.intValue()));

                    /*   
                     *  try 
                     *  {
                                rowi.setInvoiceAmount(new oracle.jbo.domain.Number(invAmt));
                        } 
                        catch (SQLException e) 
                        {                    
                        }*/
               
                    //    row.setAttribute("InvoiceAmount", invAmt);
                    row.setAttribute("InvAmtRef", invAmt);  
                  
                    cp          =  ((oracle.jbo.domain.Number)row.getAttribute("CgstTaxPer")).bigDecimalValue();
                    sp          =  ((oracle.jbo.domain.Number)row.getAttribute("SgstTaxPer")).bigDecimalValue();
                    ip          =  ((oracle.jbo.domain.Number)row.getAttribute("IgstTaxPer")).bigDecimalValue();
                    cgstTaxAmt  =   rounded((invAmt.multiply(cp)).divide(HUNDRED, ROUNDING_MODE));
                    sgstTaxAmt  =   rounded((invAmt.multiply(sp)).divide(HUNDRED, ROUNDING_MODE));
                    igstTaxAmt  =   rounded((invAmt.multiply(ip)).divide(HUNDRED, ROUNDING_MODE));
                    row.setAttribute("CgstTaxAmt", cgstTaxAmt);
                    row.setAttribute("SgstTaxAmt", sgstTaxAmt);
                    row.setAttribute("IgstTaxAmt", igstTaxAmt);
                    totAmt = invAmt.add(cgstTaxAmt).add(sgstTaxAmt).add(igstTaxAmt);
                    row.setAttribute("TotalAmount", totAmt);
                    System.out.println("inv amt-" + invAmt);
                    //        System.out.println("inv amt1-" + invAmt1);
                    System.out.println("tot amt-" + totAmt);
              }
              /*    String rowRef = pageContext.getParameter(OAWebBeanConstants.EVENT_SOURCE_ROW_REFERENCE);
                    OARow row = (OARow)am.findRowByRef(rowRef);

                    CLMPaymentInvoiceEOVORowImpl rowi =(CLMPaymentInvoiceEOVORowImpl)row;

                    if (rowi.getInvPeriodFromDate() != null && rowi.getInvPeriodToDate() != null) 
                    {
                        int                 invAmt  =   0;
                        String              stmt2   =   "BEGIN xxsify_clm_pay_wf_valid_pkg.get_inv_amount(:1,:2,:3,:4); end;";
                        CallableStatement   cs2     =   am.getOADBTransaction().createCallableStatement(stmt2, 1);
                        try 
                        {
                            cs2.setDate(1, rowi.getInvPeriodFromDate().dateValue());
                            cs2.setDate(2, rowi.getInvPeriodToDate().dateValue());
                            cs2.setInt(3, rowi.getPoLineAmount().intValue());
                            cs2.registerOutParameter(4, Types.NUMERIC);
                            cs2.execute();
                            invAmt = cs2.getInt(4);
                            cs2.close();
                        } 
                        catch (Exception e) 
                        {
                            throw new OAException("Error while calling xxsify_clm_pay_wf_valid_pkg.get_inv_amount" + 
                            e.getMessage());
                        }
                        rowi.setInvoiceAmount(new oracle.jbo.domain.Number(invAmt));
                        int cp          =   Integer.parseInt(row.getAttribute("CgstTaxPer").toString());
                        int sp          =   Integer.parseInt(row.getAttribute("SgstTaxPer").toString());
                        int ip          =   Integer.parseInt(row.getAttribute("IgstTaxPer").toString());
                        int cgstTaxAmt  =   invAmt * cp / 100;
                        int sgstTaxAmt  =   invAmt * sp / 100;
                        int igstTaxAmt  =   invAmt * ip / 100;
                        row.setAttribute("CgstTaxAmt", cgstTaxAmt);
                        row.setAttribute("SgstTaxAmt", sgstTaxAmt);
                        row.setAttribute("IgstTaxAmt", igstTaxAmt);
                        int totAmt = invAmt + cgstTaxAmt + sgstTaxAmt + igstTaxAmt;
                        row.setAttribute("TotalAmount", totAmt);
                        System.out.println("inv amt1" + invAmt);
                        System.out.println("tot amt1" + totAmt);
                    }*/
        }
        if ("InvFromDateEvent".equals(pageContext.getParameter(EVENT_PARAM))) 
        {
            String                          rowRef  =   pageContext.getParameter(OAWebBeanConstants.EVENT_SOURCE_ROW_REFERENCE);
            OARow                           row     =   (OARow)am.findRowByRef(rowRef);
            CLMPaymentInvoiceEOVORowImpl    rowi    =   (CLMPaymentInvoiceEOVORowImpl)row;
            if (rowi.getInvPeriodFromDate() != null &&  rowi.getInvPeriodToDate() != null) 
            {
             //   int invAmt = 0;
                String              stmt2   =  "BEGIN xxsify_clm_pay_wf_valid_pkg.get_inv_amount(:1,:2,:3,:4); end;";
                CallableStatement   cs2     =  am.getOADBTransaction().createCallableStatement(stmt2, 1);
                try
                {
                    cs2.setDate(1, rowi.getInvPeriodFromDate().dateValue());
                    cs2.setDate(2, rowi.getInvPeriodToDate().dateValue());
                    cs2.setInt(3, rowi.getPoLineAmount().intValue());
                    cs2.registerOutParameter(4, Types.VARCHAR );
                    cs2.execute();
                    invAmt = new BigDecimal(cs2.getString(4));
                    cs2.close();
                } 
                catch (Exception e) 
                {
                    throw new OAException("Error while calling xxsify_clm_pay_wf_valid_pkg.get_inv_amount" + e.getMessage());
                }
                //  rowi.setInvoiceAmount(new oracle.jbo.domain.Number(invAmt));
                //  row.setAttribute("InvoiceAmount", invAmt);
                row.setAttribute("InvAmtRef", invAmt);   
                                
                cp          =   ((oracle.jbo.domain.Number)row.getAttribute("CgstTaxPer")).bigDecimalValue();
                sp          =   ((oracle.jbo.domain.Number)row.getAttribute("SgstTaxPer")).bigDecimalValue();
                ip          =   ((oracle.jbo.domain.Number)row.getAttribute("IgstTaxPer")).bigDecimalValue();
                cgstTaxAmt  =   rounded((invAmt.multiply(cp)).divide(HUNDRED, ROUNDING_MODE));
                sgstTaxAmt  =   rounded((invAmt.multiply(sp)).divide(HUNDRED, ROUNDING_MODE));
                igstTaxAmt  =   rounded((invAmt.multiply(ip)).divide(HUNDRED, ROUNDING_MODE));
                row.setAttribute("CgstTaxAmt", cgstTaxAmt);
                row.setAttribute("SgstTaxAmt", sgstTaxAmt);
                row.setAttribute("IgstTaxAmt", igstTaxAmt);
                totAmt      =   invAmt.add(cgstTaxAmt).add(sgstTaxAmt).add(igstTaxAmt);
                row.setAttribute("TotalAmount", totAmt);
            }
        }
        if (pageContext.getParameter("submitBtn") != null)
        {
            saveFlag        = "N";
            String errMsg   = "";

            OAViewObject vo =  (OAViewObject)am.findViewObject("CLMPaymentInvoiceEOVO");
            for (int i = 0; i < vo.getFetchedRowCount(); i++) 
            {
                CLMPaymentInvoiceEOVORowImpl rowi =  (CLMPaymentInvoiceEOVORowImpl)vo.getRowAtRangeIndex(i);

                if (rowi.getClmInvoiceNumber() == null ||  rowi.getClmInvoiceNumber().equals("")) 
                {
                    throw new OAException("Please Enter Invoice Number",  OAException.ERROR);
                }
                else if (rowi.getInvoiceAmount() == null ||  rowi.getInvoiceAmount().equals("")) 
                {
                    throw new OAException("Please Enter Invoice Amount", OAException.ERROR);
                } 
                else if (rowi.getInvoiceDate() == null ||  rowi.getInvoiceDate().equals("")) 
                {
                    throw new OAException("Please Enter Invoice Date", OAException.ERROR);
                } 
                else if (rowi.getInvoiceDate() != null )
                {
                    Date invDate= rowi.getInvoiceDate();  
                    oracle.jbo.domain.Date currDate = new oracle.jbo.domain.Date(oracle.jbo.domain.Date.getCurrentDate());
                    if ( invDate.compareTo(currDate) > 0   )
                    {
                        throw new OAException("Invoice Date can not be Future Date",  OAException.ERROR);                      
                    }
                } 
                int     invAmt          =   rowi.getInvoiceAmount().intValue();
                int     balAmt          =   rowi.getBalAmt().intValue();
                int     amtValidation   =   (rowi.getPoLineAmount().intValue());  //Mahes
                int     toleranceAmt    =   (rowi.getPoLineAmount().intValue() * rowi.getInvoiceTolerance().intValue()) / 100;
                /*      if (!(rowi.getItemType().contains("Burstable")))
                 *      {
                            if (invAmt > (balAmt + toleranceAmt)) 
                            {
                                throw new OAException("Invoice Amount Exceeds Balance amount for the item:" +  rowi.getItemCode(), OAException.ERROR);
                            }
                        } */ //Commented by Mahes for Renewal cases

                if (rowi.getItemType().equalsIgnoreCase("Recurring"))
                {
                    String msg  =   "";
                    String stmt =   "BEGIN xxsify_clm_pay_wf_valid_pkg.sify_clm_dates_valid(:1,:2,:3,:4,:5,:6); end;";
                    CallableStatement cs =  am.getOADBTransaction().createCallableStatement(stmt, 1);
                    try 
                    {
                        cs.setDate(1, rowi.getInvPeriodFromDate().dateValue());
                        cs.setDate(2, rowi.getInvPeriodToDate().dateValue());
                        cs.setInt(4, rowi.getClmId().intValue());
                        cs.setString(5, rowi.getPoNumber());
                        cs.setInt(6, rowi.getEbsPoLineId().intValue());
                        cs.registerOutParameter(3, Types.VARCHAR);cs.execute();

                        msg = cs.getString(3);
                        cs.close();
                    } 
                    catch (Exception e) 
                    {
                        throw new OAException("Error while calling sify_clm_dates_valid procedre" + e.getMessage());
                    }
                    if (!msg.equalsIgnoreCase("Y")) 
                    {
                        throw new OAException(msg + " for the line " + rowi.getPoLineNumber(), OAException.ERROR);
                    }
                    String result1  = "";
                    String result2  = "";
                    String stmt2    = "BEGIN xxsify_clm_pay_wf_valid_pkg.clm_po_same_dates_valid(:1,:2,:3,:4,:5,:6,:7,:8,:9); end;";//Mahes
                    CallableStatement cs2 = am.getOADBTransaction().createCallableStatement(stmt2, 1);
                    try 
                    {
                        System.out.println("in create submit for loop"  + rowi.getInvPeriodFromDate().dateValue());
                        System.out.println("in create submit for loop1" + rowi.getInvPeriodFromDate());
                        cs2.setInt(1, rowi.getClmId().intValue());
                        cs2.setString(2, rowi.getPoNumber());
                        cs2.setDate(3, rowi.getInvPeriodFromDate().dateValue());
                        cs2.setDate(4, rowi.getInvPeriodToDate().dateValue());
                        cs2.registerOutParameter(5, Types.VARCHAR);
                        cs2.registerOutParameter(6, Types.VARCHAR);
                        cs2.setString(7, rowi.getBandWidhReqId());
                        cs2.setString(8, rowi.getActivity());
                        cs2.setInt(9, rowi.getInvoiceAmount().intValue());  //Mahes
                        cs2.execute();
                        result1 = cs2.getString(5);
                        result2 = cs2.getString(6);
                        cs.close();
                    } 
                    catch (Exception e) 
                    {
                        throw new OAException("Error while calling clm_po_same_dates_valid procedre-M" +   e.getMessage());
                    }
                    if (!result1.equalsIgnoreCase("N"))
                    {
                        throw new OAException(result1+"--Test1", OAException.ERROR);
                    }
                    if (!result2.equalsIgnoreCase("N")) 
                    {
                        throw new OAException(result2+"--Test2", OAException.ERROR);
                    }
                }
                //  Invoice validations
                String              stmt1   = "BEGIN xxsify_clm_pay_wf_valid_pkg.xxsify_clm_inv_validations(:1,:2,:3,:4,:5,:6,:7); end;";
                CallableStatement   cs1     = am.getOADBTransaction().createCallableStatement(stmt1, 1);
                try
                {
                    cs1.setInt(1, rowi.getClmId().intValue());
                    cs1.setString(2, rowi.getSupplier());
                    cs1.setString(3, rowi.getClmInvoiceNumber());
                    cs1.registerOutParameter(4, Types.VARCHAR);
                    cs1.setDate(5,rowi.getInvPeriodToDate().dateValue());
                    cs1.setString(6,rowi.getPoNumber());
                    cs1.setString(7, rowi.getSupplierSite());
                    cs1.execute();
                    errMsg = cs1.getString(4);
                    cs1.close();
                } 
                catch (Exception e)
                {
                    throw new OAException("Error while calling xxsify_clm_inv_validations" + e.getMessage());
                }
                if (!errMsg.equalsIgnoreCase("N")) 
                {
                    throw new OAException(errMsg, OAException.ERROR);
                }
                rowi.setInvoiceWfStatus("Submitted");
                rowi.setSaveFlag("N");
                rowi.setInvoiceStatus("New");
            }
            OAException message = new OAException("Are you sure you want to submit");
            OADialogPage dialogPage = new OADialogPage(OAException.CONFIRMATION, message, null,"","");
            dialogPage.setOkButtonItemName("YesBtn");
           // dialogPage.setOkButtonItemName("NoBtn");
            dialogPage.setOkButtonToPost(true);
            dialogPage.setNoButtonToPost(true);
            dialogPage.setOkButtonLabel("Yes");
            dialogPage.setNoButtonLabel("No");
            dialogPage.setPostToCallingPage(true);
            pageContext.redirectToDialogPage(dialogPage);
        }
        else if (pageContext.getParameter("YesBtn") != null)
        {
            System.out.println("inside yes");
            am.getOADBTransaction().commit();
            String stmt =  "BEGIN xxsify_clm_pay_wf_valid_pkg.sify_clm_pay_wf_call(:1,:2,:3,:4,:5); end;";
            CallableStatement cs =  am.getOADBTransaction().createCallableStatement(stmt, 1);
            try 
            {
                cs.setString(1, clmid);
                cs.setString(2, poNo);
                cs.setString(3, pageContext.getUserName());
                cs.setString(4, saveFlag);
                cs.setString(5, "");
                cs.execute();
                cs.close();
            }
            catch (Exception e) 
            {
                throw new OAException("Error while calling wf" + e.getMessage());
            }
            OAException     confirmMessage  =  new OAException("The Invoice for the CLM ID " + clmid +  " submitted for approval");
            OADialogPage    dialogPage1     =  new OADialogPage(OAException.CONFIRMATION, confirmMessage,  null, "OA.jsp?page=/oracle/apps/sfc/clm/PaymentForm/webui/CLMPaymentHomePG", null);
            pageContext.redirectToDialogPage(dialogPage1);
        }
    }
    private BigDecimal rounded(BigDecimal aNumber)
    {
        return aNumber.setScale(DECIMALS, ROUNDING_MODE);
    }
}
