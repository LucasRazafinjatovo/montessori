<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="ded.*" %>

<%
String lien=(String)session.getValue("lien");
UserEJB  u=(UserEJB)session.getAttribute("u");
BenefPiece pj=new BenefPiece();
PageInsert pi=new PageInsert(pj,request,(user.UserEJB)session.getValue("u"));
pi.setLien((String)session.getValue("lien"));
pi.getFormu().getChamp("nom").setType("texte");
pi.getFormu().getChamp("tel").setLibelle("telephone");
pi.preparerDataFormu();
%>

<h1>Saisir coursier</h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="benefpiece" id="benefpiece">

<%
pi.getFormu().makeHtmlInsertTabIndex();
out.println(pi.getFormu().getHtmlInsert());
%>
 <input name="acte" type="hidden" id="nature" value="insert">
 <input name="bute" type="hidden" id="bute" value="ded/entreeBenefPiece.jsp">
 <input name="classe" type="hidden" id="classe" value="ded.BenefPiece">
</form>
