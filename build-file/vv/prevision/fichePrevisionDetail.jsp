<%@ page import="user.*" %>
<%@ page import="prevision.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%!
	String apres = "prevision/apresFichePrevision.jsp";
	String lien = null;
	facture.Client clt[] = null;
	UserEJB u = null;
	PrevDepenseViseLc[] prevd = null;

    %>
	<%

	try{
		u = (user.UserEJB)session.getValue("u");
		lien = (String)session.getValue("lien");
		String id = request.getParameter("id");
		PrevDepenseViseLc prev = new PrevDepenseViseLc();
		prev.setId(id);
		prevd = ((PrevDepenseViseLc[])CGenUtil.rechercher(prev,null,null,""));


	}catch(Exception e){
		%>
		<script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
		<%
	}
%>
<SCRIPT language="JavaScript" src="script.js"></script>
<link href="style.css" rel="stylesheet" type="text/css">
	<h1>Visualiser Prevision Depense</h1>
	<h2>&nbsp;</h2>
	<h2>&nbsp;</h2>
	<form action="<%=lien%>?but=<%=apres%>" method="post" name="recette" id="recette" target="_parent" onsubmit="return (verifie(daty.value)&&verifie(designation.value)&&verifie(montant.value))">

		<table width="450" border="0" align="center" cellpadding="0" cellspacing="0">
			<tr>
				<td> <table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
					<tr>
						<td class="left">ID Prevision: </td>
						<td align="center"><%=prevd[0].getId() %></td>
					</tr>
                                        <tr>
                                                <td class="left">Daty: </td>
                                                <td align="center"><%=Utilitaire.datetostring(prevd[0].getDaty()) %></td>
					</tr>
					<tr>
						<td class="left">Montant: </td>
						<td align="center"><%=Utilitaire.formaterAr(prevd[0].getMontant())%></td>
					</tr>
					<tr>
						<td class="left">Designation : </td>
						<td align="center"> <%=prevd[0].getDescription()%></td>
					</tr>
				</table></td>
			</tr>
			<tr>
				<td height="30" align="center">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td align="center">
								<input name="acte" type="hidden" id="acte" value="modifier">
								<input type="hidden" name = "montant" value="<%=prevd[0].getMontant()%>"/>
								<input type="hidden" name = "bute" value="prevision/updatePrevisionDepense.jsp"/>
								<input type="hidden" name = "id" value="<%=prevd[0].getId()%>"/>
								<input type="submit" name="Submit" value="Modifier" class="submit">&nbsp;
                                                        </td>
						</tr>
					</table>
				</td>
			</tr>
		</table>



</form>

LISTE DES LIGNES CREDITS RELATIFS<br>
	<table align="center" width="100%" border="0" cellpadding="0" cellspacing="0" class="monographe">
		<tr class="head">
			<td width="20%" align="right"><div align="center">Designation</div></td>
			<td width="10%" align="right"><div align="center">entite  </div></td>
			<td width="10%" align="right"><div align="center">type </div></td>
                        <td width="10%" align="right"><div align="center">direction </div></td>
			<td width="20%" align="right"><div align="center">Montant op avant  </div></td>
			<td width="20%" align="right"><div align="center">Montant apres </div></td>
			<td width="20%" align="right"><div align="center">Credit prevu </div></td>
		</tr>
<%for(int i=0;i<prevd.length;i++){
  double encours=prevd[i].getMontant();
  encours=0;%>
                <tr>
                        <td  align="right"><div align="center"><%=prevd[i].getDesignationLc() %> </div></td>
                        <td align="right"><div align="center"><%=prevd[i].getIdentite() %></div></td>
                        <td  align="right"><div align="center"><%=prevd[i].getIdtypeligne()%></div></td>
                        <td  align="right"><div align="center"><%=prevd[i].getIddirection()%></div></td>
                        <td align="right"><div align="center"><%=Utilitaire.formaterAr(prevd[i].getMontantvis()) %></div></td>
                        <td  align="right"><div align="center"><%=Utilitaire.formaterAr(prevd[i].getMontantvis()+encours)%></div></td>
                        <td  align="right"><div align="center"><%=Utilitaire.formaterAr(prevd[i].getCreditinitial()) %></div></td>
		</tr>
<%}%>
	</table>
<div align="center">
	<script language="javascript"></script>
	<span class="remarque">(*) Champs obligatoires</span>
</div>