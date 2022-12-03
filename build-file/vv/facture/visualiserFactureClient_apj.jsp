<%@ page import="user.*" %>
<%@ page import="finance.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="facturefournisseur.FactureFournisseur" %>
<%@ page import="facturefournisseur.Detail" %>
<%@ page import="affichage.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>

<%!
FactureFournisseur p;
%>
<%
p=new FactureFournisseur();
//p.setNomTable(request.getParameter("etat"));
PageConsulte pc=new PageConsulte(p,request,(user.UserEJB)session.getValue("u"));

%>
<html>
<h1>Consultation Facture</h1>
<%
out.println(pc.getHtml());
%>
</html>