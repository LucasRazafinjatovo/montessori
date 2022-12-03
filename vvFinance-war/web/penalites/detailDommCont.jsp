<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="penalite.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
	String apres="facture/apresInit.jsp";
	String lien= null;
        penalite.DommageConteneur dc = null;
        UserEJB u = null;
	String idDomm = null;


%>
<%
idDomm = request.getParameter("idDomm");
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
try{
//String idVol, String datySaisie, String datyVol, String numCont, String designation, String idDossier, String proprietaire, String montant
dc = u.findDommageConteneur(idDomm,"","","%","%","%","%")[0];
}catch (Exception e)
                        {
                        %>
                                      <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
                        <%
                          return;
                        }

	                %>

<link href="style.css" rel="stylesheet" type="text/css">
<h1>D&eacute;tails dommage sur conteneur </h1>
<table cellpadding="0" cellspacing="0" border="0" align="center" width="450">
<tr><td><table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
        <tr>
          <td class="left">N&deg; Dommage :</td>
          <td><%=dc.getIdDommage()%></td>
        </tr>
        <tr>
          <td width="47%" class="left">Date :</td>
          <td width="53%"><%=Utilitaire.formatterDaty(dc.getDatySaisie())%></td>
        </tr>
        <tr>
          <td class="left">Date du dommage : </td>
          <td><%=Utilitaire.formatterDaty(dc.getDatyDommage())%></td>
        </tr>
        <tr>
          <td class="left">D&eacute;signation : </td>
          <td><%=dc.getDesignation()%></td>
        </tr>
        <tr>
          <td class="left"><strong>Montant :</strong></td>
          <td><%=dc.getMontant()%></td>
        </tr>
        <tr>
          <td class="left">N&deg; Dossier :</td>
          <td><%=dc.getIdDossier()%></td>
        </tr>
        <tr>
          <td class="left">Propri&eacute;taire :</td>
          <td><%=dc.getNomProprietaire()%></td>
        </tr>
      </table></td>
</table>

