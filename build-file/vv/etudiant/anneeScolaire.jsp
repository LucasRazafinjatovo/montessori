<%--
    Document   : rubrique-prix-entite-saisie
    Created on : 22 mai 2018, 09:37:45
    Author     : pro
--%>

<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="etudiant.*" %>
<%
    
    AnneeScolaire anneeScolaire = new AnneeScolaire();
    PageInsert pi = new PageInsert(anneeScolaire, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));

    pi.getFormu().getChamp("nom").setLibelle("Anneescolaire");
    pi.preparerDataFormu();
%>

<h1>Saisie un nouveau ann&eacute;e scolaire</h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="POST" name="anneeScolaire" id="anneScolaire">
    <%
        pi.getFormu().makeHtmlInsertTabIndex();
        out.println(pi.getFormu().getHtmlInsert());
    %>
    <input name="acte" type="hidden" id="nature" value="insert">
    <input name="bute" type="hidden" id="bute" value="etudiant/listeAnneeScolaire.jsp">
    <input name="classe" type="hidden" id="classe" value="etudiant.AnneeScolaire">
</form>
