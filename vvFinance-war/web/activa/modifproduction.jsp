<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="activa.*" %>

<%
Production atcl=new Production();
//atcl.setIdProduction(request.getParameter("id"));
PageUpdate pi=new PageUpdate(atcl,request,(user.UserEJB)session.getValue("u"));
pi.setLien((String)session.getValue("lien"));

affichage.Champ[] liste=new affichage.Champ[1];
Commande d=new Commande();
d.setNomTable("commande");
liste[0]=new Liste("idcmd",d,"idcmd","idcmd");
pi.getFormu().changerEnChamp(liste);
pi.getFormu().getChamp("idProduction").setAutre("readonly='readonly'");
pi.preparerDataFormu();
%>

<h1>Modification Production</h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="production" id="production">
<%
pi.getFormu().makeHtmlInsertTabIndex();
out.println(pi.getFormu().getHtmlInsert());
%>
 <input name="acte" type="hidden" id="nature" value="update">
 <input name="bute" type="hidden" id="bute" value="activa/listeproduction.jsp">
 <input name="classe" type="hidden" id="classe" value="activa.Production">
</form>
