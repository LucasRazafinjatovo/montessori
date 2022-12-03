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
    
    Niveau niveau = new Niveau();
    PageInsert pi = new PageInsert(niveau, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));

    pi.getFormu().getChamp("nom").setLibelle("Nom");
    pi.preparerDataFormu();
%>

<h1>Saisir une nouvelle niveau</h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="POST" name="niveau" id="niveau">
    <%
        pi.getFormu().makeHtmlInsertTabIndex();
        out.println(pi.getFormu().getHtmlInsert());
    %>
    <input name="acte" type="hidden" id="nature" value="insert">
    <input name="bute" type="hidden" id="bute" value="etudiant/liste-niveau.jsp">
    <input name="classe" type="hidden" id="classe" value="etudiant.Niveau">
</form>
