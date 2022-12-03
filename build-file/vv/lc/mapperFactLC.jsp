<%@ page import="user.*"%>
<%@ page import="facture.*"%>
<%@ page import="finance.*"%>
<%@ page import="lc.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="bean.*"%>
<%@ page contentType="text/html; charset=iso-8859-1" language="java"
	errorPage=""%>
<%!String apres = "finance/apresLC.jsp";

	String lien = null;

	UserEJB u = null;

	LigneCredit lc = null;

	TypeObjet source[] = null;

	TypeObjet tlc[] = null; //type ligne credit

	TypeObjet compte[] = null; //compte compta

	Direction dir[] = null;

	String mois[] = { "Janvier", "Février", "Mars", "Avril", "Mai", "Juin",
			"Juillet", "Août", "Septembre", "Octobre", "Novembre", "Décembre" };

	String idLC = "";

	String mois2 = null;

	String annee = null;

	String acte = null;

	String designation = "";

	String numCompte = "";

	String idTypeLC = "";

	String credit = "";

	String direction = "";

	String readOnly = "readonly";

	String msg = "";

	//<input name="choix3" type="button" onClick="pagePopUp('engagement/avantchoix_titulaire.jsp')" value="...">%>
<%
		try {
		u = (user.UserEJB) session.getValue("u");
		lien = (String) session.getValue("lien");
		mois2 = request.getParameter("mois");
		if ((mois2 == null) || mois2.compareTo("") == 0)
			mois2 = "%";
		annee = request.getParameter("annee");
		if ((annee == null) || annee.compareTo("") == 0)
			annee = String.valueOf(Utilitaire.getAneeEnCours());
		acte = request.getParameter("acte");
		if ((acte == null) || acte.compareTo("") == 0)
			acte = "Créer";
		idLC = request.getParameter("idLigneACopier");
		if ((idLC == null) || idLC.compareTo("") == 0)
			idLC = "";
		
		msg = request.getParameter("msg");
		source = u.findTypeObjet("Beneficiaire", "%", "%");
		tlc = u.findTypeObjet("TypeLigneCredit", "%", "%");
		compte = u.findTypeObjet("comptecompta", "%", "%");
		dir = u.findDirection("", "", "", "", "");
		if (acte.compareToIgnoreCase("copier") == 0) {
			lc = u.findLC(idLC, "", "", "", "", "", "")[0];
			designation = lc.getDesignation();
			numCompte = lc.getNumCompte();
			idTypeLC = lc.getIdTypeLigne();
			credit = String.valueOf(lc.getCreditInitial());
			direction = lc.getIdDirection();
		}

	} catch (Exception e) {
%>
<script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
%>
<SCRIPT language="JavaScript" src="script.js"></script>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Correspondance entre une facture et une ligne de cr&eacute;dit</h1>
<h2>&nbsp;</h2>

<form action="<%=lien%>?but=lc/apresLC.jsp" method="post"
	name="recette" id="recette" target="_parent"
	onsubmit="return (verifie(daty.value)&&verifie(designation.value)&&verifie(montant.value))">

<table width="450" border="0" align="center" cellpadding="0"
	cellspacing="0">
	<tr>
		<td>
		<table width="100%" border="0" align="center" cellpadding="2"
			cellspacing="0" class="monographe">
			<tr>
				<td width="43%" class="left">id facture  : <span class="remarque">*</span></td>
				<td width="49%" align="center">
				 <input name="fact"
					type="text" class="champ" id="fact">    			  </td>
			    <td width="8%" align="center"><input		name="choix32" type="button" onClick="pagePopUp('lc/listeLC.jsp?sender=entree')"
					value="..."></td>
			</tr>
			<tr>
				<td class="left">id ligne cr&eacute;dit  :</td>
				<td align="center"><input name="lc"
					type="text" class="champ" id="lc"></td>
			    <td align="center"><input		name="choix3" type="button" onClick="pagePopUp('lc/listeLC.jsp?sender=mapperFactLC')"
					value="..."></td>
			</tr>
			<tr>
				<td class="left">Montant corr :</td>
				<td align="center"><input name="montant"
					type="text" class="champ" id="montant"></td>
			    <td align="center">&nbsp;</td>
			</tr>
			<tr>
				<td class="left">remarque : <span class="remarque">*</span></td>
				<td align="center">
				 <input name="credit" type="text"
					class="champ" id="credit" size="20" maxlength="20"> </td>
			    <td align="center">&nbsp;</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td height="30" align="center">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td align="center" width="50%"><input type="submit"
					name="Submit"
					value="OK"
					class="submit"></td>
				<td align="center"><input type="reset" name="annuler"
					value="R&eacute;tablir" class="submit"></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</form>
<div align="center"><span class="remarque">(*) Champs
obligatoires</span></div>
<%
if (msg != null) {
%>
<br />
<div align="center"><span
	style="text-align: center; font-weight: bold; color: blue; font-size: medium"><%=msg%></span>
</div>

<%
}
%>
