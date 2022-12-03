package dossier;

import affichage.TableauRecherche;
import java.io.*;
import java.util.Date;
import java.text.SimpleDateFormat;
import bean.ClassMAPTable;
import java.lang.reflect.Field;
import bean.CGenUtil;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

/**
 * <p>
 * Title: Gestion des recettes </p>
 * <p>
 * Description: </p>
 * <p>
 * Copyright: Copyright (c) 2005</p>
 * <p>
 * Company: </p>
 *
 * @author unascribed
 * @version 1.0
 */

@WebServlet(name = "ServletDownload", urlPatterns = {"/download"})
public class ServletDownload extends HttpServlet {

    protected void doPost(HttpServletRequest arg0, HttpServletResponse arg1)
            throws ServletException, IOException {
        OutputStream os = arg1.getOutputStream();
        try {
            String ext = arg0.getParameter("ext");
            //String donn=arg0.getParameter("donnee");
            String awhere = arg0.getParameter("awhere");
            if (awhere == null) {
                awhere = "";
            }
            arg1.setContentType("text/plain");
            SimpleDateFormat fd = new SimpleDateFormat("yyyy-MM-dd");
            String d = fd.format(new Date());
            arg1.setHeader("Content-Disposition", "attachment;filename=export-" + d + "." + ext);

            String type = arg0.getParameter("donnee");

            if (type.compareTo("0") == 0) {
                if (ext.compareTo("xls") == 0) {
                    arg1.setContentType("application/vnd.ms-excel");
                    //arg1.setHeader("Content-Disposition","inline;filename=export-"+d+"."+ext);
                    //System.out.println("arg0.getParameter():"+arg0.getParameter("table"));
                    os.write(arg0.getParameter("table").replace('*', '"').getBytes());
                } else {
                    String donnee = arg0.getParameter(ext);
                    //System.out.println(donnee);
                    os.write((donnee).replace('*', '"').getBytes());
                    os.flush();
                }

            } else if (type.compareTo("1") == 0) {

                ClassMAPTable o = (ClassMAPTable) arg0.getSession().getAttribute("critere");

                Field[] field = CGenUtil.getFieldList(o);
                String entete[] = new String[field.length];
                for (int i = 0; i < entete.length; i++) {
                    entete[i] = field[i].getName();
                    //System.out.println(entete[i]);
                }

                ClassMAPTable[] c = (ClassMAPTable[]) CGenUtil.rechercher(o, null, null, awhere);
                //System.out.println("c.length:"+c.length);
                TableauRecherche tr = new TableauRecherche(c, entete);
                tr.makeHtml();
                //System.out.println(donn);
                if (ext.compareToIgnoreCase("xml") == 0) {
                    os.write(tr.getExpxml().getBytes());
                    //System.out.println(donn+tr.getExpxml());
                } else {
                    if (ext.compareToIgnoreCase("csv") == 0) {
                        os.write(tr.getExpcsv().getBytes());
                        //System.out.println(donn+tr.getExpcsv());
                    } else {
                        if (ext.compareToIgnoreCase("xls") == 0) {
                            arg1.setContentType("application/vnd.ms-excel");
                            //arg1.setHeader("Content-Disposition","attachment;filename=export-"+d+"."+ext);
                            os.write(tr.getHtml().getBytes());
                            ;
                        }
                    }
                }
                os.flush();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            os.close();
        }
    }

    protected void doGet(HttpServletRequest arg0, HttpServletResponse arg1)
            throws ServletException, IOException {
    }
}
