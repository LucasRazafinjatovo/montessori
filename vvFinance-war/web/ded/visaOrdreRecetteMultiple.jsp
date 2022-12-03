<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="finance.*" %>
<%@ page import="ded.Ded" %>
<%@ page import="ded.OrdonnerPayement" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%!
        String apres="ded/apresvisaOrdreRecette.jsp";
        String lien= null;
                facture.Client clt[] = null;
        UserEJB u = null;
       Ded ded = null;
    String id= null;

OrdonnerPayement op = null;
String nature = null;
     %>
<%
String numObjet = "";
String[] listop = request.getParameterValues("id");
for(int i = 0; i < listop.length; i++){
	numObjet += listop[i]+",";
}
try{
	u=(user.UserEJB)session.getValue("u");
	lien=(String)session.getValue("lien");
	if (numObjet==null) numObjet ="";
}catch(Exception e){
	%>
	<script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
	<%
}
%>
<SCRIPT language="JavaScript" src="script.js"></script>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>VISA ORDRE PAYEMENT </h1>
<h2>&nbsp;</h2>
<form action="<%=lien%>?but=<%=apres%>" method="post" name="recette" id="recette" target="_parent" onsubmit="return (verifie(daty.value)&&verifie(designation.value)&&verifie(montant.value))">

<table width="450" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
		<td height="30" align="center"><table width="100%" border="0" class="monographe">
			<tr>
				<td class="left">Date</td>
				<td align="center"><input name="daty" type="text" class="champ" id="daty" value="<%=Utilitaire.dateDuJour()%>">&nbsp; </td>
				<td class="left"><a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a>  </td>
			</tr>
			<tr>
				<td class="left">Libelle&nbsp; </td>
				<td align="center"><select name="libsoc" class="champ" id="remarque">
                       <option value="activa">ACTIVA</option>
                       <option value="itu">IT University</option>
                       <option value="bici">BICI</option>
                       <option value="vv">Vidy Varotra</option>
                       </select>
				</td>
			</tr>
			<tr>
				<td class="left">Remarque</td>
				<td align="center"><input name="remarque" type="text" class="champ" id="remarque" maxlength="20">&nbsp;</td><td></td>
			</tr>
		</table>
		<table width="75%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td align="center">
					<input name="idOP" type="hidden"  id="idOP" value="<%=numObjet%>" />
					<input name="nature" type="hidden" id="nature" value="<%=nature%>">
					<input name="acte" type="hidden" id="acte" value="multiple">
					<input type="submit" name="Submit" value="Viser" class="submit">
				</td>

			</tr>
		</table></td>
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