<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="activa.*" %>

<%
Livraison atcl=new Livraison();
PageUpdate pi=new PageUpdate(atcl,request,(user.UserEJB)session.getValue("u"));
pi.setLien((String)session.getValue("lien"));

pi.getFormu().getChamp("idproduction").setAutre("readonly='readonly'");
pi.getFormu().getChamp("idlivraison").setAutre("readonly='readonly'");
//pi.preparerDataFormu();
%>

<h1>Modification Commande</h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="livraison" id="livraison">
<%
pi.getFormu().makeHtmlInsertTabIndex();
out.println(pi.getFormu().getHtmlInsert());
%>
 <input name="acte" type="hidden" id="nature" value="update">
 <input name="bute" type="hidden" id="bute" value="activa/listelivraison.jsp">
 <input name="classe" type="hidden" id="classe" value="activa.Livraison">
</form>
