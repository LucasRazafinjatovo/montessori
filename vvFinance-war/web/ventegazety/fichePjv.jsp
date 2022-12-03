<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="ventegazety.*" %>
<%!
Prixjournalvendeur p;
%>
<%
p=new Prixjournalvendeur();
PageConsulte pc=new PageConsulte(p,request,(user.UserEJB)session.getValue("u"));//ou avec argument liste Libelle si besoin
%>
<html>
<h1>Consultation d'un prix individuel</h1>
<%
out.println(pc.getHtml());
%>

<!--<a href="<%=(String)session.getValue("lien")+"?but=pub/apresTarif.jsp&id="+request.getParameter("id")%>&acte=delete&bute=ventegazety/listePrixJournalV.jsp&classe=ventegazety.Prixjournalvendeur">suprimmer</a>-->

</html>
