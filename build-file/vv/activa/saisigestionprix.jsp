<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="activa.*" %>

<%
//System.out.println(max);
GestionPrix m=new GestionPrix();
m.setNomTable("gestionprix");
// preparation de l'affichage
PageInsert pi=new PageInsert(m,request,(user.UserEJB)session.getValue("u"));
pi.setLien((String)session.getValue("lien"));
pi.getFormu().getChamp("idArticle").setPageAppel("listeArticleGestionPrixChoix.jsp");
pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());

//pi.preparerDataFormu();
%>
<h1>Saisir Prix Papier </h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="gestionprix" id="gestionprix">
<%
pi.getFormu().makeHtmlInsertTabIndex();
out.println(pi.getFormu().getHtmlInsert());
%>
 <input name="acte" type="hidden" id="nature" value="insert">
 <input name="bute" type="hidden" id="bute" value="activa/saisigestionprix.jsp">
 <input name="classe" type="hidden" id="classe" value="activa.GestionPrix">
<!-- <input name="rajoutLien" type="hidden" id="classe" value="iddev-rmq"> -->
</form>
