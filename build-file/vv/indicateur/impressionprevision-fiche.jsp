<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="indicateur.*" %>
<%@ page import="affichage.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>

<%
ImpressionPrevision p;
p=new ImpressionPrevision();
p.setNomTable("IMPRESSIONPREVISION_LIBELLE");
PageConsulte pc=new PageConsulte(p,request,(user.UserEJB)session.getValue("u"));

%>
<html>
<h1>Consultation Impression pr&eacute;visionnelle</h1>
<%
out.println(pc.getHtml());
%>
<a href="<%=(String)session.getValue("lien")+"?but=pub/apresTarif.jsp&id="+request.getParameter("id")%>&acte=delete&bute=indicateur/impressionprevision-liste.jsp&classe=indicateur.ImpressionPrevision">Supprimer</a>
<a href="<%=(String)session.getValue("lien")+"?but=indicateur/impressionprevision-modif.jsp&id="+request.getParameter("id")%>">Modifier</a>
</html>