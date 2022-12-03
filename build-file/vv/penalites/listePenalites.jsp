<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="penalite.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        String apres="facture/apresFactureInit.jsp";
        String lien= null;
        facture.Client clt[] = null;
        facture.SCatService sctserv[] = null;
        UserEJB u = null;
        TypeObjet etat[] = null;
        Penalite pen[] = null;
	String typePen=null;
         historique.MapUtilisateur ut=null;
%>
<%
try{
u=(user.UserEJB)session.getValue("u");
ut=u.getUser();
clt = u.findClient("%", "%", "%", "%", "%", "%", "%", "%", "%", "%", "%");
sctserv = u.findSCatService("%", "%", "cat2", "%");
lien=(String)session.getValue("lien");
etat = u.findTypeObjet("Etat","%","%");
typePen = request.getParameter("typePen");
if (typePen==null || typePen.compareTo("")==0) typePen="%";
//String idPenalite, String daty, String designation, String montant, String idSCatService, String champ1, String champ2, String champ3, String champ4
//pen = u.findPenalite("%","","%","%","%","%","%","%","%");
//String idPenalite, String daty, String designation, String montant, String idSCatService, String champ1, String champ2, String champ3, String champ4
pen=u.findPenaliteNonFacture("%","","%","%",typePen,"%","%","%","%");
}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
%>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Liste des p&eacute;nalit&eacute;s </h1>
<form action="<%=lien%>?but=penalites/listePenalites.jsp" method="post">
<table border="0" cellpadding="3" cellspacing="0" align="center" width="600">
<tr><td><table width="50%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
          <tr>
    <td width="46%" class="left">Type :</td>
            <td width="54%" align="center">
              <select name="typePen" class="champ" id="typePen">
          <option value="%">tous</option>
        <%
	  for(int i=0;i<sctserv.length;i++){
	  %>
        <option value="<%=sctserv[i].getIdScatService()%>"><%=sctserv[i].getNomSCatService()%></option>
        <%
		}
		%>
      </select>
            </td>
  </tr>
</table></td></tr>
<tr>
    <td align="center">
<table width="50%" border="0" cellspacing="0" cellpadding="0">
  <tr>
          <td align="center">
<input name="Input" type="submit" value="Afficher" class="submit">
          </td>
          <td align="center">
<input name="Input2" type="reset" value="Annuler" class="submit">
          </td>
  </tr>
</table>
    </td>
  </tr>
</table>
</form>
<br>


<table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
<tr><td>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
        <!--DWLayoutTable-->
        <tr class="head">
    <td width="76" align="center" height="25"><div align="center">Type</div></td>
    <td width="184" align="left"><div align="center">Designation</div></td>
    <td align="center" width="173"><div align="center">Montant</div></td>
    <td align="center" width="87"><div align="center">Date d&eacute;but</div></td>
    <td align="right" width="87"><div align="center">Date fin</div></td>
    <td width="80" valign="middle"></td>
  </tr>
  <%
  for(int i=0;i<pen.length;i++){

  %>
  <tr>
    <td width="76" align="center"><%=u.findSCatService(pen[i].idSCatService,"%","%","%")[0].getNomSCatService()%></td>
    <td width="184" align="left">&nbsp;<a href="<%=lien%>?but=penalites/apresListePenalites1.jsp&idScat=<%=pen[i].idSCatService%>&idPen=<%=pen[i].getIdPenalite()%>"><%=pen[i].getDesignation()%></a> </td>
    <td align="center" width="173"><%=Utilitaire.formaterAr((double)pen[i].getMontant())%></td>
    <td align="center" width="87"><%=Utilitaire.formatterDaty(pen[i].getDateDebut())%></td>
    <td align="right" width="87"><div align="center"><%=Utilitaire.formatterDaty(pen[i].getDateFin())%></div></td>
          <td width="80" valign="middle" bgcolor="#FFFFFF">&nbsp;&nbsp;<a href="<%=lien%>?but=penalites/apresListePenalites.jsp&idPen=<%=pen[i].getIdPenalite()%>&idTypeFacture=<%=pen[i].getIdSCatService()%>">A
            facturer</a></td>
  </tr>
  <tr>
    <td colspan="5" height="5"></td>
  </tr>
  <%
  }
  %>
</table>
</td></tr></table>