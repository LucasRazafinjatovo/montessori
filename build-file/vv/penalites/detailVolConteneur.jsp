<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="penalite.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
	String apres="facture/apresInit.jsp";
	String lien= null;
    penalite.VolConteneur volcont= null;
    UserEJB u = null;
	String idVol = null;


%>
<%
idVol = request.getParameter("idVol");
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
try{
//String idVol, String datySaisie, String datyVol, String numCont, String designation, String idDossier, String proprietaire, String montant
volcont = u.findVolCont(idVol,"","","%","%","%","%","%")[0];
}catch (Exception e)
                        {
                        %>
                                      <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
                        <%
                          return;
                        }

	                %>

<link href="style.css" rel="stylesheet" type="text/css">
<h1>D&eacute;tails vols de conteneur </h1>
<table cellpadding="0" cellspacing="0" border="0" align="center" width="450">
<tr><td><table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
        <tr>
          <td class="left">N&deg; Vol :</td>
          <td><%=volcont.getIdVol()%></td>
        </tr>
        <tr> 
          <td width="47%" class="left">Date :</td>
          <td width="53%"><%=Utilitaire.formatterDaty(volcont.getDatySaisie())%></td>
        </tr>
        <tr> 
          <td class="left">Date du vol : </td>
          <td><%=Utilitaire.formatterDaty(volcont.getDatyVol())%></td>
        </tr>
        <tr> 
          <td class="left">N° Cont. : </td>
          <td><%=volcont.getNumeroConteneur()%></td>
        </tr>
        <tr> 
          <td class="left"><strong>D&eacute;clarant :</strong></td>
          <td><%=volcont.getIdDossier()%></td>
        </tr>
        <tr> 
          <td class="left">D&eacute;signation :</td>
          <td><%=volcont.getDesignation()%></td>
        </tr>
        <tr> 
          <td class="left">N&deg; Dossier :</td>
          <td><%=volcont.getIdDossier()%></td>
        </tr>
        <tr> 
          <td class="left">Propri&eacute;taire :</td>
          <td><%=volcont.getNomProprietaire()%></td>
        </tr>
        <tr> 
          <td class="left">Montant :</td>
          <td><%=volcont.getMontant()%></td>
        </tr>
      </table></td>
</table>

