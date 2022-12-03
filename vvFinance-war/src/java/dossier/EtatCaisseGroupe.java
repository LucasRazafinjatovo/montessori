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

import finance.EtatCaisseGroupee;

@WebServlet(name = "EtatCaisseGroupe", urlPatterns = {"/downloadCaisseGroupe"})
public class EtatCaisseGroupe extends HttpServlet {

    protected void doPost(HttpServletRequest arg0, HttpServletResponse arg1)
            throws ServletException, IOException {
        OutputStream os = arg1.getOutputStream();
        try {
            String ext = arg0.getParameter("ext");

            arg1.setContentType("text/plain");
            SimpleDateFormat fd = new SimpleDateFormat("yyyy-MM-dd");
            String d = fd.format(new Date());
            arg1.setHeader("Content-Disposition", "attachment;filename=export-" + d + "." + ext);

            int nombre = new Integer(arg0.getParameter("nombre"));
            EtatCaisseGroupee[] tabs = new EtatCaisseGroupee[nombre];
            for (int iterator = 0; iterator < nombre; iterator++) {
                tabs[iterator] = new EtatCaisseGroupee(arg0.getParameter("caisse" + iterator), Utilitaire.stringToDouble(arg0.getParameter("report" + iterator)),
                        Utilitaire.stringToDouble(arg0.getParameter("rdebit" + iterator)), Utilitaire.stringToDouble(arg0.getParameter("rcredit" + iterator)),
                        Utilitaire.stringToDouble(arg0.getParameter("nrdebit" + iterator)), Utilitaire.stringToDouble(arg0.getParameter("nrcredit" + iterator)),
                        Utilitaire.stringToDouble(arg0.getParameter("soldepratique" + iterator)), Utilitaire.stringToDouble(arg0.getParameter("soldetheorique" + iterator)),
                        Utilitaire.stringToDouble(arg0.getParameter("plafonnement" + iterator)));
            }

            String entete[] = {"Caisse", "Report", "plafonnement","rcredit", "rdebit", "nrcredit", "nrdebit",  "soldetheorique", "soldepratique"};
            TableauRecherche tr = new TableauRecherche(tabs, entete);
            tr.makeHtml();

            if (ext.compareToIgnoreCase("xml") == 0) {
                os.write(tr.getExpxml().getBytes());
            } else {
                if (ext.compareToIgnoreCase("csv") == 0) {
                    os.write(tr.getExpcsv().getBytes());

                } else {
                    if (ext.compareToIgnoreCase("xls") == 0) {
                        arg1.setContentType("application/vnd.ms-excel");
                        os.write(tr.getHtml().getBytes());
                        ;
                    }
                }
            }
            os.flush();

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
