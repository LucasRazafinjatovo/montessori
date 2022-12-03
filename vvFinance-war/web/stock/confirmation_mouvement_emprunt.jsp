<%@ page import="user.*" %>
<%@ page import="finance.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="stock.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
  String apres="facturefournisseur/listeFactureF.jsp";
  String lien= null;
  UserEJB u = null;
   TypeObjet typeMvt = null;
MvtStock mvt= null;
MvtStock mvtF= null;
  String nomCol[]=null;
  double sommeEntree=0;
  String apresW=null;
Dossier[] dossier = null;
String id = null;
LettrageMvt letMvt =  null;
 %>
<%

  u=(UserEJB)session.getValue("u");
     lien=(String)session.getValue("lien");
     id = request.getParameter("id");

mvt=u.findMvtStock(id,"","","%","%")[0];
letMvt = u.findLettrageMvt("%",id,"%")[0];
  mvtF =u.findMvtStock(letMvt.getFille(),"","","%","%")[0];
   typeMvt = u.findTypeObjet("typeMvt",mvt.getTypeMvt(),"%")[0];
     /*te = u.findTypeObjet("TypeEntree","%","%");
     clt = u.findClient("%", "%", "%", "%", "%", "%", "%", "%", "%", "%", "%");
     mp = u.findTypeObjet("Beneficiaire","%","%");

     caiss = u.findCaisse("%","%","%","%");*/

%>
<%
  try{

  // sommeEntree=AdminFF.getSommeEntree(factF,pazy1,pazy2);

}
catch (Exception e){
%>
<script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
  return;
}
%>
<script language="javascript">
function page(page_dest){
        document.location=page_dest;
}
</script>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Confirmation de mouvement de stock entre entrepôt</h1>
<h2>&nbsp;</h2>
<table width="450" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
  <tr>
    <td>


 <table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="formadd">
  <tr>
   <td  valign="top" class="left">Référence mouvement :</td>
   <td  valign="top">&nbsp;<font color="#FF0000"><%=mvt.getId()%></font>
   </td>
 </tr>
          <tr>
   <td  valign="top" class="left">Type mouvement :</td>
   <td  valign="top"><font color="#FF0000"><%=typeMvt.getVal()%></font>   </td>
 </tr>
 <tr>
   <td  valign="top" class="left">Date :</td>
   <td  valign="top">&nbsp;<%=Utilitaire.formatterDaty(mvt.getDaty())%>
   </td>
 </tr>
 <tr>
   <td valign="top" class="left">Remarque :</td>
   <td valign="top">&nbsp;<%=mvt.getRemarque()%></td>
 </tr>
 <tr>
   <td  valign="top" class="left">Designation
     :</td>
   <td valign="top">&nbsp;designation<%=mvt.getDesignation()%></td>
 </tr>
  <tr>
   <td valign="top"  colspan="2">
   <table width="100%" border="0">
  <tr>
    <td  width="50%">
	<fielset><legend>Père :<font color="#FF0000"><%=mvt.getId()%></font></legend>
	<table width="100%" border="0">
  <tr>
    <td class="left">Compte</td>
    <td>&nbsp;<%=mvt.getCompte()%></td>
  </tr>
  <tr>
    <td class="left">Libellé</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td class="left">Débit</td>
    <td>&nbsp;<%=mvt.getDebit()%></td>
  </tr>
  <tr>
    <td class="left">Crédit</td>
    <td>&nbsp;<%=mvt.getCredit()%></td>
  </tr>
</table>

	</fieldset>
	</td>
    <td>
	<fielset><legend>fille</legend>
 <table width="100%" border="0">
<tr>
<td class="left">Compte</td>
<td>&nbsp;<%=mvtF.getCompte()%></td>
</tr>
<tr>
<td class="left">Libellé</td>
<td>&nbsp;</td>
</tr>
<tr>
<td class="left">Débit</td>
<td>&nbsp;<%=mvtF.getDebit()%></td>
</tr>
<tr>
<td class="left">Crédit</td>
<td>&nbsp;<%=mvtF.getCredit()%></td>
</tr>
</table>
		</fieldset>

	</td>
  </tr>
</table>

          </td>
 </tr>




      </table>
	<table width="100%" border="0">
  <tr>
    <td align="center"><input type="button" onclick="page('<%=lien%>?but=stock/retour.jsp&id=<%=id%>')" class="submit" value="Retour"></td>
    <td align="center"><input type="button" onclick="page('<%=lien%>?but=stock/dossier_mouvement.jsp&id=<%=id%>&urlRetour=confirmation_mouvement_emprunt.jsp')" class="submit" value="Détail dossiers"></td>
    <td align="center"><input type="button" onclick="page('<%=lien%>?but=stock/saisir_bobine.jsp&id=<%=id%>&urlRetour=confirmation_mouvement_emprunt.jsp')" class="submit" value="Détail bobines"></td>
  </tr>
</table>


	  </td>
  </tr>
</table>

