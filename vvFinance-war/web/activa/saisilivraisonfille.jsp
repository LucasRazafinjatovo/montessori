<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="activa.*" %>

<%
//String max=UserEJBBean.getMaxIdMaintenance();
String max="test";
String test=request.getParameter("id");
Livraison m=new Livraison();
m.setNomTable("livraison");
// preparation de l'affichage
PageInsert pi=new PageInsert(m,request,(user.UserEJB)session.getValue("u"));
pi.setLien((String)session.getValue("lien"));
// mettre un calendrier
pi.getFormu().getChamp("idProduction").setDefaut(test);
pi.getFormu().getChamp("dateLivraison").setDefaut(Utilitaire.dateDuJour());
pi.getFormu().getChamp("heureLivraison").setDefaut(Utilitaire.heureCouranteHMS());
//pi.getFormu().getChamp("idMaintenance").setDefaut(max);
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
