<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="indicateur.*" %>

<%
ImpressionPrevision pj=new ImpressionPrevision();
PageInsert pi=new PageInsert(pj,request,(user.UserEJB)session.getValue("u"));
pi.setLien((String)session.getValue("lien"));

pi.getFormu().getChamp("moisprod").setPageAppel("indicateur/choixMoisproduction.jsp");

pi.getFormu().getChamp("moisprod").setLibelle("Mois de production");

pi.getFormu().getChamp("nbimpression").setDefaut("0");
pi.getFormu().getChamp("nbimpression").setLibelle("Nombre d'impressions");

pi.preparerDataFormu();
%>

<h1>Saisie Impression pr&eacute;visionnelle</h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="saisipj" id="saisipj">

<%
out.println(pi.getFormu().getHtmlInsert());
%>
<input type="submit" name="Submit2" value="valider" class="submit">
<input type="reset" name="Submit2" value="Annuler" class="submit">
 <input name="acte" type="hidden" id="nature" value="insert">
 <input name="bute" type="hidden" id="bute" value="indicateur/impressionprevision-saisie.jsp">
 <input name="classe" type="hidden" id="classe" value="indicateur.ImpressionPrevision">
</form>
