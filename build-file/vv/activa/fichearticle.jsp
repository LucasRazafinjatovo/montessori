<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="activa.*" %>

<%!
Article a;
%>
<%
a=new Article();
a.setNomTable("article");
PageConsulte pc=new PageConsulte(a,request,(user.UserEJB)session.getValue("u"));
Article e=(Article)pc.getBase();
%>
<html>
<h1>Consultation d'une fiche Article</h1>
<%
out.println(pc.getHtml());
%>
<a href="<%=(String)session.getValue("lien")+"?but=activa/modifarticle.jsp&id="+request.getParameter("idArticle")%>">Modifier</a>
</html>