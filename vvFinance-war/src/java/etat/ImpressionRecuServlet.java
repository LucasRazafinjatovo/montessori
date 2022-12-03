/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package etat;

import bean.CGenUtil;
import etudiant.EtatPaiement;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.bind.DatatypeConverter;

import org.apache.commons.codec.binary.Base64;

import user.UserEJB;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.convert.ImageConverter;
import reporting.ReportingCdn;
import reporting.ReportingUtils;
import reporting.ReportingUtils.ReportType;
import utilitaire.ChiffreLettre;
import utilitaire.Utilitaire;

/**
 *
 * @author LUCAS
 */
@WebServlet(name = "ImpressionRecuServlet", urlPatterns = {"/imprimerRecu"})
public class ImpressionRecuServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    String nomJasper = "";
    //ReportingCdn.Fonctionnalite fonctionnalite = ReportingCdn.Fonctionnalite.PAIE;

    public String getReportPath() throws IOException {
        return getServletContext().getRealPath(File.separator + "report" + File.separator + getNomJasper() + ".jasper");
    }

    public String getNomJasper() {
        return nomJasper;
    }

    public void setNomJasper(String nomJasper) {
        this.nomJasper = nomJasper;
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, Exception, IOException, JRException {
        response.setContentType("text/html;charset=UTF-8");
        
        try {
            /* TODO output your page here. You may use following sample code. */
            System.out.println("out =  mandalo servlet impressions");
            String action = request.getParameter("action");
            if (action.equalsIgnoreCase("imprimerRecu")) {
                System.out.println("imprimeo e!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
                imprimerRecu(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } 
    }

    private void imprimerRecu(HttpServletRequest request, HttpServletResponse response) throws IOException, JRException, Exception {
        UserEJB u = (UserEJB) request.getSession().getAttribute("u");
        String id = request.getParameter("id");
        
        EtatPaiement pc = new EtatPaiement();
        EtatPaiement[] list = (EtatPaiement[])CGenUtil.rechercher(pc, null, null, " AND ID = '"+id+"'");
        Map param = new HashMap();
        param.put("DATY", list[0].getMois()+"/"+list[0].getAnnee());
        param.put("DESIGNATION", list[0].getDesignation());
        param.put("MONTANT", ChiffreLettre.convertRealToString(list[0].getMontantapayer())+" Ariary");
        param.put("ECOLE", list[0].getEcole());
        param.put("IDFACTURE", list[0].getId());
        param.put("IDETUDIANT", list[0].getIdetudiant());
        setNomJasper("recu");
        UtilitaireImpression.imprimer(request, response, "recu", param, null, getReportPath());

    }
   
    

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">

    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);

        } catch (Exception ex) {
            Logger.getLogger(ImpressionRecuServlet.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);

        } catch (Exception ex) {
            Logger.getLogger(ImpressionRecuServlet.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
