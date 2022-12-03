<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="utilitaire.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
	String apres="penalites/apresVolConteneur.jsp";
	String lien= null;
        UserEJB u = null;

%>
<%
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
%>
<SCRIPT language="JavaScript" src="script.js"></script>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Enregistrer un vol de conteneur</h1>
<form action="<%=lien%>?but=<%=apres%>" method="post" name="volConteneur" id="volConteneur" target="_parent" onsubmit="return (verifie(dateVol.value)&&verifie(numCont.value)&&verifie(montant.value)&&verifie(numDossier.value))">
  <table width="450" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td><table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
          <tr>
          <td class="left">Date :</td>
          <td align="center">
<input name="date" type="text" class="champ" id="date" size="10" maxlength="10" value="<%=Utilitaire.dateDuJour()%>">
&nbsp;<a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a>
<span class="remarque">&nbsp;&nbsp;&nbsp;&nbsp;</span>
            </td>
        </tr>
        <tr>
          <td class="left">D&eacute;signation : </td>
          <td align="center">
<input name="designation" type="text" class="champ" id="designation">
&nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">
<span class="remarque">&nbsp;&nbsp;&nbsp;&nbsp;</span></td>
        </tr>
        <tr>
            <td class="left">Date du vol : </td>
          <td align="center">
<input name="dateVol" type="text" class="champ" id="dateVol" size="10" maxlength="10">
              &nbsp;<a href="javascript:cal2.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a> 
              <span class="remarque">(*)</span></td>
        </tr>
        <tr>
            <td class="left">N&deg; du conteneur :</td>
          <td align="center">
<input name="numCont" type="text" class="champ" id="numCont">
              &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle"> 
              <span class="remarque">(*) </span> </td>
        </tr>
        <tr>
            <td class="left">Montant du cont. : </td>
          <td align="center">
<input name="montant" type="text" class="champ" id="montant">
              &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle"> 
              <span class="remarque">(*)</span> </td>
        </tr>
        <tr>
            <td class="left">N&deg; du dossier :</td>
          <td align="center">
<input name="numDossier" type="text" class="champ" id="numDossier">
              &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle"> 
              <span class="remarque">(*)</span></td>
        </tr>
        <tr>
          <td class="left">D&eacute;clarant du vol : </td>
          <td align="center">
<input name="proprietaire" type="text" class="champ" id="proprietaire">
              &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle"> 
              <span class="remarque">&nbsp;&nbsp;&nbsp;&nbsp; </span></td>
        </tr>
      </table></td>
  </tr>
  <tr>
      <td height="30" align="center">
        <table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr>
          <td align="center"><input name="acte" type="hidden" id="acte3" value="INSERT">
              <input type="submit" name="Submit" value="Enregistrer" class="submit" onClick="MM_validateForm('montant','','RisNum');return document.MM_returnValue">
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
var cal1 = new calendar1(document.forms['volConteneur'].elements['date']);
cal1.year_scroll = false;
cal1.time_comp = false;
var cal2 = new calendar1(document.forms['volConteneur'].elements['dateVol']);
cal2.year_scroll = false;
cal2.time_comp = false;
</script>
  <span class="remarque"> (*) Champs obligatoires</span></div>
