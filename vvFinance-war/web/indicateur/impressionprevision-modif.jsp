<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="indicateur.*" %>

<%
ImpressionPrevision atcl=new ImpressionPrevision();
PageUpdate pi=new PageUpdate(atcl,request,(user.UserEJB)session.getValue("u"));
pi.setLien((String)session.getValue("lien"));

pi.getFormu().getChamp("moisprod").setPageAppel("indicateur/choixMoisproduction.jsp");

pi.getFormu().getChamp("id").setAutre("readonly='readonly'");
pi.getFormu().getChamp("moisprod").setLibelle("Mois de production");
pi.getFormu().getChamp("nbimpression").setLibelle("Nombre d'impressions");

pi.preparerDataFormu();
%>

<h1>Modification impression prevision</h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="article" id="article">
<%
pi.getFormu().makeHtmlInsertTabIndex();
out.println(pi.getFormu().getHtmlInsert());
%>
 <input name="acte" type="hidden" id="nature" value="update">
 <input name="bute" type="hidden" id="bute" value="indicateur/impressionprevision-liste.jsp">
 <input name="classe" type="hidden" id="classe" value="indicateur.ImpressionPrevision">
</form>
