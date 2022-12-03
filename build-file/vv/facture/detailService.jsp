<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
	String apres="facture/apresInit.jsp";
	String lien= null;
	facture.Service svc = null;
	String idService = null;
        SCatService scatserv = null;
        TypeObjet unite = null;
        TypeObjet dev = null;
        TypeObjet tva = null;
        UserEJB u = null;
%>
<%
	idService = request.getParameter("idService");
%>
<%
try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
svc = u.findService(idService, "%", "%", "%", "%","%")[0];
scatserv = u.findSCatService(svc.getIdSCatService(),"%","%","%")[0];
unite = u.findTypeObjet("unite",svc.getIdUnite(),"%")[0];
dev = u.findTypeObjet("devise",svc.getIdDevise(),"%")[0];
tva = u.findTypeObjet("tva",svc.getIdTva(),"%")[0];
}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
%>
%>
 
<link href="style.css" rel="stylesheet" type="text/css">
<h1>D&eacute;tail service</h1>
<table cellspacing="0" cellpadding="0" align="center">
<tr><td colspan="3" bgcolor="#999999" height="1"></td></tr>
<tr>
<td width="1" bgcolor="#CCCCCC"></td>
<td>
<table width="400" border="0" align="center" cellpadding="3" cellspacing="0" class="formadd">
        <tr>
          <td height="23" valign="top" class="left">D&eacute;signation :</td>
          <td valign="top"><%=svc.getDesignation()%></td>
        </tr>
        <!--DWLayoutTable-->
        <tr>
          <td width="144" height="23" valign="top" class="left">Sous-cat&eacute;gorie
            :</td>
          <td width="244" valign="top"><%=scatserv.getNomSCatService()%></td>
        </tr>
        <tr>
          <td height="23" valign="top" class="left">Date d&eacute;but validit&eacute;
            :</td>
          <td valign="top"><%=svc.getDatyDebutValid()%></td>
        </tr>
        <tr>
          <td height="23" valign="top" class="left">Unit&eacute; :</td>
          <td valign="top"><%=unite.getVal()%></td>
        </tr>
        <tr>
          <td height="23" valign="top" class="left">Prix unitaire :</td>
          <td valign="top" ><%=svc.getPrixUnitaire()%></td>
        </tr>
        <tr>
          <td height="23" valign="top" class="left">Devise :</td>
          <td valign="top" ><%=dev.getVal()%> </td>
        </tr>
        <tr>
          <td height="23" valign="top" class="left">Montant TVA :</td>
          <td valign="top" ><%=tva.getVal()%></td>
        </tr>
      </table>

</td>
<td width="1" bgcolor="#CCCCCC"></td>
</tr>
<tr><td colspan="3" bgcolor="#999999" height="1"></td></tr>
</table>
