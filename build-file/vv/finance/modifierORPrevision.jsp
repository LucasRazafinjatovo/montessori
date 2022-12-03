<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="finance.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="lc.Direction" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%@ page import="ded.OrdonnerPayement" %>
<SCRIPT language="JavaScript" src="script.js"></script>
<%
user.UserEJB u=null;
String lien;
Caisse caiss[] = null;
OrdonnerPayement[] mvt = null;
String idrib;
String idmvt;

try{
	u = (user.UserEJB)session.getValue("u");
	lien = (String)session.getValue("lien");
	OrdonnerPayement op = new OrdonnerPayement();
	op.setNomTable("OrdonnerRecette");
	mvt = (OrdonnerPayement[])CGenUtil.rechercher(op,null,null," and id like '%"+request.getParameter("id")+"%'");
    
%>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Modifier Date OR </h1>
<table width="450" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
        <td class="remarque" align="center"></td>
    </tr>
</table>
<h2>&nbsp;</h2>
<form action="<%=lien%>?but=pub/apresPub.jsp" method="post" name="recette" id="recette" target="_parent">
<table width="450" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
		<td> <table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
            <tr>
				<td class="left">Id : </td>
				<td align="center"><input name="id" type="text" class="champ" id="id"  value="<%=mvt[0].getId()%>" readonly="true"/></td>
				<td align="center">&nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle"> </td>
            </tr>
			<tr>
				<td class="left">Date :  <span class="remarque">*</span></td>
				<td align="center"><input name="daty" type="text" id="daty" value="<%=Utilitaire.convertDatyFormtoRealDatyFormat(mvt[0].getDaty().toString())%>" /></td>
				<td align="left">&nbsp;
				</td>
			</tr>
            <tr>
				<td class="left">Designation : </td>
				<td align="center"><textarea name="remarque" type="text"  id="remarque">  <%=mvt[0].getRemarque()%>"/> </textarea></td>
				<td align="center">&nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle"> </td>
            </tr>
			<tr>
				<td class="left">Montant :  <span class="remarque">*</span></td>
				<td align="center"><input name="montant" type="text" class="champ" id="montant" value="<%=mvt[0].getMontant()%>"/></td>
				<td align="center">&nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">            </td>
			</tr>
			
		</table></td>
    </tr>
	<tr>
		<td height="30" align="center">
			<table width="75%" border="0" cellspacing="0" cellpadding="0">
			<tr>
                <td>
					<input name="acte" type="hidden" id="nature" value="updateorp"/>
					<input name="bute" type="hidden" id="bute" value="finance/modifierORPrevision.jsp&id=<%=mvt[0].getId()%>"/>
					<input type="submit" name="valider" value="Modifier" class="submit"/>
				</td>
				<td align="center">
					<input type="reset" name="annuler" value="R&eacute;tablir" class="submit">
				</td>
			</tr>
			</table>
		</td>
    </tr>
</table>
</form>
<%

}catch(Exception ex){


}

%>
<div align="center">

  <span class="remarque">(*) Champs obligatoires</span></div>