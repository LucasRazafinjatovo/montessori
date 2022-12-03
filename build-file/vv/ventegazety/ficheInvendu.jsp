<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="ventegazety.*" %>
<%!
InvenduLibelle p;
%>
<%
p=new InvenduLibelle();
PageConsulte pc=new PageConsulte(p,request,(user.UserEJB)session.getValue("u"));//ou avec argument liste Libelle si besoin
%>
<html>
<h1>Consultation invendu</h1>
<%
out.println(pc.getHtml());
%>
<!--<a href="<%=(String)session.getValue("lien")+"?but=pub/apresTarif.jsp&id="+request.getParameter("id")%>&acte=delete&bute=ventegazety/listeInvendu.jsp&classe=ventegazety.Invendu">suprimmer</a>-->
</html>
