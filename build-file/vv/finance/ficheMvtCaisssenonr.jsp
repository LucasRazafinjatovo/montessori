<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="finance.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="affichage.*" %>
<%@ page import="ded.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%!
MvtCaisseTous p;
%>
<%
p=new MvtCaisseTous();
p.setNomTable("MVTNONRAPPRO");
PageConsulte pc=new PageConsulte(p,request,(user.UserEJB)session.getValue("u"));
%>
<html>
<link href="../style/style.css" rel="stylesheet" type="text/css">
<h1>Visualisation mouvement de caisse <%=request.getParameter("id")%></h1>
<%
out.println(pc.getHtml());
%>
<a href="<%=(String)session.getValue("lien")+"?but=finance/rapprocherMVTcaisse.jsp&id="+request.getParameter("id")%>">Rapprocher</a>
</html>
