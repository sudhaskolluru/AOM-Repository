/*===========================================================================+
  |   Copyright (c) 2001, 2005 Oracle Corporation, Redwood Shores, CA, USA    |
  |                         All rights reserved.                              |
  +===========================================================================+
  |  Change History :                                                         |
  |                                                                           |
  |    Date      Version        Author                  Description           |
  |  =========  ========= =================   ==============================  +
  |  17-Jun-22   1.0      Venkat Yamaluri    Initial creation for TPI charge  |
  |                                          account default in iprocurement. |
  +===========================================================================*/
package xxtpi.oracle.apps.icx.por.req.webui;

import java.sql.Connection;
import java.sql.SQLException;

import oracle.apps.fnd.framework.OAApplicationModule;
import oracle.apps.fnd.framework.OAViewObject;
import oracle.apps.fnd.framework.server.OADBTransaction;
import oracle.apps.fnd.framework.webui.OAPageContext;
import oracle.apps.fnd.framework.webui.beans.OAWebBean;
import oracle.apps.icx.por.req.server.PoReqDistributionsVORowImpl;
import oracle.apps.icx.por.req.server.PoRequisitionLinesVORowImpl;
import oracle.apps.icx.por.req.webui.EditSubmitCO;

import oracle.jbo.RowSetIterator;

import oracle.jdbc.internal.OraclePreparedStatement;
import oracle.jdbc.internal.OracleResultSet;

   
public class xxtpiEditSubmitCO 
  extends EditSubmitCO
{
     
  public void processRequest(OAPageContext pageContext, OAWebBean webBean) 
  {
    super.processRequest(pageContext, webBean);
    
    OAApplicationModule am = pageContext.getApplicationModule(webBean);
    OAViewObject vo = (OAViewObject)am.findViewObject("PoReqDistributionsVO");
    OAViewObject vol = (OAViewObject)am.findViewObject("PoRequisitionLinesVO");
    OADBTransaction tx = am.getOADBTransaction();
    Connection conn = tx.getJdbcConnection();

    PoReqDistributionsVORowImpl vo1Row = null;
    PoRequisitionLinesVORowImpl voLinRow = null;
      
    OraclePreparedStatement PreStmt = null;
    OracleResultSet oResultset = null;
    

    if (vo != null) {
      
            String returnValidation = null;
           
            vo1Row = (PoReqDistributionsVORowImpl)vo.first();
            voLinRow = (PoRequisitionLinesVORowImpl)vol.getCurrentRow();
            
        if (vo1Row != null &&  voLinRow != null){

            try {
                   
                String sql = "SELECT XXTPI_PO_SEGM_CONT_REQ_PKG.validation_segments (:1, :2, :3) VALIDATION FROM DUAL";
                
                PreStmt = (OraclePreparedStatement)tx.createPreparedStatement(sql, 1);
                
                   PreStmt.setInt (1, Integer.parseInt(voLinRow.getOrgId().toString()));
                   PreStmt.setInt (2, Integer.parseInt(voLinRow.getCategoryId().toString()));
                   PreStmt.setInt (3, Integer.parseInt(voLinRow.getToPersonId().toString()));
              
                   oResultset = (OracleResultSet)PreStmt.executeQuery(); 
                    
                    if (oResultset.next()) {                                                                                                        
                        returnValidation = oResultset.getString("VALIDATION");
                    }
                    
                    vo1Row.setCodeCombinationId(new oracle.jbo.domain.Number(returnValidation));
                   
                } catch (SQLException e) {
                      pageContext.writeDiagnostics(this, "Exception while fetching values from session.... " + e.getMessage(),  2);
                }
            }
        }
    }
    

  public void processFormRequest(OAPageContext pageContext, OAWebBean webBean) 
  {
    super.processFormRequest(pageContext, webBean);
      
      OAApplicationModule am = pageContext.getApplicationModule(webBean);
      OAViewObject vo = (OAViewObject)am.findViewObject("PoReqDistributionsVO");
      OAViewObject vol = (OAViewObject)am.findViewObject("PoRequisitionLinesVO");
      OADBTransaction tx = am.getOADBTransaction();
      Connection conn = tx.getJdbcConnection();

      PoReqDistributionsVORowImpl vo1Row = null;
      PoReqDistributionsVORowImpl vo1Row2 = null;
      PoRequisitionLinesVORowImpl voLinRow = null;
        
      OraclePreparedStatement PreStmt = null;
      OracleResultSet oResultset = null;
      

      if (vo != null) {
        
              String returnValidation = null;
             
              vo1Row = (PoReqDistributionsVORowImpl)vo.first();
              voLinRow = (PoRequisitionLinesVORowImpl)vol.getCurrentRow();
              vo1Row2 = (PoReqDistributionsVORowImpl)vo.last();
              
          if (vo1Row != null &&  voLinRow != null){

              try {
                     
                  String sql = "SELECT XXTPI_PO_SEGM_CONT_REQ_PKG.validation_segments (:1, :2, :3) VALIDATION FROM DUAL";
                  
                  PreStmt = (OraclePreparedStatement)tx.createPreparedStatement(sql, 1);
                  
                     PreStmt.setInt (1, Integer.parseInt(voLinRow.getOrgId().toString()));
                     PreStmt.setInt (2, Integer.parseInt(voLinRow.getCategoryId().toString()));
                     PreStmt.setInt (3, Integer.parseInt(voLinRow.getToPersonId().toString()));
                
                     oResultset = (OracleResultSet)PreStmt.executeQuery(); 
                     
                      if (oResultset.next()) {                                                                                                        
                          returnValidation = oResultset.getString("VALIDATION");
                      }
                      
                      vo1Row.setCodeCombinationId(new oracle.jbo.domain.Number(returnValidation));
                      
                      vo1Row2.setCodeCombinationId(new oracle.jbo.domain.Number(returnValidation));
                     
                  } catch (SQLException e) {
                        pageContext.writeDiagnostics(this, "Exception while fetching values from session.... " + e.getMessage(),  2);
                  }
              }
          }
      }
}
