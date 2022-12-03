<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="activa.*" %>

<%
Livraison m=new Livraison();
m.setNomTable("livraison");
// preparation de l'affichage
PageInsert pi=new PageInsert(m,request,(user.UserEJB)session.getValue("u"));
pi.setLien((String)session.getValue("lien"));
// mettre un calendrier
pi.getFormu().getChamp("idproduction").setPageAppel("listeProductionChoix.jsp");
pi.getFormu().getChamp("datelivraison").setDefaut(Utilitaire.dateDuJour());
pi.getFormu().getChamp("heurelivraison").setDefaut(Utilitaire.heureCouranteHMS());
%>
<h1>Saisir livraison </h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="livraison" id="livraison">
<%
pi.getFormu().makeHtmlInsertTabIndex();
out.println(pi.getFormu().getHtmlInsert());
%>
 <input name="acte" type="hidden" id="nature" value="insert">
 <input name="bute" type="hidden" id="bute" value="activa/listelivraison.jsp">
 <input name="classe" type="hidden" id="classe" value="activa.Livraison">
<!-- <input name="rajoutLien" type="hidden" id="classe" value="idliv"> -->
</form>
