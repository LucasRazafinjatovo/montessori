<%@page import="pub.PubRadioPartenariat"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="lc.Direction" %>
<%@ page import="affichage.*" %>
<%@ page import="actualite.*" %>
<%-- 
    Document   : pubRadioPack-liste
    Created on : 5 juil. 2017, 16:05:41
    Author     : Alain
--%>

<%
    try {
        PubRadioPartenariat p = new PubRadioPartenariat();
        p.setNomTable("pub_partenariat_liste");
        String listeCrt[] = {"id", "client", "observation", "reference", "responsable", "nomcampagne", "nature", "duree", "pubtype", "heure"};
        String listeInt[] = null;
        PageRecherche pr = new PageRecherche(p, request, listeCrt, listeInt, 3);
        pr.setUtilisateur((user.UserEJB) request.getSession().getAttribute("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setApres("pub/pubRadioPack-liste.jsp");

        String libEntete[] = {"id", "client", "observation", "reference", "datedebut", "datefin","responsable", "nomcampagne", "nature", "duree", "pubtype", "heure"};
        String[] colSomme = null;

        String awhere = "";
        if (request.getParameter("daty") != null) {
            String a = request.getParameter("daty");
            awhere = " and datedebut<='" + Utilitaire.convertDatyFormtoRealDatyFormat(a) + "' and datefin>='" + Utilitaire.convertDatyFormtoRealDatyFormat(a) + "'";
            pr.setAWhere(awhere);
        }

        pr.creerObjetPage(libEntete, colSomme);
%>
<h1>Liste publicité</h1>
<form action="<%=pr.getLien()%>?but=pub/pubRadioPack-liste.jsp" method="post" name="listeplagehoraire" id="listeplagehoraire">
    <%
        out.println(pr.getFormu().getHtmlEnsemble());%>
        <input type="date" name="daty" id="daty">
</form>
<%
    String lienTableau[] = {pr.getLien() + "?but=pub/pubRadioPack-fiche.jsp"};
    String colonneLien[] = {"id"};
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);
    out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
    out.println(pr.getTableau().getHtml());
    out.println(pr.getBasPage());
} catch (Exception e) {
    e.printStackTrace();
%>
<script language="JavaScript"> alert('<%=e.getMessage()%>');history.back();</script>
<%
        return;
    }
%>
