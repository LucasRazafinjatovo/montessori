<%@ page import="user.*"%>
<%@ page import="facture.*"%>
<%@ page import="finance.*"%>
<%@ page import="lc.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="bean.*"%>
<%@ page contentType="text/html; charset=iso-8859-1" language="java"
	errorPage=""%>
<%!  String apres = "finance/apresLC.jsp";
	String lien = null;
	UserEJB u = null;
	String acte = null;
	String designation = "";
	String directeur = "";
	String abbrev = "";
	String description = "";
	String readOnly = "readonly";
	String idAModifier = null;
	String msg = "";
	MapUtilisateur mu[] = null ;
	Direction d = null;
	
	
	//<input name="choix3" type="button" onClick="pagePopUp('engagement/avantchoix_titulaire.jsp')" value="...">%>
<%
		try {
		u = (user.UserEJB) session.getValue("u");
		lien = (String) session.getValue("lien");
		acte = request.getParameter("acte");
		msg = request.getParameter("msg");
		
		mu = u.findUtilisateurs("","","","","","","directeur");
		if ((acte == null) || acte.compareTo("") == 0) acte = "Créer";
		if(acte.compareToIgnoreCase("Créer")!=0){
			idAModifier=	request.getParameter("idDirectionToUpdate");
			d=u.findDirection(idAModifier,"","","","")[0];
			designation = d.getLibelledir();
			abbrev = d.getAbbrevDir();
			directeur = String.valueOf(d.getIdDirecteur());
			description = d.getDescdir();
		}
		
		
		

	} catch (Exception e) {
%>
<%@page import="historique.MapUtilisateur"%>
<script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
%>
<SCRIPT language="JavaScript" src="script.js"></script>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Admin direction</h1>

<h2><%=acte %> direction </h2>
<form action="<%=lien%>?but=lc/apresDirection.jsp" method="post"
	name="dir" id="dir" target="_parent"
	onsubmit="return (verifie(daty.value)&&verifie(designation.value)&&verifie(montant.value))">

<table width="450" border="0" align="center" cellpadding="0"
	cellspacing="0">
	<tr>
		<td>
		<table width="100%" border="0" align="center" cellpadding="2"
			cellspacing="0" class="monographe">
			<tr>
				<td class="left">Libelle: <span class="remarque">*</span></td>
				<td align="center">
				<input	name="designation" type="text" class="champ" id="designation"
					value="<%=designation %>"> &nbsp;<img
					src="images/blank.gif" width="16" height="16" align="absmiddle">
				</td>
			</tr>
			<tr>
				<td class="left">Abreviation: <span class="remarque">*</span></td>
				<td align="center">
				<input type="text" name="abbrev"
					class="champ" id="abbrev" value="<%=abbrev %>"> 
				&nbsp;<img src="images/blank.gif" width="16" height="16"
					align="absmiddle"></td>
			</tr>
			<tr>
				<td class="left">Directeur: <span class="remarque">*</span></td>
				<td align="center">
					<select name="directeur" class="champ" id="directeur">
					<%
						for(int i=0; i<mu.length; i++){
							%>
					<option value="<%=mu[i].getTuppleID() %>"  <% if(mu[i].getTuppleID().compareTo(directeur)==0) out.println(" selected ");%>><%=mu[i].getNomuser()%></option>		
							<%
						}
					
					%>
					</select><img src="images/blank.gif" width="16" height="16"	align="absmiddle"></td>
			</tr>

			<tr>
				<td class="left" valign="top">Description:</td>
				<td align="center"><textarea rows="2" cols="15" name="description"
					class="champ" id="description"><%=description %> </textarea> &nbsp;<img
					src="images/blank.gif" width="16" height="16" align="absmiddle">
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td height="30" align="center">
		<table width="75%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td align="center">
				<input name="acte" type="hidden" id="acte"	value="<%=acte %>">
				<input name="idAModifier" type="hidden" id="idAModifier"	value="<%=idAModifier %>">
				<input type="submit" name="Submit"	value="<%=acte %>"	class="submit"></td>
				<td align="center"><input type="reset" name="annuler" value="R&eacute;tablir" class="submit"></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</form>
<div align="center"><span class="remarque">(*) Champs obligatoires</span></div>
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
