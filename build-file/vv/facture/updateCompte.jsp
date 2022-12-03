<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="finance.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        String apres="facture/apresCompte.jsp";
        String lien= null;
        UserEJB u = null;
        TypeObjet te = null;
        String rep = null;
        String idTe = null;
        String idTypeEntree = null;

 %>
<%
idTypeEntree = request.getParameter("idTypeEntree");
%>
 <%
   u=(user.UserEJB)session.getValue("u");
   lien=(String)session.getValue("lien");
   te=u.findTypeObjet("Compte",idTypeEntree,"%")[0];
 %>
 
<SCRIPT language="JavaScript" src="script.js"></script>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Modifier un compte</h1>
<form action="<%=lien%>?but=<%=apres%>" method="post" name="compte" target="_parent" id="compte" onsubmit="return (verifie(designation.value))">
  <table cellpadding="0" cellspacing="0" border="0" align="center" width="450">
<tr><td><table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
          <!--DWLayoutTable-->
          <tr>
            <td class="left">Date d&eacute;but de validit&eacute; :</td>
            <td align="center"><div align="left">
                <input name="date" type="text" class="champ" id="date" value="<%=Utilitaire.dateDuJour()%>">
               <a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a></div></td>
          </tr>
          <tr> 
            <td width="37%" class="left">Identification Compt</td>
            <td width="63%" align="center"> <div align="left">
                <input name="designation" type="text" class="champ" value="<%=te.getVal()%>">
              </div></td>
          </tr>
          <tr> 
            <td valign="top" class="left">Description : </td>
            <td align="center"> <div align="left">
                <input name="description" type="text" class="champ" id="description" value="<%=te.getDesce()%>">
                <input name="idTypeEntree" type="hidden" id="idTypeEntree" value="<%=idTypeEntree%>">
                <input name="acte" type="hidden" id="acte2" value="UPDATE">
              </div></td>
          </tr>
        </table></td></tr>
<tr>
    <td height="30" align="center">
      <table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr>
          <td height="21" align="center">
            <input type="submit" name="Submit" value="Modifier" class="submit">
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
<script language="JavaScript">
var cal1 = new calendar1(document.forms['compte'].elements['date']);
cal1.year_scroll = false;
cal1.time_comp = false;
</script>
