<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="finance.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        String lien= null;
        UserEJB u = null;
        TypeObjet ts = null;
        String rep = null;
        String idCompte = null;

 %>
 <%
idCompte= request.getParameter("idCompte");
 %>
 <%
   u=(user.UserEJB)session.getValue("u");
   lien=(String)session.getValue("lien");
   ts=u.findTypeObjet("Compte","%",idCompte)[0];
 %>
<link href="style.css" rel="stylesheet" type="text/css">
 <h1>Détails compte N° <%=ts.getId()%></h1>
<table width="600" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td>
	<table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
        <!--DWLayoutTable-->
        <tr class="head">
          <td width="203" valign="top"><div align="center"><strong>Id</strong></div></td>
          <td width="203" height="19" valign="top"><div align="center"><strong>Type</strong></div></td>
          <td width="275"><div align="center">Description</div></td>

        </tr>

        <tr>
          <td><div align="center"><%=ts.getId()%></div></td>
          <td><div align="center"><%=ts.getVal()%></div></td>
          <td><div align="center"><%=ts.getDesce()%></div></td>

        </tr>

      </table></td>
  </tr>
</table>
