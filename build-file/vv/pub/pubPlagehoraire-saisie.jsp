<%@page import="pub.PubPlageHoraire"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="lc.Direction" %>
<%@ page import="affichage.*" %>
<%@ page import="actualite.*" %>
<%
PubPlageHoraire pj=new PubPlageHoraire();
PageInsert pi=new PageInsert(pj,request,(user.UserEJB)session.getValue("u"));
pi.setLien((String)session.getValue("lien"));
pi.getFormu().getChamp("heure_debut").setLibelle("Heure debut");
pi.getFormu().getChamp("heure_fin").setLibelle("Heure fin");
pi.getFormu().getChamp("heure_debut").setAutre("placeholder='HH:MM:SS'");
pi.getFormu().getChamp("heure_fin").setAutre("placeholder='HH:MM:SS'");
pi.preparerDataFormu();
%>

<h1>Saisir Plage horaire</h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="plagehoraire" id="plagehoraire">
<%
pi.getFormu().makeHtmlInsertTabIndex();
out.println(pi.getFormu().getHtmlInsert());
%>
 <input name="acte" type="hidden" id="nature" value="insert">
 <input name="bute" type="hidden" id="bute" value="pub/pubPlagehoraire-saisie.jsp">
 <input name="classe" type="hidden" id="classe" value="pub.PubPlageHoraire">
<input name="rajoutLien" type="hidden" id="classe" value="publicat-daty">
</form>
