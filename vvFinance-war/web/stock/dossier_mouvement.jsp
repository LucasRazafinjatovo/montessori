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
  TypeObjet td[] = null;
  TypeObjet mg[] = null;
MvtStock mvt= null;
  String nomCol[]=null;
  double sommeEntree=0;
  String apresW=null;
Dossier[] dossier = null;
String id = null;

String urlRetour = null;
String cloture="non";// pour tester si le mouvement est déjà cloturer
 %>
<%

  u=(UserEJB)session.getValue("u");
     lien=(String)session.getValue("lien");
      id = request.getParameter("id");
 td = u.findTypeObjet("typeDossier","%","%");
  mg = u.findTypeObjet("compte","%","%");
      urlRetour = request.getParameter("urlRetour");

      cloture = request.getParameter("cloture");
      if(cloture==null||cloture.trim().compareTo("")==0)cloture="non";

mvt=u.findMvtStock(id,"","","%","%")[0];
dossier= u.findDossier("%",id,"%","","");
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
<h1>Enregistrement dossier pour un mouvement</h1>

<form name="form2" method="post" action="<%=lien%>?but=facture/apresFactureFinal.jsp">
<table width="450" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
  <tr>
    <td>
	<table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="formadd">
	 <tr>
          <td  valign="top" class="left">Référence mouvement :</td>
          <td  valign="top">&nbsp;<%=mvt.getId()%>
          </td>
        </tr>
		 <tr>
          <td  valign="top" class="left">Type mouvement :</td>
          <td  valign="top">&nbsp;<%=mvt.getTypeMvt()%>
          </td>
        </tr>
        <tr>
          <td  valign="top" class="left">Date :</td>
          <td  valign="top">&nbsp;<%=Utilitaire.formatterDaty(mvt.getDaty())%>
          </td>
        </tr>
        <tr>
          <td  valign="top" class="left">Designation
            :</td>
          <td valign="top"><%=mvt.getDesignation()%></td>
        </tr>
     <tr>
   <td valign="top" class="left">Compte </td>
   <td valign="top">&nbsp;<font color="#003399"><%=mvt.getCompte()%></font>
           </td>
 </tr>
 <tr>
   <td valign="top" class="left">Débit</td>
   <td valign="top"><%=mvt.getDebit()%> <%=mvt.getUniteMvt()%></select>
           </td>
 </tr>
 <tr>
   <td valign="top" class="left">Crédit</td>
   <td valign="top"><%=mvt.getCredit()%> <%=mvt.getUniteMvt()%></select>
           </td>
 </tr>
        <tr>
          <td valign="top" class="left">Remarque :</td>
          <td valign="top">&nbsp;<%=mvt.getRemarque()%></td>
        </tr>

      </table></td>
  </tr>
</table>


</form>

<hr align="center" color="#0099FF" noshade size="1" width="85%">

<h1>Ajouter dossier </h1>
<form name="form1" method="post"  action="<%=lien%>?but=stock/apresDossierMouvement.jsp">
 <table width="500" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
  <tr>
    <td>
    <%
