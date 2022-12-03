package mg.vv.service;

import affichage.TableauRecherche;
import bean.CGenUtil;
import bean.ClassMAPTable;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.lang.reflect.Field;
import java.text.DecimalFormatSymbols;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.DataFormatter;
import utilitaire.Utilitaire;
import utilitaire.UtilitaireExcelMa;

@WebServlet(name = "DownloadExport", urlPatterns = {"/download"})
public class DownloadExport extends HttpServlet {
    
    protected void doPost(HttpServletRequest arg0, HttpServletResponse arg1)
           throws ServletException, IOException {       
        OutputStream os = arg1.getOutputStream();
try {
        String ext=arg0.getParameter("ext");
        //String donn=arg0.getParameter("donnee");
        String awhere=arg0.getParameter("awhere");
        if(awhere==null)
            awhere="";
                arg1.setContentType("text/plain");
                SimpleDateFormat fd=new SimpleDateFormat("yyyy-MM-dd");
                String d=fd.format(new Date());
                arg1.setHeader("Content-Disposition","attachment;filename=export-"+d+"."+ext);

                String type=arg0.getParameter("donnee");

                if(type.compareTo("0")==0)
                {
                        if(ext.compareTo("xls")==0)
                        {
                                arg1.setContentType("application/vnd.ms-excel");
                                //arg1.setHeader("Content-Disposition","inline;filename=export-"+d+"."+ext);
                                //System.out.println("arg0.getParameter():"+arg0.getParameter("table"));
                                os.write(arg0.getParameter("table").replace('*','"').getBytes());
                        }
                        else
                        {
                                String donnee=arg0.getParameter(ext);
                                //System.out.println(donnee);
                                os.write((donnee).replace('*','"').getBytes());
                                os.flush();
                        }

                }
                else if(type.compareTo("1")==0)
                {

                          ClassMAPTable o=(ClassMAPTable)arg0.getSession().getAttribute("critere");

                          Field[] field=CGenUtil.getFieldList(o);
                          String entete[]=new String[field.length];
                          for(int i=0;i<entete.length;i++)
                          {
                                entete[i]=field[i].getName();
                                //System.out.println(entete[i]);
                          }


                          ClassMAPTable []c=(ClassMAPTable[])CGenUtil.rechercher(o,null,null,awhere);
                          //System.out.println("c.length:"+c.length);
                          TableauRecherche tr=new TableauRecherche(c,entete);
                          tr.makeHtml();
                          //System.out.println(donn);
                          if(ext.compareToIgnoreCase("xml")==0)
                          {
                                os.write(tr.getExpxml().getBytes());
                                //System.out.println(donn+tr.getExpxml());
                                }
                          else
                          {if(ext.compareToIgnoreCase("csv")==0)
                                {
                                        os.write(tr.getExpcsv().getBytes());
                                        //System.out.println(donn+tr.getExpcsv());
                                }
                                else
                                {
                                        if(ext.compareToIgnoreCase("xls")==0)
                                        {
                                                arg1.setContentType("application/vnd.ms-excel");
                                                //arg1.setHeader("Content-Disposition","attachment;filename=export-"+d+"."+ext);
                                                os.write(tr.getHtml().getBytes());
;					}
                                }
                        }
                          os.flush();
                }
        }
        catch (Exception e) {
                        e.printStackTrace();
                }
        finally{
                os.close();
                }
    }
    
