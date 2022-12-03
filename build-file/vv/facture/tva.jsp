<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="facture.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
	String apres="facture/apresTva.jsp";
	String lien= null;
        UserEJB u = null;
        Tva tva = null;
%>
<%
try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
//Tva[] findTva(String idTva, String val, String daty1, String daty2)
tva = u.findTva("%","%","","")[0];
}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
%>
 
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Modifier valeur TVA</h1>
<form action="<%=lien%>?but=<%=apres%>" method="post" name="tva">
 <table cellpadding="0" cellspacing="0" border="0" align="center" width="600">
 <tr><td>

  <table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
          <!--DWLayoutTable-->
          <tr>
      <td width="175" class="left">Valeur : </td>
      <td width="144"><input name="valeur" type="text" class="champ" id="valeur" maxlength="3" value="<%=tva.getValTva()%>"> %</td>
    </tr>
    <tr>
      <td class="left">Date d&eacute;but d'application : </td>
      <td><input name="dateDebut" type="text" class="champ" id="dateDebut" value="<%=Utilitaire.dateDuJour()%>" maxlength="10">
        <a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a>
        <input name="acte" type="hidden" id="acte" value="INSERT"> </td>
    </tr>
	</table>

	</td></tr>
	<tr>
      <td height="30">
        <table cellpadding="0" cellspacing="0" border="0" align="center" width="75%">
    <tr>
            <td height="21" align="center"> 
              <input type="submit" name="Submit2" value="Enregistrer" class="submit" onClick="MM_validateForm('valeur','','RisNum','dateDebut','','R');return document.MM_returnValue">

            </td>
            <td align="center">
              <input type="reset" name="Submit" value="R&eacute;tablir" class="submit">
            </td>
    </tr>
  </table>
	  </td>
    </tr>
  </table>
  </form>
  <table cellpadding="0" cellspacing="0" border="0" align="center" width="600">
  <tr>
    <td class="remarque"> <div align="right">*La valeur de la TVA prend effet 
        à partir de la date de début d'application donnée ci dessus </div></td>
  </tr>
  </table>
<script language="javascript">
var cal1 = new calendar1(document.forms['tva'].elements['dateDebut']);
cal1.year_scroll = false;
cal1.time_comp = false;
</script>