<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="utilitaire.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
	String apres="facture/apresInit.jsp";
	String lien= null;
        penalite.Accident penAcc = null;
        String id = null;
        UserEJB u = null;

%>
<%
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
penAcc = u.findAccident(request.getParameter("id"),"","","%","%")[0];
%>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>D&eacute;tails accident</h1>
<table cellpadding="0" cellspacing="0" border="0" align="center" width="450">
<tr><td><table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
<tr><td class="left">N° Accident :</td><td><%=penAcc.getIdAccident()%></td></tr>
        <tr>

    <td width="47%" class="left">Date :</td>
    <td width="53%"><%=Utilitaire.formatterDaty(penAcc.getDatySaisie())%></td>
	</tr>
	<tr>

    <td class="left">Nom de l'employ&eacute; accident&eacute; : </td>
    <td><%=penAcc.getNomEmploye()%></td>
	</tr>
	<tr>

    <td class="left">Date de l'accident : </td>
    <td><%=Utilitaire.formatterDaty(penAcc.getDatyAccident())%></td>
	</tr>
	<tr>

    <td class="left">Description :</td>
	      <td><%=penAcc.getDescription()%></td>

	</tr>
	</table></td>
</table>
