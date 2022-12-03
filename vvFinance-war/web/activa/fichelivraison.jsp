<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="activa.*" %>

<%!
Livraison a;
%>
<%
a=new Livraison();
a.setNomTable("livraison");
PageConsulte pc=new PageConsulte(a,request,(user.UserEJB)session.getValue("u"));
Livraison e=(Livraison)pc.getBase();
%>
<html>
<h1>Consultation d'une fiche Livraison</h1>
<%
out.println(pc.getHtml());
%>
<a href="<%=(String)session.getValue("lien")+"?but=activa/modiflivraison.jsp&id="+request.getParameter("idLivraison")%>">Modifier</a>
</html>