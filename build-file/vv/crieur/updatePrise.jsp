<%@ page import="user.*" %>
<%@ page import="crieur.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%!
String apres="crieur/apresTypeVente.jsp";
String lien= null;
UserEJB u = null;
String id = null;
Prisecrieur p = null;
Prisecrieur[] lp = null;
Prisecrieurlib pl = null;
Prisecrieurlib[] lpl = null;
String type = null;
%>
<%
id = request.getParameter("id");
type = request.getParameter("type");
try{
	u = (user.UserEJB)session.getValue("u");
	lien =(String)session.getValue("lien");
	p = new Prisecrieur();
	p.setId(id);
	lp = (Prisecrieur[])CGenUtil.rechercher(p,null,null,"");
	pl = new Prisecrieurlib();
	pl.setId(id);
	lpl = (Prisecrieurlib[])CGenUtil.rechercher(pl,null,null,"");
}catch(Exception e){
	%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
	<%
}
%>
<SCRIPT language="JavaScript" src="script.js"></script>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Modifier prise</h1>
<h2>&nbsp;</h2>

<h2>&nbsp;</h2>
<form action="<%=lien%>?but=<%=apres%>" method="post" name="recette" id="recette" target="_parent" onsubmit="return (verifie(daty.value)&&verifie(designation.value)&&verifie(montant.value))">
	<table width="450" border="0" align="center" cellpadding="0" cellspacing="0">
		<tr>
			<td> 
				<table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
					<tr>
						<td class="left">id prise:</td>
						<td align="center"> <%=lp[0].getId()%><input name="id" type="hidden" id="id" value="<%=lp[0].getId()%>">&nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle"></td>
					</tr>
					<tr>
						<td class="left">publication:</td>
						<td align="center"><input name="publicat" type="text" id="caisse" value="<%=lpl[0].getJournal()+" "+lpl[0].getNumparution()%>">&nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle"></td>
					</tr>
					<tr>
						<td class="left">Vendeur: </td>
						<td align="center"><%=lpl[0].getVendeur()%>
							<input value="<%=lp[0].getVendeur()%>" type="hidden" name="vendeur" value="vendeur" class="submit"/>&nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle"></td>
					</tr>
					<tr>
						<td class="left">Daty : </td>
						<td align="center"> <input type="text" name="daty" id="champ" value="<%=Utilitaire.datetostring(lp[0].getDaty())%>"/>&nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle"></td>
					</tr>
					<tr>
						<td class="left">Nombre prise : </td>
						<td align="center"> <input type="text" name="nbre" id="champ" value="<%=lp[0].getNbreprise()%>"/>&nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle"></td>
					</tr>
				</table>
			</td>
		</tr>
        <tr>
			<td height="30" align="center">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td align="center">
							<input name="tableJointure" type="hidden" id="tableJointure" value="<%=Constante.getObjetOp()%>">
							<input name="acte" type="hidden" id="acte" value="update">&nbsp;
							<input type="hidden" name="place" value="" class="submit">&nbsp;
							<input name="type" type="hidden" id="type" value="<%=type%>">
							<input name="idPrix" type="hidden" id="idPrix" value="<%=lp[0].getIdPrix()%>">
							<input type="hidden" name="bute" value="crieur/listePrise.jsp">
							<input type="hidden" name="classe" value="crieur.Prisecrieur">
							<input type="submit" name="Submit" value="Modifier">

						</td>
					</tr>
				</table>
			</td>
        </tr>
	</table>
</form>
<span class="remarque">(*) Champs obligatoires</span></div>