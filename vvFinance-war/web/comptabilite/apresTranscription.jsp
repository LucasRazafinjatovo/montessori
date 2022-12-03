<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="affichage.*" %>
<%@ page import="comptabilite.*" %>
<%@ page import="java.sql.Date" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <%!
        UserEJB u = null;
        String acte = null;
        String lien = null;
        String bute;
    %>
    <%

        lien = (String) session.getValue("lien");
        u = (UserEJB) session.getAttribute("u");
        acte = request.getParameter("acte");

        if (acte.compareToIgnoreCase("tiers") == 0) {
            u.transcrireClientFournisseur();
        }
        if (acte.compareToIgnoreCase("depense") == 0) {
            u.transcrireDepense();
        }
        if (acte.compareToIgnoreCase("recette") == 0) {
            u.transcrireVente();
        }
        if (acte.compareToIgnoreCase("tresor") == 0) {
            u.transcrireTresorerie();
        }
        if (acte.compareToIgnoreCase("lettrage") == 0) {
            u.lettrageAutomatique();
        }
       /* if (acte.compareToIgnoreCase("employe") == 0) {
            u.transcrireEmployeMultiple();
        }*/
    %>
    <script language="JavaScript">  document.location.replace("http://localhost:8080/vvFinance-war/modeleAdmin.jsp?but=comptabilite/transcription.jsp");</script>
</html>



