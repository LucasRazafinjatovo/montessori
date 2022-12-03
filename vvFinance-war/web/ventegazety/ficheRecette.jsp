<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="ventegazety.*" %>
<%!
RecetteLibelle p;
%>
<%
p=new RecetteLibelle();
PageConsulte pc=new PageConsulte(p,request,(user.UserEJB)session.getValue("u"));//ou avec argument liste Libelle si besoin
%>
<html>
<h1>Consultation recette</h1>
<%
out.println(pc.getHtml());
%>
<!--<a href="<%=(String)session.getValue("lien")+"?but=pub/apresTarif.jsp&id="+request.getParameter("id")%>&acte=delete&bute=ventegazety/listeRecette.jsp&classe=ventegazety.Recette">suprimmer</a>-->
</html>
