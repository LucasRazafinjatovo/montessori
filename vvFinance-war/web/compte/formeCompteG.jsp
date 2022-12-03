<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="compte.*" %>

<%
  CompteG cog=new CompteG();
  cog.setNomTable("compteG");
  PageInsert pi=new PageInsert(cog,request,(user.UserEJB)session.getValue("u"));
  pi.setLien((String)session.getValue("lien"));
  pi.preparerDataFormu();
%>

<h1>Saisir CompteG</h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="compteG" id="compteG">
<%
pi.getFormu().makeHtmlInsertTabIndex();
out.println(pi.getFormu().getHtmlInsert());
%>
 <input name="acte" type="hidden" id="nature" value="insert">
 <input name="bute" type="hidden" id="bute" value="compte/formeCompteG.jsp">
 <input name="classe" type="hidden" id="classe" value="compte.CompteG">
</form>
