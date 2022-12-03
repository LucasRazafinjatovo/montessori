<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="utilitaire.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
	String apres="penalites/apresAccident.jsp";
	String lien= null;
        UserEJB u = null;
%>
<%       
try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
}catch(Exception e){
%>
                          <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp?message=<%=e.getMessage()%>"); </script>
            <%
}
%>
<SCRIPT language="JavaScript" src="script.js"></script>
 
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Enregistrer accident</h1>
<form name="accident" method="post" action="<%=lien%>?but=<%=apres%>" target="_parent" onsubmit="return (verifie(date.value)&&verifie(nomEmp.value)&&verifie(dateAccident.value))">
<table cellpadding="0" cellspacing="0" border="0" align="center" width="450">
<tr><td>
  <table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
          <tr>
            <td align="left" class="left"> Date :</td>
          <td><input name="date" type="text" class="champ" id="date" size="10" maxlength="10" value="<%=Utilitaire.dateDuJour()%>">
              <span class="remarque">(*)</span> <a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a><span class="remarque"> 
              </span></td>
        </tr>
        <tr>
            <td class="left">Nom de l'employ&eacute; accident&eacute; : </td>
          <td><input name="nomEmp" type="text" class="champ" id="nomEmp">
              <span class="remarque">(*)</span></td>
        </tr>
        <tr>
            <td align="left" class="left">
Date de l'accident :</td>
          <td><input name="dateAccident" type="text" class="champ" id="dateAccident" size="10" maxlength="10" onblur="Javascript:datecomp1(this,document.accident.date.value,'La date de l\'accident doit être antérieure à la date de saisie');">
              <span class="remarque">(*)</span><!-- <a href="javascript:cal2.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a> -->
            </td>
        </tr>
        <tr>
          <td class="left">Description :</td>
          <td><input name="description" type="text" class="champ" id="description" value="-" size="10" maxlength="10"></td>
        </tr>
        <!--<tr>
          <td valign="top" class="left">Remarque :</td>
          <td> <textarea name="remarque" cols="60" rows="7" class="champ" id="remarque"></textarea>
               </tr>-->

      </table>
</td></tr>
<tr>
    <td height="30" align="center">
      <table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr>
            <td align="center"> <input name="acte" type="hidden" id="acte" value="INSERT"> 
              <input type="submit" name="Submit" value="Enregistrer" class="submit" onClick="MM_validateForm('date','','R','nomEmp','','R','dateAccident','','R');return document.MM_returnValue">
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
var cal1 = new calendar1(document.forms['accident'].elements['date']);
cal1.year_scroll = false;
cal1.time_comp = false;
var cal2 = new calendar1(document.forms['accident'].elements['dateAccident']);
cal2.year_scroll = false;
cal2.time_comp = false;
</script>
  <span class="remarque"> (*) champs obligatoires</span></div>
