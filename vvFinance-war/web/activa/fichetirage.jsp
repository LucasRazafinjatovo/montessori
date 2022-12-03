<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="activa.*" %>

<%!
Tirage a;
%>
<%
a=new Tirage();
a.setNomTable("tirage");
PageConsulte pc=new PageConsulte(a,request,(user.UserEJB)session.getValue("u"));
Tirage e=(Tirage)pc.getBase();
%>
<html>
<h1>Consultation d'une fiche Tirage</h1>
<%
out.println(pc.getHtml());
%>
<a href="<%=(String)session.getValue("lien")+"?but=activa/modiftirage.jsp&id="+request.getParameter("idTirage")%>">Modifier</a>
<br/>
</html>