    /*===========================================================================+
 |   Copyright (c) 2001, 2005 Oracle Corporation, Redwood Shores, CA, USA    |
 |                         All rights reserved.                              |
 +===========================================================================+
 |  HISTORY                                                                  |
 +===========================================================================*/
package oracle.apps.sfc.clm.BulkUpload.webui;

import com.sun.java.util.collections.HashMap;

import java.io.File;
import java.text.SimpleDateFormat;
import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;


import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.sql.Statement;

import java.sql.Types;

import java.text.DateFormat;


import java.util.Date;

import java.util.StringTokenizer;
import java.util.Vector;

import javax.servlet.ServletOutputStream;


import javax.servlet.http.HttpServletResponse;

import jxl.Cell;
import jxl.CellType;
import jxl.Sheet;
import jxl.Workbook;

import jxl.read.biff.BiffException;

import oracle.apps.fnd.common.VersionInfo;
import oracle.apps.fnd.framework.OAApplicationModule;
import oracle.apps.fnd.framework.OAException;
import oracle.apps.fnd.framework.OAFwkConstants;
import oracle.apps.fnd.framework.server.OADBTransaction;
import oracle.apps.fnd.framework.webui.OAControllerImpl;
import oracle.apps.fnd.framework.webui.OAPageContext;
import oracle.apps.fnd.framework.webui.beans.OAWebBean;


import oracle.cabo.ui.data.DataObject;

import oracle.jbo.Row;
import oracle.jbo.domain.BlobDomain;
import oracle.jbo.domain.Number;

import oracle.jbo.server.ViewObjectImpl;

import oracle.jdbc.OracleCallableStatement;

/**
 * Controller for ...
 */
