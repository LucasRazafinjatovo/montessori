<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="affichage.*" %>
<%@ page import="activa.*" %>

<%
Marge m=new Marge();
// preparation de l'affichage
PageInsert pi=new PageInsert(m,request,(user.UserEJB)session.getValue("u"));
pi.setLien((String)session.getValue("lien"));
out.print(pi.getLien());
//pi.getFormu().getChamp("valeur").setLibelle("valeur du marge");
pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());
%>

<h1>Saisir Marge </h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="marge" id="marge">
<%
pi.getFormu().makeHtmlInsertTabIndex();
out.println(pi.getFormu().getHtmlInsert());
%>
 <input name="acte" type="hidden" id="nature" value="insert">
 <input name="bute" type="hidden" id="bute" value="activa/saisimarge.jsp">
 <input name="classe" type="hidden" id="classe" value="activa.Marge">
 <input name="rajoutLien" type="hidden" id="classe" value="valeur-daty">
</form>
