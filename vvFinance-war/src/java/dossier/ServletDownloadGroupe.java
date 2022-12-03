package dossier;

import utilitaire.*;
import java.sql.*;
import java.io.*;
import java.util.Date;
import java.text.SimpleDateFormat;
import bean.ClassMAPTable;
import java.lang.reflect.Field;
import bean.CGenUtil;
import affichage.TableauRecherche;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

import finance.EtatCaisseTableau;

/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */
@WebServlet(name = "ServletDownloadGroupe", urlPatterns = {"/downloadGroupe"})
public class ServletDownloadGroupe extends HttpServlet {


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
                                os.write(arg0.getParameter("table").replace('*','"').getBytes());
                        }
                        else
                        {
                                String donnee=arg0.getParameter(ext);
                                os.write((donnee).replace('*','"').getBytes());
                                os.flush();
                        }

                }
                else if(type.compareTo("1")==0)
                {
                          String colDefaut=arg0.getParameter("colDefaut"); String[] lcD=null;
                          String somDefaut=arg0.getParameter("somDefaut"); String[] lsD=null;
                          String ordre=arg0.getParameter("ordre");
                          if(somDefaut.compareTo("")!=0 || somDefaut!=null) lsD=Utilitaire.split(somDefaut,",");
                          if(colDefaut.compareTo("")!=0 || colDefaut!=null) lcD=Utilitaire.split(colDefaut,",");
                          ClassMAPTable o=(ClassMAPTable)arg0.getSession().getAttribute("critere");
                          String entete[]=new String[lcD.length+lsD.length];
                          int j=0;
                          for(int i=0;i<entete.length;i++)
                          {
                            if(i >= lcD.length){ entete[i]=lsD[j];j++;}
                            else entete[i]=lcD[i];
                          }
                          Connection con = (new UtilDB()).GetConn();
                          bean.ResultatEtSomme cx=(bean.ResultatEtSomme)CGenUtil.rechercherGroupe(o,lcD,lsD,null,null,awhere,lsD,ordre,con);
                          con.close();
                          ClassMAPTable[] c=(ClassMAPTable[])cx.getResultat();
                          
                          
                          TableauRecherche tr=new TableauRecherche(c,entete);
                          tr.getHtml();
                          if(ext.compareToIgnoreCase("xml")==0)
                          {
                                os.write(tr.getExpxml().getBytes());
                                }
                          else
                          {if(ext.compareToIgnoreCase("csv")==0)
                                {
                                        os.write(tr.getExpcsv().getBytes());

                                }
                                else
                                {
                                        if(ext.compareToIgnoreCase("xls")==0)
                                        {
                                                arg1.setContentType("application/vnd.ms-excel");
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

protected void doGet(HttpServletRequest arg0, HttpServletResponse arg1)
throws ServletException, IOException {
}
}