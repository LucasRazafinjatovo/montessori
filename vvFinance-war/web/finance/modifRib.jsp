<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="finance.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="lc.Direction" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>

<SCRIPT language="JavaScript" src="script.js"></script>
<%!
user.UserEJB u=null;
String lien;
Caisse caiss[] = null;
%>
<%
	u = (user.UserEJB)session.getValue("u");
	lien = (String)session.getValue("lien");
	caiss = u.findCaisse("%","%","%","%");
	Rib rib = u.findDetailRib(request.getParameter("id"));
%>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Modifier RIB </h1>
<table width="450" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
        <td class="remarque" align="center"></td>
    </tr>
</table>
<h2>&nbsp;</h2>
<form action="<%=lien%>?but=pub/apresTarif.jsp" method="post" name="recette" id="recette" target="_parent">
<table width="450" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
		<td> <table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
            <tr>
				<td class="left">Id : </td>
				<td align="center"><input name="id" type="text" class="champ" id="id"  value="<%=rib.getId()%>" readonly="true"/></td>
				<td align="center">&nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle"> </td>
            </tr>
			<tr>
				<td class="left">Date :  <span class="remarque">*</span></td>
				<td align="center"><input name="daty" type="text" class="champ" id="daty"  value="<%=Utilitaire.convertDatyFormtoRealDatyFormat(rib.getDaty().toString())%>" /></td>
				<td align="left">&nbsp;
					<a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a>
					<img src="images/blank.gif" width="16" height="16" align="absmiddle">            
				</td>
			</tr>
            <tr>
				<td class="left">Designation : </td>
				<td align="center"><textarea name="designation" class="champ" id="remarque" maxlength="100"> <%=rib.getDesignation()%></textarea></td>
				<td align="center">&nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle"> </td>
            </tr>
			<tr>
				<td class="left">N° cheque :  <span class="remarque">*</span></td>
				<td align="center"><input name="numcheque" type="text" class="champ" id="numcheque" value="<%=rib.getNumcheque()%>"/></td>
				<td align="center">&nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">            </td>
			</tr>
			<tr>
				<td class="left">Caisse :  <span class="remarque">*</span></td>
				<td align="center"> <select name="caisse" class="champ" id="caisse">
				
				<%
				for(int i=0;i<caiss.length;i++){
				%>
					<option value="<%=caiss[i].getIdCaisse()%>"><%=caiss[i].getDescCaisse()%></option>
                <%
				}
				%>
				</select> </td>
				<td align="center">&nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">            </td>
			</tr>
			<tr>
				<td class="left">N° reference : </td>
				<td align="center"><input name="numreference" type="text" class="champ" id="numreference" value="<%=rib.getNumreference()%>">&nbsp; </td>
				<td align="center"><img src="images/blank.gif" width="16" height="16" align="absmiddle"></td>
			</tr>
			<tr>
				<td class="left">Debit : <span class="remarque">*</span></td>
				<td align="center"><input name="debit" type="text" class="champ" id="debit" value="<%=rib.getDebit()%>">&nbsp; </td>
				<td align="center"><img src="images/blank.gif" width="16" height="16" align="absmiddle"></td>
			</tr>
			<tr>
				<td class="left">Credit : <span class="remarque">*</span></td>
				<td align="center"><input name="credit" type="text" class="champ" id="credit" value="<%=rib.getCredit()%>">&nbsp; </td>
				<td align="center"><img src="images/blank.gif" width="16" height="16" align="absmiddle"></td>
			</tr>
			
		</table></td>
    </tr>
	<tr>
		<td height="30" align="center">
			<table width="75%" border="0" cellspacing="0" cellpadding="0">
			<tr>
                <td>
					<input name="acte" type="hidden" id="nature" value="update">
					<input name="bute" type="hidden" id="bute" value="finance/ficheRibnonr.jsp">
                                        <input name="rajoutLien" type="hidden" value="id">
					<input name="classe" type="hidden" id="classe" value="finance.Rib">
					<input type="submit" name="valider" value="Modifier" class="submit">
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
<div align="center">
  <script language="javascript">
var cal1 = new calendar1(document.forms['recette'].elements['daty']);
cal1.year_scroll = false;
cal1.time_comp = false;

</script>
  <span class="remarque">(*) Champs obligatoires</span></div>