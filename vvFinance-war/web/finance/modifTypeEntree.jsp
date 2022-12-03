<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="finance.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        String apres="finance/apresTypeEntree.jsp";
        String lien= null;
        UserEJB u = null;
         TypeObjet te[] = null;
        String idTypeRecette=null;
        String acte=null;
        String desi, desc;
     %>
<%
u=(UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
%>
<%
te=u.findTypeObjet("TypeEntree",idTypeRecette,"%");
%>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Ajouter nouveau type de recettes</h1>
<form action="<%=lien%>?but=<%=apres%>" method="post">
<table cellpadding="2" cellspacing="0" border="0" align="center">
  <!--DWLayoutTable-->
  <tr>
    <td class="left">D&eacute;signation du type : </td>

  <td>
    <input name="designation" type="text" class="champ" id="designation">
   </td>

</tr>
 <tr>

  <td colspan="2"><textarea name="description" cols="50" rows="7" id="description"></textarea>
     <input name="acte" type="hidden" id="acte" value="INSERT">
   </td>
</tr>
  <tr>
    <td colspan="2" height="5"></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><input type="submit" name="Submit" value="Enregistrer" class="submit">
      <input type="reset" name="annuler" value="Annuler" class="submit"></td>
  </tr>
</table>
</form>