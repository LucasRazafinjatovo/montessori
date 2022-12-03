<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*"%>
<%@ page import="affichage.*"%>
<%@ page import="restriction.*"%>
<%
ListeTable rest=new ListeTable();

PageInsert pi=new PageInsert(rest,request,(user.UserEJB)session.getValue("u"));
pi.setLien((String)session.getValue("lien"));

pi.getFormu().getChamp("nom").setLibelle("Nom de table");
pi.preparerDataFormu();

%>

<h1>Saisie Table</h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="restriction" id="restriction">
<%
pi.getFormu().makeHtmlInsertTabIndex();
out.println(pi.getFormu().getHtmlInsert());
%>
 <input name="acte" type="hidden" id="nature" value="insert">
 <input name="bute" type="hidden" id="bute" value="utilisateur/formListeTable.jsp">
 <input name="classe" type="hidden" id="classe" value="restriction.ListeTable">
</form>
