<%@ page import="affichage.*" %>
<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="ded.OrdonnerPayement" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%!
String apres="prevision/apresOpPrev.jsp";
String lien= null;
UserEJB u = null;
%>
<%
try{
	u = (user.UserEJB)session.getValue("u");
	lien=(String)session.getValue("lien");

	String[] idOr = request.getParameterValues("id");
	String listeOr = Utilitaire.stringToTab(idOr,"",",");
	String idprev = (String)session.getValue("idprevision");
	session.removeAttribute("idprevision");
	OrdonnerPayement[] listeOrdre = u.getListeOrdre("OrdonnerPayement", idOr);
	String[] montant = u.getSommeMontant(listeOrdre,"opvita",idprev);
%>
<SCRIPT language="JavaScript" src="script.js"></script>
<link href="style.css" rel="stylesheet" type="text/css">


<h1>Liaison Prevision OP </h1>

<br>
<form action="modeleAdmin.jsp?but=prevision/apresOpPrev.jsp" method="post">
	<table  border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
		<tbody>
			<tr>
				<td align="left" class="left">Date</td>
				<td align="center" class="champ"><%=Utilitaire.dateDuJour()%></td>
			</tr>
			<tr>
				<td align="left" class="left">Monatant prevision</td>
				<td align="center" class="champ"><%=montant[1]%></td>
			</tr>
			<tr>
				<td align="left" class="left">Monatant OP</td>
				<td align="center" class="champ"><%=montant[0]%></td>
			</tr>
		</tbody>
	</table>
	<input type="hidden" name="montantPrev" value="<%=montant[1]%>" class="submit">
	<input type="hidden" name="montantRec" value="<%=montant[0]%>" class="submit">
	<input type="hidden" name="idop" value="<%=listeOr%>" class="submit">
	<input type="hidden" name="idprev" value="<%=idprev%>" class="submit">
	<input type="hidden" name="acte" value="attacheropprev" class="submit">
	<input type="submit"  value="Valider" class="submit">
</form>

<h1>Liste Ordre payement</h1>
<table  border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
	<tbody>
		<tr>
			<td align="left" class="left">ID</td>
			<td align="center" class="left">Date</td>
			<td align="center" class="left">Description</td>
			<td align="center" class="left">Montant</td>
		</tr>
		<% for(int i = 0; i < listeOrdre.length; i++){%>
		<tr>
			<td align="center" class="champ"><%=listeOrdre[i].getId()%></td>
			<td align="center" class="champ"><%=listeOrdre[i].getDaty()%></td>
			<td align="center" class="champ"><%=listeOrdre[i].getRemarque()%></td>
			<td align="center" class="champ"><%=listeOrdre[i].getMontant()%></td>
		</tr>
		<%}%>
	</tbody>
</table>
<%
}catch(Exception e){%>
	<script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%}%>