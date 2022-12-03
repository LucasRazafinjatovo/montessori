<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="historique.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
    String lien = null;
    MapUtilisateur a[] = null;
    UserEJB u = null;
%>
<%
try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
a = u.findUtilisateurs("%","%", "%", "%",  "%", "%","%");
}
catch (Exception e){
%>
<script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
  return;
}
%>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Liste des utilisateurs enregistr&eacute;s</h1>
<table width="600" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td><table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
        <tr class="head">
  	<td width="44">Ref.</td>
    <td width="195" height="19" valign="top"><strong>Nom</strong></td>
    <td width="88" valign="top"><strong>login</strong></td>
    <td width="104" valign="top"><strong>Profil</strong></td>
    <td width="8"></td>
    <td valign="top" colspan="3" align="center"><strong>Action</strong></td>
  </tr>
<%
  for(int i=0;i<a.length;i++){
  %>
  <tr>
  	<td width="44" align="center"><a href="<%=lien%>?idUser=<%=a[i].getRefuser()%>&but=utilisateur/detailUtilisateur.jsp"><%=a[i].getRefuser()%></a></td>
    <td><%=a[i].getNomuser()%></td>
    <td><%=a[i].getLoginuser()%></td>
    <td><%=a[i].getIdrole()%></td>
    <td></td>
    <td width="42"><a href="<%=lien%>?idUser=<%=a[i].getRefuser()%>&but=utilisateur/updateUtilisateur.jsp">Modifier</a></td>
    <td width="9"></td>
          <td width="58"><a href="<%=lien%>?idUser=<%=a[i].getRefuser()%>&but=utilisateur/apresUtilisateur.jsp&acte=<%=a[i].getEtat()%>"><%=a[i].getEtat()%></a></td>
  </tr>
<%
  }
%>
  </table>
</td>
  </tr>
</table>

