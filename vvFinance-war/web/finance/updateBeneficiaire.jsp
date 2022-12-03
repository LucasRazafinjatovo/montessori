<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="finance.*" %>
<%@ page import="utilitaire.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        String apres="facture/apresAnnulerFacture.jsp";
        String lien= null;
        UserEJB u = null;
        TypeObjet ben= null;
        String idBen = null;
        historique.MapUtilisateur ut=null;

%>
<%
idBen = request.getParameter("idBen");
%>
<%
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
ben = u.findTypeObjet("Beneficiaire",idBen,"%")[0];
 ut=u.getUser();

%>

<link href="style.css" rel="stylesheet" type="text/css">
<h1>Modifier b&eacute;n&eacute;ficiaire</h1>
<form action="<%=lien%>?but=finance/apresBeneficiaire.jsp" method="post">
  <table cellpadding="3" cellspacing="0" border="0" align="center" width="450">
<tr><td>
<table cellpadding="3" cellspacing="0" border="0" align="center" width="100%" class="monographe">
          <!--DWLayoutTable-->
          <tr>
            <td width="46%" class="left">Nom b&eacute;n&eacute;ficiaire : </td>
            <td width="54%"><div align="center">
                <input name="nom" type="text" class="champ" id="nom" value="<%=ben.getVal()%>">
              </div></td>
          </tr>
          <tr>
            <td class="left" valign="top">Description : </td>
            <td><div align="center">
                <textarea name="description" cols="50" rows="7" class="champ" id="description"><%=ben.getDesce()%>
</textarea>
<input type="hidden" value="<%=ben.getId()%>" name="idBen">
                <input name="acte" type="hidden" id="acte" value="UPDATE">
              </div></td>
          </tr>
           </table>
</td></tr>
<tr>
      <td>
<table width="75%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td><div align="center">
                <input type="submit" name="Submit" value="Enregistrer" class="submit">
              </div></td>
            <td><div align="center">
                <input type="submit" name="Submit2" value="R&eacute;tablir" class="submit">
              </div></td>
          </tr>
        </table>
        <div align="center"></div></td></tr>
</table>
</form>