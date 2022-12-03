<%-- 
    Document   : saisiejournal
    Created on : Jan 16, 2018, 12:12:46 PM
    Author     : Tian
--%>

<%@page import="ventegazety.Journal"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="indicateur.*" %>
<% 
    Journal journal = new Journal();
    
PageInsert pi=new PageInsert(journal,request,(user.UserEJB)session.getValue("u"));
pi.setLien((String)session.getValue("lien"));


pi.getFormu().getChamp("val").setLibelle("Valeur");
pi.getFormu().getChamp("desce").setLibelle("Description");
pi.preparerDataFormu();
%>
<h1>Saisie Journal</h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="saisiejournal" id="saisiejournal">

<%
out.println(pi.getFormu().getHtmlInsert());
%>
<input type="submit" name="Submit2" value="valider" class="submit">
<input type="reset" name="Submit2" value="Annuler" class="submit">
 <input name="acte" type="hidden" id="nature" value="insert">
 <input name="bute" type="hidden" id="bute" value="ventegazety/saisiejournal.jsp">
 <input name="classe" type="hidden" id="classe" value="ventegazety.Journal">
</form>
