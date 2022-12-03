<%-- 
    Document   : apresFacturePubRadioMere
    Created on : 15 juin 2017, 11:32:54
    Author     : Alain
--%>
<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="pub.*" %>
<%@ page import="bean.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <%
        UserEJB u = null;
        String date = null;
        String acte = null;
        String lien = null;
        String dateDebut = null;
        String dateFin = null;
        String idClient = null;
        String note = null;
        String idDeviseEn = null;
        String idFactureEn = null;
        String idTva = null;
        String reduction = null;
        String dateLimite = null;
        String idCategorie = null;
        String idFactMere = null;
        String montantAPayer = null;
        String idScatServ = null;
        String idCoursChange = null;
        String dateLimitePaiement = null;
        String idTypePaie = null;
        String entite = null;
        String parution = null;
        String agence;
        String actee = null;
        String listepub = "";
        String[] g = null;
        String retour = null;
        Pucomplet pub = null;
        Pucomplet[] lpub = null;

        String modepaiement = null;

        date = request.getParameter("date");
        idClient = request.getParameter("idClient");
        dateDebut = request.getParameter("dateDebut");
        dateFin = request.getParameter("dateFin");
        note = request.getParameter("note");
        idDeviseEn = request.getParameter("idDeviseEn");
        idFactureEn = request.getParameter("idFactureEn");
        reduction = request.getParameter("reduction");
        idTva = request.getParameter("idTva");
        idCategorie = request.getParameter("idTypeFacture");
        acte = request.getParameter("acte");
        montantAPayer = request.getParameter("montant");
        idScatServ = request.getParameter("idscatserv");
        idTypePaie = request.getParameter("idTypePaie");
        agence = request.getParameter("agence");
        entite = request.getParameter("entite");
        parution = request.getParameter("parution");
        actee = request.getParameter("radio");
        listepub = (String) session.getAttribute("idpubradiof");
        session.removeAttribute("idpubradiof");
        g = Utilitaire.split(listepub, ",");

        modepaiement = request.getParameter("modepaiement");
        dateLimite = request.getParameter("dateLimite");

        try {
            u = (UserEJB) session.getValue("u");
            lien = (String) session.getValue("lien");
            if (acte.compareTo("INSERT") == 0) {
                if (request.getParameter("typefact").compareToIgnoreCase("normale") == 0){
                    idFactMere = u.createFactureMereRadio2(date, dateDebut, dateFin, idClient, note, idTva, idFactureEn, idDeviseEn, reduction, idCategorie, idTypePaie, agence, entite, parution, modepaiement, dateLimite, g, request.getParameter("idTva"), request.getParameter("datyparu"));
    %><script language="JavaScript"> document.location.replace("<%=lien%>?but=facture/factureFille.jsp&idFactMere=<%=idFactMere + "&fact=" + actee + "&listepub=" + listepub%>");</script>
    <% 
            }
        }

    } catch (Exception e) {
        e.printStackTrace();%>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>");</script>
    <%
        }
    %>
</html>