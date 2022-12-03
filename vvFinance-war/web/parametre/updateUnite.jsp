<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="facture.*" %>
<%@ page import="penalite.*" %>
<%@ page import="bean.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
 
<html>
<%!
        UserEJB u = null;
        String acte=null;
        String id=null;
        ChiffreAffTac chiff = null;
        String lien = null;
        String idDevise = null;
        TypeObjet dev = null;
%>
<%
idDevise= request.getParameter("idUnite");
try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
dev = u.findTypeObjet("unite",idDevise,"%")[0];
}catch(Exception e){
  %>
                <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
    <%
        }
%>

 
<link href="style.css" rel="stylesheet" type="text/css">
<SCRIPT language="JavaScript" src="script.js"></script>
<h1>Modifier unit&eacute;</h1>
<form action="<%=lien%>?but=parametre/apresUnite.jsp" method="post" target="_parent" onsubmit="return (verifie(nom.value))">
<table cellpadding="0" cellspacing="0" border="0" align="center" width="450">
<tr><td>
  <table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
        <!--DWLayoutTable-->
        <tr>
          <td class="left">Nom unit&eacute; : </td>
          <td align="center">
<input name="nom" type="text" class="champ" value="<%=dev.getVal()%>">
          </td>
        </tr>
        <tr>
            <td height="5" valign="top" class="left">Description : <input name="acte" type="hidden" id="acte" value="UPDATE">
              <input name="idUnite" type="hidden" id="idUnite" value="<%=idDevise%>"></td>
          <td align="center">
<textarea name="description" cols="50" rows="7" class="champ"><%=dev.getDesce()%></textarea>
          </td>
        </tr>
      </table></td></tr>
<tr>
    <td height="30" align="center">
      <table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr>
          <td align="center">
<input type="submit" name="Submit2" value="Enregistrer" class="submit">
          </td>
          <td align="center">
            <input type="submit" name="Submit" value="R&eacute;tablir" class="submit">
          </td>
  </tr>
</table>
    </td>
  </tr>
</table>

</form>
