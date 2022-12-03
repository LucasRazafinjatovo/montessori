<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="activa.*" %>

<%
NombreRame m=new NombreRame();
// preparation de l'affichage
PageInsert pi=new PageInsert(m,request,(user.UserEJB)session.getValue("u"));
pi.setLien((String)session.getValue("lien"));

pi.getFormu().getChamp("valeur").setLibelle("nombre");
pi.preparerDataFormu();

%>

<h1>Saisir Nombre Rame </h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="nombrerame" id="nombrerame">
<%
pi.getFormu().makeHtmlInsertTabIndex();
out.println(pi.getFormu().getHtmlInsert());
%>
 <input name="acte" type="hidden" id="nature" value="insert">
 <input name="bute" type="hidden" id="bute" value="activa/saisinombrerame.jsp">
 <input name="classe" type="hidden" id="classe" value="activa.NombreRame">
 <input name="rajoutLien" type="hidden" id="classe" value="valeur">
</form>
