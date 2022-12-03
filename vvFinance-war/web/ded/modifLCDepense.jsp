<%@ page import="user.*"%>
<%@ page import="facture.*"%>
<%@ page import="finance.*"%>
<%@ page import="lc.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="bean.*"%>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage=""%>
<%!
	String lien = null;
    UserEJB u = null;
%>
<%
	u = (user.UserEJB) session.getValue("u");
    lien = (String) session.getValue("lien");
%>
  <SCRIPT language="JavaScript" src="script.js"></script>
  <link href="style.css" rel="stylesheet" type="text/css">
  <h1>Modif attachement LC Depense</h1>
  <table width="450" border="0" align="center" cellpadding="0"
          cellspacing="0">
          <tr>
                  <td class="remarque">&nbsp;</td>
          </tr>
  </table>
  <form action="<%=lien%>?but=ded/OPModifier.jsp" method="post" name="client" id="client" target="_parent">

  <table width="600" border="0" align="center" cellpadding="0"
          cellspacing="0">
          <tr>
                  <td>
                  <table width="100%" border="0" align="center" cellpadding="2"
                          cellspacing="0" class="monographe">
                          <tr>
                            <td class="left" width="20%" valign="top"><div align="center">Num OP:<span class="remarque">*</span></div></td>
                            <td align="center" width="30%"><input type="text" name="num" class="champ" id="num" />
                            <input class="submit" type="button" value="..." onclick="pagePopUp('ded/choixOP.jsp?champReturn=num&etat=ordonnerpayement')" name="choix3"></td>
                          </tr>
                  </table>
                  </td>
          </tr>
          <tr>
                  <td height="30" align="center">
                  <table width="75%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td align="center"><input type="submit" name="Submit"  class="submit" value="Valider"></td>
                            <td align="center"><input type="reset" name="annuler"   value="R&eacute;tablir" class="submit"></td>
                          </tr>
                  </table>
                  </td>
          </tr>
          <input type="hidden" name="acte"   value="update" class="submit">
          <input type="hidden" name="bute"   value="ded/modifLCDepense.jsp" class="submit">
  </table>
  </form>
  <div align="center"><span class="remarque">(*) Champs
  obligatoires</span></div>