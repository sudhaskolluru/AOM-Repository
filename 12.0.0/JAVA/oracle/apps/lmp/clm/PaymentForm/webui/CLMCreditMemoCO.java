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

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import oracle.apps.fnd.common.VersionInfo;
import oracle.apps.fnd.framework.OAApplicationModule;
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
public class CLMCreditMemoCO extends OAControllerImpl
{
  public static final String RCS_ID="$Header$";
  public static final boolean RCS_ID_RECORDED =
        VersionInfo.recordClassVersion(RCS_ID, "%packagename%");     
       
    String clmid    =   "";
//  String bwReqid  =   "";
    String poNo     =   "";
    String saveFlag =   "";

  /**
   * Layout and page setup logic for a region.
   * @param pageContext the current OA page context
   * @param webBean the web bean corresponding to the region
   */
  public void processRequest(OAPageContext pageContext, OAWebBean webBean)
  {
    super.processRequest(pageContext, webBean);
    CLMPaymentAMImpl    am  =   (CLMPaymentAMImpl)pageContext.getApplicationModule(webBean);
//  Serializable s[]={clmid,"create"};
    clmid   =   pageContext.getParameter("clmId");
//  bwReqid =   pageContext.getParameter("bwReqId");
    poNo    =   pageContext.getParameter("poNo");
    System.out.println("in CM co1");
//    am.invokeMethod("executCreditMemoVO",new Serializable[]{clmid,poNo} );
//    am.invokeMethod("executCreditHistVO",new Serializable[]{clmid,poNo} );
    am.executCreditMemoVO(clmid,poNo);
    am.executCreditHistVO(clmid,poNo);
//    String errflag  =(String)am.invokeMethod("setCreditMemoValues");
    String errflag  = am.setCreditMemoValues();
    if ( !errflag.equalsIgnoreCase("N"))
    {
        OASubmitButtonBean b=(OASubmitButtonBean)webBean.findChildRecursive("SubmitBtn");          
        b.setDisabled(Boolean.TRUE);
    }
//  am.invokeMethod("HandlePPR");
    System.out.println("in pg co");
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
    OAViewObject        vo  =   am.getCLMPaymentInvoiceEOVO1();
    
    if ("BalanceAmountEvent".equals(pageContext.getParameter(EVENT_PARAM))) 
    {
        BigDecimal  invAmt;
        BigDecimal  creditAmt;
        BigDecimal  balAmt;
        
        String      rowRef  =  pageContext.getParameter(OAWebBeanConstants.EVENT_SOURCE_ROW_REFERENCE);
        OARow       row     = (OARow)am.findRowByRef(rowRef);  
        if (row.getAttribute("InvoiceAmount") == null) 
        {
            throw new OAException("Please Enter Credit Invoice Amount",  OAException.ERROR);
        } 
        else 
        {
            if (row.getAttribute("InvoiceAmount")!=null)
            {
                String  invamt      =   row.getAttribute("InvoiceAmount").toString();
//              Pattern letter      =   Pattern.compile("[a-zA-z]");
                Pattern digit       =   Pattern.compile("[0-9]");
                Pattern special     =   Pattern.compile ("[-]");
//              Matcher hasLetter   =   letter.matcher(password);
                Matcher hasDigit    =   digit.matcher(invamt);
                Matcher hasSpecial  =   special.matcher(invamt);
                
                if( !(hasDigit.find() && hasSpecial.find()))
                {            
                    throw new OAException("Please Enter Neagative Amount For Invoice Amount",OAException.ERROR);            
                } 
            }
            invAmt      = ((oracle.jbo.domain.Number)row.getAttribute("InvoiceAmount")).bigDecimalValue();
            creditAmt   = ((oracle.jbo.domain.Number)row.getAttribute("InvAmtRef")).bigDecimalValue();
            balAmt      = creditAmt.subtract(invAmt);
            row.setAttribute("BalAmt",balAmt);
        }
    }
    if (pageContext.getParameter("SubmitBtn") != null)
    {
        int     cmAmt       =   0;
        int     poAmt       =   0;
        int     paymentId   =   0;
//      if(pageContext.getSessionValue("clmIdS1")!=null && pageContext.getSessionValue("poNoS1")!=null){
//      String  lid         =   (String)pageContext.getSessionValue("clmIdS1");
//      String  pno         =   (String)pageContext.getSessionValue("poNoS1");
        for (int i = 0; i < vo.getFetchedRowCount(); i++)
        {   
            CLMPaymentInvoiceEOVORowImpl rowi = ( CLMPaymentInvoiceEOVORowImpl)vo.getRowAtRangeIndex(i);        
//          clmid   =   rowi.getClmId();
//          poNo    =   rowi.getPoNumber();   
            if(rowi.getInvoiceAmount() == null || rowi.getInvoiceAmount().equals(""))
            {                        
                throw new OAException("Please Enter Credit Amount",OAException.ERROR);              
            }
            if(rowi.getClmInvoiceNumber() == null || rowi.getClmInvoiceNumber().equals(""))
            {                        
                throw new OAException("Please Enter Invoice Number",OAException.ERROR);              
            }    
            if(rowi.getInvoiceDate() == null)
            {                        
                throw new OAException("Please Enter Invoice Date",OAException.ERROR);              
            }
            else
            {
                Date invDate= rowi.getInvoiceDate();  
                oracle.jbo.domain.Date currDate = new oracle.jbo.domain.Date(oracle.jbo.domain.Date.getCurrentDate());
                if ( invDate.compareTo(currDate) > 0   )
                {
                throw new OAException("Invoice Date can not be Future Date",  OAException.ERROR);                      
                }
            }
        
            if (rowi.getInvoiceAmount()!=null)
            {
                String  invAmt      =   rowi.getInvoiceAmount().stringValue();
    //          Pattern letter      =   Pattern.compile("[a-zA-z]");
                Pattern digit       =   Pattern.compile("[0-9]");
                Pattern special     =   Pattern.compile ("[-]");
    //          Matcher hasLetter   =   letter.matcher(password);
                Matcher hasDigit    =   digit.matcher(invAmt);
                Matcher hasSpecial  =   special.matcher(invAmt);
                if( !(hasDigit.find() && hasSpecial.find()))
                {
                    throw new OAException("Please Enter Neagative Amount For Invoice Amount",OAException.ERROR);
                } 
                if(Math.abs(rowi.getInvoiceAmount().doubleValue()) > Math.abs(rowi.getInvAmtRef().doubleValue())) 
                {
                    throw new OAException("Invoice Amount Exceeds Credit Amount: "+Math.abs(rowi.getInvAmtRef().doubleValue()),OAException.ERROR);
                }
            }
            rowi.setInvoiceWfStatus("Submitted");
            rowi.setSaveFlag("N");
            rowi.setInvoiceStatus("New");
            paymentId=rowi.getPaymentId().intValue();
    //      rowi.setAdvAmount(rowi.getInvoiceAmount());
    //      rowi.setAdvInvoiceNo(rowi.getClmInvoiceNumber());
        } 
        am.getOADBTransaction().commit();
        
        String              stmt    = "BEGIN xxsify_clm_pay_wf_valid_pkg.sify_clm_pay_credit_submit(:1,:2,:3,:4,:5); end;";
        CallableStatement   cs      = am.getOADBTransaction().createCallableStatement(stmt, 1);
        try
        {
            cs.setString(1,clmid);
            cs.setString(2,poNo);
            cs.setString(3,pageContext.getUserName());
            cs.setString(4,"N");
            cs.setInt(5,paymentId);
            cs.execute(); 
            cs.close();
        } 
        catch (Exception e) 
        {
            throw new OAException("Error while submitting Credit invoice wf"+e.getMessage());
        } 
        OAException     confirmMessage  =  new OAException("The Credit Invoice for the CLM ID "+clmid+" submitted for approval");
        OADialogPage    dialogPage      =  new OADialogPage(OAException.CONFIRMATION, confirmMessage, null,  "OA.jsp?page=/oracle/apps/sfc/clm/PaymentForm/webui/CLMPaymentHomePG",  null);
        pageContext.redirectToDialogPage(dialogPage);
    }   
    if (pageContext.getParameter("CancelBtn") != null)
    {
        pageContext.setForwardURL(" OA.jsp?page=/oracle/apps/sfc/clm/PaymentForm/webui/CLMPaymentHomePG"    , 
                                    null                                                                    , 
                                    OAWebBeanConstants.KEEP_MENU_CONTEXT                                    , 
                                    null                                                                    , 
                                    null                                                                    , 
                                    false                                                                   , 
                                    OAWebBeanConstants.ADD_BREAD_CRUMB_NO                                   , 
                                    OAWebBeanConstants.IGNORE_MESSAGES
                                );
    }
  }
}
