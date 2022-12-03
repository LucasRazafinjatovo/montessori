<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="finance.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="affichage.*" %>
<%@ page import="ded.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%!
Rib p;
%>
<%
p = new Rib();
p.setNomTable("RIBNONRAPPROCHE_LIBELLE");
PageConsulte pc=new PageConsulte(p,request,(user.UserEJB)session.getValue("u"));
String id=request.getParameter("id");
String lien=(String)session.getValue("lien");
%>
<html>
<link href="../style/style.css" rel="stylesheet" type="text/css">
<h1>Visualisation RIB <%=request.getParameter("id")%></h1>
<%
out.println(pc.getHtml());
%>
<a href="<%=lien%>?but=finance/modifRib.jsp&id=<%=id%>"> Modifier</a>
</html>
