<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="finance.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%!
	String apres="finance/apresEntree.jsp";
	String lien= null;
	UserEJB u = null;
	TypeObjet tyo[] = null;
	TypeObjet tys[] = null;
	TypeObjet dev[] = null;
	TypeObjet mp[] = null;
	Caisse caiss[] = null;


%>
<%
	try
	{
		u = (user.UserEJB)session.getValue("u");
		lien = (String)session.getValue("lien");
		String[] numCheque = request.getParameterValues("id");
		Cheque[] ch = new Cheque[numCheque.length];
		Cheque cq = null;
		cq = new Cheque();
		cq.setNomTable("chequeetat");
		for(int i = 0; i < numCheque.length; i++){
			ch[i] = ((Cheque[])CGenUtil.rechercher(cq,null,null," and numcheque = '"+numCheque[i]+"'"))[0];
		}
		String listchq = "";
		for(int i=0;i<numCheque.length;i++){
			if(i == 0){
				listchq = numCheque[i]+",";
			}else{
				listchq += numCheque[i]+",";
			}
		}

		tyo = u.findTypeObjet("TypeEntree","%","%");
		tys = u.findTypeObjet("TypeSortie","%","%");
		mp = u.findTypeObjet("ModePaiement","%","%");
		dev = u.findTypeObjet("Devise","%","%");

		caiss = u.findCaisse("%","%","%","%");
%>
<SCRIPT language="JavaScript" src="script.js"></script>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Virement d'une caisse &agrave; une autre caisse</h1>
<table width="450" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
		<td class="remarque">Permet de faire un virement d'une caisse &agrave; une autre caisse</td>
	</tr>
</table>
<h2>&nbsp;</h2>

<h2>&nbsp; </h2>
<form action="<%=lien%>?but=<%=apres%>" method="post" name="recette" id="recette" target="_parent">

<table width="450" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
		<td>
			<table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
				<tr>
					<td class="left">Type de sortie : </td>
					<td align="center"> <select name="typeS" class="champ" id="idCaisse">
						<%
						for(int i=0;i<tys.length;i++){
						%>
							<option value="<%=tys[i].getId()%>" <%if(tys[i].getId().compareTo("TS019")==0) out.println("selected");%>><%=tys[i].getVal()%></option>
						<%
						}
						%>
						</select> &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">
					</td>
				</tr>
				<tr>
					<td class="left">Type d'entr&eacute;e : </td>
					<td align="center"> <select name="typeE" class="champ" id="idCaisse">
						<%
						for(int i=0;i<tyo.length;i++){
							%>
							<option value="<%=tyo[i].getId()%>"><%=tyo[i].getVal()%></option>
							<%
						}
						%>
						</select> &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">
					</td>
				</tr>
				<tr>
					<td class="left">Caisse d'arriv&eacute;e : </td>
					<td align="center"> <select name="caisse2" class="champ" id="idCaisse">
						<%
						for(int i=0;i<caiss.length;i++){
							%>
							<option value="<%=caiss[i].getIdCaisse()%>"><%=caiss[i].getDescCaisse()%></option>
							<%
						}
						%>
						</select> &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">
					</td>
				</tr>
				<tr>
					<td class="left">Mode de paiement : </td>
					<td align="center"> <select name="idModeP" class="champ" id="idModeP">
						<%
						for(int i=0;i<mp.length;i++){
							%>
							<option value="<%=mp[i].getId()%>" <%if(i==1) out.println("selected");%>><%=mp[i].getVal()%></option>
							<%
						}
						%>
						</select> &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">
					</td>
				</tr>
				<tr>
					<td class="left">Devise en : </td>
					<td align="center">
						<select name="idDevise" class="champ" id="idDevise">
							<option value="Ar">Ar</option>
							<%
							for(int i=0;i<dev.length;i++){
							%>
							<option value="<%=dev[i].getId()%>"><%=dev[i].getVal()%></option>
							<%
							}
							%>
						</select> &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">
					</td>
				</tr>
				<tr>
					<td class="left" valign="top">Date :</td>
					<td align="center">
						<input name="daty" type="text" class="champ" id="date" value="<%=Utilitaire.dateDuJour()%>" size="10" maxlength="10">
						&nbsp; <a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a></td>
				</tr>
				<tr>
					<td class="left" valign="top">Remarque :</td>
					<td align="center"><textarea name="remarque" class="champ" id="remarque" ></textarea></td>
				</tr>
			</table>
		</td>
    </tr>
    <tr>
		<td height="30" align="center">
			<table width="75%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center">
						<input name="acte" type="hidden" id="acte" value="VIREMENTMULTIPLE">
						<input name="listchq" type="hidden" id="listchq" value="<%=listchq%>">
						<input type="submit" name="Submit" value="Enregistrer" class="submit">
					</td>
					<td align="center">
						<input type="reset" name="annuler" value="R&eacute;tablir" class="submit">
					</td>
				</tr>
			</table>
		</td>
    </tr>
</table>

<h1>Lister des Mouvements de caisse selectionnée</h1>

<table width="100%"  border="0" class="monographe">
	<tr class="head">
		<td width="16%" align="center" valign="top">Num Cheque</td>
		<td width="16%" align="center" valign="top">Date saisie</td>
		<td width="16%" align="center" valign="top">Designation</td>
		<td width="16%" align="center" valign="top">Caisse (depart)</td>
		<td width="16%" align="center" valign="top">Montant</td>
		<td width="16%" align="center" valign="top">ID mvt</td>
	</tr>
	<% for(int i = 0; i < ch.length; i++){%>
	<tr>
		<td width="16%" align="center"><%=ch[i].getNumCheque()%></td>
		<td width="16%" align="center"><%=ch[i].getDatySaisieLettre()%></td>
		<td width="16%" align="center"><%=ch[i].getDesignation()%></td>
		<td width="16%" align="center"><%=ch[i].getCaisse()%></td>
		<td width="16%" align="center"><%=ch[i].getMontantLettre()%></td>
		<td width="16%" align="center"><%=ch[i].getId()%></td>
	</tr>
	<%}%>
</table><br>




</form>
<%

	}catch(Exception e){
		%>
		<script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
		<%
	}
%>
<div align="center">
  <script language="javascript">
var cal1 = new calendar1(document.forms['recette'].elements['daty']);
cal1.year_scroll = false;
cal1.time_comp = false;
</script>
  <span class="remarque">(*) Champs obligatoires</span></div>
