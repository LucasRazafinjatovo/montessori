<%@ page import="user.*" %>
<%@ page import="finance.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="lc.*" %>
<%@ page import="ded.Ded" %>
<%@ page import="ded.OrdonnerPayement" %>
<%@ page import="affichage.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>


<%
try{
	TypeObjet mp[] = null;
	TypeObjet ag[] = null;
	Caisse caiss[] = null;
	TypeObjet dev[] = null;
	String apres = "ded/apresMvtCaisse.jsp";
	UserEJB u = (user.UserEJB)session.getValue("u");
	String lien = (String)session.getValue("lien");
	
	mp = u.findTypeObjet("modepaiement","%","%");
	caiss = u.findCaisse("%","%","%","%");
	ag = u.findTypeObjet("Agence","%","%");
	dev = u.findTypeObjet("Devise","%","%");
	
	String[] idop = request.getParameterValues("id");
	OrdonnerPayement[] listOP = new OrdonnerPayement[idop.length];
	String listIdop = "";
	for(int i=0;i<idop.length;i++){
		if(i == 0){
			listIdop = idop[i]+",";
		} else {
			listIdop += idop[i]+",";
		}
	}
	for(int i = 0; i < idop.length; i++){
		OrdonnerPayement[] op = (OrdonnerPayement[])CGenUtil.rechercher(new OrdonnerPayement(),null,null," and id like '%"+idop[i]+"%'");
		listOP[i] = op[0];
	}
	
	
%>

<h1>MOUVEMENT CAISSE </h1>
<h2>&nbsp;</h2>


<form action="<%=lien%>?but=pub/apresTarif.jsp" method="post" name="recette" id="recette" target="_parent" onsubmit="return (verifie(daty.value)&&verifie(designation.value)&&verifie(montant.value))">

	<table width="450" border="0" align="center" cellpadding="0" cellspacing="0">
		<tr>
			<td><table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
				<tr>
					<td class="left">Date : <span class="remarque">*</span></td>
					<td align="center"> <input name="daty" type="text" class="champ" id="date" value="<%=Utilitaire.dateDuJour()%>">&nbsp;</td>
					<td align="center"><a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a></td>
				</tr>
				<tr>
					<td class="left">Mode : <span class="remarque">*</span></td>
					<td align="center"> <select name="idMode" class="champ" id="idMode">
					<%
					for(int i=0;i<mp.length;i++){
						%>
						<option value="<%=mp[i].getId()%>"><%=mp[i].getVal()%></option>
						<%
					}
					%>
					</select> </td>
					<td align="center">&nbsp;</td>
				</tr>
				<tr>
					<td class="left">Devise : <span class="remarque">*</span></td>
					<td align="center"> <select name="idDevise" class="champ" id="idDevise">
						<option value="Ar">Ar</option>
						<%
						for(int i=0;i<dev.length;i++){
						%>
							<option value="<%=dev[i].getId()%>"><%=dev[i].getVal()%></option>
						<%
						}
						%>
						</select> </td>
					<td align="center">&nbsp;</td>
				</tr>
				<tr>
					<td class="left">Caisse : <span class="remarque">*</span></td>
					<td align="center"> <select name="idCaisse" class="champ" id="idCaisse">
						<%
						for(int i=0;i<caiss.length;i++){
							%>
							<option value="<%=caiss[i].getIdCaisse()%>"  <%if(caiss[i].getIdCaisse().compareTo("CE000026")==0) out.println("selected");%>><%=caiss[i].getDescCaisse()%></option>
							<%
						}
						%>
						</select> </td>
					<td align="center">&nbsp;</td>
				</tr>
				<tr>
					<td class="left">numero Piece : </td>
					<td align="center"> <input name="numPiece" type="text" class="champ" id="numPiece" value="-"> </td>
					<td align="center">&nbsp;</td>
				</tr>
				<tr>
					<td class="left">Remarque : <span class="remarque">*</span></td>
					<td align="center"> <input name="remarque" type="text" class="champ" id="remarque" value=""> </td>
					<td align="center">&nbsp;</td>
				</tr>
				<tr>
					<td class="left">Agence : <span class="remarque">*</span></td>
					<td align="center"> <select name="agence" class="champ" id="agence">
					<%
					for(int i=0;i<ag.length;i++){
						%>
						<option value="<%=ag[i].getId()%>" <%if(ag[i].getId().compareTo("ag003")==0) out.println("selected");%>><%=ag[i].getVal()%></option>
						<%
					}
					%>
					</select> </td>
					<td align="center">&nbsp;</td>
				</tr>
				
				<tr>
					<td class="left">Beneficiaire finale: <span class="remarque">*</span></td>
					<td align="center"><input type="text" name="tiers" value=""/></td>
					<td align="center"><input name="choix3" type="button" onClick="pagePopUp('ded/choix_tiers.jsp?champReturn=tiers')" value="..." class="submit">              </td>
				</tr>
				<tr>
					<td class="left">Piece a retourne: <span class="remarque">*</span></td>
					<td align="center"><select name="etatpiece" class="champ" id="etatpiece">
						<option value="oui">oui</option>
						<option value="non">non</option>
					</select></td>
				</tr>
			</table></td>
		</tr>
        <!--<tr>
			<td height="30" align="center">
				<table width="75%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td align="center"><input name="nature" type="hidden" id="nature" value="">
							<input name="typeMvt" type="hidden" value="1">
							<input name="typeObjet" type="hidden" id="typeObjet" value="">
							<input name="numObjet" type="hidden" id="numObjet" value="">
							<input name="acte" type="hidden" id="acte" value="INSERT">
							<input type="submit" name="Submit" value="Enregistreer" class="submit">
						</td>

					</tr>
				</table>
			</td>
        </tr>-->
	</table>
<h1>Lister OP selectionnée</h1>

<table width="100%"  border="0" class="monographe" cellspacing="4">
	<tr>
		
		<td class="left">ID OP</td>
		<td class="left"><div align="center">Num Facture</div></td>
		<td class="left"><div align="center">Ligne</div></td>
		<td class="left"><div align="center">Montant (HT)</div></td>
		<td class="left"><div align="center">Designation</div></td>
		<td class="left"><div align="center">Etat</div></td>
		<td class="left"></td>
	</tr>
	<% for(int i = 0; i < listOP.length; i++){%>
	<tr>
		<td class="left"> <%=listOP[i].getId()%></td>
		<td><div align="center"><%=listOP[i].getDed_Id()%></div></td>
		<td><div align="center"><%=listOP[i].getIdLigne()%></div></td>
		<td><div align="center"><%=Utilitaire.formaterAr(listOP[i].getMontant())%></div></td>
		<td><div align="center"><%=listOP[i].getRemarque()%></div></td>
		<td><div align="center"><%=listOP[i].getEtat()%></div></td>
		<td><div align="center"><a href="#">Modifier</a></div></td>
	</tr>
	<%}%>
</table><br>

	<input type="hidden" name="idop" value="<%=listIdop%>">
	<input name="acte" type="hidden" id="nature" value="payerOPmultiple">
	<input name="typeMvt" type="hidden" value="1">
	<input name="bute" type="hidden" id="bute" value="ded/listeOP.jsp">
	<input name="classe" type="hidden" id="classe" value="OrdonnerPayement">
	<table width="100%"><tbody><tr>
		<td align="center"><input type="submit" name="Submit2" value="Payer" class="submit" tabindex="61"></td>
		<td align="center"><input type="reset" name="Submit2" value="Annuler" class="submit" tabindex="62"></td></tr></tbody>
	</table>
</form>
<%
}catch(Exception e){
	e.printStackTrace();
	%>
	<script language="JavaScript"> alert('<%=e.getMessage()%>');history.back(); </script>
	<%
	return;
}
%>