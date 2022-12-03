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
	clt = u.findClient("%", "%", "%", "%", "%", "%", "%", "%", "%", "%", "%");
	sctserv = u.findSCatService("%", "%", "cat2", "%");
	lien=(String)session.getValue("lien");
	etat = u.findTypeObjet("Etat","%","%");
	typePen = request.getParameter("typePen");
	ut=u.getUser();
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
<script language="javascript">
function decision(message, url){
if(confirm(message)) location.href = url;
}
</script>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Lister les p&eacute;nalit&eacute;s </h1>
<form action="<%=lien%>?but=penalites/listePenalites1.jsp" method="post">
<table border="0" cellpadding="3" cellspacing="0" align="center" width="600">
<tr><td><table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
        <!--
		  <tr>
            <td width="19%" class="left">Mois :</td>
            <td width="28%" align="center"><select name="mois" class="champ" id="mois">
                <option value="1">janvier</option>
                <option value="2">f&eacute;vrier</option>
                <option value="3">mars</option>
                <option value="4">avril</option>
                <option value="5">mai</option>
                <option value="6">juin</option>
                <option value="7">juillet</option>
                <option value="8">ao&ucirc;t</option>
                <option value="9">sept.</option>
                <option value="10">oct.</option>
                <option value="11">nov.</option>
                <option value="12">d&eacute;c.</option>
              </select></td>
            <td width="21%" align="left" class="left"><strong>Ann&eacute;e :</strong></td>
            <td width="32%" align="center"> <input name="annee" type="text" class="champ" id="annee"></td>
          </tr>
		  -->
          <tr>
            <td width="19%" class="left">Type :</td>
            <td width="28%" align="center"><select name="typePen" class="champ" id="typePen">
                <option value="%">tous</option>
                <%
	  for(int i=0;i<sctserv.length;i++){
	  %>
                <option value="<%=sctserv[i].getIdScatService()%>" <%if(sctserv[i].getIdScatService().compareTo(typePen)==0) out.println("selected");%>><%=sctserv[i].getNomSCatService()%></option>
                <%
		}
		%>
              </select></td>
            <td width="21%" align="left" class="left">&nbsp;</td>
            <td width="32%" align="center">&nbsp;</td>
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
<table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
        <!--DWLayoutTable-->
        <tr class="head">
		  <td width="76">N&deg; penalite</td>
          <td width="246" height="20" align="left"><div align="center">D&eacute;signation</div></td>
          <td align="center" width="121"><div align="center">Montant</div></td>
          <td width="137" valign="middle"></td>
        </tr>
        <%
  for(int i=0;i<pen.length;i++){
  %>
        <tr>
		<td><%=pen[i].getIdPenalite()%></td>
          <td width="246" align="left">&nbsp; <%=pen[i].getDesignation()%></td>
          <td align="center" width="121"><%=Utilitaire.formaterAr((double)pen[i].getMontant())%></td>
          <td width="137" align="center" valign="middle" bgcolor="#FFFFFF">&nbsp;&nbsp;<a href="<%=lien%>?but=penalites/apresListePenalites1.jsp&idPen=<%=pen[i].getIdPenalite()%>&idScat=<%=pen[i].getIdSCatService()%>">D&eacute;tails</a>
            &nbsp;&nbsp;

    <%
      if(ut.getIdrole().compareTo("admin")==0 || ut.getIdrole().compareTo("dg")==0 || ut.getIdrole().compareTo("adminFacture")==0)
		{
   %>
            |&nbsp;&nbsp; <a href="javascript:decision('Vous voulez vraiment annuler cette pénalité?\n\nCette opération supprimera définitivement la pénalité du système.','<%=lien%>?but=penalites/apresListePenalites1.jsp&acte=ANNULE&idPen=<%=pen[i].getIdPenalite()%>')">
            Annuler </a>
            <%
	}
	%></td>
        </tr>
        <tr>
          <td colspan="4" height="5"></td>
        </tr>
        <%
  }
  %>
      </table>
</td></tr></table>