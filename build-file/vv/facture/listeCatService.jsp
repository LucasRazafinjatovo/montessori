<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="facture.*" %>
<%@ page import="bean.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
 
<html>
<%!
        UserEJB u = null;
        String acte = null;
        String lien = null;
	String apres = null;
        TypeObjet catsvc[] = null;

%>
<%
try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
catsvc = u.findTypeObjet("categorie","%","%");
}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
%>
%>
<link href="../style/style.css" rel="stylesheet" type="text/css">
<h2>Liste des cat&eacute;gories de service existantes</h2>
<table cellpadding="3" cellspacing="0" border="0" align="center">
  <tr class="head">
    <td width="126">Cat&eacute;gorie</td>
    <td width="74" align="center" valign="middle">Valeur</td>
    <td width="74" align="center" valign="middle">&nbsp;</td>
  </tr>
  <%
	  for(int i=0;i<catsvc.length;i++){
	  %>
  <tr>
    <td ><a href="#"><%=""%></a></td>
    <td align="center" valign="middle"><%=catsvc[i].getVal()%></td>
    <td align="center" valign="middle">Detail</td>
  </tr>
  <%
		}
		%>
</table>