if(cloture.compareTo("non")==0){
%>
  <table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="formadd">

        <tr>
          <td valign="top" class="left">Designation
            :</td>
          <td valign="top" colspan="3">&nbsp; <input name="designation" type="text"  class="champ" id="designation" value="" size="20" maxlength="10"></td>
        </tr>
        <tr>
          <td valign="top" class="left">Numéro</td>
          <td valign="top" colspan="3">&nbsp; <input name="numero" type="text"  class="champ" id="valeur" value="" size="20" maxlength="10">

		  </td>
        </tr>
		<tr>
          <td  valign="top" class="left">Date :</td>
          <td valign="top" colspan="3">&nbsp; <input name="date" type="text" disabled class="champ" id="date" value="" size="10" maxlength="10"> <a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a>

          </td>
        </tr>
         <tr>
   <td  valign="top" class="left">type dossier:</td>
   <td valign="top" colspan="3">&nbsp;<select name="typeDossier">
<%
                                          for (int t=0;t<td.length;t++){
                                                       %>
                                                          <option value="<%=td[t].getTuppleID()%>"><%=td[t].getVal()%></option>
                                                       <%
                                          }
                                                       %>
</select>	</td>
        </tr>
        <tr>
          <td valign="top" class="left">Tiers</td>
          <td valign="top"  colspan="3">&nbsp; <select name="tiers">
<%
                                          for (int t=0;t<mg.length;t++){
                                                       %>
                                                          <option value="<%=mg[t].getTuppleID()%>"><%=mg[t].getVal()%> </option>
                                                       <%
                                          }
                                                       %>
</select>
		  </td>
        </tr>
		<tr>
          <td  valign="top" class="left">Quantité Tot</td>
          <td valign="top" > &nbsp; <input name="quantite" type="text" class="champ" id="quantite" value="" size="10" maxlength="10">
		  </td>
		   <td valign="top" class="left">Montant Tot</td>
          <td valign="top" > &nbsp; <input name="montant" type="text" class="champ" id="montant" value="" size="10" maxlength="10">
		  </td>
        </tr>
        <tr>
          <td  valign="top" class="left">Remarque :</td>
          <td valign="top" colspan="3">&nbsp; <textarea name="noteExplicative" cols="40" rows="5"></textarea></td>
        </tr>

      </table>
</td></tr></table>

  <br>
<div align="center">
<input type="hidden" value="<%=id%>" name="id">
<input type="hidden" value="<%=urlRetour%>" name="urlRetour">
<input type="hidden" value="INSERT" name="acte">
        <input type="submit" name="Submit" value="Ajouter">
        <input type="reset" name="Submit2" value="Annuler">
<%
}
%>
		 <input type="button" onclick="page('<%=lien%>?but=stock/<%=urlRetour%>&id=<%=id%>')" name="Submit2" value="Retour au mouvement">

  </div></form>



<table width="600" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
  <tr><td>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">

  <tr class="head">

          <td width="132">&nbsp; D&eacute;signation </td>
          <td width="57"><div align="center">&nbsp;Numéro</div></td>
  <td width="57"><div align="center">&nbsp;Date</div></td>
          <td width="41">&nbsp; Qt&eacute; </td>
          <td width="58">&nbsp; Montant </td>
          <td width="32">&nbsp;Tiers</td>
          <%
%>
          <td width="26" align="center" valign="middle">&nbsp;</td>
<%
%>
        </tr>
		<%

		for(int i=0;i<dossier.length;i++){

        %>
     <tr>

          <td width="132"><%=dossier[i].getDesignation()%></td>
          <td width="57"><%=dossier[i].getNumero()%></td>
          <td width="41"><%=Utilitaire.formatterDaty(dossier[i].getDaty())%></td>
          <td width="58"><%=dossier[i].getQtetot()%></td>
          <td width="32" align="right"><%=Utilitaire.formaterAr(dossier[i].getMonttot())%></td>
         <td width="32"><%=dossier[i].getTiers()%></td>
          <td width="26" align="center" valign="middle">
	<a href="javascript:decision('Vous voulez vraiment ce dossier?','<%=lien%>?but=stock/apresDossierMouvement.jsp&id=<%=id%>&urlRetour=<%=urlRetour%>&idDossier=<%=dossier[i].getId()%>&acte=DELETE')">
<img src="../../application/05-08-08/affichage/facture/images/button_drop.png" width="11" height="13" border="0" alt="Supprimer"></a></td>
        </tr>
        <%
		}
		%>
	  </table>
		</td></tr></table>

<%


%>

<script language="JavaScript">
<!--dateParution
    var cal1 = new calendar1(document.all.date);
     cal1.year_scroll = false;
     cal1.time_comp = false;


     //-->
</script>