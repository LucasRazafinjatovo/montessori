<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="utilitaire.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
	String apres="penalites/apresAccident.jsp";
	String lien= null;
        penalite.Accident penAcc = null;
        String id = null;
        UserEJB u = null;

%>
<%
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
penAcc = u.findAccident(request.getParameter("id"),"","","%","%")[0];
%>
<SCRIPT language="JavaScript" src="script.js"></script>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Modifier accident</h1>
<form action="<%=lien%>?but=<%=apres%>" method="post" name="updateAccident" target="_parent" onsubmit="return (verifie(date.value)&&verifie(nomEmp.value),verifie(dateAccident.value))">
  <table cellpadding="0" cellspacing="0" border="0" align="center" width="450">
<tr><td><table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
        <tr>

    <td width="47%" class="left">Date :</td>
          <td width="53%" align="center">
            <input name="date" type="text" class="champ" id="date" value="<%=Utilitaire.formatterDaty(penAcc.getDatySaisie())%>">
              &nbsp;<a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a>
            </td>
	</tr>
	<tr>

    <td class="left">Nom de l'employ&eacute; accident&eacute; : </td>
          <td align="center">
            <input name="nomEmp" type="text" class="champ" id="nomEmp" value="<%=penAcc.getNomEmploye()%>">
              &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">
            </td>
	</tr>
	<tr>

    <td class="left">Date de l'accident : </td>
          <td align="center">
            <input name="dateAccident" type="text" class="champ" id="dateAccident" value="<%=Utilitaire.formatterDaty(penAcc.getDatyAccident())%>">
              &nbsp;<a href="javascript:cal2.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a>
            </td>
	</tr>
	<tr>

    <td class="left">Description :</td>
	      <td align="center">
            <input name="description" type="text" class="champ" id="description" value="<%=penAcc.getDescription()%>">
              &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">
            </td>

	</tr>
	</table></td></tr>
	<tr>
    <td height="30" align="center">
      <table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr>
          <td align="center"><input name="idAccident" type="hidden" id="idAccident" value="<%=penAcc.getIdAccident()%>">
              <input name="acte" type="hidden" id="acte" value="UPDATE">
            <input type="submit" name="Submit" value="Modifier">
          </td>
          <td align="center">
            <input type="reset" name="Submit2" value="Annuler">
          </td>
  </tr>
</table>
    </td>
  </tr>
</table>
</form>
<script language="javascript">
var cal1 = new calendar1(document.forms['updateAccident'].elements['date']);
cal1.year_scroll = false;
cal1.time_comp = false;
var cal2 = new calendar1(document.forms['updateAccident'].elements['dateAccident']);
cal2.year_scroll = false;
cal2.time_comp = false;
</script>