    public static void writeXls (OutputStream fileOut , ArrayList<ArrayList> data)throws Exception{       
           try {
                   //FileOutputStream fileOut = new FileOutputStream("poi-test.xls");
                   HSSFWorkbook workbook = new HSSFWorkbook();
                   HSSFSheet worksheet = workbook.createSheet("Excel Genere");
                //   System.out.println("data size"+data.size());                
                   for(int i=0 ; i<data.size();i++){
                       ArrayList<String> dataRow  = (ArrayList<String>)data.get(i);
                       HSSFRow row1 = worksheet.createRow(i);
                      // System.out.println("col count= "+dataRow.size());
                       for(int j=0;j<dataRow.size();j++){
                           HSSFCell cellA1 = row1.createCell(j);
                           
                        //   System.out.println("val===="+dataRow.get(j));
                            String v = dataRow.get(j) ; 
                            //tsy espace normale le ray voalohany io 
                            DecimalFormatSymbols currentLocaleSymbols = DecimalFormatSymbols.getInstance();
                            char localeDecimalSeparator = currentLocaleSymbols.getDecimalSeparator();
                           // System.out.println("separateur________"+localeDecimalSeparator);
                         //   System.out.println("");
                            
                            v = removeSpecialCharacters(v);
                            
                            v  = v.replace(" ", "").replace(" ","");
                                                      
                           if(v.length()>0 && Utilitaire.isStringNumeric(v) && !v.contains("-") ){            
                               
                               //System.out.println("resaka numerique "+v);
                               if( v.contains(",") || v.contains(".")){                                                                 
                                   try {
                                       double value = Double.parseDouble(v);
                                       cellA1.setCellValue(value);
                                   }
                                   catch (NullPointerException e) {
                                       String value = v;
                                       cellA1.setCellValue(value);
                                   }
                                   catch (NumberFormatException e) {       
                                       try{
                                           double value = Double.parseDouble(v.replace(",", "."));    
                                           cellA1.setCellValue(value);
                                       }
                                       catch(NumberFormatException s){
                                           double value = Double.parseDouble(v.replace(".", ","));    
                                           cellA1.setCellValue(value);
                                       }                                                                        
                                   }
                                   
                                   //cellA1.setCellType(XSSFCell.CELL_TYPE_NUMERIC);
                                   HSSFDataFormat format = workbook.createDataFormat();
                                   CellStyle style = workbook.createCellStyle(); 
                                   style.setDataFormat(format.getFormat("#,##0.00"));                                
                                   cellA1.setCellStyle(style);
                                   DataFormatter df = new DataFormatter();
                                   df.formatCellValue(cellA1);
                               }                                    
                               else {
                                  // System.out.println("longValue "+Long.valueOf(v));                                               
                                   cellA1.setCellValue(v);
                               }                                    
                           }else{                                                         
                                cellA1.setCellValue(dataRow.get(j));
                           }


                       }
                       //System.out.println("i==="+i);
                   }           
                   //HSSFFormulaEvaluator.evaluateAllFormulaCells(workbook);
                   workbook.write(fileOut);
                   //fileOut.flush();
                   //fileOut.close();
           } catch (FileNotFoundException e) {
                   e.printStackTrace();
           } catch (IOException e) {
                   e.printStackTrace();
           }
    }    

