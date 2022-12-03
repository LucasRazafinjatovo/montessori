<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="historique.*" %>
<%@ page import="bean.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%!
        String apres="utilisateur/apresUtilisateur.jsp";
        String lien=null;
        UserEJB u=null;
        MapRoles[] rl=null;
        MapUtilisateur us=null;
%>
<%

		try
		{
		  u=(UserEJB)session.getValue("u");
		  lien=(String)session.getValue("lien");
		  rl=u.findRole("%");
		  us=u.findUtilisateurs(request.getParameter("idUser"),"%","%","%","%","%","%")[0];
}
                catch (Exception e){
%>
<script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
  return;
}
%>
<h2>D&eacute;tail concernant l'utilisateur</h2>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>D&eacute;tail utilisateur </h1>
<table cellpadding="0" cellspacing="0" border="0" align="center" width="450">
<tr><td><table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
        <!--DWLayoutTable-->
        <tr>
    <td width="211" class="left">Login :</td>
    <td width="227">&nbsp;<%=us.getLoginuser()%> </td>
  </tr>
  <tr>
    <td class="left">Nom : </td>
    <td>&nbsp;<%=us.getNomuser()%> </td>
  </tr>
  <tr>
    <td class="left">Adresse : </td>
    <td>&nbsp;<%=us.getAdruser()%> </td>
  </tr>
   <tr>
    <td class="left">T&eacute;l&eacute;phone : </td>
    <td>&nbsp;<%=us.getTeluser()%> </td>
  </tr>
  <tr>
    <td class="left">Profil :</td>
    <td>&nbsp;<%=us.getIdrole()%> </td>
  </tr>
  </table>
</td></tr>
<tr>
    <td height="30" align="center"><a href="<%=lien%>?idUser=<%=us.getRefuser()%>&but=utilisateur/updateUtilisateur.jsp">Modifier</a></td>
  </tr>
</table>
