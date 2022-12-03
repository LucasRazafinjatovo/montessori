<%@ page import="user.*" %>
<%@ page import="comptabilite.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>

<%
        String apres="comptabilite/apresCompta.jsp";
        String lien= null;
        UserEJB u = null;
		String exercice = null;
		Bilan[] actifs = null;
		Bilan[] passifs = null;
		Bilan[] compteresultat = null;
		Exercice exo = null;
		Societe societe = null;

try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");

exercice = request.getParameter("exercice");
Exercice exotest = new Exercice();
exotest.setNomTable("exercice_libelle");
exotest.setId(exercice);
exo = (Exercice)CGenUtil.rechercher(exotest, null, null, "")[0];

Societe soc = new Societe();
soc.setNom(exotest.getIdsociete());
societe = (Societe)CGenUtil.rechercher(soc, null, null, "")[0];

actifs =u.getResultatActifs(exercice,Utilitaire.getAnnee(exo.getDatefin()));
passifs = u.getResultatPassifFinal(exercice,Utilitaire.getAnnee(exo.getDatefin()));
compteresultat = u.getResultatAvecFormule(exercice,Utilitaire.getAnnee(exo.getDatefin()));

%>
<link href="style.css" rel="stylesheet" type="text/css">


<h1>Etat financier</h1>
<h2>&nbsp;</h2>

<h2>&nbsp;</h2>
	<table align="center" cellpadding="10px" cellspacing="10px">
		<tr>
			<td>SOCIETE : </td>
			<td><%=exo.getIdsociete()%></td>
		</tr>
		<tr>
			<td>SIEGE SOCIAL : </td>
			<td><%=societe.getAdresse()%></td>
		</tr>
		<tr>
			<td>NIF : </td>
			<td><%=Utilitaire.remplacerNull(societe.getNif())%></td>
		</tr>
		<tr>
			<td>STAT : </td>
			<td><%=Utilitaire.remplacerNull(societe.getNumstat())%></td>
		</tr>
	</table>
<br>
	<table width="1000px" align="center" cellpadding="0" cellspacing="0">
		<tr>
			<td colspan=3 align="center"><h2>Bilan du <%=Utilitaire.formatterDaty(exo.getDatedebut())%> au <%=Utilitaire.formatterDaty(exo.getDatefin())%></h2></td>
		</tr>
			<td colspan=3 align="right">Unité monétaire : Ariary</td>
		</tr>
		<tr>
			<td>
				<table width="100%" border="1px solid black" style="border-collapse:collapse">
					<tr>
						<td colspan=6 align="center"><h3>ACTIF</h3></td>
					</tr>
					<tr>
						<td align="center"><h4>ACTIF</h4></td>
						<td align="center"><h4>Note</h4></td>
						<td align="center"><h4>Dec - <%=Utilitaire.getAnnee(exo.getDatefin())%> Brut</h4></td>
						<td align="center"><h4><%=Utilitaire.formatterDaty(exo.getDatefin())%> Amort/prov</h4></td>
						<td align="center"><h4><%=Utilitaire.formatterDaty(exo.getDatefin())%> NET</h4></td>
						<td align="center"><h4>Dec - <%=Utilitaire.getAnnee(exo.getDatefin())-1%> EXO-1 NET</h4></td>
					</tr>
					<% for (int iterator = 0; iterator<actifs.length; iterator++){ %>
					<tr>
						<td><%=actifs[iterator].getIntitule()%></td>
						<td></td>
						<td align="right"><%=Utilitaire.formaterAr2(actifs[iterator].getBrut())%></td>
						<td align="right"><%=Utilitaire.formaterAr2(actifs[iterator].getAmort())%></td>
						<td align="right"><%=Utilitaire.formaterAr2(actifs[iterator].getNet())%></td>
						<td><%=Utilitaire.formaterAr2(actifs[iterator].getNetPrev())%></td>
					</tr>
					<% } %>
				</table>
			</td>
			<td>&nbsp;</td>
			<td>
				<table border="1px solid black" style="border-collapse:collapse">
					<tr>
						<td colspan=4 align="center"><h3>PASSIF</h3></td>
					</tr>
					<tr>
						<td align="center"><h4>CAPITAUX PROPRES ET PASSIFS</h4></td>
						<td align="center"><h4>Note</h4></td>
						<td align="center"><h4><%=Utilitaire.formatterDaty(exo.getDatefin())%> NET</h4></td>
						<td align="center"><h4>Dec - <%=Utilitaire.getAnnee(exo.getDatefin())-1%> EXO-1 NET</h4></td>
					</tr>
					<% for (int iterator = 0; iterator<passifs.length; iterator++){ %>
					<tr>
						<td><%=passifs[iterator].getIntitule()%></td>
						<td></td>
						<td align="right"><%=Utilitaire.formaterAr2(passifs[iterator].getNet())%></td>
						<td><%=Utilitaire.formaterAr2(passifs[iterator].getNetPrev())%></td>
					</tr>
					<% } %>
				</table>
			</td>
		</tr>
	</table>
<br>
<br>
	<table   width="1000px" align="center" cellpadding="0" cellspacing="0">
		<tr>
			<td colspan=4 align="center"><h2>Compte de résultat</h2></td>
		</tr>
			<td colspan=4 align="right">Unité monétaire : Ariary</td>
		</tr>
		<tr>
			<td colspan=4 align="center"><h2>Période du <%=Utilitaire.formatterDaty(exo.getDatedebut())%> au <%=Utilitaire.formatterDaty(exo.getDatefin())%></h2></td>
		</tr>
		<tr>
			<table  border="1px solid black" align="center" cellpadding="0" cellspacing="0" width="100%"  style="border-collapse:collapse">
				<tr>
					<td align="center"></td>
					<td align="center"><h4>Note</h4></td>
					<td align="center"><h4>Dec - <%=Utilitaire.getAnnee(exo.getDatefin())%></h4></td>
					<td align="center"><h4>Dec - <%=Utilitaire.getAnnee(exo.getDatefin())-1%></h4></td>
				</tr>
				<% for (int iterator = 0; iterator<compteresultat.length; iterator++){ %>
				<tr>
					<td><%=compteresultat[iterator].getIntitule()%></td>
					<td></td>
					<td align="right"><%=Utilitaire.formaterAr2(compteresultat[iterator].getNet())%></td>
					<td><%=Utilitaire.formaterAr2(compteresultat[iterator].getNetPrev())%></td>
				</tr>
				<% } %>
			</table>
		</tr>
	</table>
<br>
<br>
<a href="<%=(String)session.getValue("lien")%>?but=comptabilite/apresCompta.jsp&acte=downloadEtatFinancier&exercice=<%=exercice%>&bute=comptabilite/etatfinancier.jsp">Exporter Excel</a>
<%
}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
%>