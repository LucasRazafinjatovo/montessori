<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="activa.*" %>

<%
TypeArticle t=new TypeArticle();
t.setNomTable("typearticle");
// preparation de l'affichage
PageInsert pi=new PageInsert(t,request,(user.UserEJB)session.getValue("u"));
pi.setLien((String)session.getValue("lien"));
pi.getFormu().getChamp("val").setLibelle("valeur");
pi.getFormu().getChamp("desce").setLibelle("description");
pi.preparerDataFormu();
%>
<h1>Saisir Type Article </h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="typearticle" id="typearticle">
<%
pi.getFormu().makeHtmlInsertTabIndex();
out.println(pi.getFormu().getHtmlInsert());
%>
 <input name="acte" type="hidden" id="nature" value="insert">
 <input name="bute" type="hidden" id="bute" value="activa/saisitypearticle.jsp">
 <input name="classe" type="hidden" id="classe" value="activa.TypeArticle">
 <!--<input name="rajoutLien" type="hidden" id="classe" value="val-desc"> -->
</form>
