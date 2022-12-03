<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="utilitaire.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
	String apres="facture/apresDevise.jsp";
	String lien= null;
        UserEJB u = null;
%>
<%
try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
%>
<SCRIPT language="JavaScript" src="script.js"></script>
 
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Ajouter une nouvelle devise</h1>

<form action="<%=lien%>?but=<%=apres%>" method="post" target="_parent" onsubmit="return (verifie(designation.value))">
  <table width="450" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
    <td><table width="100%" border="0" cellpadding="3" cellspacing="0" class="monographe">
          <tr>
            <td align="center" valign="top" class="left">Nom devise : </td>
            <td align="center">
              <input name="designation" type="text" class="champ" id="designation">
              <span class="remarque">* </span></td>
        </tr>
          <tr align="center" valign="top">
            <td class="left">Symbole :
              </td><td><input name="idDevise" type="text" class="champ" id="idDevise">
              <span class="remarque">* </span></td>
        </tr>
       <tr align="center" valign="top">
            <td class="left">Description :</td>
            <td>
              <textarea name="description" cols="10" rows="5" class="champ"></textarea>
              <input name="acte" type="hidden" id="acte2" value="INSERT">
            </td>
        </tr>
      </table></td>
  </tr>
  <tr>
      <td height="30">
<table width="75%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td align="center">
<input type="submit" name="Submit" value="Enregistrer" class="submit">
            </td>
            <td align="center">
<input type="reset" name="annuler" value="R&eacute;tablir" class="submit">
            </td>
        </tr>
      </table>
        <div align="center"></div></td>
  </tr>
</table>

</form>

<table width="358" border="0" cellpadding="0" cellspacing="0" align="center">
  <!--DWLayoutTable-->
  <tr>
    <td width="358" height="16" valign="top" class="remarque"><p>Entrer les informations
        concernant la nouvelle devise.</p>
      <p>(*) Champs obligatoires</p></td>
  </tr>
</table>
