<%-- 
    Document   : Generer-edition.jsp
    Created on : 8 janv. 2019, 08:37:24
    Author     : pro
--%>

<%@page import="etudiant.Edition"%>
<%@page import="etudiant.EntiteBeneficiaire"%>
<%@page import="recette.RubriquePrixEntite"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="lc.Direction" %>
<%@ page import="affichage.*" %>
<%@ page import="actualite.*" %>
<%
    Edition edition = new Edition();
    PageInsert pi = new PageInsert(edition, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));

    pi.getFormu().getChamp("mois").setVisible(false);
    pi.getFormu().getChamp("mois").setDefaut(""+Utilitaire.getAneeEnCours());
    pi.getFormu().getChamp("ecolagepaye").setVisible(false);
    pi.getFormu().getChamp("ecolagedu").setVisible(false);
    pi.getFormu().getChamp("fooddu").setVisible(false);
    pi.getFormu().getChamp("foodpaye").setVisible(false);
    pi.getFormu().getChamp("transportdu").setVisible(false);
    pi.getFormu().getChamp("transportpaye").setVisible(false);
    pi.getFormu().getChamp("inscriptiondu").setVisible(false);
    pi.getFormu().getChamp("autredu").setVisible(false);
    pi.getFormu().getChamp("inscriptionpaye").setVisible(false);
    pi.getFormu().getChamp("autrepaye").setVisible(false);
    pi.getFormu().getChamp("remarque").setVisible(false);

    //pi.getFormu().getChamp("idetudiant").setPageAppel("etudiant/listeEtudiantChoix.jsp");
    pi.getFormu().getChamp("idetudiant").setVisible(false);

    pi.preparerDataFormu();
%>

<h1>Generer edition</h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="rubriqueprix" id="rubriqueprix">
    <%
        pi.getFormu().makeHtmlInsertTabIndex();
        out.println(pi.getFormu().getHtmlInsert());
    %>
    <input name="acte" type="hidden" id="nature" value="insert">
    <input name="bute" type="hidden" id="bute" value="etudiant/listeEtudiant.jsp">
    <input name="classe" type="hidden" id="classe" value="etudiant.Edition">
</form>
