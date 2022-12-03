<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
    <%!
        UserEJB u = null;
        String acte = null;
        String acteSubmit = null;
        String lien = null;
        String apres = null;
        facture.Client clt = null;
        String idClient = null;

    %>
    <%
        acte = request.getParameter("acte");
        acteSubmit = request.getParameter("Submit");
    %>
    <%
        try {
            lien = (String) session.getValue("lien");
            u = (UserEJB) session.getAttribute("u");
            if (acte.compareTo("UPDATE") == 0) {
                u.updateClient(request.getParameter("idClient"), request.getParameter("nomClient"), request.getParameter("idRegime"), request.getParameter("telephone"), request.getParameter("fax"), request.getParameter("adresse"), request.getParameter("numStat"), request.getParameter("nif"), request.getParameter("rc"), request.getParameter("tp"), request.getParameter("quittance"));
    %>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=facture/listeClient.jsp");</script>
    <%
        }
        if (acte.compareTo("ANNULER") == 0) {
    %>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=facture/client.jsp");</script>
    <%
        }
        if (acte.compareTo("ANNULERMISEAJOUR") == 0) {
    %>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=facture/miseAJourClient.jsp");</script>
    <%
        }
        if (acte.compareTo("INSERT") == 0) {
            u.createClientComptable(request.getParameter("nomClient"), request.getParameter("idRegime"), request.getParameter("telephone"), request.getParameter("fax"), request.getParameter("adresse"), request.getParameter("numStat"), request.getParameter("nif"), request.getParameter("rc"), request.getParameter("tp"), request.getParameter("quittance"), request.getParameter("comptable"));
    %>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=facture/listeClient.jsp");</script>
    <%
        }
        if (acte.compareTo("DELETE") == 0) {
            u.deleteClient(request.getParameter("idClient"));
    %>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=facture/listeClient.jsp");</script>
    <%
        }
        if (acte.compareTo("MISEAJOUR") == 0) {

            try {
                u.miseAjourClientDouble(request.getParameter("clientdepart"), request.getParameter("clientcible"));
            } catch (Exception ex) {
                ex.printStackTrace();
            }
            
    %>

    <script language="JavaScript"> document.location.replace("<%=lien%>?but=facture/miseAJourClient.jsp");</script>
    <%
        }
    } catch (Exception e) {
    %>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>");</script>
    <%
            return;
        }
    %>


    <head>
        <title></title>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    </head>
</html>