    public static void writeXlsSpec (OutputStream fileOut , ArrayList<ArrayList> data)throws Exception
    {
        try {
                //FileOutputStream fileOut = new FileOutputStream("poi-test.xls");
                HSSFWorkbook workbook = new HSSFWorkbook();
                HSSFSheet worksheet = workbook.createSheet("Excel Genere");
             //   System.out.println("data size"+data.size());
                int valeur = 0;
                boolean last=false;
                for(int i=1 ; i<data.size();i++){
                    ArrayList<String> dataRow  = (ArrayList<String>)data.get(i);
                    HSSFRow row1 = worksheet.createRow(i);
                   // System.out.println("col count= "+dataRow.size());
                    valeur = 0; 
                    for(int j=0;j<dataRow.size();j++){                        
                        HSSFCell cellA1 = null;
                     //   System.out.println("val===="+dataRow.get(j));
                        String v = dataRow.get(j) ; 
                        if(v.contains("SOUS-TOTAUX")&&j==0)continue;
                        cellA1 = row1.createCell(j+valeur);
                        //tsy espace normale le ray voalohany io 
                        DecimalFormatSymbols currentLocaleSymbols = DecimalFormatSymbols.getInstance();
                        char localeDecimalSeparator = currentLocaleSymbols.getDecimalSeparator();
                        // System.out.println("separateur________"+localeDecimalSeparator);
                        //   System.out.println("");
                        v = removeSpecialCharacters(v);
                        v  = v.replace(" ", "").replace(" ","");
                         
                        if(v.length()>0 && Utilitaire.isStringNumeric(v) && !v.contains("-") ){            
                            //System.out.println("resaka numerique "+v);
                            if( v.contains(",") || v.contains(".")){
                                                              
                                try {
                                    double value = Double.parseDouble(v);
                                    cellA1.setCellValue(value);
                                }
                                catch (NullPointerException e) {
                                    String value = v;
                                    cellA1.setCellValue(value);
                                }
                                catch (NumberFormatException e) {       
                                    try{
                                        double value = Double.parseDouble(v.replace(",", "."));    
                                        cellA1.setCellValue(value);
                                    }
                                    catch(NumberFormatException s){
                                        double value = Double.parseDouble(v.replace(".", ","));    
                                        cellA1.setCellValue(value);
                                    }                                                                        
                                }
                                
                                //cellA1.setCellType(XSSFCell.CELL_TYPE_NUMERIC);
                                HSSFDataFormat format = workbook.createDataFormat();
                                CellStyle style = workbook.createCellStyle(); 
                                style.setDataFormat(format.getFormat("#,##0.00"));                                
                                cellA1.setCellStyle(style);
                                DataFormatter df = new DataFormatter();
                                df.formatCellValue(cellA1);
                            }                                    
                            else {
                               // System.out.println("longValue "+Long.valueOf(v));
                                cellA1.setCellValue(v);
                            }                                    

                        }else{          
                            String toWrite = dataRow.get(j).toUpperCase();                            
                            if(i==2){
                                valeur=2;
                                if(last){                                   
                                  //  valeur=2;                                    
                                }                                    
                            }
                            if(i==3){
                              //  valeur=6;
                            }                            
                                                                                                              
                            cellA1 = row1.createCell(j+valeur);
                            cellA1.setCellValue(dataRow.get(j));           
                            
                            if(toWrite.contains("SOLDE ANT")){                                
                                valeur=1;
                               // worksheet.addMergedRegion(new CellRangeAddress(i,i,3,4));                             
                            }      
                            else if(toWrite.contains("MOUVEMENT")&&!(toWrite.contains("SOLDE"))){  
                                valeur=2;
                                //worksheet.addMergedRegion(new CellRangeAddress(i,i,5,6));
                                
                            }
                            
                            else if(toWrite.contains("SOLDE MOUVEMENT") ){     
                                 valeur=3;
                                //worksheet.addMergedRegion(new CellRangeAddress(i,i,7,8));       
                                
                            }   
                            
                            else if(toWrite.compareTo("SOLDE")==0){
                              // valeur=3;
                                //worksheet.addMergedRegion(new CellRangeAddress(i,i,9,10));
                                //last=true;
                                                           
                            }
                        }


                    }
                    //System.out.println("i==="+i);
                }
                //HSSFFormulaEvaluator.evaluateAllFormulaCells(workbook);
                workbook.write(fileOut);
                //fileOut.flush();
                //fileOut.close();
        } catch (FileNotFoundException e) {
                e.printStackTrace();
        } catch (IOException e) {
                e.printStackTrace();
        }
    }
   
    
    public static String removeSpecialCharacters(String source){
        String temp  = "XXXXX";
        String space = "ZZZZZspace";
        String slash = "oslasho";        
        source = source.replace(",", ".").replace(".", temp).replace(" ", space).replace("/", slash);        
        return source.replaceAll("[^a-zA-Z0-9]+","").replace(temp, ",").replace(space," ").replace(slash, "/");
    }

}
