<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="finance.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="ventegazety.*" %>
<%@ page import="lc.Direction" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%!
        String apres="ded/apresOrdonnerPayement.jsp";
        String lien= null;
        UserEJB u = null;
        String id = null;
        double montant=0;
     %>
<%
try{
	u = (user.UserEJB)session.getValue("u");
	lien = (String)session.getValue("lien");
	id = (String)session.getAttribute("id");
	Vendeur v = Vendeur.getDetailVendeur((String)session.getAttribute("matricule"));
	montant = u.getMontantRecette(id);

%>
<SCRIPT language="JavaScript" src="script.js"></script>
<link href="style.css" rel="stylesheet" type="text/css">


<h1>Payement Commission vendeur </h1>
<h2>&nbsp;</h2>

<h2>&nbsp;</h2>

<form action="<%=lien%>?but=<%=apres%>" method="post" name="recette" id="recette" target="_parent" onsubmit="return (verifie(daty.value)&&verifie(designation.value)&&verifie(montant.value))">

<table width="450" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
		<td> <table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
			<tr>
				<td class="left">Date : </td>
				<td align="center"><%=Utilitaire.dateDuJour() %></td>
			</tr>
			<tr>
				<td class="left">Vendeur : </td>
				<td align="center"><%=v.getNom()+": "+v.getType()%></td>
			</tr>
			<tr>
				<td class="left">Matricule : </td>
				<td align="center"><%=(String)session.getAttribute("matricule") %></td>
			</tr>
			<tr>
				<td class="left">Mois : </td>
				<td align="center"><input type="text" id="class" name="mois" value="<%=Utilitaire.getMoisEnCours() %>"></td>
			</tr>
			<tr>
				<td class="left">Annee : </td>
				<td align="center"><input type="text" id="class" name="annee" value="<%=Utilitaire.getAneeEnCours() %>"></td>
			</tr>
			<tr>
				<td class="left">Total commission : </td>
				<td align="center"><%=(String)session.getAttribute("sommeCommission")%></td>
				<td align="center">&nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">            </td>
			</tr>
			<tr>
				<td class="left">Remarque : </td>
				<td align="center"><textarea id="class" name="remarque"></textarea></td>
				<td align="center">&nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">            </td>
			</tr>
		</table></td>
    </tr>
	<tr>
		<td height="30" align="center"><table width="75%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td align="center">
					<input name="acte" type="hidden" id="acte" value="commissionGroupe">
					<input type="submit" name="Submit" value="Enregistrer" class="submit">
				</td>
			</tr>
		</table></td>
    </tr>
</table>
</form>
<%
}catch(Exception e){
  e.printStackTrace();
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
%>
<div align="center">

	<span class="remarque">(*) Champs obligatoires</span>
</div>