<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="activa.*" %>

<%
CodeRV m=new CodeRV();
// preparation de l'affichage
PageInsert pi=new PageInsert(m,request,(user.UserEJB)session.getValue("u"));
pi.setLien((String)session.getValue("lien"));

pi.getFormu().getChamp("val").setLibelle("valeur");
pi.getFormu().getChamp("desce").setLibelle("description");
pi.preparerDataFormu();

%>
<h1>Saisir Code RV </h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="coderv" id="coderv">
<%
pi.getFormu().makeHtmlInsertTabIndex();
out.println(pi.getFormu().getHtmlInsert());
%>
 <input name="acte" type="hidden" id="nature" value="insert">
 <input name="bute" type="hidden" id="bute" value="activa/saisicoderv.jsp">
 <input name="classe" type="hidden" id="classe" value="activa.CodeRV">
 <input name="rajoutLien" type="hidden" id="classe" value="val-desc">
</form>
