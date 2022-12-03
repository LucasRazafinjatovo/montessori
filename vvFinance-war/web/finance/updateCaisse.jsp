<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="finance.*" %>
<%@ page import="utilitaire.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        String apres="facture/apresAnnulerFacture.jsp";
        String lien= null;
        UserEJB u = null;
        Caisse caiss = null;
        String idCaisse = null;

%>
<%
idCaisse = request.getParameter("idCaisse");

%>
<%
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
caiss = u.findCaisse(idCaisse,"%","%","%")[0];
%>
 
<SCRIPT language="JavaScript" src="script.js"></script>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Modifier caisse</h1>
<form action="<%=lien%>?but=finance/apresCaisse.jsp" method="post">
  <table cellpadding="0" width="450" cellspacing="0" border="0" align="center">
  <tr><td>
 <table cellpadding="3" cellspacing="0" border="0" align="center" class="monographe" width="100%">
  <tr>
      <td class="left">Nom caisse : </td>
    <td><input name="caisse" type="text" class="champ" id="caisse" value="<%=caiss.getDescCaisse()%>"> </td>
  </tr>
   <tr>
            <td height="26" class="left">Responsable : </td>
      <td><input name="responsable" type="text" class="champ" value="<%=caiss.getRespCaisse()%>">
              <input name="acte" type="hidden" id="acte" value="UPDATE">
              <input name="idEtat" type="hidden" id="idEtat" value="etaCs1">
              <input name="idCaisse" type="hidden" id="idCaisse" value="<%=request.getParameter("idCaisse")%>"></td>
  </tr>
   </table>
  </td></tr>
  <tr>
       
      <td align="center" height="30"> 
        <table width="75%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td align="center"><input type="submit" name="Submit2" value="Enregistrer" class="submit"></td>
            <td align="center"><input type="submit" name="Submit" value="R&eacute;tablir" class="submit"></td>
          </tr>
        </table></td>
  </tr>
</table>
</form>