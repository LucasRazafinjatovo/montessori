<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="ventegazety.*" %>

<%
Prixjournalvendeur bc=new Prixjournalvendeur();
PageUpdate pi=new PageUpdate(bc,request,(user.UserEJB)session.getValue("u"));
pi.setLien((String)session.getValue("lien"));
pi.getFormu().getChamp("id").setAutre("readonly=true");
pi.getFormu().getChamp("vendeur").setAutre("readonly=true");
pi.getFormu().getChamp("journal").setAutre("readonly=true");


%>

<h1>Modification prix journal</h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="article" id="article">
<%
pi.getFormu().makeHtmlInsertTabIndex();
out.println(pi.getFormu().getHtmlInsert());
%>
 <input name="acte" type="hidden" id="nature" value="update">
 <input name="bute" type="hidden" id="bute" value="ventegazety/listePrixJournalV.jsp">
 <input name="classe" type="hidden" id="classe" value="ventegazety.Prixjournalvendeur">
</form>


