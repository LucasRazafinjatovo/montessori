<%@ page import="affichage.*" %>
<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="finance.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="ded.OpLcComplet" %>
<%@ page import="lc.Direction" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%!
String apres="ded/apresOrdonnerRecette.jsp";
String lien= null;
UserEJB u = null;
%>
<%
try{
	u = (user.UserEJB)session.getValue("u");
	lien=(String)session.getValue("lien");

	String idOr = request.getParameter("radio");
	String listepub = (String)session.getAttribute("listepub");
	session.removeAttribute("listepub");
	String montant = u.getSommeMontant(listepub);
%>
<SCRIPT language="JavaScript" src="script.js"></script>
<link href="style.css" rel="stylesheet" type="text/css">


<h1>Liaison OR recette </h1>

<br>
<form action="modeleAdmin.jsp?but=ded/apresOrdonnerRecette.jsp" method="post">
	<table  border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
	<tbody>
		<tr>
			<td align="left" class="left">Date</td>
			<td align="center" class="champ"><%=Utilitaire.dateDuJour()%></td>
		</tr>
		<tr>
			<td align="left" class="left">Monatant</td>
			<td align="center" class="champ"><%=montant%></td>
		</tr>
		<tr>
			<td align="left" class="left">ID Ordre recette</td>
			<td align="center" class="champ"><%=idOr%></td>
		</tr>
	</tbody>
</table>
	<input type="hidden" name="montant" value="<%=montant%>" class="submit">
	<input type="hidden" name="idor" value="<%=idOr%>" class="submit">
	<input type="hidden" name="listepub" value="<%=listepub%>" class="submit">
	<input type="hidden" name="acte" value="rcpub" class="submit">
	<input type="hidden" name="typeOr" value="<%=Constante.typeOpNormale%>" class="submit">
	<input type="submit"  value="Valider" class="submit">
</form>
<%
}catch(Exception e){%>
	<script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%}%>