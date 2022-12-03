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
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
caiss = u.findCaisse("%","%","%","%");
%>
<link href="style.css" rel="stylesheet" type="text/css">


<h1>Saisir RIB </h1>
 <table width="450" border="0" align="center" cellpadding="0"
          cellspacing="0">
          <tr>
                  <td class="remarque" align="center">Enregistrement de tous les actions dans elionet</td>
          </tr>
  </table>
<h2>&nbsp;</h2>

<h2>&nbsp;</h2>

<form action="<%=lien%>?but=finance/apresRib.jsp" method="post" name="recette" id="recette" target="_parent" onsubmit="return (verifie(daty.value)&&verifie(designation.value)&&verifie(montant.value))">

<table width="450" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td> <table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
                <tr>
            <td class="left">Date :  <span class="remarque">*</span></td>
            <td align="center"><input name="daty" type="text" class="champ" id="daty" value=<%=Utilitaire.dateDuJour() %> /></td>
            <td align="left">&nbsp;
              <a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a>
              <img src="images/blank.gif" width="16" height="16" align="absmiddle">            </td>
        </tr>
                <tr>
                        <td class="left">Designation : </td>
                        <td align="center"><textarea name="designation" class="champ" id="remarque" maxlength="100"></textarea></td>
                        <td align="center">&nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle"> </td>
                </tr>
          <tr>
            <td class="left">N° cheque :  <span class="remarque">*</span></td>
            <td align="center"><input name="numcheque" type="text" class="champ" id="numcheque"/></td>
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
            <td align="center"><input name="numreference" type="text" class="champ" id="numreference">&nbsp; </td>
            <td align="center"><img src="images/blank.gif" width="16" height="16" align="absmiddle"></td>
          </tr>
          <tr>
            <td class="left">montant : <span class="remarque">*</span></td>
            <td align="center"><input name="montant" type="text" class="champ" id="montant">&nbsp; </td>
            <td align="center"><img src="images/blank.gif" width="16" height="16" align="absmiddle"></td>
          </tr>
          <tr>
            <td class="left">Type : <span class="remarque">*</span></td>
            <td align="center"><input name="type" type="radio" id="debit" value="debit">&nbsp; Debit
                               <input name="type" type="radio" id="credit" value="credit">&nbsp; Credit</td>
            <td align="center"><img src="images/blank.gif" width="16" height="16" align="absmiddle"></td>
          </tr>


</table></td>
    </tr>

        <tr>
    <td height="30" align="center">
      <table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr>
                <td>
        <input name="acte" type="hidden" id="nature" value="saveRib">
                <input name="bute" type="hidden" id="bute" value="finance/rib.jsp">
                <input name="classe" type="hidden" id="classe" value="finance.Rib">
                <input type="submit" name="valider" value="valider" class="submit">
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