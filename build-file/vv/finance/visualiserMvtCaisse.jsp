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
p.setNomTable("MvtCaisseTous");
PageConsulte pc=new PageConsulte(p,request,(user.UserEJB)session.getValue("u"));//ou avec argument liste Libelle si besoin
String lien=(String)session.getValue("lien");
String apres="";
%>
<html>
<link href="../style/style.css" rel="stylesheet" type="text/css">
<h1>Visualisation mouvement de caisse <%=request.getParameter("id")%></h1>
<form action="<%=lien%>?but=<%=apres%>" method="post" name="recette" id="recette">
<%
out.println(pc.getHtml());
%>
<input type ="hidden" name="acte" value="update"/>
<a href="<%=lien%>?but=finance/updateMvtCaisse.jsp&id=<%=request.getParameter("id")%>">modifier</a>
</form>
</html>
s