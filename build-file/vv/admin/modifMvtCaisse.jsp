<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="finance.*" %>
<%@ page import="ded.Ded" %>
<%@ page import="ded.OrdonnerPayement" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%!
	String apres="admin/apresModifMvtCaisse.jsp";
	String lien= null;
	UserEJB u = null;
%>
<%
try{
	u=(user.UserEJB)session.getValue("u");
	lien=(String)session.getValue("lien");
}catch(Exception e){
	%>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
	<%
}
%>
<SCRIPT language="JavaScript" src="script.js"></script>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Modifier mvt caisse </h1>
<form action="<%=lien%>?but=<%=apres%>" method="post" name="recette" id="recette" target="_parent" >
	<table width="450" border="0" align="center" cellpadding="0" cellspacing="0">
		<tr>
			<td height="30" align="center"><table width="100%" border="0" class="monographe">
				<tr>
					<td class="left">Reference mouvement caisse : <span class="remarque">*</span></td>
					<td align="center"><input name="id" type="text" class="champ"  id="id" /></td>
				</tr>
			</table>
			<br/><br/>
			<table width="75%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center">
						<input type="submit" name="Submit" value="Enregistrer" class="submit">
						<input type="hidden" name="type" class="submit">
						<input type="hidden" name="acte" value="search" class="submit">
					</td>
				</tr>
			</table></td>
        </tr>
	</table>
</form>
  <span class="remarque">(*) Champs obligatoires</span></div>