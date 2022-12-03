<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
	String apres="facture/apresAvoir.jsp";
	String lien= null;
    UserEJB u = null;
	String idFacture = null;
%>
<%
idFacture=request.getParameter("idFacture");
try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
if(idFacture==null)idFacture="";
}catch(Exception e){
%>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
%>
 
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Cr&eacute;er un avoir sur facture</h1>

<form action="<%=lien%>?but=<%=apres%>" method="post" name="autoAnnul">
<table width="450" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td align="center"><table width="100%" border="0" cellpadding="3" cellspacing="0" class="monographe">
          <tr>
            <td width="38%" class="left">Date :</td>
            <td width="8%">&nbsp;</td>
            <td width="54%"><input name="date" type="text" class="champ" id="date" value="<%=Utilitaire.dateDuJour()%>" size="10" maxlength="10">
              <a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a>
            </td>
          </tr>
          <tr>
            <td class="left">N&deg; Facture : </td>
            <td>&nbsp;</td>
            <td><input name="numFact" type="text" class="champ" id="numFact" value="<%=idFacture%>">
              <a href="<%=lien%>?but=facture/listeChoixFacture1.jsp">[Chercher]</a>
            </td>
          </tr>
          <tr>
            <td class="left">Autoris&eacute; par : </td>
            <td>&nbsp;</td>
            <td><input name="responsable" type="text" class="champ" id="num2"></td>
          </tr>
          <tr>
            <td class="left">Type : </td>
            <td>&nbsp;</td>
            <td><select name="type" class="champ" id="type">
                <option selected>interne</option>
                <option>externe</option>
              </select></td>
          </tr>
          <tr>
            <td class="left">Montant : </td>
            <td>&nbsp;</td>
            <td><input name="montant" type="text" class="champ" id="responsable2" value="0"></td>
          </tr>
          <tr>
            <td valign="top" class="left">Motif :</td>
            <td>&nbsp;</td>
            <td><textarea name="motif" cols="30" rows="7" class="champ" id="textarea">-
</textarea>
              <input name="acte" type="hidden" id="acte3" value="INSERT"> <input name="type" type="hidden" id="type" value="interne"></td>
          </tr>
        </table></td>
  </tr>
  <tr>
      <td height="30" align="center">
        <table width="75%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td align="center">
<input type="submit" name="Submit" value="Enregistrer" class="submit" onClick="MM_validateForm('montant','','RisNum','responsable','','R');return document.MM_returnValue">
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
<script language="javascript">
var cal1 = new calendar1(document.forms['autoAnnul'].elements['date']);
cal1.year_scroll = false;
cal1.time_comp = false;
</script>