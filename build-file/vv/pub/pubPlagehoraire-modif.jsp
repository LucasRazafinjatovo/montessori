<%@page import="pub.PubPlageHoraire"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="compte.*" %>

<%
PubPlageHoraire konty=new PubPlageHoraire();
PageUpdate pi=new PageUpdate(konty,request,(user.UserEJB)session.getValue("u"));
pi.setLien((String)session.getValue("lien"));
pi.getFormu().getChamp("heure_debut").setLibelle("Heure debut");
pi.getFormu().getChamp("heure_fin").setLibelle("Heure fin");
pi.getFormu().getChamp("heure_debut").setAutre("placeholder='HH:MM:SS'");
pi.getFormu().getChamp("heure_fin").setAutre("placeholder='HH:MM:SS'");
pi.preparerDataFormu();
%>

<h1>Modification de compte general</h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="compteg" id="compteg">
<%
pi.getFormu().makeHtmlInsertTabIndex();
out.println(pi.getFormu().getHtmlInsert());
%>
 <input name="acte" type="hidden" id="nature" value="update">
 <input name="bute" type="hidden" id="bute" value="pub/pubPlagehoraire-fiche.jsp&id=<%=request.getParameter("id")%>">
 <input name="classe" type="hidden" id="classe" value="pub.PubPlageHoraire">
</form>
