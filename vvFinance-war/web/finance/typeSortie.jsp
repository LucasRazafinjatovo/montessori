<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="finance.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        String apres="finance/apresTypeSortie.jsp";
        String lien= null;
        UserEJB u = null;
     %>
<%
u=(UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
%>
<SCRIPT language="JavaScript" src="script.js"></script>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Ajouter nouveau type de d&eacute;pense</h1>
<form action="<%=lien%>?but=<%=apres%>" method="post" target="_parent" onsubmit="return (verifie(designation.value))">
<table cellpadding="0" cellspacing="0" border="0" align="center" width="450">
<tr><td>
<table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
        <!--DWLayoutTable-->
        <tr>
          <td class="left">D&eacute;signation du type : </td>
          <td align="center"> <input name="designation" type="text" class="champ" id="designation">
          </td>
        </tr>
        <tr>
          <td valign="top" class="left">Description : </td>
          <td align="center"> <textarea name="description" cols="50" rows="7" class="champ" id="description">-</textarea>
            <input name="acte" type="hidden" id="acte2" value="INSERT"> </td>
        </tr>
      </table></td></tr>
<tr>
    <td height="30" align="center">
      <table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr>
          <td align="center">
<input type="submit" name="Submit" value="Enregistrer" class="submit" onClick="MM_validateForm('designation','','R','description','','R');return document.MM_returnValue">
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
