<%@ page import="user.*" %>
<%@ page import="crieur.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="ded.*" %>
<%@ page import="bean.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%!
String apres="pub/apresTarif.jsp";
String lien= null;
UserEJB u = null;
String id = null;
OrdonnerPayement p = null;
OrdonnerPayement[] lp = null;
%>
<%
	id = request.getParameter("id");
	try{
		u = (user.UserEJB)session.getValue("u");
		lien =(String)session.getValue("lien");
		p = new OrdonnerPayement();
		p.setId(id);
		lp = (OrdonnerPayement[])CGenUtil.rechercher(p,null,null,"");
	%>
<SCRIPT language="JavaScript" src="script.js"></script>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Annuler OP</h1>
<h2>&nbsp;</h2>

<h2>&nbsp;</h2>
<form action="<%=lien%>?but=<%=apres%>" method="post" name="recette" id="recette" target="_parent" onsubmit="return (verifie(daty.value)&&verifie(designation.value)&&verifie(montant.value))">
	<table width="450" border="0" align="center" cellpadding="0" cellspacing="0">
		<tr>
			<td> 
				<table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
					<tr>
						<td class="left">Id OP:</td>
						<td align="center"> <%=lp[0].getId()%></td>
					</tr>
					<tr>
						<td class="left">ID Facture :</td>
						<td align="center"><%=lp[0].getDed_Id()%></td>
					</tr>
					
					<tr>
						<td class="left">Daty : </td>
						<td align="center"><%=lp[0].getDaty()%></td>
					</tr>
					<tr>
						<td class="left">Montant OP : </td>
						<td align="center"><%=lp[0].getMontant()%></td>
					</tr>
					<tr>
						<td class="left">Designation: </td>
						<td align="center">
							<textarea name="remarque" class="champ" id="remarque"></textarea>
						</td>
					</tr>
					
				</table>
			</td>
		</tr>
        <tr>
			<td height="30" align="center">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td align="center">
							<input name="id" type="hidden" id="id" value="<%=lp[0].getId()%>">
							<input name="acte" type="hidden" id="acte" value="annulerOP">&nbsp;
							<input type="hidden" name="bute" value="ded/listeOP.jsp">
							<input type="hidden" name="classe" value="ded.OrdonnerPayement">
							<input type="submit" name="Submit" value="Valider">

						</td>
					</tr>
				</table>
			</td>
        </tr>
	</table>
</form>
<span class="remarque">(*) Champs obligatoires</span></div>
<%
}catch(Exception e){
		%>
		<script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
		<%
	}
	%>