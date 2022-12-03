<%-- 
    Document   : rubrique-prix-entite-modif
    Created on : 22 mai 2018, 12:18:44
    Author     : pro
--%>

<%@page import="etudiant.*"%>
<%@page import="recette.RubriquePrixEntite"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="activa.*" %>

<%
AnneeScolaire anneeScolaire=new AnneeScolaire();
PageUpdate pi=new PageUpdate(anneeScolaire,request,(user.UserEJB)session.getValue("u"));
pi.setLien((String)session.getValue("lien"));


pi.getFormu().getChamp("id").setAutre("readonly='readonly'");
pi.preparerDataFormu();
%>

<h1>Modification ann&eacute;e scolaire</h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="article" id="article">
<%
pi.getFormu().makeHtmlInsertTabIndex();
out.println(pi.getFormu().getHtmlInsert());
%>
 <input name="acte" type="hidden" id="nature" value="update">
 <input name="bute" type="hidden" id="bute" value="etudiant/listeAnneeScolaire.jsp">
 <input name="classe" type="hidden" id="classe" value="etudiant.AnneeScolaire">
</form>
