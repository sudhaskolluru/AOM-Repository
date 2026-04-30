/*===========================================================================+
 |   Copyright (c) 2001, 2005 Oracle Corporation, Redwood Shores, CA, USA    |
 |                         All rights reserved.                              |
 +===========================================================================+
 |  HISTORY                                                                  |
 +===========================================================================*/
package oracle.apps.sfc.clm.PaymentForm.webui;

import oracle.apps.fnd.common.VersionInfo;
import oracle.apps.fnd.framework.OAViewObject;
import oracle.apps.fnd.framework.webui.OAControllerImpl;
import oracle.apps.fnd.framework.webui.OAPageContext;
import oracle.apps.fnd.framework.webui.beans.OAWebBean;

import oracle.apps.sfc.clm.PaymentForm.server.CLMPaymentAMImpl;


/**
 * Controller for ...
 */
public class CLMInvHistoryPopCO extends OAControllerImpl
{
  public static final String RCS_ID="$Header$";
  public static final boolean RCS_ID_RECORDED =
        VersionInfo.recordClassVersion(RCS_ID, "%packagename%");

  /**
   * Layout and page setup logic for a region.
   * @param pageContext the current OA page context
   * @param webBean the web bean corresponding to the region
   */
  public void processRequest(OAPageContext pageContext, OAWebBean webBean)
  {
    super.processRequest(pageContext, webBean);
    CLMPaymentAMImpl    am  =   (CLMPaymentAMImpl)pageContext.getApplicationModule(webBean);
    OAViewObject        vo  =   am.getCLMInvPopupVO();
    
    String  clmid   =   (String)pageContext.getParameter("param1");
    String  bwReqid =   (String)pageContext.getParameter("param2");
    String  pono    =   (String)pageContext.getParameter("param3");
    
    vo.setWhereClauseParams(null);
    vo.setWhereClauseParam(0,clmid);
    vo.setWhereClauseParam(1,bwReqid);
    vo.setWhereClauseParam(2,pono);
    vo.executeQuery(); 
    
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
  }

}
