<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
	String apres="facture/apresChange.jsp";
	String lien= null;
        UserEJB u = null;
        TypeObjet dev[]=null;
%>
<%
try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
dev=u.findTypeObjet("Devise","%","%");
}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
%>
<SCRIPT language="JavaScript" src="script.js"></script>
 
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Change.</h1>

<form action="<%=lien%>?but=<%=apres%>" method="post" name="change" target="_parent" id="change" onSubmit="return (verifie(dateDebutValide.value))">
  <table width="450" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
    <td><table width="100%" border="0" cellpadding="3" cellspacing="0" class="monographe">
          <tr>
            <td align="center" valign="top" class="left">Date d&eacute;but de
              validit&eacute; : </td>
            <td align="center">
<input name="dateDebutValide" type="text" class="champ" id="designation" onBlur="cal_prs_date1(dateDebutValide.value)" value="<%=Utilitaire.dateDuJour()%>" maxlength="10">
              &nbsp; <span class="remarque"><a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a> 
              </span></td>
        </tr>


          <tr align="center" valign="top">
            <td class="left">1 &nbsp; 
              <select name="idDevise" class="champ">
                <%
  for(int i=0;i<dev.length;i++){
%>
<option value="<%=dev[i].getId()%>"><%=dev[i].getVal()%></option>
<%
  }
%>
</select> &nbsp;=
</td>
            <td> <input name="valeurEnAr" type="text" class="champ" id="valeurEnAr">
              Ar&nbsp;&nbsp;&nbsp;&nbsp; </td>
        </tr>

      </table></td>
  </tr>
  <tr>
      <td height="30">
<table width="75%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td align="center"><input name="acte" type="hidden" id="acte" value="INSERT"> 
              <input type="submit" name="Submit" value="Enregistrer" class="submit" onClick="MM_validateForm('valeurEnAr','','RisNum');return document.MM_returnValue">
            </td>
            <td align="center">
<input type="reset" name="annuler" value="R&eacute;tablir" class="submit">
            </td>
        </tr>
      </table>
        <div align="center"></div></td>
  </tr>
</table>

</form>
<script language="">
var cal1 = new calendar1(document.forms['change'].elements['dateDebutValide']);
cal1.year_scroll = false;
cal1.time_comp = false;
</script>
