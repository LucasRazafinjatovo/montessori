<%@ page import="user.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
	String apres="facture/apresCatService.jsp";
	String lien= null;
	UserEJB u = null;
%>
<%
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
%>
 
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Ajouter une nouvelle cat&eacute;gorie de service</h1>
<form method="post" action="<%=lien%>?but=<%=apres%>">
  <table cellpadding="2" cellspacing="0" border="0" align="center">
  <!--DWLayoutTable-->
  <tr>
      <td class="left">Nom : </td>
    <td><input name="designation" type="text" class="champ" id="designation"> </td>
  </tr>
    <tr>
    <td class="left" colspan="2">Description : </td>
    </tr>
	<tr>
    <td colspan="2"><textarea name="description" cols="50" rows="7" id="description"></textarea>
        <input name="acte" type="hidden" id="acte" value="INSERT"></td>
  </tr>
  <tr>
    <td colspan="2" height="5"></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><input type="submit" name="Submit" value="Enregistrer" class="submit">
      <input type="reset" name="annuler" value="R&eacute;tablir" class="submit"></td>
  </tr>
</table>
</form>
<table width="346" border="0" cellpadding="0" cellspacing="0" align="center">
  <!--DWLayoutTable-->
  <tr> 
    <td width="346" height="16" valign="top" class="remarque">Ins&eacute;rer les 
      informations concernant la nouvelle cat&eacute;gorie de service</td>
  </tr>
</table>
