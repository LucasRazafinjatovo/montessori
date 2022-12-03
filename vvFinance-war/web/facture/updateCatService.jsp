<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<%!
        UserEJB u = null;
        String acte = null;
        String lien = null;
	String apres = null;
        TypeObjet catsvc= null;
        String idCatServ = null;

%>
<%
try{
idCatServ = request.getParameter("idCatServ");
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
catsvc = u.findTypeObjet("categorie",idCatServ,"%")[0];
}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
%>
%>
 
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Ajouter nouvelle cat&eacute;gorie</h1>
<form action="<%=lien%>?but=<%=apres%>" method="post">
  <table width="450" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
    <!--DWLayoutTable-->
    <tr>
      <td class="left">D&eacute;signation : </td>
    <td><input name="designation" type="text" class="champ" id="designation" value="<%=catsvc.getVal()%>"> </td>
  </tr>
    <tr>
    <td class="left" colspan="2">Description : </td>
    </tr>
	<tr>
    <td colspan="2"><textarea name="description" cols="50" rows="7" id="description"><%=catsvc.getDesce()%>
</textarea></td>
  </tr>
  <tr>
    <td colspan="2" height="5"></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><input type="submit" name="Submit" value="Enregistrer" class="submit">
      <input type="submit" name="Submit" value="R&eacute;tablir" class="submit"></td>
  </tr>
</table>
  <input name="acte" type="hidden" id="acte" value="UPDATE">
  <input name="idCatServ" type="hidden" id="idCatServ" value="<%=catsvc.getId()%>">
</form>