public class SifyBulkUploadPGCO extends OAControllerImpl
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
            
   if(!pageContext.isFormSubmission())
   {
      OAApplicationModule am = pageContext.getApplicationModule(webBean);
        
        String SessionReqIdVal="";
          
          if(pageContext.getSessionValue("Session_Req_ID") != null)
             {
             SessionReqIdVal=(String )pageContext.getSessionValue("Session_Req_ID");
             pageContext.removeSessionValue("Session_Req_ID");
             }

       System.out.println("Session val first time" + pageContext.getSessionValue("UploadAccess")+"");
                      
            
       
            if(pageContext.getSessionValue("Session_PriceRev_Batch_ID") != null)  
            {
                        pageContext.removeSessionValue("Session_PriceRev_Batch_ID");
            }
       
       if(pageContext.getSessionValue("UploadAccess") != null)  
       {
                   pageContext.removeSessionValue("UploadAccess");
       }
       
       else
       {
        pageContext.putSessionValue("UploadAccess","Y");
        am.invokeMethod("initPropVO");
       }
       
       System.out.println("Session val PR" + pageContext.getSessionValue("UploadAccess")+"");
       
       

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
    OAApplicationModule am = pageContext.getApplicationModule(webBean);
//      
//      OAWebBean body = pageContext.getRootWebBean();
//      if (body instanceof OABodyBean)
//      {
//      ((OABodyBean)body).setBlockOnEverySubmit(true);
//          ((OABodyBean)body).setDirty(false);
//          ((OABodyBean)body).setFirstClickPassed(true);
//          
//      }
//      
//      
if (pageContext.getParameter("SubmitBtn")!=null)
{
      
String from_loc="";
String to_loc="";
String supp_name ="";
String supp_site="";
String Clm_id="";
          
          
          String rId="";
          String retCode="";
          

from_loc=pageContext.getParameter("FromLocationLov");
to_loc=pageContext.getParameter("ToLocationLov");
supp_name=pageContext.getParameter("SuppNameLOV");          
supp_site=pageContext.getParameter("SuppSiteLOV");
Clm_id=pageContext.getParameter("ClmIDLOV");

          //System.out.println("from_loc    "+from_loc);
          //System.out.println("to_loc    "+to_loc);
          //System.out.println("supp_name    "+supp_name);
          //System.out.println("supp_site    "+supp_site);
          //System.out.println("Clm_id    "+Clm_id);

          OADBTransaction txn = am.getOADBTransaction(); 
                String sql2 = "BEGIN XXSIFY_CLM_BULK_LOAD_PKG.XXSIFY_BULK_CLM_REPORT_PRC(:1,:2,:3,:4,:5,:6,:7); END;";
                                    
                try
                         {
                                OracleCallableStatement cs1 = (OracleCallableStatement)txn.createCallableStatement(sql2, 1);
                
                                cs1.registerOutParameter(1, java.sql.Types.VARCHAR);
                                cs1.registerOutParameter(2, java.sql.Types.VARCHAR);
                                
                                cs1.setString(3,from_loc);
                                cs1.setString(4,to_loc);
                                cs1.setString(5,supp_name);
                                cs1.setString(6,supp_site);
                                cs1.setString(7,Clm_id);
                                
                                cs1.execute();
                                
                                rId = cs1.getString(1);
                                retCode = cs1.getString(2);
          
                                cs1.close();
                               
                           }
                                  catch (Exception ex) 
                                  {
                                  throw new OAException("Error while calling Procedure "+ex.getMessage());
                                  }
                                  
                                  if(retCode.equals("S"))
                                  {
                                  
                                  
                                    pageContext.putSessionValue("Session_Req_ID",rId);     
                                    throw new OAException("Submitted to Concurrent Program with Request ID : "+rId,OAException.CONFIRMATION);

                                  }
                                  
                                  else
                                      throw new OAException("Error While Submitting Concurrent Request "+OAException.ERROR);
 
      }
      

//      if (pageContext.getParameter("UploadEvent")!=null)
//      {
          if("UploadDataEvent".equals(pageContext.getParameter(EVENT_PARAM)))
          {
   
        Vector errMsgs = new Vector();
        Vector errMsgs1 = new Vector();
          
        String uploadSessAccessVal="";
        
        if(pageContext.getSessionValue("UploadAccess")!=null)
        {
        System.out.println("UPLOAD CLICKED : Session val NOT NULL in PFR" + pageContext.getSessionValue("UploadAccess")+"");
        uploadSessAccessVal=pageContext.getSessionValue("UploadAccess").toString();
         
         if("N".equalsIgnoreCase(uploadSessAccessVal))
         {   
         }
         
        }
        
        else
        {
        
            throw new OAException("NULL value confirm ",OAException.CONFIRMATION);
        }
        
        if(uploadSessAccessVal.equalsIgnoreCase("Y")) {
            
        System.out.println("Session val Inside Event PFR " + pageContext.getSessionValue("UploadAccess")+"");
            
        pageContext.putSessionValue("UploadAccess","N");     
        am.invokeMethod("DisableSubmitBtn");
          
          String retValues="";
          String retFlag="E";          
          String newprice="";
          String oldPrice="";
          String  p_batchNum = "";
          
          
            p_batchNum=         am.getOADBTransaction().getSequenceValue("xxsify_clm_bulk_upld_batch_seq").intValue()+"";         
          
          pageContext.putSessionValue("Session_PriceRev_Batch_ID",p_batchNum);
          
      
//         int p_batchNum=0;

      ViewObjectImpl vo = 
                          (ViewObjectImpl)am.findViewObject("XxsifyClmBulkLoadTVO");
      DataObject excelUploadData = 
                    pageContext.getNamedDataObject("UploadItem");
          
         //System.out.println("vo init ");
       //Declare Variable that will be used in reading uploaded file  
       int flag=0;
       String fileName = null;  
       String contentType = null;  
       Long fileCapacity = null;  
       BlobDomain uploadStream = null;  
       BufferedReader inReader = null;  
       Date sdate=null;
       Date edate=null;
       
       String StrSdate="";
       String StrEdate="";
       
       try {  
         fileName =   
             (String)excelUploadData.selectValue(null, "UPLOAD_FILE_NAME");  
         contentType =   
             (String)excelUploadData.selectValue(null, "UPLOAD_FILE_MIME_TYPE");  
         uploadStream =   
             (BlobDomain)excelUploadData.selectValue(null, fileName);  
       
           }
           
           catch (NullPointerException ex) {  
               System.out.println("exception as it is not excel file catch ex");
             throw new OAException("Please Select an Excel File to Upload it to Database!!!",   
                        OAException.ERROR);  
                        
     }
     try{
     
                    
 String[] excel_data  = new String[32];
 InputStream inputWorkbook = uploadStream.getInputStream();
 Workbook w;
 System.out.println(" Into Readexcel method :" ) ;



 try
 {
 
 
 
 w = Workbook.getWorkbook(inputWorkbook);
               
 // Get the first sheet
 Sheet sheet = w.getSheet(0);
                
 for (int i = 1; i < sheet.getRows(); i++)
 {
 System.out.println(" Into i") ;
 for (int j = 0; j < sheet.getColumns(); j++)
 {
 //System.out.println(" Into j") ;
 Cell cell = sheet.getCell(j, i);
 CellType type = cell.getType();
 if (cell.getType() == CellType.LABEL)
 {
  //System.out.println("I got a char " + cell.getContents());
  excel_data[j] = cell.getContents();
 }
 
 else if (cell.getType() == CellType.NUMBER)
 { 
  //System.out.println("I got a number " + cell.getContents());
  
  excel_data[j] = cell.getContents();
  
 }
 
     else if(cell.getType()==CellType.DATE)
     {
     System.out.println("I got a date " + cell.getContents());
                
     excel_data[j] = cell.getContents();
     if(excel_data[j]!=null)
     {
      String adate=ValidateDate(pageContext,excel_data[j]);
          if( adate.equalsIgnoreCase("Error"))
          {
          System.out.println("if ERROR");
          flag=1;
     //              pageContext.putDialogMessage(new OAException("Date Format Error - Enter DD-MMMM-YYYY format",OAException.ERROR));
     //             throw new OAException("Date Format Error - Enter DD-MMMM-YYYY format",OAException.ERROR);
          }
          else
          
              excel_data[j] = cell.getContents();
         
         }
     }
     else
     {
         excel_data[j] = cell.getContents();
     }
 }//For Loop for CELL
 
 if(flag==0)
     {
     vo.setMaxFetchSize(0) ;
     Row row = vo.createRow();
     try
     {
     //  for (int i=0; i < excel_data.length; i++)
     if (excel_data.length > 1 )
     {
     
                            row.setAttribute("BatchId", p_batchNum);
//                            row.setAttribute("Status", "Staging");
                            row.setAttribute("OafLineId", am.getOADBTransaction().getSequenceValue("xxsify_clm_bulk_upld_line_seq"));
     
                       
         row.setAttribute("ClmPoHdrId", excel_data[0]);
         row.setAttribute("ClmPoLineId", excel_data[1]);
         row.setAttribute("ClmPoLineItemsDetId", excel_data[2]);
                       
                       
                            row.setAttribute("FromLocation", excel_data[3]);
                            row.setAttribute("ToLocation", excel_data[4]);
                            row.setAttribute("SupplierName", excel_data[5]);
                            row.setAttribute("SupplierSite", excel_data[6]);
                            row.setAttribute("Capacity", excel_data[7]);
                            row.setAttribute("SifyBillTo", excel_data[8]);
                            row.setAttribute("SifyShipTo", excel_data[9]);
                            row.setAttribute("EbsPoNum", excel_data[10]);
                            row.setAttribute("ClmId", excel_data[11]);
                            
                            row.setAttribute("Remarks", excel_data[12]);
                            //System.out.println("remarks seting ");
                            
                            row.setAttribute("ItemCode", excel_data[13]);
                          
                          
                          
                            row.setAttribute("NewActivity", excel_data[15]);
                            
                           row.setAttribute("Elgibility", excel_data[19]);
         
                           row.setAttribute("Reason", excel_data[20]);
                           
       
                            //System.out.println("EffectiveStartDate print "+excel_data[17]);
                            
                            if(excel_data[17]!=null)
                            {
                            row.setAttribute("EffectiveStartDate", castToJBODate(pageContext,excel_data[17]));                                                                                      
                            }
                            else
                                row.setAttribute("EffectiveStartDate", excel_data[17]);
                            
                            
                            if(excel_data[18]!=null)
                            {
                            row.setAttribute("EffectiveEndDate", castToJBODate(pageContext,excel_data[18]));
                            }
                            
                            else
                                {
                                row.setAttribute("EffectiveEndDate", excel_data[18]);
                                }
                                
                if(excel_data[14]!=null)
                {
                
                row.setAttribute("Rate",excel_data[14]);
                }
                       
                            
         if(excel_data[16]!=null)
                {
                   
                            row.setAttribute("NewPoPrice", excel_data[16]);
                  
                }

      /*   if(excel_data[16]!=null)
         {
             newprice = excel_data[16].replaceAll("\\W","");
            
            try{
                     row.setAttribute("NewPoPrice", new Number(Integer.parseInt(newprice.trim())));
            }
            catch (Exception ex1)
            {
//            System.out.println("new po price catch "+ex1.getMessage());
            }
         }*/   //new po price
         
         
         
       /*  if(excel_data[14]!=null)
         {
             oldPrice= excel_data[14].replaceAll("\\W","");
         
         try{
         row.setAttribute("Qty", new Number(Integer.parseInt(oldPrice.trim())));
         }
         catch(Exception ex){
             System.out.println("qty price catch "+ex.getMessage());
             throw new OAException("Error while parsing Qty Amount " + 
                                   ex.getMessage());
             
         }
         
         }*/   
         
         //old po price
         
         
         
         
     }
     
     }
     
     catch(Exception e)
     {
     System.out.println(e.getMessage());
         throw new OAException("Error while setAttributes fom CELL " + 
                               e.getMessage());
     }
     
     vo.insertRow(row);
     }//if flag==0
     
         else
             pageContext.putDialogMessage(new OAException("Date Format Error - Enter DD-MMM-YYYY format",OAException.ERROR));

             
             }//for loop for each line
             
             
             
             }//try
             
             catch (BiffException e)
             {
         //            e.printStackTrace();
                 throw new OAException("Please Select an Excel File to Upload it to Database!!!",   
                            OAException.ERROR); 
             }



             }//try
             catch(Exception e)
             {
                 throw new OAException("Excel Initialization error",   
                            OAException.ERROR); 
         //        e.printStackTrace();
             }
             

 
 OADBTransaction txn = pageContext.getRootApplicationModule().getOADBTransaction();
 txn.commit();

            String stmt = "BEGIN XXSIFY_CLM_BULK_LOAD_PKG.XXSIFY_CLM_RECUR_BULK_LOAD_PRC(:1,:2,:3); end;";
               CallableStatement cs = 
                   am.getOADBTransaction().createCallableStatement(stmt, 1);
               try {
                 
                   cs.setString(1, p_batchNum );
                   cs.registerOutParameter(2, Types.VARCHAR);
                   cs.registerOutParameter(3, Types.VARCHAR);
                   cs.execute();
                   retValues = cs.getString(2);
                   retFlag =   cs.getString(3);
                
                   cs.close();
               } catch (Exception e) {
                   throw new OAException("Error while calling procedure"+e.getMessage() ,OAException.ERROR);
               }       
               
                        System.out.println("ret values from OUT " +retValues);
                        System.out.println(" retValues after concat : "+retValues);
                        
                        
                        if(retValues !=null)
                        {
                        StringTokenizer st = new StringTokenizer(retValues,"##" );  
                                    while(st.hasMoreTokens())
                                    {
                                                     errMsgs.add(st.nextToken());
                                                     System.out.println(" err token "+errMsgs.toString());
                                     }
                        

                        
                        System.out.println("errmessage :"+errMsgs.size());
                        
                        if(errMsgs!=null && errMsgs.size()>0){
                              for(int i=1;i<errMsgs.size();i++){
                              System.out.println(" i in vector size ");                                                     
                               //  if (errMsgs.get(i).toString().equalsIgnoreCase("1. S")){
                                if (retFlag.equalsIgnoreCase("S")){
                                    pageContext.putDialogMessage(new OAException(errMsgs.get(i).toString(),OAException.CONFIRMATION));  
                                    // break;
                                 }
                                 else{      
                                  pageContext.putDialogMessage(new OAException(errMsgs.get(i).toString(),OAException.ERROR));
                                 } 
                              
                              }
                              System.out.println("after break");
                         }
                        }    
                        else
                        {
                           errMsgs=null;
                           pageContext.putDialogMessage(new OAException("Status Out Message : null ",OAException.ERROR));
                        }
                        
             
//                  
//                  String sql2 = "BEGIN xxsify_clm_Show_err_msg_prc(:1,:2,:3,:4); END;";
//                       String outExcp2 =null;
//                         
//                       try
//                       {
//                         OracleCallableStatement cs2 = (OracleCallableStatement)txn.createCallableStatement(sql2, 2);
//                         cs2.registerOutParameter(4, java.sql.Types.VARCHAR);
//                           cs2.setString(1, "1");
//                           cs2.setString(2, p_batchNum);
//                           cs2.setString(3, retValues);
//                           
//                         cs2.execute();
//                         outExcp2 = cs2.getString(4);
//                         cs2.close();
//                         System.out.println("insert procedure is done for error message*********");
//                           txn.commit();
//                       }
//                       catch (Exception ex) 
//                       {
//                       throw new OAException("Exception in Showing Error Message  :"+ex.getMessage(),OAException.ERROR);
//                       }
//                 
//            
            
     
        }
        

      }      //end of METHOD
          

      
      if (pageContext.getParameter("DownloadReport")!=null)//DOWNLOAD
      {
      String cpReqid="";
           
        
          String outfilePath=pageContext.getProfile("XXSIFY_CLM_BLK_UPLD_OUTFILE_PATH") ;
//           String outfilePath="/ebsdev/app/R12DEV/fs_ne/inst/R12DEV_ebsdev/logs/appl/conc/out";
          
          if(pageContext.getSessionValue("Session_Req_ID") != null)
            {
           cpReqid=(String)pageContext.getSessionValue("Session_Req_ID");            
              
               
               }
           
       //   XXSIFY CLM Price Revision Upload Report
            
         //  String file_name_with_ext="XXSIFYCLMUPGRADEREP_"+cpReqid+"_1.xls";            
        //   String file_name_with_path=outfilePath+"/XXSIFYCLMUPGRADEREP_"+cpReqid+"_1.xls";  
        
           String file_name_with_ext="XXSIFYCLMPREVREP_"+cpReqid+"_1.xls";            
           String file_name_with_path=outfilePath+"/XXSIFYCLMPREVREP_"+cpReqid+"_1.xls";

          pageContext.writeDiagnostics(this,"Log => "+cpReqid ,OAFwkConstants.STATEMENT) ;
          
          pageContext.writeDiagnostics("Log=>","BulUpload outfilePath :  "+outfilePath,1);
          pageContext.writeDiagnostics("Log=>","BulUpload  cp req id: "+cpReqid,1);
          pageContext.writeDiagnostics("Log=>","BulUpload  file_name_with_ext : "+file_name_with_ext,1);
          pageContext.writeDiagnostics("Log=>","BulUpload  file_name_with_path: "+file_name_with_path,1);
          
          
           downloadFileFromServer(pageContext,webBean,file_name_with_path,file_name_with_ext,cpReqid);


//            String file_name_with_path="/ebsdev/app/R12DEV/fs_ne/inst/R12DEV_ebsdev/logs/appl/conc/out/XXSIFYINVFIFOCOSSR_821110_1.xls";
           
//          String file_name_with_path="C:\\Users\\vshanmugam.OSIUS\\Desktop\\TestFile\\XXSIFYCLMUPGRADEREP_822114_1.xls";
          
//          String file_name_with_ext="XXSIFYCLMUPGRADEREP_822114_1.xls";
//            String file_name_with_ext="XXSIFYCLMUPGRADEREP_822114_1.xls";
            
            
            
            System.out.println("file_name_with_path "+file_name_with_path);
            System.out.println("file_name_with_ext "+file_name_with_ext);
            
          
      }
  }
  
  
    
    public String ValidateDate(OAPageContext pageContext,String aDate) {
    DateFormat formatter;
    java.util.Date date;

    if (!aDate.isEmpty()) {

    
       try {
           
           System.out.println("date is "+aDate);

           formatter = new SimpleDateFormat("dd-MMM-yyyy");
           date = formatter.parse(aDate);
           java.sql.Date sqlDate = new java.sql.Date(date.getTime());
           oracle.jbo.domain.Date jboDate = 
               new oracle.jbo.domain.Date(sqlDate);
           System.out.println("sql date "+sqlDate);
           
           

           return jboDate+"";
       } catch (Exception e) {
           System.out.println("catch exception : date parsing ");
            return "Error";
    //                throw new OAException("DATE Exception "+e.getMessage());
           
    
       }

    }

    return null;
    }
    
  
    public oracle.jbo.domain.Date castToJBODate(OAPageContext pageContext,String aDate) {
            DateFormat formatter;
            java.util.Date date;

            if (!aDate.isEmpty()) {

            //System.out.println("is not empty");
                try {
                    //System.out.println("try block");
                    formatter = new SimpleDateFormat("dd-MMM-yyyy");
                    date = formatter.parse(aDate);
                    java.sql.Date sqlDate = new java.sql.Date(date.getTime());
                    oracle.jbo.domain.Date jboDate = 
                        new oracle.jbo.domain.Date(sqlDate);
                    //System.out.println("sql date "+sqlDate);
                    
                    

                    return jboDate;
                } catch (Exception e) {
                    System.out.println("catch ex date");
//break;
//                    OAException catchEx1=new OAException("Enter the date in dd-mon-yyyy format "+e.getMessage(),OAException.ERROR);
//                    pageContext.putDialogMessage(catchEx1);
//                    
                    //e.printStackTrace();
                }

            }

            return null;
        }
  
 public void downloadFileFromServer(OAPageContext pageContext,
 OAWebBean webBean,
                                  String file_name_with_path,
                                  String file_name_with_ext,
                                  String cpReqid) 
  {
  
    OAApplicationModule am = pageContext.getApplicationModule(webBean);
    String status_code="" ;
    String phase_code="";
    
  HttpServletResponse response = (HttpServletResponse) pageContext.getRenderingContext().getServletResponse();
 
      //System.out.println("Inside download : file_name_with_path "+file_name_with_path);
      //System.out.println("file_name_with_ext "+file_name_with_ext);
      
 
  if (((file_name_with_path == null) || ("".equals(file_name_with_path)))){
    throw new OAException("File path is invalid.");
  }


  File fileToDownload = null;
 // try{
    fileToDownload = new File(file_name_with_path);
 // }catch (Exception e){
  //  throw new OAException("Invalid File Path or file does not exist.");
    //}
  if(fileToDownload.exists())
  {  
  
     if (!fileToDownload.canRead()){
        throw new OAException("Not Able to read the file.");
      }

     // String fileType = "application/pdf";//getMimeType(file_name_with_ext);
      response.setContentType("application/MSEXCEL");

//       response.setContentType("application/csv");
      response.setContentLength((int)fileToDownload.length());
      response.setHeader("Content-Disposition", "attachment; filename=\"" + file_name_with_ext + "\"");

      InputStream in = null;
      ServletOutputStream outs = null;

      try{
        outs = response.getOutputStream();
        in = new BufferedInputStream(new FileInputStream(fileToDownload));
        int ch;
        while ((ch = in.read()) != -1)
        {
          outs.write(ch);
        }
      }catch (IOException e)
      {
       
        e.printStackTrace();
      }finally
      {
        try{
          outs.flush();
          outs.close();
          if (in != null)
          {
            in.close();
          }
        }catch (Exception e)
        {
          e.printStackTrace();
        }
      } 

  }//file exists
  
  
  else
  {
    // throw new OAException("No out file exists for request "+cpReqid+".The concurrent manager may have encountered an error while attempting to create this file.",OAException.ERROR);
  OAException message1 = new OAException("The Concurrent Request  "+cpReqid+" is Pending/Running...",OAException.WARNING);
  pageContext.putDialogMessage(message1);
  }
  
  
      
      
     
  }
  

  
}


