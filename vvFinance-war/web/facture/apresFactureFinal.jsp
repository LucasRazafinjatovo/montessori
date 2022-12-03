<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="facture.*" %>
<%@ page import="pub.*" %>
<%@ page import="ventegazety.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <%!
        UserEJB u = null;
        String lien = null;
        String acte = null;
        String idFact = null;
        String listepub = "";
        String[] g = null;
        String fact = null;
        Pucomplet pub = null;
        Pucomplet[] lpub = null;
        Invendu inv = null;
    %>
    <%
        acte = request.getParameter("acte");
        idFact = request.getParameter("idFactMere");
        listepub = request.getParameter("listepub");
        // session.removeAttribute("listepub");
        g = Utilitaire.split(listepub, ",");
        fact = request.getParameter("fact");
    %>

    <%
        try {
            u = (UserEJB) session.getValue("u");
            lien = (String) session.getValue("lien");

            if (acte.compareToIgnoreCase("finalise") == 0) {

                if (request.getParameter("typefact").compareToIgnoreCase("normale") == 0) {
                    idFact = u.finaliseFactureUpdate(request.getParameter("idFactMere"), request.getParameter("daty"), request.getParameter("periodeDebut"), request.getParameter("periodeFin"), request.getParameter("idClient"), request.getParameter("noteExplicative"), request.getParameter("idTva"), request.getParameter("idFactureEn"), request.getParameter("idDeviseEn"), request.getParameter("reduction"), request.getParameter("idSCatService"), request.getParameter("idTypePaiement"), request.getParameter("modepaiement"), request.getParameter("datelimite"));
                    FactureClientFiche factclt = new FactureClientFiche();
                    FactureClientFiche[] lfactclt = (FactureClientFiche[]) CGenUtil.rechercher(factclt, null, null, " and numfact='" + idFact + "'");

                    if (fact.compareToIgnoreCase("pub") == 0) {
                        u.insertPubFact(g, lfactclt[0].getIdfacturefournisseur());

                    } else if (fact.compareToIgnoreCase("invendu") == 0) {
                        u.insertInvFact(g, lfactclt[0].getIdfacturefournisseur());

                    }else if (fact.compareToIgnoreCase("radio") == 0) {
                        u.insertInvFact(g, lfactclt[0].getIdfacturefournisseur());

                    }

    %>
    <script language="javascript">
        document.location.replace("<%=lien%>?but=facture/detailFacture.jsp&idFactureMere=<%=idFact%>");
    </script>
    <%
    } else {
        idFact = u.finaliseFactureUpdateProforma(request.getParameter("idFactMere"), request.getParameter("daty"), request.getParameter("periodeDebut"), request.getParameter("periodeFin"), request.getParameter("idClient"), request.getParameter("noteExplicative"), request.getParameter("idTva"), request.getParameter("idFactureEn"), request.getParameter("idDeviseEn"), request.getParameter("reduction"), request.getParameter("idSCatService"), request.getParameter("idTypePaiement"));

    %>
    <script language="javascript">
        document.location.replace("<%=lien%>?but=facture/detailFactureProforma.jsp&idFactureMere=<%=idFact%>");
    </script>
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