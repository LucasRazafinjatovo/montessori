<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="compte.*" %>

<%
CompteG konty=new CompteG();
PageUpdate pi=new PageUpdate(konty,request,(user.UserEJB)session.getValue("u"));
pi.setLien((String)session.getValue("lien"));
pi.preparerDataFormu();
%>

<h1>Modification de compte general</h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="compteg" id="compteg">
<%
pi.getFormu().makeHtmlInsertTabIndex();
out.println(pi.getFormu().getHtmlInsert());
%>
 <input name="acte" type="hidden" id="nature" value="update">
 <input name="bute" type="hidden" id="bute" value="compte/listeCompteG.jsp">
 <input name="classe" type="hidden" id="classe" value="compte.CompteG">
<!--<input name="rajoutLien" type="hidden" id="classe" value="publicat-daty">-->
</form>
