<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="activa.*" %>

<%
String idcmd=request.getParameter("idcmd");
String daty=request.getParameter("daty");
String datylivraison=request.getParameter("datylivraison");
LiaisonCommandeActiva m=new LiaisonCommandeActiva();
// preparation de l'affichage
PageInsert pi=new PageInsert(m,request,(user.UserEJB)session.getValue("u"));
pi.setLien((String)session.getValue("lien"));

pi.getFormu().getChamp("idcommande").setDefaut(idcmd);
pi.getFormu().getChamp("idcommande").setAutre("readonly='readonly'");
pi.getFormu().getChamp("reduction").setVisible(false);
pi.getFormu().getChamp("daty").setDefaut(Utilitaire.convertDatyFormtoRealDatyFormat(daty));
pi.getFormu().getChamp("daty").setAutre("readonly='readonly'");
pi.getFormu().getChamp("datyLivraison").setDefaut(Utilitaire.convertDatyFormtoRealDatyFormat(datylivraison));
pi.getFormu().getChamp("datyLivraison").setAutre("readonly='readonly'");
pi.getFormu().getChamp("noteExplicative").setLibelle("Note explicative");
pi.getFormu().getChamp("noteExplicative").setType("textarea");
pi.preparerDataFormu();
%>
<h1>Liaison Commande Activa </h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="article" id="article">
<%
pi.getFormu().makeHtmlInsertTabIndex();
out.println(pi.getFormu().getHtmlInsert());
%>
 <input name="acte" type="hidden" id="nature" value="insert"/>
 <input name="bute" type="hidden" id="bute" value="activa/fichecommande.jsp&idcmd=<%=idcmd%>"/>
 <input name="classe" type="hidden" id="classe" value="activa.LiaisonCommandeActiva"/>
</form>
