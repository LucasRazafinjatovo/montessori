<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="indicateur.*" %>
<%@ page import="affichage.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>

<%
TauxVentePrevision p;
p=new TauxVentePrevision();
p.setNomTable("TAUXVENTEPREVISION_LIBELLE");
PageConsulte pc=new PageConsulte(p,request,(user.UserEJB)session.getValue("u"));

%>
<html>
<h1>Consultation Taux de vente pr&eacute;visionnel</h1>
<%
out.println(pc.getHtml());
%>
<a href="<%=(String)session.getValue("lien")+"?but=pub/apresTarif.jsp&id="+request.getParameter("id")%>&acte=delete&bute=indicateur/tauxventeprevision-liste.jsp&classe=indicateur.TauxVentePrevision">Supprimer</a>
<a href="<%=(String)session.getValue("lien")+"?but=indicateur/tauxventeprevision-modif.jsp&id="+request.getParameter("id")%>">Modifier</a>
</html>