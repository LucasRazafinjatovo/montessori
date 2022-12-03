<%-- 
    Document   : personnel
    Created on : 4 mai 2017, 16:57:16
    Author     : Murielle
--%>
<%@page import="lc.Direction"%>
<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="affichage.*" %>
<%@ page import="comptabilite.*" %>

<%
    UserEJB u = null;
    String acte = null;
    String lien = null;
    historique.MapUtilisateur ut = null;
    String username = null;
    String pwd = null;
%>
<%
    try {
        username = "dev";
        pwd = "gtgt987";
        UserEJBClient uc = new UserEJBClient();
        u = uc.getInterface();
        u.testLogin(username, pwd);
        session.setAttribute("u", u);
        ut = u.getUser();
        Direction crd = new Direction();
        crd.setIdDir(ut.getAdruser());
        Direction[] ret = (Direction[]) (CGenUtil.rechercher(crd, null, null, ""));
        if (ret.length > 0) {
            session.setAttribute("dirlib", ret[0].getLibelledir());
            u.setIdDirection(ret[0].getLibelledir());
        }
        if (ut.getIdrole().compareTo("dg") == 0) {
            lien = "modeleAdmin.jsp";
            session.setAttribute("lien", lien);
            session.setAttribute("dir", ut.getAdruser());
            acte = request.getParameter("acte");
            String id = request.getParameter("id");
            String entite = request.getParameter("entite");
            String nom = request.getParameter("nom");
            String prenom = request.getParameter("prenom");
            String telephone = request.getParameter("telephone");
            String adresse = request.getParameter("adresse");
            String fonction = request.getParameter("fonction");
            String poste = request.getParameter("poste");
            String matricule = request.getParameter("matricule");

            if (acte.compareToIgnoreCase("insert") == 0) {
                u.insertEmploye(id, entite, nom, prenom, telephone, adresse, fonction, poste, matricule);
            }
        }
%>
<script language="JavaScript">history.back();</script>
<%        } catch (Exception e) {
    e.printStackTrace();
%>
<script language="JavaScript"> alert('<%=e.getMessage()%>');history.back();</script>
<%
        return;
    }
%>

