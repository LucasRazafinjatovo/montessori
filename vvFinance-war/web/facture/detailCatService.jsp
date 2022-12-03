<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
	String apres="facture/apresInit.jsp";
	String lien= null;
	TypeObjet catsvc = null;
        UserEJB u = null;
   	String idCatService = null;
%>
<%
idCatService = request.getParameter("idCatService");
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
try{
catsvc =  u.findTypeObjet("categorie",idCatService,"%")[0];
}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
%>
%>
 
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Detail de la cat&eacute;gorie de service</h1>
<table cellpadding="0" cellspacing="0" border="0" align="center" width="385">
  <!--DWLayoutTable-->
  <tr>

    <td width="193" height="20" class="left">Valeur : </td>

    <td width="192"><%=catsvc.getVal()%> </td>
    </tr>
    <tr>

    <td height="20" colspan="2" class="left">Description : </td>
    </tr>

  <tr class="left">
    <td colspan="2"><%=catsvc.getDesce()%> </td>
    </tr>

  </table>
