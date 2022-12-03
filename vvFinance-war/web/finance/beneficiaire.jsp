<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="finance.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        String apres="finance/apresBeneficiaire.jsp";
        String lien= null;
        UserEJB u = null;
 %>
 <%
 lien=(String)session.getValue("lien");
 u=(UserEJB)session.getAttribute("u");
 %>
<SCRIPT language="JavaScript" src="script.js"></script>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Ajouter nouveau b&eacute;n&eacute;ficiaire</h1>
<form action="<%=lien%>?but=<%=apres%>" method="post" target="_parent" onsubmit="return (verifie(comptable.value))">
  <table width="450" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
    <!--DWLayoutTable-->
    <tr> 
      <td width="178" class="left">Nom b&eacute;n&eacute;ficiaire : </td>
      <td width="260"> <div align="center"> 
          <input name="nom" type="text" class="champ" id="nom">
        </div></td>
    </tr>
    <tr> 
      <td class="left">Description : </td>
      <td><div align="center"> 
          <textarea name="description" cols="70" rows="7" class="champ" id="description"></textarea>
          <input name="acte" type="hidden" id="acte" value="INSERT">
        </div></td>
    </tr>
      </table>
  <br><table width="600" border="0" align="center" class="monographe">
    <tr>
      <td><div align="center"><strong><u>INFORMATION COMPTABLE</u></strong></div></td>
    </tr>
    <tr>
      <td><table width="100%" border="0">
          <tr>
            <td width="14%"><div align="right"><strong>Identification Comptable
                :</strong></div></td>
            <td width="17%"><div align="center">
                <input name="comptable" type="text" class="champ" id="comptable" size="18">
                <span class="remarque">(*)</span></div></td>
          </tr>
        </table></td>
    </tr>
  </table>

  <br><table width="450" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr><td>
  <table width="75%" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
            <td align="center">
<input type="submit" name="Submit" value="Valider" class="submit" onClick="MM_validateForm('nom','','R');return document.MM_returnValue">
            </td>
            <td align="center">
<input type="reset" name="Submit2" value="Annuler" class="submit">
            </td>
        </tr>
      </table>
	  </td></tr>
	  </table>
</form>